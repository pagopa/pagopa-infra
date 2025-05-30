<policies>
    <inbound>
        <base />
        <!-- start validation policy -->
        <set-variable name="orderId" value="@(context.Request.MatchedParameters["orderId"])" />
        <!--  Check if Authorization header is present -->
        <choose>
            <when condition="@(!context.Request.Url.Query.ContainsKey("sessionToken"))">
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
                    <set-body>Unauthorized</set-body>
                </return-response>
            </when>
        </choose>
        <!-- Extract 'iss' claim -->
        <set-variable name="jwtIssuer" value="@{
            Jwt jwt;
            context.Request.Url.Query.GetValueOrDefault("sessionToken","").Split(' ').Last().TryParseJwt(out jwt);
            return jwt?.Claims.GetValueOrDefault("iss", "");
        }" />
        <!-- Store useOpenId as string 'true' or 'false' -->
        <set-variable name="useOpenId" value="@(
            (context.Variables.GetValueOrDefault<string>("jwtIssuer")?.Contains("jwt-issuer-service") == true).ToString()
        )" />
        <!-- Conditional validation -->
        <choose>
            <when condition="@(bool.Parse(context.Variables.GetValueOrDefault<string>("useOpenId")))">
                <validate-jwt query-parameter-name="sessionToken" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
                  <openid-config url="https://${hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
                  <audiences>
                    <audience>npg</audience>
                  </audiences>
                  <required-claims>
                    <claim name="orderId" match="all">
                      <value>@((string)context.Variables.GetValueOrDefault("orderId",""))</value>
                    </claim>
                 </required-claims>
                </validate-jwt>
            </when>
            <otherwise>
                <validate-jwt query-parameter-name="sessionToken" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-signed-tokens="true" output-token-variable-name="jwtToken">
                  <issuer-signing-keys>
                      <key>{{npg-notification-jwt-secret}}</key>
                  </issuer-signing-keys>
                  <required-claims>
                    <claim name="orderId" match="all">
                      <value>@((string)context.Variables.GetValueOrDefault("orderId",""))</value>
                    </claim>
                 </required-claims>
                </validate-jwt>
            </otherwise>
        </choose>
        <!-- end validation policy -->
      <!-- start policy variables -->
      <set-variable name="transactionId" value="@{
           var jwt = (Jwt)context.Variables["jwtToken"];
           if(jwt.Claims.ContainsKey("transactionId")){
               string uuidString = jwt.Claims["transactionId"][0];
               return uuidString.Replace("-", "");
           }
           return "";
        }" />
        <set-variable name="paymentMethodId" value="@{
            var jwt = (Jwt)context.Variables["jwtToken"];
            if(jwt.Claims.ContainsKey("paymentMethodId")){
                return jwt.Claims["paymentMethodId"][0];
            }
            return "";
        }" />
        <choose>
            <when condition="@((string)context.Variables["transactionId"] == "" && (string)context.Variables["paymentMethodId"] == "")">
                <return-response>
                    <set-status code="500" reason="Mandatory data missing" />
                </return-response>
            </when>
        </choose>
        <set-variable name="paymentMethodBackendUri" value="https://${hostname}/pagopa-ecommerce-payment-methods-service" />
        <set-variable name="transactionServiceBackendUri" value="https://${hostname}/pagopa-ecommerce-transactions-service" />
        <set-variable name="npgNotificationRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <!-- end policy variables -->
        <!-- start request validation
        <validate-content unspecified-content-type-action="prevent" max-size="102400" size-exceeded-action="prevent" errors-variable-name="requestBodyValidation">
           <content type="application/json" validate-as="json" action="prevent" />
        </validate-content>
         end request validation -->
        <!-- payment method verify session -->
        <choose>
            <when condition="@((string)context.Variables["transactionId"] == "")">
                <send-request mode="new" response-variable-name="paymentMethodSessionVerificationResponse" timeout="10" ignore-error="true">
                    <set-url>@(String.Format((string)context.Variables["paymentMethodBackendUri"]+"/v2/payment-methods/{0}/sessions/{1}/transactionId", (string)context.Variables["paymentMethodId"], (string)context.Variables["orderId"]))</set-url>
                    <set-method>GET</set-method>
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-header name="Authorization" exists-action="override">
                        <value> @{
                                JObject requestBody = (JObject)context.Variables["npgNotificationRequestBody"];
                                return "Bearer " + (string)requestBody["securityToken"];
                            }</value>
                    </set-header>
                </send-request>
                <choose>
                    <when condition="@(((int)((IResponse)context.Variables["paymentMethodSessionVerificationResponse"]).StatusCode) != 200)">
                        <trace source="ecommerce_npg_notify" severity="error">
                            <message>NPG Notification Error - Payment Method</message>
                            <metadata name="paymentMethodResponseCode" value="@(((int)((IResponse)context.Variables["paymentMethodSessionVerificationResponse"]).StatusCode).ToString())" />
                        </trace>
                        <return-response>
                            <set-status code="500" reason="Error retrieving session" />
                        </return-response>
                    </when>
                </choose>
                <set-variable name="transactionId" value="@(((string)((IResponse)context.Variables["paymentMethodSessionVerificationResponse"]).Body.As<JObject>(preserveContent: true)["transactionId"]))" />
            </when>
        </choose>
        <!-- end payment method verify session -->
        <!-- send transactions service PATCH request -->
        <set-backend-service base-url="@((string)context.Variables["transactionServiceBackendUri"])" />
        <rewrite-uri template="@(String.Format("/v2/transactions/{0}/auth-requests", (string)context.Variables["transactionId"]))" copy-unmatched-params="false"/>
        <set-method>PATCH</set-method>
        <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
        </set-header>
        <set-header name="x-payment-gateway-type" exists-action="override">
            <value>"NPG"</value>
        </set-header>
        <set-body>@{
                        JObject requestBody = (JObject)context.Variables["npgNotificationRequestBody"];
                        JObject operation = (JObject)requestBody["operation"];
                        string operationResult = (string)operation["operationResult"];
                        string orderId = (string)operation["orderId"];
                        string operationId = (string)operation["operationId"];
                        string paymentCircuit = (string)operation["paymentCircuit"];
                        var additionalData = operation["additionalData"];
                        string authorizationCode = null;
                        string errorCode = null;
                        string rrn = null;
                        string validationServiceId = null;
                        string bpayEndToEndId = null;
                        string myBankEndToEndId = null;
                        if(additionalData != null && additionalData.Type != JTokenType.Null){
                            JObject receivedAdditionalData = (JObject)additionalData;
                            authorizationCode = (string)receivedAdditionalData["authorizationCode"];
                            errorCode = (string)receivedAdditionalData["authorizationStatus"];
                            rrn = (string)receivedAdditionalData["rrn"];
                            validationServiceId = (string)receivedAdditionalData["validationServiceId"];
                            bpayEndToEndId = (string)receivedAdditionalData["bpayEndToEndId"];
                            myBankEndToEndId = (string)receivedAdditionalData["myBankEndToEndId"];
                        }
                        string paymentEndToEndId = null;
                        switch(paymentCircuit){
                            case "BANCOMATPAY":
                                paymentEndToEndId = bpayEndToEndId;
                                break;
                            case "MYBANK":
                                paymentEndToEndId = myBankEndToEndId;
                                break;
                            default:
                                paymentEndToEndId =  (string)operation["paymentEndToEndId"];
                                break;
                        }
                        string operationTime = (string)operation["operationTime"];
                        string timestampOperation = null;
                        if(operationTime != null) {
                            DateTime npgDateTime = DateTime.Parse(operationTime.Replace(" ","T"));
                            TimeZoneInfo zone = TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time");
                            DateTime utcDateTime = TimeZoneInfo.ConvertTimeToUtc(npgDateTime, zone);
                            DateTimeOffset dateTimeOffset = new DateTimeOffset(utcDateTime);
                            timestampOperation = dateTimeOffset.ToString("o");
                        }
                        JObject outcomeGateway = new JObject();
                        outcomeGateway["paymentGatewayType"] = "NPG";
                        outcomeGateway["operationResult"] = operationResult;
                        outcomeGateway["orderId"] = orderId;
                        outcomeGateway["operationId"] = operationId;
                        outcomeGateway["errorCode"] = errorCode;
                        outcomeGateway["authorizationCode"] = authorizationCode;
                        outcomeGateway["paymentEndToEndId"] = paymentEndToEndId;
                        outcomeGateway["rrn"] = rrn;
                        outcomeGateway["validationServiceId"] = validationServiceId;
                        JObject response = new JObject();
                        response["timestampOperation"] = timestampOperation;
                        response["outcomeGateway"] = outcomeGateway;
                        return response.ToString();
                     }
        </set-body>
        <!-- end send transactions service PATCH request -->
    </inbound>
    <backend>
        <retry condition="@(context.Response.StatusCode >= 500)"
              interval="2" count="3" first-fast-retry="true">
              <forward-request timeout="10" buffer-request-body="true" />
        </retry>
    </backend>
    <outbound>
        <!-- forward transaction-service response but set empty body for response -->
        <set-body></set-body>
    </outbound>
    <on-error>
        <trace source="ecommerce_npg_notify" severity="error">
            <message>NPG Notification Error</message>
            <metadata name="errorSource" value="@(context.LastError.Source)" />
            <metadata name="errorMessage" value="@(context.LastError.Message)" />
            <metadata name="errorReason" value="@(context.LastError?.Reason ?? "-")" />
            <metadata name="errorSection" value="@(context.LastError?.Section ?? "-")" />
            <metadata name="errorPath" value="@(context.LastError?.Path ?? "-")" />
            <metadata name="errorStatusCode" value="@((context.Response?.StatusCode ?? -1).ToString())" />
        </trace>
        <base />
    </on-error>
</policies>
