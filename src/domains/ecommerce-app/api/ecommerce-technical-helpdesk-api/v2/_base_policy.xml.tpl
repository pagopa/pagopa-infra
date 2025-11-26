<policies>
    <inbound>
      <base />
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-helpdesk-service-rest-api-key}}</value>
      </set-header>
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-helpdesk-service/v2" />
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
