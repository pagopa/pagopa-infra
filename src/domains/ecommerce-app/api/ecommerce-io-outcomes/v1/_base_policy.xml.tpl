<policies>
    <inbound>
        <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
        <return-response>
          <set-status code="302" />
          <set-header name="location" exists-action="override">
            <value>@($"iowallet://{context.Request.OriginalUrl.Host}{context.Request.OriginalUrl.Path}{context.Request.OriginalUrl.QueryString}")</value>
          </set-header>
        </return-response>
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