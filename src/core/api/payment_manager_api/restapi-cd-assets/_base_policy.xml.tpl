<policies>
    <inbound>
      <set-variable name="fromDnsHost" value="@(context.Request.OriginalUrl.Host)" />
      <choose>
        <when condition="@(context.Variables.GetValueOrDefault<string>("fromDnsHost").Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-restapi-CD/assets")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/assets")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
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
