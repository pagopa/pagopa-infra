<policies>
    <inbound>
     <base />
      <set-backend-service base-url="https://${wallet-basepath}/pagopa-wallet-service" />
      <set-header name="x-api-key" exists-action="override">
        <value>{{payment-wallet-service-rest-api-key}}</value>
      </set-header>
    </inbound>
    <outbound>
      <base />
      <choose>
        <when condition="@(context.Response.StatusCode == 201)">
            <set-variable name="body" value="@(context.Response.Body.As<JObject>(preserveContent: true))" />
            <set-variable name="redirectUrl" value="@((string)((JObject) context.Variables["body"])["redirectUrl"])" />
              <choose>
                <when condition="@(!String.IsNullOrEmpty((string)context.Variables["redirectUrl"]))">
                    <!-- Token JWT START-->
                      <set-variable name="walletId" value="@((string)((JObject) context.Variables["body"])["walletId"])" />
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
                        return inBody.ToString();
                    }</set-body>
                </when>
              </choose>
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
