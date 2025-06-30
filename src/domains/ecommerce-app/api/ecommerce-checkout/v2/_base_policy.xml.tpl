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
              <header>Authorization</header>
              <header>x-transaction-id-from-client</header>
              <header>x-correlation-id</header>
              <header>x-client-id-from-client</header>
          </allowed-headers>
        </cors>
      <base />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-variable name="blueDeploymentPrefix" value="@( context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue") || context.Request.Headers.GetValueOrDefault("Origin","").Equals("https://pagopa-d-checkout-cdn-endpoint.azureedge.net") ?"/beta":"")" />
      <set-header name="X-Client-Id" exists-action="override" >
      <value>CHECKOUT</value>
    </set-header>
      <set-variable name="transactionsV2OperationId" value="getTransactionInfo" />
      <set-variable name="transactionsV21OperationId" value="newTransaction" />
      <set-variable name="paymentMethodsOperationId" value="calculateFees" />
      <choose>
        <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("transactionsV21OperationId","").Split(','), operations => operations == context.Operation.Id))">
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-transactions-service-api-key-value}}</value>
          </set-header>
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2.1")"/>
        </when>
        <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("transactionsV2OperationId","").Split(','), operations => operations == context.Operation.Id))">
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-transactions-service-api-key-value}}</value>
          </set-header>
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2")"/>
        </when>
        <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("paymentMethodsOperationId","").Split(','), operations => operations == context.Operation.Id))">
          <!-- Set payment-methods API Key header -->
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-payment-methods-api-key-value}}</value>
          </set-header>
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
