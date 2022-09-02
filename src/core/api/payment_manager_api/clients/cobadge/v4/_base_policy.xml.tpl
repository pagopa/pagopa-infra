<policies>
    <inbound>
      <base />
      <set-backend-service base-url="${endpoint}" />
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
