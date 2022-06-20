<policies>
    <inbound>
      <base />
      <set-backend-service base-url="https://${postepay_hostname}/paymentserver/api/v1" />
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
