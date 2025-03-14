<policies>

  <inbound>
    <!-- Rate limit policy -->
    <rate-limit-by-key
      calls="150"
      renewal-period="10"
      counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))"
    />

    <base />
    <set-backend-service base-url="@("https://${checkout_ingress_hostname}"+"/pagopa-checkout-identity-provider-mock")"/>
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
