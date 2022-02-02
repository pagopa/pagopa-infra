<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>${origin}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>GET</method>
          <method>POST</method>
          <method>OPTIONS</method>
          <method>HEAD</method>
        </allowed-methods>
      </cors>
      <set-backend-service base-url="{{pm-gtw-hostname}}/pp-admin-panel" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <base />
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
