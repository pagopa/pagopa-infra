<policies>

  <inbound>
    <base />

    <!-- Delete headers required for backend service START -->
    <set-header name="x-client-id" exists-action="delete" />
    <set-header name="x-user-id" exists-action="delete" />
    <set-header name="x-client-id" exists-action="override">
        <value>IO</value>
    </set-header>
    <!-- Delete headers required for backend service END -->

    <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
    <!-- Session eCommerce START-->
    <!-- Check JWT START-->
    <include-fragment fragment-id="jwt-chk-wallet-session" />
    <!-- Check JWT END-->
    <!-- Headers settings required for backend service START -->
    <set-header name="x-user-id" exists-action="override">
        <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
    </set-header>
    <set-header name="x-client-id" exists-action="override" >
      <value>IO</value>
    </set-header>
    <!-- Headers settings required for backend service END -->
    <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
    <set-variable name="paymentMethodsHandlerOperationId" value="getAllPaymentMethods" />
    <choose>
      <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("paymentMethodsHandlerOperationId","").Split(','), operations => operations == context.Operation.Id))">
        <!-- Set payment-methods API Key header -->
        <set-header name="x-api-key" exists-action="override">
          <value>{{ecommerce-payment-methods-api-key-value}}</value>
        </set-header>
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-handler")"/>
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
