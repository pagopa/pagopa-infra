<policies>

  <inbound>
      <base />
      <set-backend-service base-url="https://${ecommerce_ingress_hostname}/pagopa-ecommerce-transactions-service"/>
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