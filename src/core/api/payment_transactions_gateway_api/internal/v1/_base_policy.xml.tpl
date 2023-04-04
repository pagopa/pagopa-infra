<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>  
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

      <!-- Handle X-Client-ID - multi channel - START -->
      <choose>
        <when condition="@(context.User.Groups.Select(g => g.Id).Contains("payment-manager"))">
            <set-header name="X-Client-ID" exists-action="override">
                <value>ECOMMERCE_APP</value>
            </set-header>
        </when>
        <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce"))" >
          <set-header name="X-Client-ID" exists-action="override">
            <value>ECOMMERCE_WEB</value>
          </set-header>
        </when>
        <otherwise>
            <return-response>
                <set-status code="404" reason="Not found" />
            </return-response>
        </otherwise>
      </choose>
      <!-- Handle X-Client-ID - multi channel - END -->
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
      <!-- Handle X-Client-ID - multi channel - START -->
        <set-header name="X-Client-ID" exists-action="delete" />
        <choose>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("payment-manager"))">
                <set-header name="X-Client-ID" exists-action="override">
                    <value>ECOMMERCE_APP</value>
                </set-header>
            </when>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce"))" >
              <set-header name="X-Client-ID" exists-action="override">
                <value>ECOMMERCE_WEB</value>
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
