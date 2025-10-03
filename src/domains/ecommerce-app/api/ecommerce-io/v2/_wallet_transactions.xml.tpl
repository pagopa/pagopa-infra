<policies>
    <inbound>
     <base />
      <set-backend-service base-url="https://${wallet-basepath}/pagopa-wallet-service" />
      <set-header name="x-api-key" exists-action="override">
        <value>{{payment-wallet-service-rest-api-key}}</value>
      </set-header>
    </inbound>
    <outbound>
      <base />
      <choose>
        <when condition="@(context.Response.StatusCode == 201)">
          <!-- Token JWT START-->
          <set-variable name="walletId" value="@((string)((context.Response.Body.As<JObject>(preserveContent: true))["walletId"]))" />
          <set-variable name="transactionId" value="@(context.Request.MatchedParameters["transactionId"])" />
          <send-request ignore-error="true" timeout="10" response-variable-name="x-jwt-token" mode="new">
            <set-url>https://${wallet-basepath}/pagopa-jwt-issuer-service/tokens</set-url>
            <set-method>POST</set-method>
            <!-- Set jwt-issuer-service API Key header -->
            <set-header name="x-api-key" exists-action="override">
              <value>{{pay-wallet-jwt-issuer-api-key-value}}</value>
            </set-header>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>@{
              var userId = ((string)context.Variables.GetValueOrDefault("xUserId",""));
              var walletId = ((string)context.Variables.GetValueOrDefault("walletId",""));
              var transactionId = ((string)context.Variables.GetValueOrDefault("transactionId",""));
              return new JObject(
                      new JProperty("audience", "wallet"),
                      new JProperty("duration", 900),
                      new JProperty("privateClaims", new JObject(
                          new JProperty("walletId", walletId),
                          new JProperty("transactionId", transactionId),
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
        <set-variable name="body" value="@(context.Response.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="redirectUrl" value="@((string)((JObject) context.Variables["body"])["redirectUrl"])" />
        <choose>
          <when condition="@(!String.IsNullOrEmpty((string)context.Variables["redirectUrl"]))">
              <set-body>@{
                  JObject inBody = context.Response.Body.As<JObject>(preserveContent: true);
                  var redirectUrl = inBody["redirectUrl"];
                  inBody["redirectUrl"] = redirectUrl + "&sessionToken=" + ((string)context.Variables.GetValueOrDefault("token",""));
                  return inBody.ToString();
              }</set-body>
          </when>
        </choose>
      </when>
    </choose>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
