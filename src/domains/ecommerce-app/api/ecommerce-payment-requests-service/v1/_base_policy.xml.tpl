<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="30" renewal-period="10" counter-key="@(context.Subscription != null ? context.Subscription.Id.ToLower() : "unknown_subscription")" />
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-payment-requests-api-key-value}}</value>
      </set-header>
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-payment-requests-service" />
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
