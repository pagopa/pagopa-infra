<policies>
    <inbound>
        <base />
        <set-backend-service base-url="http://{{aks-lb-nexi}}/nodo-dev/v1" />
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