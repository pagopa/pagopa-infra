<policies>
    <inbound>
        <base />
        <set-backend-service base-url="${base-url}" />
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