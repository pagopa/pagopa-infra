<policies>
    <inbound>
        <base />
        <rewrite-uri template="/" />
        <set-backend-service base-url="{{url-payments}}" />
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
