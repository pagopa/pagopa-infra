<policies>
    <inbound>
      <base />
      <set-backend-service base-url="https://weudev.ecommerce.internal.dev.platform.pagopa.it/pagopa-ecommerce-sessions-service" />
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
