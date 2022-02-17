<policies>
    <inbound>
      <base />
      <set-backend-service base-url="${endpoint}/ecomm/api" />
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
