<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pagopa-fn-checkout-url}}/api/v1" />
      <set-header name="x-functions-key" exists-action="override">
        <value>{{fn-checkout-key}}</value>
      </set-header>
      <rate-limit-by-key calls="20" renewal-period="30" counter-key="@(context.Request.IpAddress)" />
      <cors>
        <allowed-origins>
          <origin>${origin}</origin>
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