<policies>
  <inbound>
    <set-variable
        name="body"
        value="@(context.Request.Body.As<JObject>(preserveContent: true))"
    />
    <set-variable name="rptId" value="@(context.Variables["body"]["paymentNotices"][0]["rptId"])" />
    <set-variable name="amount" value="@(context.Variables["body"]["paymentNotices"][0]["amount"].Value<int>)" />
    <set-variable name="bearerToken" value="@{
      string authorizationHeader = context.Request.Headers["Authorization"];

      return authorizationHeader.Substring(0, "Bearer ".Length);
    }" />

    <set-variable name="numberOfPaymentNotices" value="@{
        var body = context.Request.Body.As<JObject>();
        return body["paymentNotices"].Length;
    }" />

    <choose>
        <when condition="@(context.Variables["numberOfPaymentNotices"] > 1)">
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

    <set-body>
      @{
        JObject pagopaProxyBody = new JObject();
        pagopaProxyBody["rptId"] = context.Variables["rptId"];
        pagopaProxyBody["amount"] = context.Variables["amount"];

        return pagopaProxyBody;
      }
    </set-body>

    <base />
  </inbound>

  <outbound>
      <base />

      <set-variable name="ccp" value="@(context.Response.Body.As<JObject>()["codiceContestoPagamento"])" />

      <cache-store-value key="@(context.Variables["ccp"])" value="@(context.Variables["body"]["walletId"])" duration="600" />

      <set-body>
        @{
          JObject eCommerceResponseBody = new JObject();
          eCommerceResponseBody["transactionId"] = context.Variables["ccp"];
          eCommerceResponseBody["payments"] = new List<int>{};
          eCommerceResponseBody["clientId"] = "IO";
          eCommerceResponseBody["authToken"] = context.Variables["bearerToken"];

          return eCommerceResponseBody;
        }
    </set-body>

  </outbound>

  <backend>
      <base />
  </backend>
</policies>
