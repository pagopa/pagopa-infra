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
        <set-backend-service base-url="https://${hostname}/pagopa-api-config-service" />
        <choose>
            <when condition="@(context.User == null || !context.User.Groups.Select(g => g.Id).Contains("api-config-be-writer"))">
                <set-variable name="isGet" value="@(context.Request.Method.Equals("GET"))" />
                <set-variable name="isPost" value="@(context.Request.Method.Equals("POST"))" />
                <set-variable name="isXsd" value="@(context.Request.Url.Path.Contains("xsd"))" />
                <choose>
                    <when condition="@(!context.Variables.GetValueOrDefault<bool>("isGet") && !(context.Variables.GetValueOrDefault<bool>("isPost") && context.Variables.GetValueOrDefault<bool>("isXsd")))">
                        <return-response>
                            <set-status code="403" reason="Unauthorized, you have read-only access" />
                        </return-response>
                    </when>
                </choose>
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
