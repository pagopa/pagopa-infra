<policies>
    <inbound>
        <base />

         <set-variable name="requestBody" value="@((JObject)context.Request.Body.As<JObject>(preserveContent: true))" />
         <set-variable name="ecTaxCode" value="@((string)((JObject)((JObject)context.Variables["requestBody"])["payee"])?["taxCode"])"/>

         <!-- Validate EC tax code -->
         <choose>
             <when condition="@((string)context.Variables["ecTaxCode"] == null)">
                 <return-response>
                     <set-status code="400" reason="Bad Request" />
                     <set-body>{
                       "httpStatusCode": "BAD_REQUEST",
                       "httpStatusDescription": "Bad Request",
                       "appErrorCode": "PDFE_400",
                       "errors": [
                         {
                           "message": "Missing payee tax code"
                         }
                       ]
                     }</set-body>
                 </return-response>
             </when>
         </choose>

        <cache-lookup-value key="@((string) context.Variables["ecTaxCode"])" variable-name="cached_cbill" caching-type="internal" />

        <choose>
            <when condition="@(!context.Variables.ContainsKey("cached_cbill"))">
                <!-- CACHE MISS -->
                <send-request mode="new" response-variable-name="apiConfigResponse" timeout="10" ignore-error="true">
                    <set-url>@($"https://weudev.apiconfig.internal.dev.platform.pagopa.it/apiconfig/auth/api/v1/creditorinstitutions/{context.Variables["ecTaxCode"]}")</set-url>
                    <set-method>GET</set-method>
                </send-request>

                <set-variable name="externalResponse" value="@((IResponse)context.Variables["apiConfigResponse"])" />

                <!-- Validate Api Config response status code -->
                <choose>
                    <when condition="@(
                        context.Variables["externalResponse"] == null ||
                        ((IResponse)context.Variables["externalResponse"]).StatusCode != 200
                    )">
                        <return-response>
                            <set-status code="502" reason="Bad Gateway" />
                            <set-body>{
                              "httpStatusCode": "BAD_GATEWAY",
                              "httpStatusDescription": "Bad Gateway",
                              "appErrorCode": "PDFE_502_1",
                              "errors": [
                                {
                                  "message": "External service error"
                                }
                              ]
                            }</set-body>
                        </return-response>
                    </when>
                </choose>

                <set-variable name="cbillCode" value="@{
                    var response = (IResponse)context.Variables["apiConfigResponse"];
                    var json = JObject.Parse(response.Body.As<string>());
                    return json["cbill_code"])
                }"/>

                <!-- Validate Api Config response body -->
                <choose>
                    <when condition="@((string)context.Variables["cbillCode"] == null)">
                        <return-response>
                            <set-status code="502" reason="Bad Gateway" />
                            <set-body>{
                              "httpStatusCode": "BAD_GATEWAY",
                              "httpStatusDescription": "Bad Gateway",
                              "appErrorCode": "PDFE_502_2",
                              "errors": [
                                {
                                  "message": "Missing cbill code in external response"
                                }
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
                <set-variable name="cbillCode" value="@((string)context.Variables["cached_cbill"])" />
            </otherwise>
        </choose>

        <set-body>@{
            var body = (JObject)context.Variables["requestBody"];
            body["notice"]["cbill"] = (string)context.Variables["cbillCode"];
            return body.ToString();
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
