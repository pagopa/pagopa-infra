<policies>
    <inbound>
        <base />

        <set-backend-service base-url="{{schema-ip-nexi}}/nodo-dev/webservices/input" />

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
