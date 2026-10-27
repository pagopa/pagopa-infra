<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="3" renewal-period="10" counter-key="@(context.Subscription != null ? context.Subscription.Id.ToLower() : "unknown_subscription")" />
      <set-backend-service base-url="https://${hostname}/pagopa-payment-wallet-helpdesk-service" />
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
