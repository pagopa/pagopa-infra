<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>https://{{wisp2-gov-it}}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>GET</method>
          <method>POST</method>
          <method>OPTIONS</method>
          <method>HEAD</method>
        </allowed-methods>
      </cors>
      <choose>
      <!-- TODO Enable after ticket resolution -->
      <!-- <when condition="@(context.Request.Headers.GetValueOrDefault("X-Environment", "").Equals("uat"))">
        <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
          <value>${allowed_ip_1}</value>
          <value>${allowed_ip_2}</value>
        </check-header>
      </when> -->
      <when condition="@(context.Request.Headers.GetValueOrDefault("X-Environment", "").Equals("prod"))">
        <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
          <value>${allowed_ip_1}</value>
          <value>${allowed_ip_2}</value>
        </check-header>
      </when>
    </choose>
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-admin-panel")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-admin-panel")" />
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
