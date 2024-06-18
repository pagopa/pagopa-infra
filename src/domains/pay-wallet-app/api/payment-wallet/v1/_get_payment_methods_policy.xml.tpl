<policies>
    <inbound>
      <set-header name="X-Client-Id" exists-action="override" >
        <value>IO</value>
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
