<policies>
    <inbound>
      <base />
      <set-backend-service base-url="http://10.1.100.250" />
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
