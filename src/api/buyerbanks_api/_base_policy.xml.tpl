<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pagopa-fn-buyerbanks-url}}/api/v1" />
      <set-header name="x-functions-key" exists-action="override">
        <value>{{pagopa-fn-buyerbanks-key}}</value>
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
