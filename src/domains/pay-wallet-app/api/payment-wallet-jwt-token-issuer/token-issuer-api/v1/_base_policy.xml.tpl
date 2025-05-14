<policies>
    <inbound>
      <base />
      <set-backend-service base-url="@("https://${hostname}/pagopa-jwt-issuer-service")"/>
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
