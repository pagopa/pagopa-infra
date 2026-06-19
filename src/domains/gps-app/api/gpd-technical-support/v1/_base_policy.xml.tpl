<policies>
  <inbound>
    <base />
    <rate-limit calls="300" renewal-period="10" remaining-calls-variable-name="remainingCallsPerSubscription" />
    <set-backend-service base-url="https://${hostname}/gpd-technical-support" />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
  <on-error>
    <base />
  </on-error>
</policies>