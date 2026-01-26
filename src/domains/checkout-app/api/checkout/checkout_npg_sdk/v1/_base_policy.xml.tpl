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
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
        </allowed-headers>
      </cors>
      <base />
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
