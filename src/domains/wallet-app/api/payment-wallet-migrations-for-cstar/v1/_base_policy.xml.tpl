<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="50" renewal-period="1" counter-key="@(context.Request.IpAddress)" />
      <set-backend-service base-url="https://${hostname}/pagopa-wallet-service" />
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
