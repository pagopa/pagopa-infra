<policies>

  <inbound>
      <cors>
          <allowed-origins>
              <origin>${checkout_origin}</origin>
          </allowed-origins>
          <allowed-methods>
              <method>POST</method>
              <method>OPTIONS</method>
          </allowed-methods>
          <allowed-headers>
              <header>Content-Type</header>
              <header>Authorization</header>
              <header>x-transaction-id-from-client</header>
              <header>x-correlation-id</header>
          </allowed-headers>
        </cors>
      <base />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-variable name="blueDeploymentPrefix" value="@( context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue") || context.Request.Headers.GetValueOrDefault("Origin","").Equals("https://pagopa-d-checkout-cdn-endpoint.azureedge.net") ?"/beta":"")" />
      <set-header name="X-Client-Id" exists-action="override" >
      <value>CHECKOUT</value>
    </set-header>
      <choose>
        <when condition="@( context.Request.Url.Path.Contains("transactions") )">
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2")"/>
        </when>
        <when condition="@( context.Request.Url.Path.Contains("payment-methods") )">
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service/v2")"/>
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
