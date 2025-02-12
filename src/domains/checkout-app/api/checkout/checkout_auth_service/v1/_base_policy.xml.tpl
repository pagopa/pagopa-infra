<policies>

  <inbound>
      <cors>
        <allowed-origins>
          <origin>*</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
          <header>bearerAuth</header>
        </allowed-headers>
      </cors>
      <base />
      <set-backend-service base-url="@("https://${checkout_ingress_hostname}"+"/https://pagopa-checkout-auth-service")"/>
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
