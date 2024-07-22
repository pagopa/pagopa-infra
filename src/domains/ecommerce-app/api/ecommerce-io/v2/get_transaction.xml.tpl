<policies>
    <inbound>
        <base />
        <choose>
        <when condition="@("PM".Equals("{{ecommerce-for-io-pm-npg-ff}}") || ("NPGFF".Equals("{{ecommerce-for-io-pm-npg-ff}}") && !"{{pay-wallet-family-friends-user-ids}}".Contains(((string)context.Variables["sessionTokenUserId"]))))"> 
            <set-variable name="requestTransactionId" value="@{
                var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
                return transactionId;
            }" />
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
            <set-variable name="pagopaProxyCcpResponseHttpResponseCode" value="@((int)((IResponse)context.Variables["pagopaProxyCcpResponse"]).StatusCode)" />
            <set-variable name="pagopaProxyResponseBody" value="@(((IResponse)context.Variables["pagopaProxyCcpResponse"]).Body.As<JObject>())" />
            <cache-lookup-value key="@($"ecommerce:{context.Variables["requestTransactionId"]}-rptId")" variable-name="cacheRptId" caching-type="internal" /> 
            <cache-lookup-value key="@($"ecommerce:{context.Variables["requestTransactionId"]}-amount")" variable-name="cacheAmount" caching-type="internal" /> 
            <choose>
                <when condition="@((int)context.Variables["pagopaProxyCcpResponseHttpResponseCode"] == 200)">
                    <send-request ignore-error="true" timeout="10" response-variable-name="pmActionsCheckResponse">
                        <set-url>@("{{pm-host}}/pp-restapi-CD/v1/payments/" + ((JObject)context.Variables["pagopaProxyResponseBody"])["idPagamento"] + "/actions/check")</set-url>
                        <set-method>GET</set-method>
                    </send-request>
                    <return-response>
                        <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                        </set-header>
                        <set-body>@{
                            JObject eCommerceResponseBody = new JObject();
                            eCommerceResponseBody["transactionId"] = (string) context.Variables["requestTransactionId"];
                            eCommerceResponseBody["status"] = "ACTIVATED";
                            eCommerceResponseBody["clientId"] = "IO";
                            JObject payment = new JObject();
                            payment["rptId"] = (string) context.Variables["cacheRptId"];
                            payment["amount"] = (int) context.Variables["cacheAmount"];
                            payment["paymentToken"] = (string) ((JObject) context.Variables["pagopaProxyResponseBody"])["idPagamento"];
                            JArray payments = new JArray();
                            payments.Add(payment);
                            eCommerceResponseBody["payments"] = payments;
                            return eCommerceResponseBody.ToString();
                            }
                        </set-body>
                    </return-response>
                </when>
                <when condition="@((int)context.Variables["pagopaProxyCcpResponseHttpResponseCode"] == 404)">
                    <return-response>
                        <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                        <set-body>@{
                            JObject eCommerceResponseBody = new JObject();
                            eCommerceResponseBody["transactionId"] = (string) context.Variables["requestTransactionId"];
                            eCommerceResponseBody["status"] = "ACTIVATION_REQUESTED";
                            eCommerceResponseBody["payments"] = new JArray();
                            JObject payment = new JObject();
                            payment["rptId"] = (string) context.Variables["cacheRptId"];
                            payment["amount"] = (int) context.Variables["cacheAmount"];
                            JArray payments = new JArray();
                            payments.Add(payment);
                            eCommerceResponseBody["payments"] = payments;
                            return eCommerceResponseBody.ToString();
                            }
                        </set-body>
                    </return-response>
                </when>
                <otherwise>
                    <return-response>
                        <set-status code="404" reason="Not found" />
                        <set-header name="Content-Type" exists-action="override">
                            <value>application/json</value>
                        </set-header>
                        <set-body>{
                                "title": "Unable to get transaction status",
                                "status": 404,
                                "detail": "Transaction not found",
                            }</set-body>
                    </return-response>
                </otherwise>
            </choose>
        </when>
        </choose>
    </inbound>

    <outbound>
        <base />
    </outbound>

    <backend>
        <base />
    </backend>
</policies>