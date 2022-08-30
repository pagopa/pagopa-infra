<policies>

  <inbound>
      <base />
      <set-backend-service base-url="{{pagopa-appservice-proxy-url}}" />
      <choose>
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("checkout-rate-no-limit"))" />
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("checkout-rate-limit-300"))">
              <rate-limit-by-key calls="300" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
          </when>
          <otherwise>
              <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
          </otherwise>
      </choose>
  </inbound>
  
  <outbound>
      <set-header name="cache-control" exists-action="override">
          <value>no-store</value>
      </set-header>
      <set-variable name="body" value="@(context.Response.Body.As<JObject>())" />
      <base />
  </outbound>
  
  <backend>
      <base />
  </backend>
  
  <on-error>
      <base />
  </on-error>

</policies>
