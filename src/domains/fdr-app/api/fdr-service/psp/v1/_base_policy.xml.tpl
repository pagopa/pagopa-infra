<policies>
    <inbound>
        <base />
        <set-backend-service base-url="https://${hostname}/pagopa-fdr-service" />
        <!-- Calling Authorizer's fragment -->
        <set-variable name="application_domain" value="fdr" />
        <choose>
            <!-- Making sure that will excludes all APIs that does not includes CI fiscal code -->
            <when condition="@(context.Request.MatchedParameters.ContainsKey("pspId"))">
                <set-variable name="authorization_entity" value="@(context.Request.MatchedParameters["pspId"])" />
                <include-fragment fragment-id="authorizer" />
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
