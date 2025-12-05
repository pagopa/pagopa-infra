<policies>
    <inbound>
        <base />
        <set-variable name="requestTransactionId" value="@{
                    var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
                    if(transactionId == ""){
                        transactionId = context.Request.Headers.GetValueOrDefault("x-transaction-id-from-client","");
                    }
                    return transactionId;
            }" />
        <set-header name="x-transaction-id" exists-action="delete" />
        <set-header name="x-user-id" exists-action="delete" />
        <!--  Check if Authorization header is present -->
        <choose>
            <when condition="@(!context.Request.Headers.ContainsKey("Authorization"))">
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
                    <set-body>Missing Authorization header</set-body>
                </return-response>
            </when>
        </choose>
        <!-- Extract 'iss' claim -->
        <set-variable name="jwtIssuer" value="@{
            Jwt jwt;
            context.Request.Headers.GetValueOrDefault("Authorization", "").Split(' ').Last().TryParseJwt(out jwt);
            return jwt?.Claims.GetValueOrDefault("iss", "");
        }" />
        <!-- Store useOpenId as string 'true' or 'false' -->
        <set-variable name="useOpenId" value="@(
            (context.Variables.GetValueOrDefault<string>("jwtIssuer")?.Contains("jwt-issuer-service") == true).ToString()
        )" />
        <!-- Conditional validation -->
        <choose>
            <when condition="@(bool.Parse(context.Variables.GetValueOrDefault<string>("useOpenId")))">
                <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
                    <openid-config url="https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
                    <audiences>
                      <audience>ecommerce</audience>
                    </audiences>
                </validate-jwt>
            </when>
            <otherwise>
                <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
                    <issuer-signing-keys>
                        <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key>
                    </issuer-signing-keys>
                </validate-jwt>
            </otherwise>
        </choose>
        <set-variable name="tokenTransactionId" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("transactionId")){
           return jwt.Claims["transactionId"][0];
        }
        return "";
        }" />
        <set-variable name="userId" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("userId")){
           return jwt.Claims["userId"][0];
        }
        return "";
        }" />
        <choose>
            <when condition="@((string)context.Variables.GetValueOrDefault("userId","") != "")">
                <set-header name="x-user-id" exists-action="override">
                    <value>@((string)context.Variables.GetValueOrDefault("userId",""))</value>
                </set-header>
            </when>
        </choose>
        <choose>
            <when condition="@((string)context.Variables.GetValueOrDefault("tokenTransactionId","") != (string)context.Variables.GetValueOrDefault("requestTransactionId",""))">
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
                </return-response>
            </when>
            <when condition="@((string)context.Variables["requestTransactionId"] != "")">
                <set-header name="x-transaction-id" exists-action="override">
                    <value>@((string)context.Variables.GetValueOrDefault("requestTransactionId",""))</value>
                </set-header>
            </when>
        </choose>
        <set-variable name="walletId" value="@{
            JObject body = context.Request.Body.As<JObject>(preserveContent: true);
            return (string)body["walletId"];
        }" />
        <set-variable name="isCard" value="@{
            JObject body = context.Request.Body.As<JObject>(preserveContent: true);
            string walletType = (string)body["walletType"];
            return walletType == "CARDS";
        }" />
        <choose>
            <when condition="@((bool)context.Variables["isCard"] && !String.IsNullOrEmpty((string)context.Variables["walletId"]))">
                <send-request ignore-error="false" timeout="10" response-variable-name="authDataResponse">
                    <set-url>@($"https://${wallet_ingress_hostname}/pagopa-wallet-service/wallets/{(string)context.Variables["walletId"]}/auth-data")</set-url>
                    <set-method>GET</set-method>
                    <set-header name="x-api-key" exists-action="override">
                      <value>{{payment-wallet-service-rest-api-key}}</value>
                    </set-header>
                </send-request>
                <choose>
                    <when condition="@(((int)((IResponse)context.Variables["authDataResponse"]).StatusCode) == 200)">
                        <set-variable name="authDataBody" value="@((JObject)((IResponse)context.Variables["authDataResponse"]).Body.As<JObject>())" />
                        <set-variable name="bin" value="@((string)((JObject)context.Variables["authDataBody"])["paymentMethodData"]["bin"])" />
                        <set-body>@{
                            JObject body = context.Request.Body.As<JObject>(preserveContent: true);
                            string bin = context.Variables.GetValueOrDefault<string>("bin", null);
                            body["bin"] = bin;
                            return body.ToString();
                        }</set-body>
                    </when>
                    <when condition="@(((int)((IResponse)context.Variables["authDataResponse"]).StatusCode) == 404)">
                        <return-response>
                            <set-status code="404" reason="Not found" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>{
                                "title": "Not Found",
                                "status": 404,
                                "detail": "Unable to get wallet auth data",
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
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
