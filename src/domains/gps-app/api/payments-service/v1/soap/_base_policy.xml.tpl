<policies>
    <inbound>
        <base />
        <rewrite-uri template="/" />
        <set-backend-service base-url="https://${hostname}/partner" />
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
