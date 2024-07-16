<policies>
    <inbound>
        <base />
        <set-variable name="paymentMethodId" value="@(context.Request.MatchedParameters["id"])" />
        <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
            <set-url>@($"https://${ecommerce-basepath}/pagopa-ecommerce-payment-methods-service/payment-methods/{(string)context.Variables["paymentMethodId"]}")</set-url>
            <set-method>GET</set-method>
            <set-header name="X-Client-Id" exists-action="override">
                <value>IO</value>
            </set-header>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode) == 200)">
                <set-variable name="paymentMethod" value="@((JObject)((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />
                <set-variable name="paymentTypeCode" value="@((string)((JObject)context.Variables["paymentMethod"])["paymentTypeCode"])" />
                <set-variable name="isPayPal" value="@(((string)context.Variables["paymentTypeCode"]).Equals("PPAL"))" />
                <set-variable name="isBancomatPay" value="@(((string)context.Variables["paymentTypeCode"]).Equals("BPAY"))" />
                <set-variable name="isCard" value="@(((string)context.Variables["paymentTypeCode"]).Equals("CP"))" />
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
                        "detail": "Payment method not available",
                    }</set-body>
                </return-response>
            </otherwise>
        </choose>
        <choose>
            <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}") )">
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
                    <set-header name="X-Client-Id" exists-action="override">
                        <value>IO</value>
                    </set-header>
                </send-request>
                <choose>
                    <when condition="@((bool)context.Variables["isPayPal"])">
                        <send-request ignore-error="true" timeout="10" response-variable-name="getPspForCardsResponse">
                            <set-url>@($"{{pm-host}}/pp-restapi-CD/v3/paypal/psps")</set-url>
                            <set-method>GET</set-method>
                            <set-header name="Authorization" exists-action="override">
                                <value>@($"Bearer {(string)context.Variables.GetValueOrDefault("sessionToken","")}")</value>
                            </set-header>
                        </send-request>
                    </when>
                    <when condition="@((bool)context.Variables["isCard"] || (bool)context.Variables["isBancomatPay"])">
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
                            <set-status code="502" reason="Bad Gateway" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>{
                                "title": "Bad Gateway",
                                "status": 502,
                                "detail": "PSP not available",
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
                                    bool isPayPal = (bool)context.Variables["isPayPal"];
                                    JArray psps = (JArray)(((JObject)context.Variables["pmPspsResponse"])["data"]);
                                    JObject response = new JObject();
                                    JArray pspResponse = new JArray();
                                    foreach (JObject pmPsp in psps) {
                                        JObject psp = new JObject();
                                        psp["abi"] = pmPsp["codiceAbi"];
                                        psp["bundleName"] = pmPsp["ragioneSociale"];
                                        psp["pspBusinessName"] = pmPsp["ragioneSociale"];
                                        if(isPayPal) {
                                            psp["taxPayerFee"] = pmPsp["maxFee"];
                                            psp["idPsp"] = (string)pmPsp["idPsp"];
                                            psp["idBundle"] = pmPsp["idPsp"];
                                        } else {
                                        psp["taxPayerFee"] = pmPsp["fee"];
                                        psp["idPsp"] = (string)pmPsp["id"];
                                        psp["idBundle"] = pmPsp["idPsp"];
                                        }
                                        pspResponse.Add(psp);
                                    }
                                    response["paymentMethodName"] = ((string)((JObject)context.Variables["paymentMethod"])["name"]);
                                    response["paymentMethodDescription"] = ((string)((JObject)context.Variables["paymentMethod"])["description"]);
                                    response["paymentMethodStatus"] = ((string)((JObject)context.Variables["paymentMethod"])["status"]);
                                    response["belowThreshold"] = false;
                                    response["bundles"] = (JArray)pspResponse;
                                    response["asset"] = "https://assets.cdn.platform.pagopa.it/creditcard/generic.png";
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
            <otherwise>
                <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
                <set-variable name="walletId" value="@((string)((JObject) context.Variables["body"])["walletId"])" />
                <choose>
                    <when condition="@((bool)context.Variables["isCard"] && !String.IsNullOrEmpty((string)context.Variables["walletId"]))">
                        <send-request ignore-error="false" timeout="10" response-variable-name="authDataResponse">
                            <set-url>@($"https://${wallet-basepath}/pagopa-wallet-service/wallets/{(string)context.Variables["walletId"]}/auth-data")</set-url>
                            <set-method>GET</set-method>
                        </send-request>
                        <choose>
                            <when condition="@(((int)((IResponse)context.Variables["authDataResponse"]).StatusCode) == 200)">
                                <set-variable name="authDataBody" value="@((JObject)((IResponse)context.Variables["authDataResponse"]).Body.As<JObject>())" />
                                <!-- <set-variable name="contractId" value="@((string)((JObject)context.Variables["authDataBody"])["contractId"])" NO NEED FOR THIS MOMENT /> -->
                                <set-variable name="bin" value="@((string)((JObject)context.Variables["authDataBody"])["paymentMethodData"]["bin"])" />
                            </when>
                            <when condition="@(((int)((IResponse)context.Variables["authDataResponse"]).StatusCode) == 404)">
                                <return-response>
                                    <set-status code="404" reason="Not found" />
                                    <set-header name="Content-Type" exists-action="override">
                                        <value>application/json</value>
                                    </set-header>
                                    <set-body>{
                                        "title": "Unable to get auth data",
                                        "status": 404,
                                        "detail": "Unable to get auth data",
                                    }</set-body>
                                </return-response>
                            </when>
                            <otherwise>
                                <return-response>
                                    <set-status code="502" reason="Bad Gateway" />
                                    <set-header name="Content-Type" exists-action="override">
                                        <value>application/json</value>
                                    </set-header>
                                    <set-body>{
                                        "title": "Bad gateway",
                                        "status": 502,
                                        "detail": "Wallet not available",
                                    }</set-body>
                                </return-response>
                            </otherwise>
                        </choose>
                    </when>
                </choose>
                <set-query-parameter name="maxOccurrences" exists-action="override">
                    <value>100</value>
                </set-query-parameter>
                <set-body>@{
                    var bin = (string)context.Variables.GetValueOrDefault("bin", "");
                    JObject inBody = (JObject)context.Variables["body"];
                    inBody.Remove("walletId");
                    inBody.Remove("paymentToken");
                    inBody.Remove("language");
                    inBody.Add("touchpoint","IO");
                    if(!String.IsNullOrEmpty(bin)) {
                        inBody.Add("bin", bin);
                    }
                    foreach (JObject transfer in ((JArray)(inBody["transferList"]))) {
                        if( transfer.ContainsKey("paFiscalCode") == true )
                        {
                            var creditorInstitution = ((string)transfer["paFiscalCode"]);
                            transfer.Add("creditorInstitution",creditorInstitution);
                            transfer.Remove("paFiscalCode");
                        }
                    }
                    return inBody.ToString();
                }</set-body>
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
