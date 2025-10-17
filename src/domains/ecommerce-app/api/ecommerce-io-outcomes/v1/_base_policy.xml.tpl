<policies>
    <inbound>
        <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

        <choose>
          <when condition='@((string)context.Request.Original.Path).Equals("/payments/cars/outcomes", StringComparison.OrdinalIgnoreCase)'>

            <choose>

              <when condition='@(context.Request.MatchedParameters.ContainsKey("outcome") && (context.Request.MatchedParameters["outcome"] == "0" || context.Request.MatchedParameters["outcome"] == "1"))'>
                <return-response>
                  <set-status code="302" />
                  <set-header name="location" exists-action="override">
                    <value>@($"iowallet://{context.Request.OriginalUrl.Host}{context.Request.OriginalUrl.Path}{context.Request.OriginalUrl.QueryString}")</value>
                  </set-header>
                </return-response>
              </when>

              <otherwise>
                <return-response>
                  <set-status code="404" reason="Not found" />
                </return-response>
              </otherwise>

            </choose>
          </when>

          <otherwise>
            <return-response>
              <set-status code="302" />
              <set-header name="location" exists-action="override">
                <value>@($"iowallet://{context.Request.OriginalUrl.Host}{context.Request.OriginalUrl.Path}{context.Request.OriginalUrl.QueryString}")</value>
              </set-header>
            </return-response>
          </otherwise>

        </choose>



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
