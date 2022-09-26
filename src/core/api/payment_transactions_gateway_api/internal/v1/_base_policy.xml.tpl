<policies>
    <inbound>
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
      <!-- Handle X-Client-ID - multi channel - START -->
        <set-header name="X-Client-ID" exists-action="delete" />
        <choose>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("payment-manager"))">
                <set-header name="X-Client-ID" exists-action="override">
                    <value>APP</value>
                </set-header>
            </when>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce"))" >
              <set-header name="X-Client-ID" exists-action="override">
                <value>WEB</value>
              </set-header>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="404" reason="Not found" />
                </return-response>
            </otherwise>
        </choose>
        <!-- Handle X-Client-ID - multi channel - END -->
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
