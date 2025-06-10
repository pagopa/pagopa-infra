<policies>
    <inbound>
        <base />
        <set-variable name="requestTransactionId" value="@{
            return context.Request.Headers.GetValueOrDefault("x-transaction-id-from-client","");
        }" />
        <set-variable name="requestOrderId" value="@{
            return context.Request.MatchedParameters.GetValueOrDefault("orderId","");
        }" />
        <set-header name="x-transaction-id" exists-action="delete" />
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
        <set-variable name="tokenOrderId" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("orderId")){
           return jwt.Claims["orderId"][0];
        }
        return "";
        }" />
        <choose>
            <when condition="@( (string)context.Variables.GetValueOrDefault("tokenTransactionId","") != (string)context.Variables.GetValueOrDefault("requestTransactionId","") || (string)context.Variables.GetValueOrDefault("tokenOrderId","") != (string)context.Variables.GetValueOrDefault("requestOrderId",""))">
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
