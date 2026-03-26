<policies>
    <inbound>
        <base />
        <set-variable name="orderIdPathParam" value="@(context.Request.MatchedParameters["orderId"])" />
        <set-variable name="walletId" value="@(context.Request.MatchedParameters["walletId"])" />
        <set-variable name="npgNotificationRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <set-variable name="orderIdBodyParam" value="@((string)((JObject)((JObject)context.Variables["npgNotificationRequestBody"])["operation"])["orderId"])" />
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
        <choose>
            <when condition="@(bool.Parse(context.Variables.GetValueOrDefault<string>("useOpenId")))">
                <validate-jwt query-parameter-name="sessionToken" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
                  <openid-config url="https://${hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
                  <audiences>
                    <audience>npg</audience>
                  </audiences>
                  <required-claims>
                    <claim name="walletId" match="all">
                        <value>@((string)context.Variables.GetValueOrDefault("walletId",""))</value>
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
                    <claim name="walletId" match="all">
                        <value>@((string)context.Variables.GetValueOrDefault("walletId",""))</value>
                    </claim>
                 </required-claims>
                </validate-jwt>
            </otherwise>
        </choose>
        <!-- end validation policy -->
        <choose>
            <when condition="@(((string)context.Variables["orderIdPathParam"]).Equals((string)context.Variables["orderIdBodyParam"]) != true)">
                <return-response>
                    <set-status code="400" reason="orderId mismatch" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
                    "title": "Unable to handle notification",
                    "status": 400,
                    "detail": "orderId mismatch",
                }</set-body>
                </return-response>
            </when>
        </choose>
        <set-header name="Authorization" exists-action="override">
      <value>
          @{
              JObject requestBody = (JObject)context.Variables["npgNotificationRequestBody"];
              return "Bearer " + (string)requestBody["securityToken"];
          }
      </value>
        </set-header>
      <set-body>
          @{
            JObject requestBody = (JObject)context.Variables["npgNotificationRequestBody"];
            JObject operation = (JObject)requestBody["operation"];
            string operationResult = (string)operation["operationResult"];
            string operationId = (string)operation["operationId"];
            string operationTime = (string)operation["operationTime"];
            var additionalData = operation["additionalData"];
            string timestampOperation = null;
            string errorCode = null;
            string cardId4 = null;
            if(operationTime != null) {
                DateTime npgDateTime = DateTime.Parse(operationTime.Replace(" ","T"));
                TimeZoneInfo zone = TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time");
                DateTime utcDateTime = TimeZoneInfo.ConvertTimeToUtc(npgDateTime, zone);
                DateTimeOffset dateTimeOffset = new DateTimeOffset(utcDateTime);
                timestampOperation = dateTimeOffset.ToString("o");
            }
            if(additionalData != null && additionalData.Type != JTokenType.Null){
                JObject receivedAdditionalData = (JObject)additionalData;
                errorCode = (string)receivedAdditionalData["authorizationStatus"];
                cardId4 = (string)((JObject)additionalData)["cardId4"];
            }
            string paymentCircuit = (string)operation["paymentCircuit"];
            string paymentMethod = (string)operation["paymentMethod"];
            string paymentInstrumentInfo = (string)operation["paymentInstrumentInfo"];
            JObject details = null;
            if(paymentCircuit == "PAYPAL" && !String.IsNullOrEmpty(paymentInstrumentInfo)){
                details = new JObject();
                details["type"] = "PAYPAL";
                details["maskedEmail"] = paymentInstrumentInfo;
            } else if(paymentMethod == "CARD" && !String.IsNullOrEmpty(cardId4)){
                details = new JObject();
                details["type"] = "CARD";
                details["paymentInstrumentGatewayId"] = cardId4;
            }

            JObject request = new JObject();
            request["timestampOperation"] = timestampOperation;
            request["operationResult"] = operationResult;
            request["operationId"] = operationId;
            request["errorCode"] = errorCode;
            request["details"] = details;
            return request.ToString();
          }
      </set-body>
      <set-backend-service base-url="https://${hostname}/pagopa-wallet-service" />
      <set-header name="x-api-key" exists-action="override">
        <value>{{payment-wallet-service-rest-api-key}}</value>
      </set-header>
    </inbound>
    <backend>
      <retry condition="@(context.Response.StatusCode >= 500)"
            interval="2" count="3" first-fast-retry="true">
            <forward-request timeout="10" buffer-request-body="true" />
      </retry>
    </backend>
    <outbound />
    <on-error>
        <base />
    </on-error>
</policies>
