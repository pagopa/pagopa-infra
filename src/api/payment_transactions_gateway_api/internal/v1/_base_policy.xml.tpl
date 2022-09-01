<policies>
    <inbound>
      <base />
      <set-backend-service base-url="${hostname}/payment-gateway" />
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
