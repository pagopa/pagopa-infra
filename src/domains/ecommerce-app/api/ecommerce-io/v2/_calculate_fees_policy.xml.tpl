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
        <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="walletId" value="@((string)((JObject) context.Variables["body"])["walletId"])" />
        <choose>
            <when condition="@((bool)context.Variables["isCard"] && !String.IsNullOrEmpty((string)context.Variables["walletId"]))">
                <send-request ignore-error="false" timeout="10" response-variable-name="authDataResponse">
                    <set-url>@($"https://${wallet-basepath}/pagopa-wallet-service/wallets/{(string)context.Variables["walletId"]}/auth-data")</set-url>
                    <set-method>GET</set-method>
                    <set-header name="x-api-key" exists-action="override">
                      <value>{{payment-wallet-service-api-key-for-ecommerce-value}}</value>
                    </set-header>
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
            JArray paymentNotices = new JArray();
            JObject paymentNotice = new JObject(
                new JProperty("transferList", ((JArray)(inBody["transferList"]))),
                new JProperty("paymentAmount", inBody["paymentAmount"]),
                new JProperty("primaryCreditorInstitution", inBody["primaryCreditorInstitution"])
            );
            paymentNotices.Add(paymentNotice);
            inBody.Add("paymentNotices",paymentNotices);
            inBody.Remove("transferList");
            inBody.Remove("paymentAmount");
            inBody.Remove("primaryCreditorInstitution");
            return inBody.ToString();
        }</set-body>
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
