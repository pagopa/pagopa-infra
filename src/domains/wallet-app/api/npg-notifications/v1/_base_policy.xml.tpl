<policies>
    <inbound>
        <base />
        
        <set-variable name="orderIdPathParam" value="@(context.Request.MatchedParameters["orderId"])" />
        <set-variable name="npgNotificationRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <set-variable name="orderIdBodyParam" value="@((string)((JObject)((JObject)context.Variables["npgNotificationRequestBody"])["operation"])["orderId"])" />
        <set-variable name="walletId" value="@(context.Request.MatchedParameters["walletId"])" />

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

        <!-- START send wallet notify request -->
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
                string timestampOperation = null;
                if(operationTime != null) {
                    DateTime npgDateTime = DateTime.Parse(operationTime.Replace(" ","T"));
                    TimeZoneInfo zone = TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time");
                    DateTime utcDateTime = TimeZoneInfo.ConvertTimeToUtc(npgDateTime, zone);
                    DateTimeOffset dateTimeOffset = new DateTimeOffset(utcDateTime);
                    timestampOperation = dateTimeOffset.ToString("o");
                }
                string paymentCircuit = (string)operation["paymentCircuit"];
                JObject details = null;
                if(paymentCircuit == "PAYPAL"){
                    details = new JObject();
                    details["type"] = "PAYPAL";
                    details["maskedEmail"] = (string)operation["paymentInstrumentInfo"];
                }
                JObject request = new JObject();
                request["timestampOperation"] = timestampOperation;
                request["operationResult"] = operationResult;
                request["operationId"] = operationId;
                request["details"] = details;
                return request.ToString();
            }
        </set-body>
        <set-backend-service base-url="https://${hostname}/pagopa-wallet-service" />
        <!-- END send wallet notify request -->

    </inbound>
    <backend>
        <base />
    </backend>
    <outbound />
    <on-error>
        <base />
    </on-error>
</policies>
