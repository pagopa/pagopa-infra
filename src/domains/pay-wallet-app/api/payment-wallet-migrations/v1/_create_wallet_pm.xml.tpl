<policies>
    <inbound>
      <base />
      <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />

      <!-- Post Token PDV START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
        <set-url>${pdv_api_base_path}/tokens</set-url>
        <set-method>PUT</set-method>
        <set-header name="x-api-key" exists-action="override">
            <value>{{wallet-personal-data-vault-api-key}}</value>
        </set-header>
        <set-body>@{
          JObject requestBody = (JObject)context.Variables["body"];
          return new JObject(
                  new JProperty("pii",  (string)requestBody["fiscalCode"])
              ).ToString();
            }</set-body>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="pdvToken" value="@(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())" />
      <set-variable name="fiscalCodeTokenized" value="@((string)((JObject)context.Variables["pdvToken"])["token"])" />
      <choose>
        <when condition="@(String.IsNullOrEmpty((string)context.Variables["fiscalCodeTokenized"]))">
            <return-response>
                <set-status code="502" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>@{
            return new JObject(
              new JProperty("title", "Bad gateway - Invalid PDV response"),
              new JProperty("status", 502),
              new JProperty("detail", "Cannot tokenize fiscal code")
            ).ToString();
          }</set-body>
            </return-response>
        </when>
      </choose>
      <!-- Post Token PDV END-->

      <!-- Override body with fiscalCodeTokenized - START -->
      <set-body>@{
          JObject bodyAsJobject = (JObject) context.Variables["body"];
          String fiscalCodeTokenized = (String) context.Variables["fiscalCodeTokenized"];
          bodyAsJobject["userId"] = fiscalCodeTokenized;
          bodyAsJobject.Remove("fiscalCode");
          return bodyAsJobject.ToString();
      }</set-body>
      <!-- Override body with fiscalCodeTokenized - END -->
    </inbound>
    <outbound>
      <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
