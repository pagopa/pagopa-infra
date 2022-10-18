<policies>

  <inbound>
      <cors>
        <allowed-origins>
          <origin>${checkout_origin}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
        </allowed-headers>
      </cors>
      <base />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <choose>
        <when condition="@( context.Request.Url.Path.Contains("payment-requests") ||  context.Request.Url.Path.Contains("transactions-service") )">
          <set-backend-service base-url="https://${ecommerce_ingress_hostname}/pagopa-ecommerce-transactions-service"/>
        </when>
        <when condition="@( context.Request.Url.Path.Contains("request-payments") )">
          <set-backend-service base-url="https://${pgs_hostname}/payment-gateway"/>
        </when>
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