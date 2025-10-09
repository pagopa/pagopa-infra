<policies>
    <inbound>
      <base />
      <set-header name="Authorization" exists-action="override">
        <value>@("Bearer "+ (string)(context.Request.Headers.GetValueOrDefault("x-npg-security-token", "")))</value>
      </set-header>
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
