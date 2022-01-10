<policies>
    <inbound>
      <cors>
        <allowed-methods>
          <method>GET</method>
          <method>POST</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
        </allowed-headers>
      </cors>
      <base />
      <set-backend-service base-url="{{pagopa-fn-buyerbank-url}}/api/v1" />
      <set-header name="x-functions-key" exists-action="override">
        <value>{{pagopa-fn-buyerbank-key}}</value>
      </set-header>
      <rate-limit-by-key calls="50" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
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
