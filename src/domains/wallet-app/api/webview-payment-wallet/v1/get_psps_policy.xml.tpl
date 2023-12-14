<policies>
    <inbound>
        <cors>
            <allowed-origins>
                <origin>${payment_wallet_origin}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>POST</method>
                <method>GET</method>
                <method>OPTIONS</method>
            </allowed-methods>
            <allowed-headers>
                <header>Content-Type</header>
                <header>Authorization</header>
            </allowed-headers>
        </cors>

        <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

        <set-backend-service base-url="https://${gec_hostname}/pagopa-afm-calculator-service" />
        <rewrite-uri template="fees" />
        <set-method>POST</set-method>

        <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
            <set-url>@("https://${ecommerce_hostname}/pagopa-ecommerce-payment-methods-service/payment-methods/" + context.Request.MatchedParameters["paymentMethodId"])</set-url>
            <set-method>GET</set-method>
            <set-header name="x-client-id" exists-action="override">
                <value>IO</value>
            </set-header>
        </send-request>

        <choose>
            <when condition="@(((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode == 404)">
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
            <otherwise>
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
            </otherwise>
        </choose>
        <set-variable name="paymentMethodsResponseBody" value="@(((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />
        <set-variable name="paymentMethodTypeCode" value="@((string)((JObject) context.Variables["paymentMethodsResponseBody"])["paymentTypeCode"])" />

        <set-body>
            @{
                var requestBody = new JObject();
                requestBody["touchpoint"] = "IO";
                requestBody["paymentMethod"] = (string) context.Variables["paymentMethodTypeCode"];
                requestBody["paymentAmount"] = 0;
                requestBody["isAllCcp"] = false;
                requestBody["transferList"] = new JArray();

                return requestBody.ToString();
            }
        </set-body>
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
