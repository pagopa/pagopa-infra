<policies>
  <inbound>
    <!-- TODO check fees and set psp with put wallet -->
    <!-- Get transactionId from request -->
    <set-variable name="requestTransactionId" value="@{
        var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
        return transactionId;
    }" />

    <!-- SessionToken check -->
    <!--
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
        <issuer-signing-keys>
            <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key>
        </issuer-signing-keys>
        <required-claims>
            <claim name="transactionId">
                <value>@((string)context.Variables.GetValueOrDefault("tokenTransactionId",""))</value>
            </claim>
        </required-claims>
    </validate-jwt>
    -->
    
    <!-- Check ccp/idPagamento given transactionId -->
    <send-request
        response-variable-name="pagopaProxyResponse"
        timeout="10"
    >
        <set-url>@("{{pagopa-appservice-proxy-url}}/payment-activations/" + context.Variables["requestTransactionId"])</set-url>
        <set-method>GET</set-method>
        <set-header name="X-Client-Id" exists-action="override">
          <value>CLIENT_IO</value>
        </set-header>
    </send-request>
    <choose>
        <when condition="@(((int)((IResponse)context.Variables["pagopaProxyResponse"]).StatusCode) == 200)">
          <set-variable name="idPayment" value="@((string)((IResponse)context.Variables["pagopaProxyResponse"]).Body.As<JObject>()["idPagamento"])" />
          <set-variable  name="sessionToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
          <set-variable name="walletId" value="@{
                string walletIdUUID = (string) context.Request.Body.As<JObject>()["details"]["walletId"];
                string walletIdHex = walletIdUUID.Substring(walletIdUUID.Length-17 , 17).Replace("-" , ""); 
                return Convert.ToInt64(walletIdHex , 16).ToString();
            }" />
          <!-- Return url to execute PM webview -->
          <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <!-- set cookies for redirect to eCommerce outcome url -->
            <set-header name="Set-Cookie" exists-action="append">
                  <value>isEcommerceTransaction=true; path=/pp-restapi-CD; SameSite=None; Secure</value>
                  <value>@($"ecommerceTransactionId={(string)context.Variables["requestTransactionId"]}; path=/pp-restapi-CD; SameSite=None; Secure")</value>
              </set-header>
            <set-body>
                @{
                    JObject response = new JObject();
                    response["authorizationUrl"] = $"https://${webview_host}/${webview_path}#idWallet={(string)context.Variables["walletId"]}&idPayment={(string)context.Variables["idPayment"]}&sessionToken={(string)context.Variables["sessionToken"]}&language=IT";
                    response["authorizationRequestId"] = (string)context.Variables["requestTransactionId"];
                    return response.ToString();
                }
            </set-body>
          </return-response>
        </when>
        <otherwise>
            <return-response response-variable-name="existing context variable">
                <set-status code="404" reason="Not found" />
                <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
                </set-header>
                <set-body>{
                    "title": "Unable to execute auth request",
                    "status": 404,
                    "detail": "Transaction not found",
                }</set-body>
            </return-response>
        </otherwise>
    </choose>

  </inbound>

  <outbound>
    <base />
  </outbound>

  <backend>
      <base />
  </backend>
</policies>
