<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>*</origin>
        </allowed-origins>
        <allowed-methods>
          <method>GET</method>
          <method>POST</method>
          <method>OPTIONS</method>
          <method>HEAD</method>
        </allowed-methods>
      </cors>
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/wallet")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/wallet")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
      <base />
    </inbound>
    <outbound>
        <base />
        <choose>
            <when condition="@(((string)context.Response.Headers.GetValueOrDefault("location","")).Contains("{{pm-host}}"))">
                <set-variable name="locationIn" value=" @(Regex.Replace((string)context.Response.Headers.GetValueOrDefault("location",""), "{{pm-host}}", "https://{{wisp2-gov-it}}"))" />
                <set-header name="location" exists-action="override">
                    <value>@(context.Variables.GetValueOrDefault<string>("locationIn"))</value>
                </set-header>
            </when>
        </choose>

        <!-- related to https://developers.google.com/search/docs/advanced/crawling/block-indexing?hl=it -->
        <set-header name="X-Robots-Tag" exists-action="override">
          <value>noindex</value>
        </set-header>

    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
