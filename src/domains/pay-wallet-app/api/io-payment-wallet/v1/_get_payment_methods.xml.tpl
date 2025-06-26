<policies>
    <inbound>
    <base />
    <!-- Set payment-methods API Key header -->
    <set-header name="x-api-key" exists-action="override">
      <value>{{commerce-payment-methods-api-key-value}}</value>
    </set-header>
    <set-backend-service base-url="https://${ecommerce_hostname}/pagopa-ecommerce-payment-methods-service"/>
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
