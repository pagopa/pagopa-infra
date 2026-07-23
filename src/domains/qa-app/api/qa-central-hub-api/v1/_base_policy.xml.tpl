<policies>
    <inbound>
      <base />
      <set-backend-service backend-id="${backend_id}" />
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
