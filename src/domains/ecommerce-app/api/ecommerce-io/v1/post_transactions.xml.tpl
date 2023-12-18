<policies>
    <inbound>
        <base />
        <set-header name="X-Client-Id" exists-action="delete" />
        <choose>
          <when condition="@("true".Equals("${ecommerce_io_with_pm_enabled}"))">
            <set-backend-service base-url="{{pagopa-appservice-proxy-url}}" />
            <rewrite-uri template="/payment-activations" />
            <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
            <set-variable name="rptId" value="@(((JObject) context.Variables["body"])["paymentNotices"][0]["rptId"].ToObject<string>())" />
            <set-variable name="amount" value="@(((JObject) context.Variables["body"])["paymentNotices"][0]["amount"].Value<int>())" />
            <choose>
                <when condition="@(!context.Request.Headers.ContainsKey("Authorization"))">
                    <return-response>
                        <set-status code="401" reason="Unauthorized" />
                        <set-header name="Content-Type" exists-action="override">
                          <value>application/json</value>
                        </set-header>
                        <set-body>
                          {
                            "status": 401,
                            "title": "Unauthorized",
                            "details": "Missing Authorization header"
                          }
                        </set-body>
                    </return-response>
                </when>
            </choose>

            <set-variable name="numberOfPaymentNotices" value="@{
              var body = context.Request.Body.As<JObject>();
              return body["paymentNotices"].ToObject<object[]>().Length;
            }" />
            <choose>
                <when condition="@(((int) context.Variables["numberOfPaymentNotices"]) > 1)">
                    <return-response>
                        <set-status code="422" reason="Unprocessable Entity" />
                        <set-header name="Content-Type" exists-action="override">
                          <value>application/json</value>
                        </set-header>
                        <set-body>
                          {
                            "status": 422,
                            "title": "Invalid payment request",
                            "details": "Cannot pay more than one payment notice at once"
                          }
                        </set-body>
                    </return-response>
                </when>
            </choose>
            <set-variable name="ccp" value="@(Guid.NewGuid().ToString("N"))" />
            <cache-store-value key="@($"ecommerce:{context.Variables["ccp"]}-rptId")"  value="@(((string) context.Variables["rptId"]))" duration="900" caching-type="internal" />
            <cache-store-value key="@($"ecommerce:{context.Variables["ccp"]}-amount")" value="@(((int) context.Variables["amount"]))" duration="900" caching-type="internal" /> 
            <set-body>
              @{
                JObject pagopaProxyBody = new JObject();
                pagopaProxyBody["rptId"] = ((string) context.Variables["rptId"]);
                pagopaProxyBody["codiceContestoPagamento"] = ((string) context.Variables["ccp"]);
                pagopaProxyBody["importoSingoloVersamento"] = ((int) context.Variables["amount"]);
                return pagopaProxyBody.ToString();
              }
            </set-body>
            <set-header name="X-Client-Id" exists-action="override">
              <value>CLIENT_IO</value>
            </set-header>
          </when>
          <otherwise>
          <!-- Get User IO START-->
          <send-request ignore-error="true" timeout="10" response-variable-name="user-auth-body" mode="new">
              <set-url>@("${io_backend_base_path}/pagopa/api/v1/user?version=20200114")</set-url> 
              <set-method>GET</set-method>
              <set-header name="Accept" exists-action="override">
                <value>application/json</value>
              </set-header>
              <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables.GetValueOrDefault("walletToken"))</value>
              </set-header>
          </send-request>
          <choose>
            <when condition="@(((IResponse)context.Variables["user-auth-body"]).StatusCode != 200)">
              <return-response>
                <set-status code="502" reason="Bad Gateway" />
              </return-response>
            </when>
          </choose>
          <set-variable name="userAuth" value="@(((IResponse)context.Variables["user-auth-body"]).Body.As<JObject>())" />
          <!-- Get User IO END-->
            <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2")"/>
            <!-- Maybe here add a backend call to the get user to get user email -->
            <set-body>@{ 
                JObject userAuth = (JObject)context.Variables["userAuth"];
                String spidEmail = userAuth["spidEmail"];
                String noticeEmail = userAuth["noticeEmail"];
                JObject requestBody = context.Request.Body.As<JObject>(preserveContent: true); 
                requestBody["orderId"] = "ORDER_ID"; //To be removed since it is mandatory for transaction request body, but it should not be
                if(noticeEmail.IsNullOrEmpty()) {
                  requestBody["email"] = spidEmail;
                } else {
                  requestBody["email"] = noticeEmail;
                }
                return requestBody.ToString();  
            }</set-body>
            <set-header name="X-Client-Id" exists-action="override">
              <value>IO</value>
            </set-header>
          </otherwise>
        </choose>
    </inbound>
    <outbound>
        <base />
        <choose>
          <when condition="@("true".Equals("${ecommerce_io_with_pm_enabled}"))">
            <set-variable name="pagopaProxyResponseBody" value="@(context.Response.Body.As<JObject>())" />
            <choose>
              <when condition="@(context.Response.StatusCode == 200)">
                <set-body>@{
                  JObject payment = new JObject();
                  payment["rptId"] = (string) context.Variables["rptId"];
                  payment["amount"] = (int) ((JObject) context.Variables["pagopaProxyResponseBody"])["importoSingoloVersamento"];

                  JArray payments = new JArray();
                  payments.Add(payment);

                  JObject eCommerceResponseBody = new JObject();
                  eCommerceResponseBody["transactionId"] = (string) context.Variables["ccp"];
                  eCommerceResponseBody["status"] = "ACTIVATION_REQUESTED";
                  eCommerceResponseBody["payments"] = payments;
                  eCommerceResponseBody["clientId"] = "IO";

                  return eCommerceResponseBody.ToString();
                }</set-body>
              </when>
              <otherwise>
                <set-status code="502" reason="Bad Gateway" />
                <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
                </set-header>
                <set-body>
                  {
                    "status": 502,
                    "title": "Bad Gateway",
                    "details": "pagopa-proxy returned non-200 status code"
                  }
                </set-body>
              </otherwise>
            </choose> 
          </when>
        </choose>
    </outbound>
    <backend>
        <base />
    </backend>
    <on-error>
        <base />
        <choose>
          <when condition="@("true".Equals("${ecommerce_io_with_pm_enabled}"))">
            <set-body>
            {
              "status": 502,
              "title": "Bad Gateway",
              "details": "Error while contacting pagopa-proxy"
            }
            </set-body>
          </when>
        </choose>
    </on-error>
</policies>
