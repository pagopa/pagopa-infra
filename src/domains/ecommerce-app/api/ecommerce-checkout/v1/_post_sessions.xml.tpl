<policies>
    <inbound>
    <rate-limit-by-key 
    calls="10" 
    renewal-period="60" 
    increment-condition="@(context.Response.StatusCode == 200)" //maybe it is not important the status if we accept a limited number of calls in a minute
    counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" //or ip address @(context.Request.IpAddress)
    remaining-calls-variable-name="remainingCallsPerIP"
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
