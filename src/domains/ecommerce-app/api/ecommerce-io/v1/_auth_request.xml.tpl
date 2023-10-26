<policies>
  <inbound>
    <!-- TODO check fees and set psp with put wallet -->
    <!-- Get transactionId from request -->
    <set-variable name="requestTransactionId" value="@{
        var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
        if(transactionId == ""){
            transactionId = context.Request.Headers.GetValueOrDefault("x-transaction-id-from-client","");
        }
        return transactionId;
    }" />
    <set-header name="x-transaction-id" exists-action="delete" />

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
          <set-variable  name="sessiontToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
          <!-- Return url to execute PM webview -->
          <return-response>
            <set-status code="200" reason="Ok" />
            <set-body>
                @{
                    JObject response = new JObject();
                    response["authorizationUrl"] = $"https://${webview_host}/${webview_path}#idWallet={(string)context.Variables["requestTransactionId"]}&idPayment={(string)context.Variables["idPayment"]}&sessionToken={(string)context.Variables["sessiontToken"]}&language=IT";
                    response["authorizationRequestId"] = (string)context.Variables["requestTransactionId"];
                    return response.ToString();
                }
            </set-body>
          </return-response>
        </when>
        <otherwise>
            <return-response response-variable-name="existing context variable">
                <set-status code="404" reason="Not found" />
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
