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
      <set-variable name="fromDnsHost" value="@(context.Request.OriginalUrl.Host)" />
      <choose>
        <when condition="@(context.Variables.GetValueOrDefault<string>("fromDnsHost").Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-admin-panel")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-admin-panel")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
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
