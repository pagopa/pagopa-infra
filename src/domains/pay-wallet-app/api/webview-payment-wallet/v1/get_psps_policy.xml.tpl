<policies>
    <inbound>
        <base />

        <set-backend-service base-url="https://${gec_hostname}/pagopa-afm-calculator-service" />
        <rewrite-uri template="fees" />
        <set-method>POST</set-method>

        <send-request ignore-error="false" timeout="10" response-variable-name="walletResponse">
            <set-url>@("https://${wallet_hostname}/pagopa-wallet-service/wallets/" + context.Variables["walletId"])</set-url>
            <set-method>GET</set-method>
            <set-header name="x-user-id" exists-action="override">
                <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
            </set-header>
            <set-header name="x-api-key" exists-action="override">
              <value>{{payment-wallet-service-rest-api-key}}</value>
            </set-header>
        </send-request>

        <choose>
            <when condition="@(((IResponse)context.Variables["walletResponse"]).StatusCode == 404)">
                <return-response>
                    <set-status code="404" reason="Not Found" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "title": "Wallet not found",
                            "status": 404,
                            "detail": "Couldn't find the requested wallet"
                        }
                    </set-body>
                </return-response>
            </when>
            <when condition="@(((IResponse)context.Variables["walletResponse"]).StatusCode != 200)">
                <return-response>
                    <set-status code="502" reason="Bad Gateway" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "title": "Error retrieving wallet",
                            "status": 502,
                            "detail": "There was an error while retrieving wallet"
                        }
                    </set-body>
                </return-response>
            </when>
        </choose>

        <set-variable name="paymentMethodId" value="@(((IResponse) context.Variables["walletResponse"]).Body.As<JObject>()["paymentMethodId"])" />

        <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
            <set-url>@("https://${ecommerce_hostname}/pagopa-ecommerce-payment-methods-service/payment-methods/" + context.Variables["paymentMethodId"])</set-url>
            <set-method>GET</set-method>
            <set-header name="x-client-id" exists-action="override">
                <value>IO</value>
            </set-header>
        </send-request>

        <set-variable name="paymentMethodsResponseBody" value="@(((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />

        <choose>
            <when condition="@(((IResponse) context.Variables["paymentMethodsResponse"]).StatusCode == 404)">
                <return-response>
                    <set-status code="404" reason="Not Found" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "title": "Payment method not found",
                            "status": 404,
                            "detail": "Couldn't find the provided payment method"
                        }
                    </set-body>
                </return-response>
            </when>
            <when condition="@(((string) ((JObject) context.Variables["paymentMethodsResponseBody"])["status"]) != "ENABLED")">
                <return-response>
                    <set-status code="422" reason="Unprocessable Entity" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "title": "Payment method is not enabled",
                            "status": 422,
                            "detail": "The payment method associated to this wallet is not currently enabled"
                        }
                    </set-body>
                </return-response>
            </when>
            <when condition="@(((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode != 200)">
                <return-response>
                    <set-status code="502" reason="Bad Gateway" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "title": "Error retrieving eCommerce payment methods",
                            "status": 502,
                            "detail": "There was an error retrieving eCommerce payment methods"
                        }
                    </set-body>
                </return-response>
            </when>
        </choose>

        <set-variable name="paymentMethodTypeCode" value="@((string)((JObject) context.Variables["paymentMethodsResponseBody"])["paymentTypeCode"])" />

        <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
        </set-header>

        <set-body>
            @{
                var requestBody = new JObject();
                requestBody["touchpoint"] = "IO";
                requestBody["paymentMethod"] = (string) context.Variables["paymentMethodTypeCode"];
                requestBody["paymentAmount"] = 1;
                requestBody["isAllCcp"] = false;
                requestBody["primaryCreditorInstitution"] = "";

                var transfer = new JObject();
                transfer["creditorInstitution"] = "";
                transfer["digitalStamp"] = false;

                var transferList = new JArray();
                transferList.Add(transfer);
                requestBody["transferList"] = transferList;

                return requestBody.ToString();
            }
        </set-body>
    </inbound>
    <outbound>
        <base />

        <choose>
            <when condition="@(context.Response.StatusCode == 200)">
                <set-body>
                    @{
                        var response = context.Response.Body.As<JObject>();
                        foreach (var value in response["bundleOptions"]) {
                            var bundle = (JObject) value;

                            if (bundle["idCiBundle"].Type == JTokenType.Null) {
                                bundle.Remove("idCiBundle");
                            }
                        }

                        return response.ToString();
                    }
                </set-body>
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
