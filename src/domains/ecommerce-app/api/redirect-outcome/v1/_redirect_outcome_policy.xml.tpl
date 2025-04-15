<policies>
    <inbound>
        <base />
         <set-variable name="transactionId" value="@(context.Request.MatchedParameters["idTransaction"])" />
        <!-- start request validation
        <validate-content unspecified-content-type-action="prevent" max-size="102400" size-exceeded-action="prevent" errors-variable-name="requestBodyValidation">
           <content type="application/json" validate-as="json" action="prevent" />
        </validate-content>
         end request validation -->
        <!-- start set policy variables -->
        <set-variable name="redirectRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <set-variable name="transactionServiceBackendUri" value="https://${hostname}/pagopa-ecommerce-transactions-service" />
        <!-- end set policy variables -->
        <!-- send transactions service PATCH request -->
        <send-request mode="new" response-variable-name="transactionServiceAuthorizationPatchResponse" timeout="10" ignore-error="false">
            <set-url>@(String.Format((string)context.Variables["transactionServiceBackendUri"]+"/v2/transactions/{0}/auth-requests", (string)context.Variables["transactionId"]))</set-url>
            <set-method>PATCH</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-header name="x-payment-gateway-type" exists-action="override">
                <value>REDIRECT</value>
            </set-header>
            <set-body>
                @{
                JObject requestBody = (JObject)context.Variables["redirectRequestBody"];
                string outcome = (string)requestBody["outcome"];
                string timestampOperation = null;
                string errorCode = null;
                string authorizationCode = null;
                string pspId = (string)requestBody["idPsp"];
                if(outcome == "OK"){
                    authorizationCode = (string)requestBody["details"]["authorizationCode"];
                    timestampOperation = ((DateTimeOffset)requestBody["details"]["timestampOperation"]).ToString("o");
                } else {
                    errorCode = (string)requestBody["details"]["errorCode"];
                    //we receive timestamp operation only for authorized transactions (outcome OK)
                    //in case of error set timestampOperation to now since this field is mandatory in eCommerce transactions service api
                    timestampOperation = DateTimeOffset.Now.ToString("o");
                }
                string pspTransactionId = (string)requestBody["idPSPTransaction"];;
                JObject outcomeGateway = new JObject();
                outcomeGateway["paymentGatewayType"] = "REDIRECT";
                outcomeGateway["pspTransactionId"] = pspTransactionId;
                outcomeGateway["outcome"] = outcome;
                outcomeGateway["pspId"] = pspId;
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
                <return-response>
                     <set-status code="200" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                        @{
                            string transactionId = (string)context.Variables["transactionId"];
                            JObject response = new JObject();
                            response["idTransaction"] = transactionId;
                            response["outcome"] = "OK";
                            return response.ToString();
                        }
                    </set-body>
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="@(((int)((IResponse)context.Variables["transactionServiceAuthorizationPatchResponse"]).StatusCode))" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                    @{
                        JObject transactionsServiceErrorResponseBody = ((IResponse)context.Variables["transactionServiceAuthorizationPatchResponse"]).Body.As<JObject>(preserveContent: true);
                        string transactionId = (string)context.Variables["transactionId"];
                        transactionsServiceErrorResponseBody["idTransaction"] = transactionId;
                        return transactionsServiceErrorResponseBody.ToString();
                    }
                    </set-body>
            </return-response>
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
                        string transactionId = (string)context.Variables["transactionId"];
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
            <when condition="@(context.LastError.Source == "authorization")">
                <return-response>
                    <set-status code="401" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                    {
                        "status": 401,
                        "title": "Unauthorized",
                        "detail": "Unauthorized"
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
                    string transactionId = (string)context.Variables["transactionId"];
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
