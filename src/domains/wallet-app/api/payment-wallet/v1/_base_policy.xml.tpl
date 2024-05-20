<policies>
    <inbound>
      <base />
      <set-header name="x-user-id" exists-action="delete" />
      <set-backend-service base-url="https://${hostname}/pagopa-wallet-service" />
      <set-header name="x-client-id" exists-action="override">
          <value>IO</value>
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
