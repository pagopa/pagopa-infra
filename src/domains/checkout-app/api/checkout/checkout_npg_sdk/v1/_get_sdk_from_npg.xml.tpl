<policies>
    <inbound>
        <base />
        <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" caching-type="internal" />
        <!-- fetch sdk from NPG redirecting request to NPG server -->
        <set-backend-service base-url="https://${npg_hostname}/monetaweb/resources/hfsdk.js"/>
        <rewrite-uri template="/monetaweb/resources/hfsdk.js" copy-unmatched-params="true" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
        <cache-store duration="10" />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
