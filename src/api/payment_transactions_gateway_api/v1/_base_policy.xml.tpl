<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pm-onprem-hostname}}/payment-gateway" />
      <!-- Handle X-Client-Id - pagopa-proxy multi channel - START -->
        <set-header name="X-Client-Id" exists-action="delete" />
        <choose>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("payment-manager"))">
                <set-header name="X-Client-Id" exists-action="override">
                    <value>APP</value>
                </set-header>
            </when>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce"))" >
              <set-header name="X-Client-Id" exists-action="override">
                <value>WEB</value>
              </set-header>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="404" reason="Not found" />
                </return-response>
            </otherwise>
        </choose>
        <!-- Handle X-Client-Id - pagopa-proxy multi channel - END -->
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
