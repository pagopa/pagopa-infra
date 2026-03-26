<policies>
    <inbound>
      <base />
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-transactions-service-api-key-value}}</value>
      </set-header>
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-transactions-service" />
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
