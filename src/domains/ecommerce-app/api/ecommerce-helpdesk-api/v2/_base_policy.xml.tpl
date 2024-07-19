<policies>
    <inbound>
      <base />
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-helpdesk-service/v2" />
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
