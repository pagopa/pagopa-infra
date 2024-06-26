<policies>
    <inbound>
      <set-variable  name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <!-- Session PM START-->
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
    <!-- START get user wallets -->
    <send-request ignore-error="false" timeout="10" response-variable-name="pmWalletResponse">
        <set-url>{{pm-host}}/pp-restapi-CD/v3/wallet</set-url>
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
        <set-header name="X-Client-id" exists-action="override">
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
    <!-- END get payment methods -->
    <return-response>
        <set-status code="200" />
        <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
        </set-header>
        <set-body>
            @{
                JObject pmWalletResponse = (JObject)context.Variables["pmUserWalletResponseBody"];
                var walletApplications = new List<String>{"PAGOPA"};
                var eCommerceWalletTypes = new Dictionary<string, string>
                    {
                        { "Card", "CARDS" },
                        { "BPay", "BANCOMATPAY" },
                        { "PayPal", "PAYPAL" }
                    };
                var eCommercePaymentMethodIds = new Dictionary<string, string>();
                JObject paymentMethods = (JObject)context.Variables["paymentMethodsResponseBody"];
                foreach(JObject paymentMethod in (JArray)paymentMethods["paymentMethods"]){
                    eCommercePaymentMethodIds[paymentMethod["name"].ToString()] = paymentMethod["id"].ToString();
                }
                Object[] wallets = pmWalletResponse["data"]
                    .Where(wallet =>{
                       return eCommerceWalletTypes.ContainsKey((string) wallet["walletType"]);
                    })
                    .Select(wallet =>{
                            JObject result = new JObject();
                            //convert wallet id (long) to UUID v4 with all bit set to 0 (except for the version).
                            //wallet id long value is stored into UUID latest 8 byte
                            string walletIdHex = ((long)wallet["idWallet"]).ToString("X").PadLeft(16,'0');
                            string walletIdToUuid = "00000000-0000-4000-"+walletIdHex.Substring(0,4)+"-"+walletIdHex.Substring(4);
                            result["walletId"] = walletIdToUuid;
                            string pmWalletType = (string) wallet["walletType"];
                            string eCommerceWalletType = eCommerceWalletTypes[pmWalletType];
                            result["paymentMethodId"] = eCommercePaymentMethodIds[eCommerceWalletType];
                            result["status"] = "VALIDATED";

                            TimeZoneInfo zone = TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time");

                            DateTime creationDateTime = DateTime.Parse(((string)wallet["createDate"]).Replace(" ","T"));
                            DateTime utcCreationDateTime = TimeZoneInfo.ConvertTimeToUtc(creationDateTime, zone);
                            DateTimeOffset creationDateTimeOffset = new DateTimeOffset(utcCreationDateTime);
                            result["creationDate"] = creationDateTimeOffset.ToString("o");
                            result["updateDate"] = result["creationDate"];

                            var convertedApplications = new List<JObject>();
                            foreach(JValue application in wallet["enableableFunctions"]){
                                string applicationName = application.ToString().ToUpper();
                                if(walletApplications.Contains(applicationName) && wallet[application.ToString()] != null){
                                    JObject converted = new JObject();
                                    converted["name"] = applicationName;
                                    converted["status"] = Convert.ToBoolean(wallet[application.ToString()]) == true ? "ENABLED" : "DISABLED";
                                    converted["updateDate"] = result["creationDate"];
                                    convertedApplications.Add(converted);
                                }
                            }
                            result["applications"] = JArray.FromObject(convertedApplications);
                            JObject details = new JObject();
                            details["type"] = eCommerceWalletType;
                            string paymentMethodAsset = null;
                            if (eCommerceWalletType == "CARDS") {
                                details["lastFourDigits"] = $"{wallet["info"]["blurredNumber"]}";
                                details["expiryDate"] = $"{(string)wallet["info"]["expireYear"]}{(string)wallet["info"]["expireMonth"]}";
                                details["brand"] = wallet["info"]["brand"];
                                paymentMethodAsset = (string)wallet["info"]["brandLogo"];
                            }
                            if (eCommerceWalletType == "PAYPAL") {
                                var info = (JObject)(wallet["info"]);
                                var pspArray = (JArray)(info["pspInfo"]);
                                var pspInfo = (JObject)(pspArray[0]);
                                details["pspId"] = pspInfo["abi"];
                                details["maskedEmail"] = pspInfo["email"];
                                details["pspBusinessName"] = pspInfo["ragioneSociale"];
                                paymentMethodAsset = "https://assets.cdn.platform.pagopa.it/apm/paypal.png";
                            }
                            if (eCommerceWalletType == "BANCOMATPAY") {
                                details["maskedNumber"] = wallet["info"]["numberObfuscated"];
                                details["instituteCode"] = wallet["info"]["instituteCode"];
                                details["bankName"] = wallet["info"]["bankName"];
                                paymentMethodAsset = (string)wallet["info"]["brandLogo"];
                            }
                            result["details"] = details;
                            result["paymentMethodAsset"] = paymentMethodAsset;

                            Boolean favourite = (Boolean) wallet["favourite"];
                            JObject clients = new JObject();
                            JObject clientIO = new JObject();
                            clientIO["status"] = "ENABLED";
                            if(favourite == true) {
                                DateTime localDateUtc = DateTime.UtcNow;
                                DateTimeOffset lastUsageDateTimeOffset = new DateTimeOffset(localDateUtc);
                                clientIO["lastUsage"] = lastUsageDateTimeOffset.ToString("o");
                            }
                            clients["IO"] = clientIO;
                            result["clients"] = clients;

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
