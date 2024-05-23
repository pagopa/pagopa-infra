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
          <method>DELETE</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
          <header>Authorization</header>
          <header>x-transaction-id-from-client</header>
        </allowed-headers>
      </cors>
      <base />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-header name="X-Client-Id" exists-action="override" >
      <value>CHECKOUT</value>
    </set-header>
      <choose>
        <when condition="@( context.Request.Url.Path.Contains("transactions") )">
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service")"/>
        </when>
        <when condition="@( context.Request.Url.Path.Contains("payment-methods") )">
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service")"/>
        </when>
        <when condition="@( context.Request.Url.Path.Contains("payment-requests") || context.Request.Url.Path.Contains("carts") )"> <!-- TODO use startWith -->
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-requests-service")"/>
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
