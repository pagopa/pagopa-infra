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
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
            <openid-config url="https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
            <audiences>
              <audience>ecommerce</audience>
            </audiences>
        </validate-jwt>
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
        %{ if enable_rate_limit_by_transactionId }
        <rate-limit-by-key calls="5" renewal-period="10" counter-key="@((string)context.Variables["requestTransactionId"])" retry-after-header-name="Retry-After" />
        %{ endif }
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
