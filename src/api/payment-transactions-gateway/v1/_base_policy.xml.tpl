<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{ip}}/payment-transactions-gateway" />
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
