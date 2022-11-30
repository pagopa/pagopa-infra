<policies>
    <inbound>
      <base />
      <set-backend-service base-url="${base-url}/v1" />
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
