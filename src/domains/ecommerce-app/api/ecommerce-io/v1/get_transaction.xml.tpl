<policies>
  <inbound>
    <set-variable name="requestTransactionId" value="@{
            var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
            if(transactionId == ""){
                transactionId = context.Request.Headers.GetValueOrDefault("x-transaction-id-from-client","");
            }
            return transactionId;
    }" />
    <set-header name="x-transaction-id" exists-action="delete" />
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
        <issuer-signing-keys>
            <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key>
        </issuer-signing-keys>
    </validate-jwt>
    <set-variable name="tokenTransactionId" value="@{
    var jwt = (Jwt)context.Variables["jwtToken"];
    if(jwt.Claims.ContainsKey("transactionId")){
        return jwt.Claims["transactionId"][0];
    }
    return "";
    }" />
    <choose>
        <when condition="@((string)context.Variables.GetValueOrDefault("tokenTransactionId","") != (string)context.Variables.GetValueOrDefault("requestTransactionId",""))">
            <return-response>
                <set-status code="401" reason="Unauthorized" />
            </return-response>
        </when>
        <when condition="@((string)context.Variables["requestTransactionId"] != "")">
            <set-header name="x-transaction-id" exists-action="override">
                <value>@((string)context.Variables.GetValueOrDefault("requestTransactionId",""))</value>
            </set-header>
        </when>
    </choose>

    <set-variable name="bearerToken" value="@{
      string authorizationHeader = context.Request.Headers["Authorization"];

      return authorizationHeader.Substring(0, "Bearer ".Length);
    }" />

    <send-request ignore-error="false" timeout="10" response-variable-name="pagopaProxyCcpResponse">
        <set-url>@("${pagopa-proxy-basepath}/payment-activations/" + context.Variables["requestTransactionId"])</set-url>
        <set-method>GET</set-method>
    </send-request>

    <choose>
        <when condition="@(context.Variables["pagopaProxyCcpResponse"].StatusCode == 200)">
            <set-variable name="eCommerceStatus" value="ACTIVATED" />

            <send-request ignore-error="true" timeout="10" response-variable-name="pmActionsCheckResponse">
                <set-url>@("${pm-basepath}/payments/" + context.Variables["pagopaProxyCcpResponse"].Body.As<JObject>["idPagamento"] + "/actions/check")</set-url>
                <set-method>GET</set-method>
            </send-request>
        </when>
        <when condition="@(context.Variables["pagopaProxyCcpResponse"].StatusCode == 404)">
            <set-variable name="eCommerceStatus" value="ACTIVATION_REQUESTED" />
        </when>
        <otherwise>
            <return-response response-variable-name="existing context variable">
                <set-status code="502" reason="Bad Gateway" />
                <set-body>
                    {
                        "title": "Unable to get transaction status",
                        "status": 502,
                        "detail": "There was an error while getting the idPayment associated to the transaction",
                    }
                </set-body>
            </return-response>
        </otherwise>
    </choose>
  </inbound>

  <outbound>
      <base />

      <set-body>
        @{
          JObject eCommerceResponseBody = new JObject();
          eCommerceResponseBody["transactionId"] = context.Variables["requestTransactionId"];
          eCommerceResponseBody["status"] = context.Variables["eCommerceStatus"];
          eCommerceResponseBody["payments"] = new List<int>{};
          eCommerceResponseBody["clientId"] = "IO";
          eCommerceResponseBody["authToken"] = context.Variables["jwtToken"];

          return eCommerceResponseBody;
        }
    </set-body>

  </outbound>

  <backend>
      <base />
  </backend>
</policies>
