<policies>
    <inbound>
      <base />
        <set-variable name="tokenRequest" value="@(context.Request.Body.As<JObject>())" />
        <set-variable name="spidEmail" value="mockuser@pagopa.it" />
        <choose>
          <when condition"@(context.Variables.GetValueOrDefault("userId") != "")">
              <!-- Token JWT START-->
              <set-variable name="x-jwt-token" value="@{
                JObject tokenRequest = (JObject)context.Variables["tokenRequest"];
                    
                //Construct the Base64Url-encoded header
                var header = new { typ = "JWT", alg = "HS512" };
                var jwtHeaderBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(header))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
                
                // Construct the Base64Url-encoded payload 
                var expireInMinutes = (int) tokenRequest["expiryInMinutes"];
                var jti = Guid.NewGuid().ToString(); //sets the iat claim. Random uuid added to prevent the reuse of this token
                var date = DateTime.Now;
                var iat = new DateTimeOffset(date).ToUnixTimeSeconds(); // sets the issued time of the token now
                var exp = new DateTimeOffset(date.AddMinutes(expireInMinutes)).ToUnixTimeSeconds();  // sets the expiration of the token to be 20 minutes from now
                String userId = (string) tokenRequest["userId"];
                
                // Read email and pass it to the JWT. By now the email in shared as is. It MUST be encoded (by pdv) but POST transaction need to updated to not match email address as email field
                String spidEmail = ((string)context.Variables.GetValueOrDefault("spidEmail","")); 
                String noticeEmail = ((string)context.Variables.GetValueOrDefault("notice_email",""));
                String email = String.IsNullOrEmpty(noticeEmail) ? spidEmail : noticeEmail;
                
                var payload = new { iat, exp, jti, email, userId}; 
                var jwtPayloadBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(payload))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
                
                // Construct the Base64Url-encoded signature                
                var signature = new HMACSHA512(Convert.FromBase64String("{{pagopa-wallet-session-jwt-signing-key}}")).ComputeHash(Encoding.UTF8.GetBytes($"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}"));
                var jwtSignatureBase64UrlEncoded = Convert.ToBase64String(signature).Replace("/", "_").Replace("+", "-"). Replace("=", "");

                // Return the HMAC SHA512-signed JWT as the value for the Authorization header
                return $"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}.{jwtSignatureBase64UrlEncoded}"; 
              }" />
              <!-- Token JWT END-->
              <return-response>
                <set-status code="201" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>@{ return new JObject(new JProperty("token", (string)context.Variables.GetValueOrDefault("x-jwt-token",""))).ToString(); }
                </set-body>
            </return-response>
          </when>
          <otherwise>
            <return-response>
              <set-status code="400"/>
              <set-body>Missing mandatory x-user-id header</set-body>
            </return-response>
          </otherwise>
        </choose>
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