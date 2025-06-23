<policies>
    <inbound>
      <base />
      <!-- Set notifications-service API Key header -->
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-notification-service-api-key-value}}</value>
      </set-header>
      <!-- Handle X-Client-Id - multi channel - START -->
      <set-header name="X-Client-Id" exists-action="delete" />
      <choose>
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce"))">
              <set-header name="X-Client-Id" exists-action="override">
                  <value>CLIENT_ECOMMERCE</value>
              </set-header>
          </when>
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("payment-manager"))" >
            <set-header name="X-Client-Id" exists-action="override">
              <value>CLIENT_PAYMENT_MANAGER</value>
            </set-header>
          </when>
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce-test"))" >
            <set-header name="X-Client-Id" exists-action="override">
              <value>CLIENT_ECOMMERCE_TEST</value>
            </set-header>
          </when>
          <otherwise>
              <return-response>
                  <set-status code="401" reason="Unauthorized X-Client-Id" />
              </return-response>
          </otherwise>
      </choose>
      <!-- Handle X-Client-Id - multi channel - END -->
      <set-backend-service base-url="@("https://${hostname}/pagopa-notifications-service")"/>

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
