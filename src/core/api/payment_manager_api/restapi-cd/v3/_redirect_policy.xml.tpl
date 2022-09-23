<policies>
    <inbound>
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Forwarded-For")).Equals("{{nexi-haproxy-ip}}"))">
          <return-response>
            <set-status code="307" />
            <set-header name="location" exists-action="override">
              <value>@($"https://${host}https://api.uat.platform.pagopa.it{context.Request.OriginalUrl.Path}{context.Request.OriginalUrl.QueryString}")</value>
            </set-header>
          </return-response>
        </when>
      </choose>
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
