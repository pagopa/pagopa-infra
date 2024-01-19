<policies>
    <inbound>
        <return-response>
          <set-status code="302" />
          <set-header name="location" exists-action="override">
            <value>@($"iowallet://{context.Request.OriginalUrl.Host}{context.Request.OriginalUrl.Path}{context.Request.OriginalUrl.QueryString}")</value>
          </set-header>
        </return-response>
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
