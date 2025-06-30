<policies>
    <inbound>
      <base />
      <set-header name="x-user-id" exists-action="delete" />
      <choose>
        <when condition="@(context.Request.Headers.GetValueOrDefault("X-Environment", "").Equals("prod"))">
          <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
            <value>${pagopa_vpn}</value>
            <value>${pagopa_vpn_dr}</value>
          </check-header>
        </when>
      </choose>
      <set-header name="x-user-id" exists-action="override">
        <value>@(context.Subscription.Id)</value>
      </set-header>  
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-helpdesk-command-service-api-key-value}}</value>
      </set-header>  
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-helpdesk-commands-service" />
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
