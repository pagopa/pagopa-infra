<policies>
    <inbound>
        <base />
        <set-variable name="requestTransactionId" value="@{
            var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
            if(transactionId == ""){
                transactionId = context.Request.Headers.GetValueOrDefault("x-transaction-id-from-client","");
            }
            return transactionId;
        }" />
        <set-header name="x-transaction-id" exists-action="delete" />
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
        <send-request ignore-error="false" timeout="10" response-variable-name="pagopaProxyCcpResponse">
            <set-url>@("{{pagopa-appservice-proxy-url}}/payment-activations/" + context.Variables["requestTransactionId"])</set-url>
            <set-method>GET</set-method>
            <set-header name="X-Client-Id" exists-action="override">
                <value>CLIENT_IO</value>
            </set-header>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["pagopaProxyCcpResponse"]).StatusCode) == 200)">
                <set-variable name="eCommerceStatus" value="ACTIVATED" />
                <send-request ignore-error="true" timeout="10" response-variable-name="pmActionsCheckResponse">
                    <set-url>@("{{pm-host}}/pp-restapi-CD/v1/payments/" + ((IResponse)context.Variables["pagopaProxyCcpResponse"]).Body.As
                        <JObject>()["idPagamento"] + "/actions/check")</set-url>
                    <set-method>GET</set-method>
                </send-request>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["pagopaProxyCcpResponse"]).StatusCode) == 404)">
                <set-variable name="eCommerceStatus" value="ACTIVATION_REQUESTED" />
            </when>
            <otherwise>
                <return-response response-variable-name="existing context variable">
                    <set-status code="404" reason="Not found" />
                    <set-body>{
                            "title": "Unable to get transaction status",
                            "status": 404,
                            "detail": "Transaction not found",
                        }</set-body>
                </return-response>
            </otherwise>
        </choose>
      
    </inbound>

    <outbound>
        <base />

        <set-status code="200" reason="OK" />
        <set-body>
            @{
                JObject eCommerceResponseBody = new JObject();
                eCommerceResponseBody["transactionId"] = (string) context.Variables["requestTransactionId"];
                eCommerceResponseBody["status"] = (string) context.Variables["eCommerceStatus"];
                eCommerceResponseBody["payments"] = new JArray();
                eCommerceResponseBody["clientId"] = "IO";

                return eCommerceResponseBody.ToString();
            }
        </set-body>

    </outbound>

    <backend>
        <base />
    </backend>
</policies>