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
        <!-- product before base policy -->
        <base />
        <!-- product after base policy -->
        <!-- set ndphost header -->
        <include-fragment fragment-id="ndphost-header" />

        <!-- get SOAPAction info from header -->
        <set-variable name="soapAction" value="@((string)context.Request.Headers.GetValueOrDefault("SOAPAction", "NONE"))" />

        <choose>
            <when condition="@(context.Request.Body != null)">
                <!-- copy request body into renewrequest variable -->
                <set-variable name="renewrequest" value="@(context.Request.Body.As<string>(preserveContent: true))" />
            </when>
        </choose>
        <choose>
            <when condition="@(true)">
                <!-- apply nuova connettivita logic (placeholder) -->
                <include-fragment fragment-id="ndp-nuova-connettivita" />
            </when>
            <otherwise>
                <!-- blacklist for appgateway-snet  -->
                <ip-filter action="forbid">
                    <address-range from="0.0.0.0" to="0.0.0.0" />
                </ip-filter>
            </otherwise>
        </choose>
        <!-- Loading decoupler configuration -->
        <include-fragment fragment-id="decoupler-configuration" />
        <!-- used for convention in the cache key -->
        <set-variable name="domain" value="nodo" />
        <set-variable name="domain_eCommerce" value="ecommerce" />
        <!-- the following is the default baseUrl and baseNodeId -->
        <set-variable name="baseUrl" value="{{default-nodo-backend}}" />
        <set-variable name="baseNodeId" value="{{default-nodo-id}}" />
        <!-- the following is the TTL used to cache tagging regarding payments -->
        <set-variable name="ndp_nodo_fiscalCode_noticeNumber_ttl" value="@{
            bool success = int.TryParse("{{ndp-nodo-fiscalCode-noticeNumber-ttl}}", out var ttl);
            return success ? ttl.ToString() : "5184000";  // 60 days
        }" />
        <set-variable name="ndp_nodo_fiscalCode_iuv_ttl" value="@{
            bool success = int.TryParse("{{ndp-nodo-fiscalCode-iuv-ttl}}", out var ttl);
            return success ? ttl.ToString() : "5184000";  // 60 days
        }" />
        <set-variable name="ndp_nodo_paymentToken_ttl" value="@{
            bool success = int.TryParse("{{ndp-nodo-paymentToken-ttl}}", out var ttl);
            return success ? ttl.ToString() : "5184000";  // 60 days
        }" />
        <set-variable name="ndp_eCommerce_transactionId_ttl" value="@{
            bool success = int.TryParse("{{ndp-eCommerce-transactionId-ttl}}", out var ttl);
            return success ? ttl.ToString() : "86400";  // 1 day
        }" />

        <!-- set backend service url -->
        <set-backend-service base-url="@((string)context.Variables["baseUrl"])" />
    </inbound>
    <backend>
        <!-- product before base policy -->
        <base />
        <!-- product after base policy -->
    </backend>
    <outbound>
        <!-- product before base policy -->
        <base />
        <!-- product after base policy -->
    </outbound>
    <on-error>
        <!-- product before base policy -->
        <base />
        <!-- product after base policy -->
    </on-error>
</policies>
