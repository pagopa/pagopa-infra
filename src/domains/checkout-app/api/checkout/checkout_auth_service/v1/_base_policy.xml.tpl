<policies>

  <inbound>
    <!-- Rate limit policy -->
    <rate-limit-by-key
      calls="150"
      renewal-period="10"
      counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))"
    />
    <!-- End rate limit policy -->
      <cors>
        <allowed-origins>
          <origin>${checkout_origin}</origin>
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
      <set-backend-service base-url="@("https://${checkout_ingress_hostname}"+"/pagopa-checkout-auth-service")"/>
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
