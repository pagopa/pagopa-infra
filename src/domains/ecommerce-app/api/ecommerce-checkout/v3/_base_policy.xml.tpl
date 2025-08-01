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
          <header>lang</header>
          <header>x-correlation-id</header>
          <header>x-client-id-from-client</header>
          <header>x-rpt-id</header>
          <header>Traceparent</header>
        </allowed-headers>
      </cors>
      <base />
      <set-variable name="authToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
      <choose>
        <when condition="@(((string)(context.Variables["authToken"])).Equals(""))">
        <return-response>
          <set-status code="401" reason="Unauthorized" />
        </return-response>
        </when>
      </choose>
      <rate-limit-by-key calls="10" renewal-period="5" counter-key="@(context.Request.Headers.GetValueOrDefault("Authorization",""))" />
      <!-- use same threshold as for other checkout api's for IP rate limits -->
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-header name="X-Client-Id" exists-action="override" >
        <value>CHECKOUT</value>
      </set-header>
      <rewrite-uri template="@((context.Request.Url.Path).Replace("auth/",""))" />
      <set-variable name="transactionsOperationId" value="newTransactionV3" />
      <set-variable name="paymentMethodsOperationId" value="getAllPaymentMethodsV3,createSessionV3" />
      <set-variable name="paymentRequestsOperationId" value="getPaymentRequestInfoV3" />
      <choose>
        <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("transactionsOperationId","").Split(','), operations => operations == context.Operation.Id))">
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-transactions-service-api-key-value}}</value>
          </set-header>
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2.1")"/>
        </when>
        <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("paymentMethodsOperationId","").Split(','), operations => operations == context.Operation.Id))">
          <!-- Set payment-methods API Key header -->
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-payment-methods-api-key-value}}</value>
          </set-header>
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service")"/>
        </when>
        <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("paymentRequestsOperationId","").Split(','), operations => operations == context.Operation.Id))">
          <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-requests-service")"/>
        </when>
      </choose>
      <!-- Check authorization token START-->
      <choose>
        <when condition="@(context.Operation.Id != ("newTransactionV3"))">
          <send-request ignore-error="true" timeout="10" response-variable-name="checkSessionResponse" mode="new">
            <set-url>@($"https://${checkout_ingress_hostname}/pagopa-checkout-auth-service/auth/validate")</set-url>
            <set-method>GET</set-method>
            <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["authToken"])</value>
            </set-header>
            <set-header name="x-rpt-id" exists-action="override">
              <value>@((string)context.Request.Headers.GetValueOrDefault("x-rpt-id",""))</value>
            </set-header>
          </send-request>
          <choose>
            <when condition="@(((int)((IResponse)context.Variables["checkSessionResponse"]).StatusCode) == 401)">
              <return-response>
                <set-status code="401" reason="Unauthorized" />
              </return-response>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["checkSessionResponse"]).StatusCode) == 500)">
              <return-response>
                <set-status code="502" reason="Internal server error" />
                <set-body>
                  {
                      "status": 502,
                      "title": "Internal server error",
                      "detail": "Error in token validation"
                  }
                </set-body>
              </return-response>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["checkSessionResponse"]).StatusCode) != 200)">
              <return-response>
                <set-status code="502" reason="Internal server error" />
                <set-body>
                  {
                      "status": 502,
                      "title": "Internal server error",
                      "detail": "Unexpected error in token validation"
                  }
                </set-body>
              </return-response>
            </when>
          </choose>
        </when>
      </choose>
      <!-- Check authorization token END-->
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
