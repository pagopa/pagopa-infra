<policies>
    <inbound>
      <base />
      <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" caching-type="internal" />
      <set-backend-service base-url="https://${hostname}/pagopa-wallet-service" />
      <set-header name="x-api-key" exists-action="override">
        <value>{{payment-wallet-service-rest-api-key}}</value>
      </set-header>
    </inbound>
    <outbound>
      <base />
        <cache-store duration="300" /> <!-- 5 minutes-->
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
