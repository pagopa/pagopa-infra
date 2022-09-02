<policies>
    <inbound>
      <base />
      <set-backend-service base-url="${endpoint}/srvs/AI" />
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
