<policies>
    <inbound>
      <base />
      <!-- Handle X-Client-Id START-->
      <choose>
          <when condition="@(context.User == null || !context.User.Groups.Select(g => g.Id).Contains("ecommerce-methods-full-read"))">
               <set-header name="x-client-id" exists-action="delete" />
          </when>
      </choose>
      <choose>
          <when condition="@(context.User != null && context.User.Groups.Select(g => g.Id).Contains("checkout-rate-no-limit"))">
              <set-header name="x-client-id" exists-action="override">
                  <value>CHECKOUT</value>
              </set-header>
          </when>
          <when condition="@(context.User != null && context.User.Groups.Select(g => g.Id).Contains("payment-wallet"))">
              <set-header name="x-client-id" exists-action="override">
                  <value>IO</value>
              </set-header>
          </when>
      </choose>
      <!-- Handle X-Client-Id END -->
      <!-- Set payment-methods API Key header -->
      <set-header name="x-api-key" exists-action="override">
        <value>{{ecommerce-payment-methods-api-key-value}}</value>
      </set-header>
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-payment-methods-service" />
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
