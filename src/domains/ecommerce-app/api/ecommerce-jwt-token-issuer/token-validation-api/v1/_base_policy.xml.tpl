<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="10" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-backend-service base-url="@("https://${hostname}/pagopa-jwt-issuer-service")"/>
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
