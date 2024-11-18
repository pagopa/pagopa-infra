<policies>
    <inbound>
    <rate-limit-by-key 
    calls="150"
    renewal-period="10" 
    counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))"
    />       
    <base />
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
