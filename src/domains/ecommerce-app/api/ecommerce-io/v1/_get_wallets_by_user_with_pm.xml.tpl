<policies>
    <inbound>
        <set-variable  name="sessionToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />

        <!-- START get user wallets -->
        <send-request ignore-error="false" timeout="10" response-variable-name="pmWalletResponse">
            <set-url>{{pm-host}}/pp-restapi-CD/v3/wallet</set-url>
            <set-method>GET</set-method>
            <set-header name="Authorization" exists-action="override">
                <value>@($"Bearer {((string)context.Variables["sessionToken"])}")</value>
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
            <set-url>https://${ecommerce-hostname}/pagopa-ecommerce-payment-methods-service/payment-methods</set-url>
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
                    var walletServices = new List<String>{"PAGOPA"};
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

                                var convertedServices = new List<JObject>();
                                foreach(JValue service in wallet["enableableFunctions"]){
                                    string serviceName = service.ToString().ToUpper();
                                    if(walletServices.Contains(serviceName)){
                                        JObject converted = new JObject();
                                        converted["name"] = serviceName;
                                        converted["status"] = "ENABLED";
                                        converted["updateDate"] = result["creationDate"];
                                        convertedServices.Add(converted);
                                    }
                                }
                                result["services"] = JArray.FromObject(convertedServices);
                                JObject details = new JObject();
                                details["type"] = eCommerceWalletType;
                                if (eCommerceWalletType == "CARDS") {
                                    details["maskedPan"] = $"{wallet["info"]["blurredNumber"]}";
                                    details["expiryDate"] = $"{(string)wallet["info"]["expireYear"]}{(string)wallet["info"]["expireMonth"]}";
                                    details["holder"] = wallet["info"]["holder"];
                                    details["brand"] = wallet["info"]["brand"];
                                }
                                if (eCommerceWalletType == "PAYPAL") {
                                    var info = (JObject)(wallet["info"]);
                                    var pspArray = (JArray)(info["pspInfo"]);
                                    var pspInfo = (JObject)(pspArray[0]);
                                    details["abi"] = pspInfo["abi"];
                                    details["maskedEmail"] = pspInfo["email"];
                                }
                                if (eCommerceWalletType == "BANCOMATPAY") {
                                    details["maskedNumber"] = wallet["info"]["numberObfuscated"];
                                    details["instituteCode"] = wallet["info"]["instituteCode"];
                                    details["bankName"] = wallet["info"]["bankName"];
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
