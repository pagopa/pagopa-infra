<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>${payment_wallet_origin}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
          <header>Authorization</header>
        </allowed-headers>
      </cors>
      <base />
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-restapi-CD/v1")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/v1")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
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
