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
      <set-backend-service base-url="https://${ecommerce_ingress_hostname}/pagopa-ecommerce-payment-methods-handler/npg/sdk"/>
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-payment-methods-api-key-value}}</value>
      </set-header>
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
