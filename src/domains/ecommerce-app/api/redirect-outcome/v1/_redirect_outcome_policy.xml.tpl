<policies>
    <inbound>
        <base /> 
        <!-- start request validation -->
        <validate-content unspecified-content-type-action="prevent" max-size="102400" size-exceeded-action="prevent" errors-variable-name="requestBodyValidation">
           <content type="application/json" validate-as="json" action="prevent" />
        </validate-content>
        <!-- end request validation -->
        <!-- start set policy variables -->
        <set-variable name="redirectRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <set-variable name="transactionId" value="@(context.Request.MatchedParameters["idTransaction"])" />
        <set-variable name="transactionServiceBackendUri" value="https://${hostname}/pagopa-ecommerce-transactions-service" />
        <!-- end set policy variables -->
        <!-- send transactions service PATCH request -->
        <send-request mode="new" response-variable-name="transactionServiceAuthorizationPatchResponse" timeout="10" ignore-error="true">
            <set-url>@(String.Format((string)context.Variables["transactionServiceBackendUri"]+"/transactions/{0}/auth-requests", (string)context.Variables["transactionId"]))</set-url>
            <set-method>PATCH</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-header name="x-payment-gateway-type" exists-action="override">
                <value>"REDIRECT"</value>
            </set-header>
            <set-body>
                @{
                JObject requestBody = (JObject)context.Variables["redirectRequestBody"];
                string outcome = (string)requestBody["outcome"];
                string timestampOperation = null;
                string errorCode = null;
                string authorizationCode = null;
                if(outcome == "OK"){
                    authorizationCode = (string)requestBody["authorizationCode"];
                    timestampOperation = (string)requestBody["timestampOperation"];
                } else {
                    errorCode = (string)requestBody["errorCode"];
                    //we receive timestamp operation only for authorized transactions (outcome OK)
                    //in case of error set timestampOperation to now since this field is mandatory in eCommerce transactions service api
                    timestampOperation = DateTimeOffset.Now.ToString("o");
                }
                string pspTransactionId = (string)requestBody["idPSPTransaction"];;
                JObject outcomeGateway = new JObject();
                outcomeGateway["paymentGatewayType"] = "REDIRECT";
                outcomeGateway["outcome"] = outcome;
                outcomeGateway["pspTransactionId"] = pspTransactionId;
                outcomeGateway["authorizationCode"] = authorizationCode;
                outcomeGateway["errorCode"] = errorCode;
                JObject response = new JObject();
                response["timestampOperation"] = timestampOperation;
                response["outcomeGateway"] = outcomeGateway;
                return response.ToString();
                }
            </set-body>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["transactionServiceAuthorizationPatchResponse"]).StatusCode) == 200)">
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    @{
                        string transactionId = (string)context.Variables["eCommerceTransactionId"];
                        JObject response = new JObject();
                        response["idTransaction"] = transactionId;
                        response["outcome"] = "OK";
                        return response.ToString();
                    }
                </set-body>
            </when>
            <otherwise>
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    @{
                        string transactionId = (string)context.Variables["eCommerceTransactionId"];
                        JObject response = new JObject();
                        response["idTransaction"] = transactionId;
                        response["outcome"] = "KO";
                        return response.ToString();
                    }
                </set-body>
            </otherwise>
        </choose>
        <!-- end send transactions service PATCH request -->
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound />
    <on-error>
        <base />
         <choose>
            <when condition="@(context.LastError.Source == "validate-content")">
                <return-response>
                    <set-status code="400" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                    @{
                        string transactionId = (string)context.Variables["eCommerceTransactionId"];
                        JObject validationErrorResponse = new JObject();
                        validationErrorResponse["status"] = 400;
                        validationErrorResponse["title"] = "Bad request";
                        validationErrorResponse["detail"] = "Invalid input request";
                        validationErrorResponse["idTransaction"] = transactionId;
                        return validationErrorResponse.ToString();
                    }
                    </set-body>
                </return-response>
            </when>
            <otherwise>
            <return-response>
                <set-status code="500" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                @{
                    string transactionId = (string)context.Variables["eCommerceTransactionId"];
                    JObject validationErrorResponse = new JObject();
                    validationErrorResponse["status"] = 500;
                    validationErrorResponse["title"] = "Internal Server Error";
                    validationErrorResponse["detail"] = "There was an error processing the request";
                    validationErrorResponse["idTransaction"] = transactionId;
                    return validationErrorResponse.ToString();
                }
                </set-body>
            </return-response>
            </otherwise>
        </choose>
    </on-error>
</policies>
