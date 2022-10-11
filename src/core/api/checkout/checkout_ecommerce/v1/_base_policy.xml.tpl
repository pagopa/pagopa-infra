<policies>

  <inbound>
      <base />
      <set-backend-service base-url="https://${ecommerce_ingress_hostname}"/>
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