<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
    </inbound>
    <outbound>
      <base />
      <set-header name="cache-control" exists-action="override">
          <value>no-store</value>
      </set-header>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
