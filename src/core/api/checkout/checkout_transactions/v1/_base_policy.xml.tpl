<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>*</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
        </allowed-headers>
      </cors>
      <base />
      <set-backend-service base-url="{{pagopa-fn-checkout-url}}/api/v1" />
      <set-header name="x-functions-key" exists-action="override">
        <value>{{pagopa-fn-checkout-key}}</value>
      </set-header>
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
