<policies>
    <inbound>
    <base />
        <choose>
            <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))">
                <!-- Extract payment method name for create redirectUrl -->
                <set-variable name="requestBody" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
                <set-variable name="paymentMethodId" value="@((string)((JObject) context.Variables["requestBody"])["paymentMethodId"])" />
                <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
                    <set-url>@("https://${ecommerce_hostname}/pagopa-ecommerce-payment-methods-service/payment-methods/" + context.Variables["paymentMethodId"])</set-url>
                    <set-method>GET</set-method>
                    <set-header name="x-client-id" exists-action="override">
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
                <set-variable name="paymentMethodTypeCode" value="@((string)((JObject) context.Variables["paymentMethodsResponseBody"])["paymentTypeCode"])" />
                <set-variable name="redirectUrlPrefix" value="@{
                        string returnedPaymentMethodTypeCode = (string)context.Variables["paymentMethodTypeCode"];
                        var paymentMethodTypeCodes = new Dictionary<string, string>
                            {
                                { "CP", "pm-onboarding/creditcard" },
                                { "BPAY", "pm-onboarding/bpay" },
                                { "PPAL", "pm-onboarding/paypal" }
                            };
        
                        string redirectUrlPrefix;
                        paymentMethodTypeCodes.TryGetValue(returnedPaymentMethodTypeCode, out redirectUrlPrefix);
                        return redirectUrlPrefix;
                }" />
                <choose>
                <when condition="@((string)context.Variables["redirectUrlPrefix"] == null)">
                    <return-response>
                        <set-status code="502" reason="Bad Gateway" />
                        <set-header name="Content-Type" exists-action="override">
                            <value>application/json</value>
                        </set-header>
                        <set-body>
                            {
                                "title": "Error retrieving eCommerce payment methods",
                                "status": 502,
                                "detail": "Invalid payment method name"
                            }
                        </set-body>
                    </return-response>
                </when>
                </choose>
                <!-- End extract payment method name for create redirectUrl -->
                <return-response>
                <set-status code="201" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>@{
                    return new JObject(
                                new JProperty("redirectUrl", $"https://${env}.payment-wallet.pagopa.it/{(string)context.Variables["redirectUrlPrefix"]}#sessionToken={((string)((JObject) context.Variables["pmSession"])["data"]["sessionToken"])}")
                        ).ToString();
                }</set-body>
                </return-response>
                <!-- Session PM END-->
            </when>
            <otherwise>
            </otherwise>
        </choose>
    </inbound>
    <outbound>
      <base />
        <choose>
            <when condition="@(("true".Equals("{{enable-pm-ecommerce-io}}")) && (context.Response.StatusCode == 201))">
                <!-- Token JWT START-->
                <set-variable name="walletId" value="@((string)((context.Response.Body.As<JObject>(preserveContent: true))["walletId"]))" />
                <set-variable name="x-jwt-token" value="@{
                // Construct the Base64Url-encoded header
                var header = new { typ = "JWT", alg = "HS512" };
                var jwtHeaderBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(header))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
    
                // 2) Construct the Base64Url-encoded payload 
                var jti = Guid.NewGuid().ToString(); //sets the iat claim. Random uuid added to prevent the reuse of this token
                var date = DateTime.Now;
                var iat = new DateTimeOffset(date).ToUnixTimeSeconds(); // sets the issued time of the token now
                var exp = new DateTimeOffset(date.AddMinutes(10)).ToUnixTimeSeconds();  // sets the expiration of the token to be 10 minutes from now
                var userId = ((string)context.Variables.GetValueOrDefault("userId","")); 
                var walletId = ((string)context.Variables.GetValueOrDefault("walletId",""));
                var payload = new { iat, exp, jti, userId, walletId }; 
                var jwtPayloadBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(payload))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
    
                // 3) Construct the Base64Url-encoded signature                
                var signature = new HMACSHA512(Convert.FromBase64String("{{wallet-jwt-signing-key}}")).ComputeHash(Encoding.UTF8.GetBytes($"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}"));
                var jwtSignatureBase64UrlEncoded = Convert.ToBase64String(signature).Replace("/", "_").Replace("+", "-"). Replace("=", "");
    
                // 4) Return the HMAC SHA512-signed JWT as the value for the Authorization header
                return $"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}.{jwtSignatureBase64UrlEncoded}"; 
            }" />
                <!-- Token JWT END-->
                <set-body>@{ 
                    JObject inBody = context.Response.Body.As<JObject>(preserveContent: true); 
                    var redirectUrl = inBody["redirectUrl"];
                    inBody["redirectUrl"] = redirectUrl + "&sessionToken=" + ((string)context.Variables.GetValueOrDefault("x-jwt-token",""));
                    inBody.Remove("walletId");
                    return inBody.ToString(); 
                }</set-body>
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
