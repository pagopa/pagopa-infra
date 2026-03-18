<!--
    - Policies are applied in the order they appear.
    - Position <base/> inside a section to inherit policies from the outer scope.
    - Comments within policies are not preserved.
-->
<!-- Add policies as children to the <inbound>, <outbound>, <backend>, and <on-error> elements -->
<policies>
    <inbound>
      <base />

        <!-- ===== Handle MULTIPART ===== -->
        <!-- Content-Type and boundary -->
      <set-variable name="boundary" value="@{
          var ct = context.Request.Headers.GetValueOrDefault("Content-Type");

          var idx = ct.IndexOf("boundary=");

          return ct.Substring(idx + 9);
          }" />

      <set-variable name="rawBody" value="@(context.Request.Body.As<string>(preserveContent: true))" />

        <!-- Extract JSON part -->
      <set-variable name="dataJsonString" value="@{
            var body = (string)context.Variables["rawBody"];
            var boundary = (string)context.Variables["boundary"];

            var token = "name=\"data\"";
            var index = body.IndexOf(token);
            var last = body.LastIndexOf("--" + boundary);
            var startIndex = index + token.Length;
            var jsonString = body.Substring(startIndex, last - startIndex);

            jsonString = jsonString.Trim('\r');
            jsonString = jsonString.Trim('\n');

            return jsonString;
        }" />

      <set-variable name="requestBody"
                    value="@((JObject)JsonConvert.DeserializeObject((string)context.Variables["dataJsonString"]))" />

      <set-variable name="ecTaxCode"
            value="@((string)((JObject)context.Variables["requestBody"])["payee"]?["taxCode"])" />

      <choose>
        <when condition="@((string)context.Variables["ecTaxCode"] == null)">
          <return-response>
              <set-status code="400" reason="Bad Request" />
              <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
              </set-header>
              <set-body>{
                "httpStatusCode": "BAD_REQUEST",
                "httpStatusDescription": "Bad Request",
                "appErrorCode": "PDFE_400",
                "errors": [
                  { "message": "Missing payee tax code" }
                ]
              }</set-body>
          </return-response>
        </when>
      </choose>

      <cache-lookup-value key="@((string) context.Variables["ecTaxCode"])"
            variable-name="cached_cbill"
            caching-type="internal" />

      <choose>
        <when condition="@(!context.Variables.ContainsKey("cached_cbill"))">
            <!-- CACHE MISS -->
            <send-request mode="new" response-variable-name="apiConfigResponse" timeout="10" ignore-error="true">
                <set-url>
                    @("https://${apiconfig_hostname}/pagopa-api-config-core-service/p/creditorinstitutions/"
                    + (string)context.Variables["ecTaxCode"])
                </set-url>
                <set-method>GET</set-method>
            </send-request>

            <set-variable name="externalResponse"
                          value="@((IResponse)context.Variables["apiConfigResponse"])" />

            <!-- Validate Api Config response status code -->
            <choose>
                <when condition="@(
                    context.Variables["externalResponse"] == null ||
                    ((IResponse)context.Variables["externalResponse"]).StatusCode != 200
                )">
                    <return-response>
                        <set-status code="502" reason="Bad Gateway" />
                        <set-header name="Content-Type" exists-action="override">
                          <value>application/json</value>
                        </set-header>
                        <set-body>{
                          "httpStatusCode": "BAD_GATEWAY",
                          "httpStatusDescription": "Bad Gateway",
                          "appErrorCode": "PDFE_502_1",
                          "errors": [
                            { "message": "External service error" }
                          ]
                        }</set-body>
                    </return-response>
                </when>
            </choose>

            <set-variable name="cbillCode" value="@{
                var response = (IResponse)context.Variables["apiConfigResponse"];
                var json = JObject.Parse(response.Body.As<string>());
                return (string)json["cbill_code"];
            }"/>

            <!-- Validate Api Config response body -->
            <choose>
                <when condition="@((string)context.Variables["cbillCode"] == null)">
                    <return-response>
                        <set-status code="502" reason="Bad Gateway" />
                        <set-header name="Content-Type" exists-action="override">
                          <value>application/json</value>
                        </set-header>
                        <set-body>{
                          "httpStatusCode": "BAD_GATEWAY",
                          "httpStatusDescription": "Bad Gateway",
                          "appErrorCode": "PDFE_502_2",
                          "errors": [
                            { "message": "Missing cbill code in external response" }
                          ]
                        }</set-body>
                    </return-response>
                </when>
            </choose>

            <!-- Put value in cache with a TTL of 12 hours -->
            <cache-store-value
                key="@((string)context.Variables["ecTaxCode"])"
                value="@((string)context.Variables["cbillCode"])"
                duration="43200"
                caching-type="internal"/>
        </when>

        <otherwise>
            <!-- CACHE HIT -->
            <set-variable name="cbillCode"
                          value="@((string)context.Variables["cached_cbill"])" />
        </otherwise>
    </choose>

    <!-- ===== Rebuild MULTIPART ===== -->

    <set-body>@{
    var body = (string)context.Variables["rawBody"];
    var boundary = (string)context.Variables["boundary"];

    var token = "name=\"data\"";
    var index = body.IndexOf(token);
    var last = body.LastIndexOf("--" + boundary);
    var startIndex = index + token.Length;
    var jsonString = body.Substring(startIndex, last - startIndex);

    var json = (JObject)context.Variables["requestBody"];
    json["notice"]["cbill"] = (string)context.Variables["cbillCode"];
    var modifiedJson = json.ToString();

    var before = body.Substring(0, startIndex);
    var after = body.Substring(last);

    return before + modifiedJson + "\r\n" + after;
    }</set-body>


  </inbound>

    <backend>
        <base />
    </backend>

    <outbound>
        <base />
    </outbound>

    <on-error>
        <base />
    </on-error>
</policies>
