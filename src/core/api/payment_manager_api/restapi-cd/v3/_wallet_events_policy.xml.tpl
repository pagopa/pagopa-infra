<policies>
    <inbound>
      <base />
    </inbound>
    <outbound>
        <base />
        <choose>
        <when condition="@( context.Response.StatusCode == 200 )">
            <set-variable name="walletResponseBody" value="@(context.Response.Body.As<JObject>())" />

            <!-- set USER  fiscalCode GET pp-restapi-CD/v1/users con request.header["Authorization"] -->
            <!-- pay attention: IO user, not card holder -->

            <set-variable name="walletEvent" value="@{
                
                var walletEvent = new JObject();

                foreach (var wallet in ((JObject)context.Variables["walletResponseBody"]))
                {
                    walletEventTmp = new JObject(
                        new JProperty("idWalletOld",["idWallet"]),
                        new JProperty("taxCode", ((JObject) user)["fiscalCode"]),
                        new JProperty("bin", ((JObject) wallet)["info"]["???"]),
                        new JProperty("expiryDate", (wallet)["info"]["expireMonth"] + (JObject) wallet)["info"]["expireYear"]),
                        new JProperty("maskedPan", ((JObject) wallet)["info"]["blurredNumber"]), // TODO last 4 number for blurredNumber
                        new JProperty("creationTs", ((JObject) wallet)["createDate"]),
                        new JProperty("contractNumber", ((JObject) wallet)["??"]),
                        new JProperty("payTipperId", ((JObject) wallet)["??"]),
                        new JProperty("services", ((JObject) wallet)["enableableFunctions"]),
                        new JProperty("onboardingChannel", ((JObject) wallet)["onboardingChannel"]),
                    );
                    walletEvent.add(walletEventTmp);
                    
                }

                return walletEvent;
            }" />
            <set-variable name="paymentInstrumentEvent" value="@{
                
               var paymentInstrumentEvent = new JObject();

                foreach (var wallet in ((JObject)context.Variables["walletResponseBody"]))
                {
                    paymentInstrumentEventTmp = new JObject(
                        new JProperty("idWalletOld", wallet)["idWallet"]),
                        new JProperty("taxCodeHolder", ((JObject) wallet)["???"]),
                        new JProperty("idPayInstrOld", ((JObject) wallet)["info"]["???"]),
                        new JProperty("bin", ((JObject) wallet)["creditCard"]["???"]),
                        new JProperty("expiryDate", ((JObject) wallet)["creditCard"]["expireMonth"] + (JObject) wallet)["creditCard"]["expireYear"]),
                        new JProperty("maskedPan", ((JObject) wallet)["creditCard"]["blurredNumber"]), // TODO last 4 number for blurredNumber
                        new JProperty("creationTs", ((JObject) wallet)["createDate"]),
                        new JProperty("contractNumber", ((JObject) wallet)["??"]),
                        new JProperty("payTipperId", ((JObject) wallet)["??"])
                    );
                    paymentInstrumentEvent.add(paymentInstrumentEventTmp);
                }

                return paymentInstrumentEvent;
            }" />
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