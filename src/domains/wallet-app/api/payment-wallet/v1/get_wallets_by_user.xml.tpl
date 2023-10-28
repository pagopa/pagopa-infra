<policies>
    <inbound>
      <set-variable  name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <!-- Session PM START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
          <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletToken"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
       <choose>
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
    <!-- START get user wallets -->
    <send-request ignore-error="false" timeout="10" response-variable-name="pmWalletResponse">
        <set-url>{{pm-host}}/pp-restapi-CD/v1/wallet</set-url>
        <set-method>GET</set-method>
        <set-header name="Authorization" exists-action="override">
            <value>@($"Bearer {((JObject)context.Variables["pmSession"])["data"]["sessionToken"].ToString()}")</value>
        </set-header>
    </send-request>
    <choose>
        <when condition="@(((IResponse)context.Variables["pmWalletResponse"]).StatusCode != 200)">
            <return-response>
                <set-status code="502" reason="Bad Gateway" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    {
                    "title": "Error retrieving user wallet data",
                    "status": 502,
                    "detail": "There was an error retrieving user wallet data"
                    }
                </set-body>
            </return-response>
        </when>
    </choose>
    <set-variable name="pmUserWalletResponseBody" value="@(((IResponse)context.Variables["pmWalletResponse"]).Body.As<JObject>())" />
    <set-variable name="pmUserWalletResponseBodyLength" value="@(((JArray)((JObject)context.Variables["pmUserWalletResponseBody"])["data"]).Count)" />
    <choose>
        <when condition="@(((int)context.Variables["pmUserWalletResponseBodyLength"])==0)">
            <return-response>
                <set-status code="404" reason="Wallet not found" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    {
                    "title": "Wallet not found",
                    "status": 404,
                    "detail": "No wallet found for input wallet token"
                    }
                </set-body>
            </return-response>
        </when>
    </choose>
    <!-- END get user wallets -->
    <!-- START get payment methods -->
    <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
        <set-url>https://${ecommerce-basepath}/pagopa-ecommerce-payment-methods-service/payment-methods</set-url>
        <set-method>GET</set-method>
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
    <!-- END get payment methods -->
    <return-response>
        <set-status code="200" />
        <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
        </set-header>
        <set-body>
            @{
                JObject pmWalletResponse = (JObject)context.Variables["pmUserWalletResponseBody"];
                var walletServices = new List<String>{"PAGOPA"};
                var eCommerceWalletTypes = new Dictionary<string, string>
                    {
                        { "CREDIT_CARD", "CARDS" }
                    };
                var eCommercePaymentMethodIds = new Dictionary<string, string>();
                JObject paymentMethods = (JObject)context.Variables["paymentMethodsResponseBody"];
                foreach(JObject paymentMethod in (JArray)paymentMethods["paymentMethods"]){
                    eCommercePaymentMethodIds[paymentMethod["name"].ToString()] = paymentMethod["id"].ToString();
                } 
                Object[] wallets = pmWalletResponse["data"].Select(wallet =>{
                JObject result = new JObject();
                //convert wallet id (long) to UUID v4 with all bit set to 0 (except for the version).
                //wallet id long value is stored into UUID latest 8 byte
                string walletIdHex = ((long)wallet["idWallet"]).ToString("X").PadLeft(16,'0');
                string walletIdToUuid = "00000000-0000-4000-"+walletIdHex.Substring(0,4)+"-"+walletIdHex.Substring(4);
                result["walletId"] = walletIdToUuid;
                string eCommerceWalletType = "";
                string pmWalletType = (string) wallet["type"];
                if (eCommerceWalletTypes.ContainsKey(pmWalletType)) {
                    eCommerceWalletType = eCommerceWalletTypes[pmWalletType];
                }
                result["paymentMethodId"] = eCommercePaymentMethodIds[eCommerceWalletType];
                result["status"] = "VALIDATED";
                result["creationDate"] = wallet["lastUsage"];
                result["updateDate"] = wallet["lastUsage"];
                var convertedServices = new List<JObject>();
                foreach(JValue service in wallet["services"]){
                    string serviceName = service.ToString().ToUpper();
                    if(walletServices.Contains(serviceName)){
                        JObject converted = new JObject();
                        converted["name"] = serviceName;
                        converted["status"] = "ENABLED";
                        converted["updateDate"] = wallet["lastUsage"];
                        convertedServices.Add(converted);
                    }
                }
                result["services"] = JArray.FromObject(convertedServices);
                JObject details = new JObject();
                details["type"] = eCommerceWalletType;
                if (eCommerceWalletType == "CARDS") {
                    details["maskedPan"] = wallet["creditCard"]["pan"];
                    details["expiryDate"] = $"20{(string)wallet["creditCard"]["expireYear"]}{(string)wallet["creditCard"]["expireMonth"]}";
                    details["holder"] = wallet["creditCard"]["holder"];
                    details["brand"] = wallet["creditCard"]["brand"];
                }
                result["details"] = details;

                return result;
            }).ToArray();

            JObject response = new JObject();
            response["wallets"] = JArray.FromObject(wallets);
            return response.ToString();
            }
        </set-body>
    </return-response>
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