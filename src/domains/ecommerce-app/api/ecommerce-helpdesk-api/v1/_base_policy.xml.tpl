<policies>
    <inbound>
      <base />
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-helpdesk-service" />
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-helpdesk-service-rest-api-key}}</value>
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
