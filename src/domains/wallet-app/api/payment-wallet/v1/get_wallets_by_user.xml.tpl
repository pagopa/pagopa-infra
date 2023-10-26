<policies>
    <inbound>
        <!-- START get payment methods -->
        <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
            <set-url>https://${ecommerce-basepath}/pagopa-ecommerce-payment-methods-service/payment-methods</set-url>
            <set-method>GET</set-method>
        </send-request>
        <choose>
        <when condition="@(((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode != 200)">
            <return-response>
            <set-status code="502" reason="Bad Gateway" />
            <set-body>
                @{
                    JObject errorResponse = new JObject();
                    errorResponse["title"] = "Error retrieving payment methods";
                    errorResponse["status"] = 502;
                    errorResponse["detail"] = "There was an error retrieving eCommerce payment methods";
                    return errorResponse.ToString();
                }
            </set-body>
            </return-response>
        </when>
        </choose>
        <set-variable name="paymentMethodsResponseBody" value="@(((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />
        <!-- END get payment methods -->

        <!-- START get user wallets -->
        <set-variable  name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
        <send-request ignore-error="false" timeout="10" response-variable-name="pmWalletResponse">
            <set-url>{{pm-host}}/pp-restapi-CD/v1/wallet</set-url>
            <set-method>GET</set-method>
            <set-header name="Authorization" exists-action="override">
                <value>@((string)context.Variables["walletToken"])</value>
            </set-header>
        </send-request>
        <choose>
        <when condition="@(((IResponse)context.Variables["pmWalletResponse"]).StatusCode != 200)">
            <return-response>
            <set-status code="502" reason="Bad Gateway" />
            <set-body>
                @{
                    JObject errorResponse = new JObject();
                    errorResponse["title"] = "Error retrieving user wallet data";
                    errorResponse["status"] = 502;
                    errorResponse["detail"] = "There was an error retrieving user wallet data";
                    return errorResponse.ToString();
                }
            </set-body>
            </return-response>
        </when>
        </choose>
        <set-variable name="pmUserWalletResponseBody" value="@(((IResponse)context.Variables["pmWalletResponse"]).Body.As<JObject>())" />
        <!-- END get user wallets -->
        <return-response>
            <set-status code="200" />
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>
                @{
                    JObject pmWalletResponse = (JObject)context.Variables["pmWalletResponse"];
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
                    byte[] bytes = new byte[16];
                    BitConverter.GetBytes((long)wallet["idWallet"]).CopyTo(bytes, 0);
                    result["walletId"] = new Guid(bytes).ToString();
                    string eCommerceWalletType = "";
                    string pmWalletType = (string) wallet["type"];
                    if (eCommerceWalletTypes.ContainsKey(pmWalletType)) {
                        eCommerceWalletType = eCommerceWalletTypes[pmWalletType];
                    }
                    result["paymentMethodId"] = eCommercePaymentMethodIds[eCommerceWalletType];
                    result["status"] = "SCA_COMPLETED";
                    result["creationDate"] = wallet["lastUsage"];
                    result["updateDate"] = wallet["lastUsage"];
                    result["services"] = JArray.FromObject(
                        wallet["services"].Select(service => {
                            JObject converted = new JObject();
                            converted["name"] = ((string) service).ToUpper();
                            converted["status"] = "ENABLED";
                            converted["updateDate"] = (string) wallet["lastUsage"];
                            return converted;
                        }).ToList()
                    );
                    JObject details = new JObject();
                    details["type"] = eCommerceWalletType;
                    if (eCommerceWalletType == "CARDS") {
                        details["bin"] = wallet["creditCard"]["abiCode"];
                        details["maskedPan"] = wallet["creditCard"]["pan"];
                        details["expiryDate"] = $"({(string)wallet["creditCard"]["expireMonth"]}{(string)wallet["creditCard"]["expireYear"]}";
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