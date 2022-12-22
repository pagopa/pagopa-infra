<policies>
    <inbound>
        <base />
        <rewrite-uri template="/" />
        <set-backend-service base-url="https://${hostname}/pagopa-gpd-payments/partner" />
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
