<policies>
    <inbound>
      <base />
      <choose>
        <when condition="@(context.Operation.Id == "ecommerceSearchMetrics")">
          <rate-limit-by-key
            calls="10"
            renewal-period="5"
            counter-key="@(context.Subscription.Name + &quot;:ecommerceSearchMetrics&quot;)"
            increment-condition="@(true)" />
        </when>
      </choose>
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-helpdesk-service/v2" />
      <set-header name="x-api-key" exists-action="override">
              <value>{{ecommerce-helpdesk-service-rest-api-key}}</value>
      </set-header>
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
