<policies>
    <inbound>
      <set-header name="x-transaction-origin" exists-action="delete" />
      <!--> Add here some logic for value x-transaction-origin header properly such as based on api key etc <-->
      <base />
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
