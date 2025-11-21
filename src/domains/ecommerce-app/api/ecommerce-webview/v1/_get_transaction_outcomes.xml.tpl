<policies>
    <inbound>
            <cors>
                <allowed-origins>
                    ${origins}
                </allowed-origins>
                <allowed-methods>
                    <method>GET</method>
                    <method>OPTION</method>
                </allowed-methods>
                <allowed-headers>
                    <header>Authorization</header>
                </allowed-headers>
            </cors>
            <set-header name="x-user-id" exists-action="delete" />
            <set-variable name="requestTransactionId" value="@(context.Request.MatchedParameters["transactionId"])" />
            <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
                <openid-config url="https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
                <audiences>
                    <audience>ecommerce</audience>
                    <audience>ecommerce-outcomes</audience>
                </audiences>
            </validate-jwt>
            <set-variable name="tokenTransactionId" value="@{
                var jwt = (Jwt)context.Variables["jwtToken"];
                if(jwt.Claims.ContainsKey("transactionId")){
                    return jwt.Claims["transactionId"][0];
                }
                return "";
            }" />
            <choose>
                <when condition="@(
                    (string)context.Variables["tokenTransactionId"] != (string)context.Variables["requestTransactionId"]
                )">
                    <return-response>
                        <set-status code="401" reason="Unauthorized" />
                    </return-response>
                </when>
            </choose>
            <set-variable name="xUserId" value="@{
                var jwt = (Jwt)context.Variables["jwtToken"];
                if(jwt.Claims.ContainsKey("userId")){
                    return jwt.Claims["userId"][0];
                }
                return "";
            }" />
        <choose>
            <when condition="@(context.Variables.GetValueOrDefault("xUserId","") != "")">
                <set-header name="x-user-id" exists-action="override">
                    <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
                </set-header>
            </when>
        </choose>
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service")"/>
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
