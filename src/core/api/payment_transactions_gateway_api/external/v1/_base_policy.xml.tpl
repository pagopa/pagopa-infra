<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>${origin}</origin>
        </allowed-origins>
        <allowed-methods preflight-result-max-age="300">
          <method>*</method>
        </allowed-methods>
        <allowed-headers>
          <header>*</header>
        </allowed-headers>
        <expose-headers>
          <header>*</header>
        </expose-headers>
      </cors>
      <base />
      <set-variable name="fromDnsHost" value="@(context.Request.OriginalUrl.Host)" />
      <choose>
        <when condition="@(context.Variables.GetValueOrDefault<string>("fromDnsHost").Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/payment-gateway")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/payment-gateway")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
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
