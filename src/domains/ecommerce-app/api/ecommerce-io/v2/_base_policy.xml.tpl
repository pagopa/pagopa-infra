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
    <set-variable name="transactionsOperationId" value="newTransactionForIO,getTransactionInfoForIO,requestTransactionUserCancellationForIO,requestTransactionAuthorizationForIO" />
    <set-variable name="paymentMethodsOperationId" value="getAllPaymentMethodsForIO" />
    <set-variable name="paymentMethodsOperationIdV2" value="calculateFeesForIO" />
    <set-variable name="paymentRequestsOperationId" value="getPaymentRequestInfoForIO" />
    <set-variable name="lastPaymentMethodUsedOperationId" value="getUserLastPaymentMethodUsed" />
    <set-variable name="walletsOperationId" value="createWalletForTransactionsForIO,getWalletsByIdIOUser" />
    <choose>
      <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("transactionsOperationId","").Split(','), operations => operations == context.Operation.Id))">
        <set-header name="x-api-key" exists-action="override">
          <value>{{ecommerce-transactions-service-api-key-value}}</value>
        </set-header>
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service")"/>
      </when>
      <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("paymentMethodsOperationId","").Split(','), operations => operations == context.Operation.Id))">
        <!-- Set payment-methods API Key header -->
        <set-header name="x-api-key" exists-action="override">
          <value>{{ecommerce-payment-methods-api-key-value}}</value>
        </set-header>
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service")"/>
      </when>
      <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("paymentMethodsOperationIdV2","").Split(','), operations => operations == context.Operation.Id))">
        <!-- Set payment-methods API Key header -->
        <set-header name="x-api-key" exists-action="override">
          <value>{{ecommerce-payment-methods-api-key-value}}</value>
        </set-header>
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service/v2")" />
      </when>
      <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("paymentRequestsOperationId","").Split(','), operations => operations == context.Operation.Id))">
        <!-- Set payment-requests API Key header -->
        <set-header name="x-api-key" exists-action="override">
          <value>{{ecommerce-payment-requests-api-key-value}}</value>
        </set-header>
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-requests-service")"/>
      </when>
      <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("lastPaymentMethodUsedOperationId","").Split(','), operations => operations == context.Operation.Id))">
        <set-header name="x-api-key" exists-action="override">
          <value>{{ecommerce-user-stats-service-api-key-value}}</value>
        </set-header>
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-user-stats-service")"/>
      </when>
      <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("walletsOperationId","").Split(','), operations => operations == context.Operation.Id))">
        <set-backend-service base-url="@("https://${wallet_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-wallet-service")"/>
        <set-header name="x-api-key" exists-action="override">
          <value>{{payment-wallet-service-rest-api-key}}</value>
        </set-header>
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
