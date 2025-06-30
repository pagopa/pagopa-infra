<policies>
    <inbound>
      <set-header name="X-Client-Id" exists-action="delete" />
      <!--> Add here some logic for value X-Client-Id header properly such as based on api key etc <-->
      <base />
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-transactions-service-api-key-value}}</value>
      </set-header>
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-transactions-service/v2" />
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
