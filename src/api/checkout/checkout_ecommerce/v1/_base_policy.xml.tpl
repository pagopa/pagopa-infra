<policies>

  <inbound>
      <base />
      <set-backend-service base-url="${backend-service}" />
      <set-header name="ocp-apim-subscription-key" exists-action="delete" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-header name="ocp-apim-subscription-key" exists-action="override">
        <value>{{ecommerce-for-checkout-api-key}}</value>
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
