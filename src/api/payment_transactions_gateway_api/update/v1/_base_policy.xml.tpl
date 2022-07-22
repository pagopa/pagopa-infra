<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pm-onprem-hostname}}/payment-gateway" />
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
