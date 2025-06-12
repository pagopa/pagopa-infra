<policies>
    <inbound>
    <base />
    </inbound>
    <outbound>
      <base />
          <!-- pagoPA platform wallet JWT post wallet token : START -->
          <!-- Token JWT START-->
          <set-variable name="walletId" value="@((string)((context.Response.Body.As<JObject>(preserveContent: true))["walletId"]))" />
          <send-request ignore-error="true" timeout="10" response-variable-name="x-jwt-token" mode="new">
              <set-url>https://${hostname}/pagopa-jwt-issuer-service/tokens</set-url>
              <set-method>POST</set-method>
              <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
              </set-header>
              <set-body>@{
                var userId = ((string)context.Variables.GetValueOrDefault("xUserId",""));
                var walletId = ((string)context.Variables.GetValueOrDefault("walletId",""));
                return new JObject(
                        new JProperty("audience", "wallet"),
                        new JProperty("duration", 900),
                        new JProperty("privateClaims", new JObject(
                            new JProperty("walletId", walletId),
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
        <!-- pagoPA platform wallet JWT session token : END -->
        <set-body>@{
            JObject inBody = context.Response.Body.As<JObject>(preserveContent: true);
            var redirectUrl = inBody["redirectUrl"];
            inBody["redirectUrl"] = redirectUrl + "&sessionToken=" + ((string)context.Variables["token"]);
            inBody.Remove("walletId");
            return inBody.ToString();
        }</set-body>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
