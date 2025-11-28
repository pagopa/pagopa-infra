<policies>

  <inbound>
      <cors>
        <allowed-origins>
          ${origins}
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
      <set-variable name="transactionsOperationId" value="newTransaction,getTransactionInfo,getTransactionOutcomes,requestTransactionUserCancellation,requestTransactionAuthorization" />
      <set-variable name="paymentMethodsOperationId" value="getAllPaymentMethods,getPaymentMethod,calculateFees,createSession,getSessionPaymentMethod" />
      <set-variable name="paymentRequestsOperationId" value="getPaymentRequestInfo" />
      <set-variable name="cartsOperationId" value="GetCarts,GetCartsRedirect" />
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
        <when condition="@(
          Array.Exists(context.Variables.GetValueOrDefault("paymentRequestsOperationId","").Split(','), operations => operations == context.Operation.Id)
          ||
          Array.Exists(context.Variables.GetValueOrDefault("cartsOperationId","").Split(','), operations => operations == context.Operation.Id)
        )">
          <!-- Set payment-requests API Key header -->
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-payment-requests-api-key-value}}</value>
          </set-header>
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-requests-service")"/>
        </when>
      </choose>
  </inbound>
  <outbound>
      <base />
      <choose>
          <!-- per operation id tracing -->
          <when condition="@(context.Operation.Id == "getTransactionOutcomes")">
              <set-variable name="responseBody" value="@(context.Response.Body.As<JObject>(preserveContent: true))" />
              <trace source="Transaction outcome api result" severity="information">
                  <message>Transaction outcome</message>
                  <metadata name="outcome" value="@{
                      JObject responseBody = (JObject)context.Variables["responseBody"];
                      string responseValue = null;
                      if(responseBody != null){
                      responseValue = (string)responseBody["outcome"];
                      }
                      return responseValue != null ? responseValue : "-";
                  }" />
                  <metadata name="isFinalStatus" value="@{
                      JObject responseBody = (JObject)context.Variables["responseBody"];
                      string responseValue = null;
                      if(responseBody != null){
                      responseValue = (string)responseBody["isFinalStatus"];
                      }
                      return responseValue != null ? responseValue : "-";
                  }" />
                  <metadata name="transactionId" value="@(context.Request.MatchedParameters.GetValueOrDefault("transactionId",""))" />
              </trace>
          </when>
      </choose>
  </outbound>
  <backend>
      <base />
  </backend>

  <on-error>
      <base />
  </on-error>

</policies>
