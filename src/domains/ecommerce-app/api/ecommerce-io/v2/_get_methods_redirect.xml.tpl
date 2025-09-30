<policies>
    <inbound>
      <base />
      <!-- pagoPA platform get payment methods redirect url : START -->
      <!-- Token JWT START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="x-jwt-token" mode="new">
          <set-url>https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/tokens</set-url>
          <set-method>POST</set-method>
          <!-- Set jwt-issuer-service API Key header -->
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-jwt-issuer-api-key-value}}</value>
          </set-header>
          <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
          </set-header>
          <set-body>@{
            var userId = ((string)context.Variables.GetValueOrDefault("xUserId",""));
            return new JObject(
                    new JProperty("audience", "ecommerce"),
                    new JProperty("duration", 900),
                    new JProperty("privateClaims", new JObject(
                        new JProperty("userId", userId)
                    ))
                ).ToString();
          }</set-body>
      </send-request>
    <choose>
        <when condition="@(((IResponse)context.Variables["x-jwt-token"]).StatusCode != 200)">
            <return-response>
                <set-status code="502" reason="Bad Gateway" />
            </return-response>
        </when>
    </choose>
    <set-variable name="token" value="@( (string) ( ((IResponse)context.Variables["x-jwt-token"] ).Body.As<JObject>(preserveContent: true)) ["token"])" />
    <!-- Token JWT END-->
    <!-- pagoPA platform get payment methods redirect url : END -->
    <return-response>
      <set-header name="Content-Type" exists-action="override">
          <value>application/json</value>
      </set-header>
      <set-body>@{
          var response = new JObject();
          response["redirectUrl"] = "redirectUrl" + "&sessionToken=" + ((string)context.Variables["token"]);
          return response.ToString();
      }</set-body>
    </return-response>
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
