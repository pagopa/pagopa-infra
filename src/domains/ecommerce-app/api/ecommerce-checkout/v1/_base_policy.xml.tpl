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
          <header>lang</header>
        </allowed-headers>
      </cors>
      <base />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-header name="X-Client-Id" exists-action="override" >
      <value>CHECKOUT</value>
    </set-header>
      <choose>
        <when condition="@(
          (context.Request.Url.Path.StartsWith("/transactions")
              || context.Request.Url.Path.StartsWith("/v2/transactions")
              || context.Request.Url.Path.StartsWith("/v2.1/transactions"))
            && (context.Operation.Id.Equals("newTransaction")
              || context.Operation.Id.Equals("getTransactionInfo")
              || context.Operation.Id.Equals("requestTransactionUserCancellation")
              || context.Operation.Id.Equals("requestTransactionAuthorization")
              || context.Operation.Id.Equals("updateTransactionAuthorization")
              || context.Operation.Id.Equals("addUserReceipt"))
        )">
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service")"/>
        </when>
        <when condition="@(
          (context.Request.Url.Path.StartsWith("/payment-methods")
              || context.Request.Url.Path.StartsWith("/v2/payment-methods"))
            && (context.Operation.Id.Equals("newPaymentMethod")
              || context.Operation.Id.Equals("getAllPaymentMethods")
              || context.Operation.Id.Equals("patchPaymentMethod")
              || context.Operation.Id.Equals("getPaymentMethod")
              || context.Operation.Id.Equals("createSession")
              || context.Operation.Id.Equals("calculateFees")
              || context.Operation.Id.Equals("getSessionPaymentMethod")
              || context.Operation.Id.Equals("updateSession")
              || context.Operation.Id.Equals("getTransactionIdForSession"))
        )">
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service")"/>
        </when>
        <when condition="@(
          (context.Request.Url.Path.StartsWith("/payment-requests")
              || context.Request.Url.Path.StartsWith("/carts"))
            && (context.Operation.Id.Equals("getPaymentRequestInfo")
              || context.Operation.Id.Equals("PostCarts")
              || context.Operation.Id.Equals("GetCarts"))
        )">
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
