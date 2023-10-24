<policies>
  <inbound>
    <set-variable name="ccp" value="@(context.Request.MatchedParameters["transactionId"])" />

    <cache-lookup-value key="@(context.Variables["ccp"])" variable-name="idWallet" />

    <send-request
        response-variable-name="pagopaProxyResponse"
        timeout="10"
    >
        <set-url>@("${pagopa_proxy_host}/${pagopa_proxy_path}/" + context.Variables["ccp"]</set-url>
        <set-method>GET</set-method>
    </send-request>

    <set-variable name="idPayment" value="@(context.Variables["pagopaProxyResponse"].Body.As<JOBject>()["idPagamento"])" />

    <set-variable name="bearerToken" value="@{
      string authorizationHeader = context.Request.Headers["Authorization"];
      return authorizationHeader.Substring(0, "Bearer ".Length);
    }" />

    <set-body>
        @{
            var paymentPageParameters = new Dictionary<string,string> {{
                "idWallet", context.Variables["idWallet"],
                "idPayment", context.Variables["idPayment"],
                "sessionToken", context.Variables["bearerToken"],
                "language", "IT"
            }};

            var fragment = "#" + string.Join("&", paymentPageParameters.Select(kvp => $"{kvp.Key}={kvp.Value}"));
            var url = new UriBuilder("https","${webview_host}", 443, "${webview_path}", fragment);
            
            var response = new JObject();
            response["authorizationUrl"] = url;
            response["authorizationRequestId"] = context.Variables["idPayment"];
            
            return response;
        }
    </set-body>

  </inbound>

  <outbound>
    <base />
  </outbound>

  <backend>
      <base />
  </backend>
</policies>
