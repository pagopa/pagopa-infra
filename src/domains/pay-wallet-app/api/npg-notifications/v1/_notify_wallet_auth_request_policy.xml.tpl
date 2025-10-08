<policies>
    <inbound>
        <base />
        <set-variable name="transactionId" value="@(context.Request.MatchedParameters["transactionId"])" />
        <set-variable name="walletId" value="@(context.Request.MatchedParameters["walletId"])" />
        <set-variable name="orderIdPathParam" value="@(context.Request.MatchedParameters["orderId"])" />
        <set-variable name="npgAuthNotificationRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <set-variable name="orderIdBodyParam" value="@((string)((JObject)((JObject)context.Variables["npgAuthNotificationRequestBody"])["operation"])["orderId"])" />

        <!--  Check if session token is present -->
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
        <validate-jwt query-parameter-name="sessionToken" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
            <openid-config url="https://${hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
            <audiences>
              <audience>npg</audience>
            </audiences>
            <required-claims>
                <claim name="walletId" match="all">
                    <value>@((string)context.Variables.GetValueOrDefault("walletId",""))</value>
                </claim>
                <claim name="transactionId" match="all">
                    <value>@((string)context.Variables.GetValueOrDefault("transactionId",""))</value>
                </claim>
                <claim name="orderId" match="all">
                    <value>@((string)context.Variables.GetValueOrDefault("orderIdPathParam",""))</value>
                </claim>
            </required-claims>
        </validate-jwt>
            

        <choose>
            <when condition="@((string)context.Variables["orderIdPathParam"] != (string)context.Variables["orderIdBodyParam"])">
                <return-response>
                    <set-status code="400" reason="Bad Request" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@{
                        return new JObject(
                            new JProperty("title", "OrderId mismatch"),
                            new JProperty("status", 400),
                            new JProperty("detail", "OrderId in path does not match orderId in body")
                        ).ToString();
                    }</set-body>
                </return-response>
            </when>
        </choose>

        
        <!-- Transform request body for transaction-service -->
        <set-body>
        @{
            JObject requestBody = (JObject)context.Variables["npgAuthNotificationRequestBody"];
            JObject operation = (JObject)requestBody["operation"];

            string operationResult = (string)operation["operationResult"];
            string operationId = (string)operation["operationId"];
            string operationTime = (string)operation["operationTime"];

            var additionalData = operation["additionalData"];
            string timestampOperation = null;
            string errorCode = null;
            string authorizationCode = null;
            string validationServiceId = null;
            string orderId = null;

            // TODO: guarda ecommerce cardId4

            // Parse operation time to ISO 8601 UTC
            if(operationTime != null) {
                DateTime npgDateTime = DateTime.Parse(operationTime.Replace(" ","T"));
                TimeZoneInfo zone = TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time");
                DateTime utcDateTime = TimeZoneInfo.ConvertTimeToUtc(npgDateTime, zone);
                DateTimeOffset dateTimeOffset = new DateTimeOffset(utcDateTime);
                timestampOperation = dateTimeOffset.ToString("o");
            }

            // Extract additional data
            if(additionalData != null && additionalData.Type != JTokenType.Null){
                JObject receivedAdditionalData = (JObject)additionalData;
                errorCode = (string)receivedAdditionalData["authorizationStatus"];
                authorizationCode = (string)receivedAdditionalData["authorizationCode"];
                validationServiceId = (string)receivedAdditionalData["validationServiceId"];
            }

            // Extract orderId from operation if present
            orderId = (string)operation["orderId"];

            // Build outcomeGateway object for NPG
            JObject outcomeGateway = new JObject();
            outcomeGateway["paymentGatewayType"] = "NPG";
            outcomeGateway["operationResult"] = operationResult;
            outcomeGateway["operationId"] = operationId;

            // Add optional fields only if they exist
            if(!String.IsNullOrEmpty(authorizationCode)) {
                outcomeGateway["authorizationCode"] = authorizationCode;
            }
            if(!String.IsNullOrEmpty(errorCode)) {
                outcomeGateway["errorCode"] = errorCode;
            }
            if(!String.IsNullOrEmpty(orderId)) {
                outcomeGateway["orderId"] = orderId;
            }
            if(!String.IsNullOrEmpty(validationServiceId)) {
                outcomeGateway["validationServiceId"] = validationServiceId;
            }

            // Build request for transaction-service PATCH auth-request
            JObject transactionRequest = new JObject();
            transactionRequest["outcomeGateway"] = outcomeGateway;
            transactionRequest["timestampOperation"] = timestampOperation;

            return transactionRequest.ToString();
        }
        </set-body>

        <!-- end payment method verify session -->
        <!-- send transactions service PATCH request -->
        <set-backend-service base-url="@((string)context.Variables["transactionServiceBackendUri"])" />
        <rewrite-uri template="@(String.Format("/v2/transactions/{0}/auth-requests", (string)context.Variables["transactionId"]))" copy-unmatched-params="false"/>
        <set-method>PATCH</set-method>
        <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
        </set-header>
        <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-transactions-service-api-key-value}}</value>
        </set-header>
        <set-header name="x-payment-gateway-type" exists-action="override">
            <value>"NPG"</value>
        </set-header>
        <set-body
            @{
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
              string cardId4 = null;
              if(additionalData != null && additionalData.Type != JTokenType.Null){
                  JObject receivedAdditionalData = (JObject)additionalData;
                  authorizationCode = (string)receivedAdditionalData["authorizationCode"];
                  errorCode = (string)receivedAdditionalData["authorizationStatus"];
                  rrn = (string)receivedAdditionalData["rrn"];
                  validationServiceId = (string)receivedAdditionalData["validationServiceId"];
                  bpayEndToEndId = (string)receivedAdditionalData["bpayEndToEndId"];
                  myBankEndToEndId = (string)receivedAdditionalData["myBankEndToEndId"];
                  // right now we support only card processes
                  if (!String.IsNullOrEmpty(cardId4)) {
                    cardId4 = (string)receivedAdditionalData["cardId4"];
                  }
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
              outcomeGateway["cardId4"] = cardId4;
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
