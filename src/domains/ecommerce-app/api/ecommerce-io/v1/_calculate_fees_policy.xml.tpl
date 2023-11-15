<policies>
    <inbound>
        <base />
        <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
        <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="walletId" value="@((string)((JObject) context.Variables["body"])["walletId"])" />
        <set-variable name="idWallet" value="@{
                string walletIdUUID = (string)context.Variables["walletId"];
                string walletIdHex = walletIdUUID.Substring(walletIdUUID.Length-17 , 17).Replace("-" , "");
                return Convert.ToInt64(walletIdHex , 16).ToString();
           }" />
        <set-variable name="idPayment" value="@((string)((JObject) context.Variables["body"])["paymentToken"])" />
        <set-variable name="language" value="@((string)((JObject) context.Variables["body"])["language"])" />
        <set-variable name="paymentMethodId" value="@(context.Request.MatchedParameters["id"])" />
        <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
            <set-url>@($"https://${ecommerce-basepath}/pagopa-ecommerce-payment-methods-service/payment-methods/{(string)context.Variables["paymentMethodId"]}")</set-url>
            <set-method>GET</set-method>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode) == 200)">
                <set-variable name="paymentTypeCode" value="@((string)((JObject)((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())["paymentTypeCode"])" />
                <choose>
                    <when condition="@(((string)context.Variables["paymentTypeCode"]).Equals("PPAY"))">
                        <send-request ignore-error="true" timeout="10" response-variable-name="getPspForCardsResponse">
                            <set-url>@($"{{pm-host}}/pp-restapi-CD/v3/paypal/psps")</set-url>
                            <set-method>GET</set-method>
                            <set-header name="Authorization" exists-action="override">
                                <value>@($"Bearer {(string)context.Variables.GetValueOrDefault("sessionToken","")}")</value>
                            </set-header>
                        </send-request>
                    </when>
                    <when condition="@(((string)context.Variables["paymentTypeCode"]).Equals("CP") || ((string)context.Variables["paymentTypeCode"]).Equals("BPAY"))">
                        <send-request ignore-error="true" timeout="10" response-variable-name="getPspForCardsResponse">
                            <set-url>@($"{{pm-host}}/pp-restapi-CD/v2/payments/{(string)context.Variables["idPayment"]}/psps?idWallet={(string)context.Variables["idWallet"]}&language={(string)context.Variables["language"]}&isList=true")</set-url>
                            <set-method>GET</set-method>
                            <set-header name="Authorization" exists-action="override">
                                <value>@($"Bearer {(string)context.Variables.GetValueOrDefault("sessionToken","")}")</value>
                            </set-header>
                        </send-request>
                    </when>
                    <otherwise>
                        <return-response>
                            <set-status code="501" reason="Not implemented" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>{
                                "title": "Unable to handle payment method",
                                "status": 501,
                                "detail": "Payment method not handled",
                            }</set-body>
                        </return-response>
                    </otherwise>
                </choose>
                <choose>
                    <when condition="@(((int)((IResponse)context.Variables["getPspForCardsResponse"]).StatusCode) == 200)">
                        <set-variable name="pmPspsResponse" value="@(((IResponse)context.Variables["getPspForCardsResponse"]).Body.As<JObject>(preserveContent: true))" />
                        <return-response>
                            <set-status code="200" reason="OK" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>@{
                                    JArray psps = (JArray)(((JObject)context.Variables["pmPspsResponse"])["data"]);
                                    JObject response = new JObject();
                                    JArray pspResponse = new JArray();
                                    foreach (JObject pmPsp in psps) {
                                        JObject psp = new JObject();
                                        psp["abi"] = pmPsp["codiceAbi"];
                                        psp["bundleName"] = pmPsp["ragioneSociale"];
                                        psp["idPsp"] = pmPsp["id"];
                                        psp["idBundle"] = pmPsp["idPsp"];
                                        if(pmPsp["fee"] != null) {
                                          psp["taxPayerFee"] = pmPsp["fee"];
                                        }
                                        if(pmPsp["maxFee"] != null) {
                                          psp["taxPayerFee"] = pmPsp["maxFee"];
                                        }
                                        pspResponse.Add(psp);
                                    }
                                    response["paymentMethodName"] = "CARDS";
                                    response["paymentMethodDescription"] = "Carte di credito o debito";
                                    response["paymentMethodStatus"] = "ENABLED";
                                    response["belowThreshold"] = "false";
                                    response["bundles"] = (JArray)pspResponse;
                                    return response.ToString();
                                }</set-body>
                        </return-response>
                    </when>
                    <when condition="@(((int)((IResponse)context.Variables["getPspForCardsResponse"]).StatusCode) == 401)">
                        <return-response>
                            <set-status code="401" reason="Unauthorized" />
                        </return-response>
                    </when>
                    <otherwise>
                        <return-response>
                            <set-status code="404" reason="Not found" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>{
                                    "title": "Unable to get Psps",
                                    "status": 404,
                                    "detail": "Psps not found",
                                }</set-body>
                        </return-response>
                    </otherwise>
                </choose>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode) == 404)">
                <return-response>
                    <set-status code="404" reason="Not found" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
                          "title": "Unable to get payment method",
                          "status": 404,
                          "detail": "Payment method not found",
                      }</set-body>
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="502" reason="Bad Request" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
                          "title": "Bad gateway",
                          "status": 502,
                          "detail": "Payment method not found",
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
    <on-error>
        <base />
    </on-error>
</policies>
