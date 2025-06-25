<policies>
    <inbound>
        <base />
        <set-header name="x-pgs-id" exists-action="delete" />
        <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
        <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="walletId" value="@((string)((JObject) context.Variables["body"])["details"]["walletId"])" />
        <set-variable name="detailType" value="@((string)((JObject) context.Variables["body"])["details"]["detailType"])" />
        <choose>
             <when condition="@(((string)context.Variables["detailType"]).Equals("redirect"))">
                <set-header name="x-pgs-id" exists-action="override">
                    <value>REDIRECT</value>
                </set-header>
            </when>
            <otherwise>
                <set-header name="x-pgs-id" exists-action="override">
                    <value>NPG</value>
                </set-header>
            </otherwise>
        </choose>
        <choose>
            <when condition="@(!String.IsNullOrEmpty((string)(context.Variables["walletId"])))">
                <send-request response-variable-name="walletResponse" timeout="10">
                    <set-url>@($"https://${wallet-basepath}/pagopa-wallet-service/wallets/{(string)context.Variables["walletId"]}")</set-url>
                    <set-method>GET</set-method>
                    <set-header name="x-user-id" exists-action="override">
                        <value>@((string)context.Request.Headers.GetValueOrDefault("x-user-id",""))</value>
                    </set-header>
                    <set-header name="x-api-key" exists-action="override">
                       <value>{{payment-wallet-service-api-key-for-ecommerce-value}}</value>
                    </set-header>
                </send-request>
                <choose>
                    <when condition="@(((int)((IResponse)context.Variables["walletResponse"]).StatusCode) == 200)">
                        <set-variable name="walletResponseBody" value="@((JObject)((IResponse)context.Variables["walletResponse"]).Body.As<JObject>())" />
                        <set-variable name="paymentMethodId" value="@((string)((JObject)context.Variables["walletResponseBody"])["paymentMethodId"])" />
                    </when>
                    <when condition="@(((int)((IResponse)context.Variables["walletResponse"]).StatusCode) == 404)">
                        <return-response>
                            <set-status code="404" reason="Not found" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>{
                                "title": "Wallet not found",
                                "status": 404,
                                "detail": "Cannot retrieve wallet for input wallet id",
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
        <set-body>@{
            JObject requestBody = (JObject)context.Variables["body"];
            JObject authDetail = (JObject)requestBody["details"];
            string walletId = (string)context.Variables["walletId"];
            string detailType = (string)authDetail["detailType"];
            string paymentMethodId = (string)context.Variables.GetValueOrDefault("paymentMethodId","");
            JObject requestBodyDetails = new JObject();
            requestBodyDetails["detailType"] = (string)authDetail["detailType"];
            switch(detailType)
            {
                case "wallet":
                    requestBodyDetails = authDetail;
                    requestBodyDetails["walletId"] = walletId;
                    break;
                case "apm":
                    paymentMethodId = (string)authDetail["paymentMethodId"];
                    authDetail.Remove("paymentMethodId");
                    requestBodyDetails = authDetail;
                    break;
                case "redirect":
                    paymentMethodId = (string)authDetail["paymentMethodId"];
                    authDetail.Remove("paymentMethodId");
                    requestBodyDetails = authDetail;
                    break;
                default:
                    break;
            }
            requestBody["details"] = requestBodyDetails;
            requestBody["paymentInstrumentId"] = paymentMethodId;
            return requestBody.ToString();
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
