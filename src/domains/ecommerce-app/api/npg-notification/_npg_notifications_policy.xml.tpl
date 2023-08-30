<policies>
    <inbound>
        <base />
        <!-- start policy variables -->
        <set-variable name="paymentMethodBackendUri" value="https://weudev.ecommerce.internal.dev.platform.pagopa.it/pagopa-ecommerce-payment-methods-service" />
        <set-variable name="transactionServiceBackendUri" value="https://weudev.ecommerce.internal.dev.platform.pagopa.it/pagopa-ecommerce-transactions-service" />
        <set-variable name="sessionId" value="@(context.Request.MatchedParameters["sessionId"])" />
        <set-variable name="paymentMethodId" value="@(context.Request.MatchedParameters["paymentMethodId"])" />
        <set-variable name="npgNotificationRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <!-- end policy variables -->
        <!-- payment method verify session -->
        <send-request mode="new" response-variable-name="paymentMethodSessionVerificationResponse" timeout="10" ignore-error="false">
            <set-url>@(String.Format((string)context.Variables["paymentMethodBackendUri"]+"/payment-methods/{0}/sessions/{1}/validate", (string)context.Variables["paymentMethodId"], (string)context.Variables["sessionId"]))</set-url>
            <set-method>POST</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body template="liquid">
                    {
                         "securityToken": "{{body.securityToken}}"
                    }
            </set-body>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["paymentMethodSessionVerificationResponse"]).StatusCode) != 200)">
                <return-response>
                    <set-status code="500" reason="Error retrieving session" />
                </return-response>
            </when>
        </choose>
        <set-variable name="transactionId" value="@(((IResponse)context.Variables["paymentMethodSessionVerificationResponse"]).Body.As<JObject>(preserveContent: true)["transactionId"])" />
        <!-- end payment method verify session -->
        <!-- send transactions service PATCH request -->
        <send-request mode="new" response-variable-name="transactionServiceAuthorizationPatchResponse" timeout="10" ignore-error="false">
            <set-url>@(String.Format((string)context.Variables["transactionServiceBackendUri"]+"/transactions/{0}/auth-requests", (string)context.Variables["transactionId"]))</set-url>
            <set-method>PATCH</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body template="liquid">
                    {
                        "outcomeGateway" : {
                            "paymentGatewayType" : "NPG",
                            "operationResult" : "{{body.operation?.operationResult}}",
                            "orderId" : "{{body.operation?.orderId}}",
                            "operationId" : "{{body.operation?.operationId}}",
                            "authorizationCode" : "{{body.operation?.additionalData?.authorizationCode}}",
                            "paymentEndToEndId" : "{{body.operation?.paymentEndToEndId}}"
                        },
                        "timestampOperation" : "{{body.operation?.eventTime | date: "yyyy-MM-ddTHH:mm:ss" }}"
                    }
            </set-body>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["transactionServiceAuthorizationPatchResponse"]).StatusCode) != 200)">
                <return-response>
                    <set-status code="500" reason="Error during transaction status notify" />
                </return-response>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["transactionServiceAuthorizationPatchResponse"]).StatusCode) == 200)">
                <return-response>
                    <set-status code="200" reason="Notification elaborated successfully" />
                </return-response>
            </when>
        </choose>
        <!-- end send transactions service PATCH request -->
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound />
    <on-error>
        <base />
    </on-error>
</policies>