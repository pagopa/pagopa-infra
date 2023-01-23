<policies>
    <inbound>
        <base />
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
            <issuer-signing-keys>
                <key>{{transaction-jwt-signing-key}}</key>
            </issuer-signing-keys>
        </validate-jwt>
        <set-variable name="isValidToken" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("transactionId")){
        var transactionId = jwt.Claims["transactionId"];
        return context.Request.MatchedParameters["transactionId"].Equals(transactionId);
        }
        return false;
        }" />
        <choose>
            <when condition="@((bool)context.Variables["isValidToken"] == false)">
                <return-response>
                    <set-status code="401" reason="Invalid token transaction id" />
                </return-response>
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