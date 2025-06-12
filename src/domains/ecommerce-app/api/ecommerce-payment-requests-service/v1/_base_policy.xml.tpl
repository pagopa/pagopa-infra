<policies>
    <inbound>
      <base />
      <set-header name="X-Api-Key" exists-action="override">
        <value>{{ecommerce-payment-request-api-key-value}}</value>
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
