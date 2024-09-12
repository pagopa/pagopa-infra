<policies>
    <inbound>
      <!-- Session PM START-->
      <set-variable  name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
          <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletToken"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
       <choose>
          <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode == 401)">
              <return-response>
                  <set-status code="401" reason="Unauthorized" />
                  <set-header name="Content-Type" exists-action="override">
                      <value>application/json</value>
                  </set-header>
                  <set-body>
                      {
                          "title": "Unauthorized",
                          "status": 401,
                          "detail": "Invalid session token"
                      }
                  </set-body>
              </return-response>
          </when>
          <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode != 200)">
              <return-response>
                  <set-status code="502" reason="Bad Gateway" />
                  <set-header name="Content-Type" exists-action="override">
                      <value>application/json</value>
                  </set-header>
                  <set-body>
                      {
                          "title": "Error starting session",
                          "status": 502,
                          "detail": "There was an error starting session for input wallet token"
                      }
                  </set-body>
              </return-response>
          </when>
      </choose>
      <set-variable name="pmSession" value="@(((IResponse)context.Variables["pm-session-body"]).Body.As<JObject>())" />
      <!-- Extract payment method name for create redirectUrl -->
      <set-variable name="requestBody" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
      <set-variable name="paymentMethodId" value="@((string)((JObject) context.Variables["requestBody"])["paymentMethodId"])" />
      <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
          <set-url>@("https://${ecommerce-basepath}/pagopa-ecommerce-payment-methods-service/payment-methods/" + context.Variables["paymentMethodId"])</set-url>
          <set-method>GET</set-method>
          <set-header name="x-client-id" exists-action="override">
              <value>IO</value>
          </set-header>
      </send-request>
      <choose>
          <when condition="@(((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode != 200)">
              <return-response>
              <set-status code="502" reason="Bad Gateway" />
              <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
              </set-header>
              <set-body>
                  {
                      "title": "Error retrieving eCommerce payment methods",
                      "status": 502,
                      "detail": "There was an error retrieving eCommerce payment methods"
                  }
              </set-body>
              </return-response>
          </when>
      </choose>
      <set-variable name="paymentMethodsResponseBody" value="@(((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />
      <set-variable name="paymentMethodTypeCode" value="@((string)((JObject) context.Variables["paymentMethodsResponseBody"])["paymentTypeCode"])" />
      <set-variable name="redirectUrlPrefix" value="@{
              string returnedPaymentMethodTypeCode = (string)context.Variables["paymentMethodTypeCode"];
              var paymentMethodTypeCodes = new Dictionary<string, string>
                  {
                      { "CP", "pm-onboarding/creditcard" },
                      { "BPAY", "pm-onboarding/bpay" },
                      { "PPAL", "pm-onboarding/paypal" }
                  };

              string redirectUrlPrefix;
              paymentMethodTypeCodes.TryGetValue(returnedPaymentMethodTypeCode, out redirectUrlPrefix);
              return redirectUrlPrefix;
      }" />
      <choose>
        <when condition="@((string)context.Variables["redirectUrlPrefix"] == null)">
            <return-response>
               <set-status code="502" reason="Bad Gateway" />
               <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
               </set-header>
               <set-body>
                   {
                       "title": "Error retrieving eCommerce payment methods",
                       "status": 502,
                       "detail": "Invalid payment method name"
                   }
               </set-body>
            </return-response>
        </when>
      </choose>
      <!-- End extract payment method name for create redirectUrl -->
      <return-response>
        <set-status code="201" />
        <set-header name="Content-Type" exists-action="override">
          <value>application/json</value>
        </set-header>
        <set-body>@{
            return new JObject(
                        new JProperty("redirectUrl", $"https://${env}.payment-wallet.pagopa.it/{(string)context.Variables["redirectUrlPrefix"]}#sessionToken={((string)((JObject) context.Variables["pmSession"])["data"]["sessionToken"])}")
                ).ToString();
        }</set-body>
      </return-response>
      <!-- Session PM END-->
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
