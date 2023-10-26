<policies>
    <inbound>
        <base />
        <set-backend-service base-url="{{pagopa-appservice-proxy-url}}" />

        <rewrite-uri template="/payment-activations" />
        <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="rptId" value="@(((JObject) context.Variables["body"])["paymentNotices"][0]["rptId"].ToObject<string>())" />
        <set-variable name="amount" value="@(((JObject) context.Variables["body"])["paymentNotices"][0]["amount"].Value<int>())" />

        <choose>
            <when condition="@(!context.Request.Headers.ContainsKey("Authorization"))">
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
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

        <set-variable name="bearerToken" value="@{
          string authorizationHeader = context.Request.Headers["Authorization"][0];
          return authorizationHeader.Substring("Bearer ".Length);
        }" />
        <set-variable name="numberOfPaymentNotices" value="@{
          var body = context.Request.Body.As<JObject>();
          return body["paymentNotices"].ToObject<object[]>().Length;
        }" />
        <choose>
            <when condition="@(((int) context.Variables["numberOfPaymentNotices"]) > 1)">
                <return-response>
                    <set-status code="422" reason="Unprocessable Entity" />
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
    </inbound>
    <outbound>
        <base />
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
              eCommerceResponseBody["payments"] = payments;
              eCommerceResponseBody["clientId"] = "IO";
              eCommerceResponseBody["authToken"] = (string) context.Variables["bearerToken"];

              return eCommerceResponseBody.ToString();
            }</set-body>
          </when>
          <otherwise>
            <set-status code="502" reason="Bad Gateway" />
            <set-body>
              {
                "status": 502,
                "title": "Bad Gateway",
                "details": "pagopa-proxy returned non-200 status code"
              }
            </set-body>
          </otherwise>
        </choose> 
    </outbound>
    <backend>
        <base />
    </backend>
    <on-error>
        <base />
        <set-body>
          {
            "status": 502,
            "title": "Bad Gateway",
            "details": "Error while contacting pagopa-proxy"
          }
        </set-body>
    </on-error>
</policies>
