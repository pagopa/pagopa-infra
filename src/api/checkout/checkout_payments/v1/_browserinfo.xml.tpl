<policies>
    <inbound>
      <base />
      <set-header name="x-functions-key" exists-action="override">
        <value>{{pagopa-fn-checkout-key}}</value>
      </set-header>
      <set-backend-service base-url="{{pagopa-fn-checkout-url}}/api/v1" />
    </inbound>
    <outbound>
      <base />
      <set-header name="cache-control" exists-action="override">
          <value>no-store</value>
      </set-header>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
