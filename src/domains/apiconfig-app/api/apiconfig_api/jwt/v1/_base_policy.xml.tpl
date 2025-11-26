<!--
    IMPORTANT:
    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.
    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.
    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.
    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.
    - To remove a policy, delete the corresponding policy statement from the policy document.
    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.
    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.
    - Policies are applied in the order of their appearance, from the top down.
    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.
-->
<policies>
    <inbound>
        <cors>
            <allowed-origins>
                <origin>${origin}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>GET</method>
                <method>POST</method>
                <method>PUT</method>
                <method>DELETE</method>
                <method>OPTIONS</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <base />
        <set-backend-service base-url="https://${hostname}/{{apicfg-core-service-path}}" />

        <rate-limit-by-key calls="300" renewal-period="60" counter-key="@(context.Request.Headers.GetValueOrDefault("Authorization","").AsJwt()?.Subject)" />
        <set-variable name="isGet" value="@(context.Request.Method.Equals("GET"))" />
        <set-variable name="isPost" value="@(context.Request.Method.Equals("POST"))" />
        <set-variable name="isXsd" value="@(context.Request.Url.Path.Contains("xsd"))" />
        <set-variable name="aud" value="@{
            string aud = "";
            string authHeader = context.Request.Headers.GetValueOrDefault("Authorization", "");
            if (authHeader?.Length > 0)
            {
                string[] authHeaderParts = authHeader.Split(' ');
                if (authHeaderParts?.Length == 2 && authHeaderParts[0].Equals("Bearer", StringComparison.InvariantCultureIgnoreCase))
                {
                    Jwt jwt;
                    if (authHeaderParts[1].TryParseJwt(out jwt))
                    {
                        aud = jwt.Claims.GetValueOrDefault("aud", "");
                    }
                }
            }
            return aud;
        }" />
        <choose>
            <!-- Postman Token-->
            <when condition="@(context.Variables.GetValueOrDefault<string>("aud").Contains("${apiconfig_be_client_id}"))">
                <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized. Access token is missing or invalid.">
                    <openid-config url="https://login.microsoftonline.com/${pagopa_tenant_id}/v2.0/.well-known/openid-configuration" />
                    <required-claims>
                        <claim name="aud">
                            <value>${apiconfig_be_client_id}</value>
                        </claim>
                    </required-claims>
                </validate-jwt>
            </when>
            <!-- FE Token Writer -->
            <when condition="@(context.Variables.GetValueOrDefault<string>("aud").Contains("${apiconfig_fe_client_id}") && !context.Variables.GetValueOrDefault<bool>("isGet"))">
                <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized. Access token is missing or invalid.">
                    <openid-config url="https://login.microsoftonline.com/${pagopa_tenant_id}/v2.0/.well-known/openid-configuration" />
                    <required-claims>
                        <claim name="aud">
                            <value>${apiconfig_fe_client_id}</value>
                        </claim>
                        <claim name="groups" match="any">
                            <value>68e78f4f-ee0c-4ade-9523-0f69e71a3d2f</value>
                        </claim>
                    </required-claims>
                </validate-jwt>
            </when>
            <!-- FE Token Reader -->
            <otherwise>
                <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized. Access token is missing or invalid.">
                    <openid-config url="https://login.microsoftonline.com/${pagopa_tenant_id}/v2.0/.well-known/openid-configuration" />
                    <required-claims>
                        <claim name="aud">
                            <value>${apiconfig_fe_client_id}</value>
                        </claim>
                    </required-claims>
                </validate-jwt>
            </otherwise>
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
