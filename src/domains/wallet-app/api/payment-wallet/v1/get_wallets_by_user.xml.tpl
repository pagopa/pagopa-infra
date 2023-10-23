<policies>
  <inbound>
    <base />
  </inbound>

  <outbound>
    <base />

    <send-request ignore-error="false" timeout="10" response-variable-name="pmUserResponse">
        <set-url>${pm-basepath}/user</set-url>
        <set-method>GET</set-method>
        <set-header name="Authorizaiton" exists-action="override">
            <value>@(context.Request.Headers["Authorization"])</value>
        </set-header>
    </send-request>

    <set-body>
        @{
            var eCommerceWalletTypes = new Dictionary<string, string>
                {
                    { "creditCard", "CARDS" }, 
                };

            var eCommercePaymentMethodIds = new Dictionary<string, string>
                {
                    { "CARDS", "{{ecommerce-creditcard-method-id}}" },
                };
            
            Func<int, Guid> intToGuid = (int value) =>
                {
                    byte[] bytes = new byte[16];
                    BitConverter.GetBytes(value).CopyTo(bytes, 0);
                    return new Guid(bytes);
                };

            JOBject paymentManagerResponse = context.Response.Body.As<JObject>(true);

            JOBject[] wallets = paymentManagerResponse["data"].Select(wallet =>
                JObject result = new JOBject();
                result["walletId"] = intToGuid(wallet["idWallet"]);
                result["userId"] = context.Variables["pmUserResponse"].Body.As<JObject>()["data"]["userId"];
                result["paymentInstrumentId"] = null;

                string walletType = "";

                foreach (var pair in eCommercePaymentMethodIds) {
                    if (wallet.ContainsKey(pair.Key)) {
                        walletType = eCommerceWalletTypes[pair.Value]
                        break;
                    }
                }

                result["paymentMethodId"] = eCommercePaymentMethodIds[walletType];

                result["status"] = "SCA_COMPLETED";
                result["creationDate"] = wallet["lastUsage"];
                result["updateDate"] = wallet["lastUsage"];

                result["services"] = wallet["services"].Select(service => {
                    JOBject service = new JOBject();
                    service["name"] = service.ToUpper();
                    service["status"] = "ENABLED";
                    service["updateDate"] = wallet["lastUsage"];
                    service["creationDate"] = wallet["lastUsage"];

                    return service;
                }).ToList());

                JObject details = new JObject();
                details["type"] = walletType;

                if (walletType == "CARDS") {
                    result["contractId"] = wallet["creditCard"]["id"];

                    details["bin"] = wallet["creditCard"]["abiCode"];
                    details["maskedPan"] = wallet["creditCard"]["pan"];
                    details["expiryDate"] = wallet["creditCard"]["expireMonth"] + wallet["creditCard"]["expireYear"];
                    details["holder"] = wallet["creditCard"]["holder"];
                    details["brand"] = wallet["creditCard"]["brand"];
                }

                result["details"] = details;

                return result;
            ).ToArray();

            JObject response = new JObject();
            response["wallets"] = wallets;

            return response;
        }
    </set-body>

  </outbound>

  <backend>
      <base />
  </backend>
</policies>
