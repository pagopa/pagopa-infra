<policies>
    <inbound>
      <base />
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-transactions-service" />
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
