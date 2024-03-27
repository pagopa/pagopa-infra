<policies>
  <inbound>
    <base />
    <set-variable name="requestTransactionId" value="@(context.Request.Url.Query.GetValueOrDefault("transactionId",""))" />
    <return-response>
      <set-status code="200" />
      <set-header name="Content-Type" exists-action="override">
          <value>text/html</value>
      </set-header>
      <!-- set cookies for redirect to eCommerce outcome url -->
      <set-header name="Set-Cookie" exists-action="append">
        <value>isEcommerceTransaction=true; path=/pp-restapi-CD;</value>
        <value>@($"ecommerceTransactionId={(string)context.Variables["requestTransactionId"]}; path=/pp-restapi-CD;")</value>
      </set-header>
      <set-body template="liquid">
        <html>
          <body>
            <form id="pmPay" action="/pp-restapi-CD/v3/webview/transactions/pay" method="POST" style="display: none">
              <input type="number" id="idWallet" name="idWallet" readOnly="true" hidden="true" />
              <input type="text" id="sessionToken" name="sessionToken" readOnly="true" hidden="true" />
              <input type="text" id="language" name="language" value="IT" readOnly="true" hidden="true" />
              <input type="text" id="idPayment" name="idPayment" readOnly="true" hidden="true" />
              <input type="text" id="Request-Id" name="Request-Id" value="SDFY5EPC" readOnly="true" hidden="true" />
            </form>
            <script>
              const fragment = window.location.hash.slice(1);
              const params = new URLSearchParams(fragment);
              document.getElementById('idWallet').value = params.get("idWallet");
              document.getElementById('idPayment').value = params.get("idPayment");
              document.getElementById('sessionToken').value = params.get("sessionToken");
              document.getElementById('pmPay').submit();
            </script>
          </body>
        </html>
      </set-body>
    </return-response>
  </inbound>

  <outbound>
    <base />
  </outbound>

  <backend>
      <base />
  </backend>
</policies>
