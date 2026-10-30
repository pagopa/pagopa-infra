<policies>
    <inbound>
        <base />
        <set-backend-service base-url="@(context.Variables.GetValueOrDefault<string>("baseUrl", "{{schema-ip-nexi}}"))" />
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
