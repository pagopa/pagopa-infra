<policies>
    <inbound>
      <base />
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/payment-gateway")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/payment-gateway")" />
        </otherwise>
      </choose>
      <set-variable name="requestPath" value="@(context.Request.Url.Path)" />
      <choose>
          <when condition="@(context.Request.Url.Path.Contains("xpay"))">
              <rewrite-uri template="@(((string)context.Variables["requestPath"]).Replace("request-payments/xpay","xpay/authorizations"))" />
          </when>
          <when condition="@(context.Request.Url.Path.Contains("vpos"))">
              <rewrite-uri template="@(((string)context.Variables["requestPath"]).Replace("request-payments/vpos","vpos/authorizations"))" />
          </when>
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
