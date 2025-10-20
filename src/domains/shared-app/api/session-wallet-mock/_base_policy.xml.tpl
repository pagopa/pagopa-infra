<policies>
    <inbound>
      <base />
        <set-variable name="tokenRequest" value="@(context.Request.Body.As<JObject>())" />
        <set-variable name="usePDV" value="@(context.Request.Headers.GetValueOrDefault("use-pdv","false"))"/>
        <set-variable name="email" value="@(((JObject)context.Variables["tokenRequest"])["userEmail"]?.ToString() ?? "c7223203-4842-484e-a635-2ec07fa3d08c")" />
        <set-variable name="userId" value="@(((JObject)context.Variables["tokenRequest"])["userId"]?.ToString() ?? "")" />
        <!-- Token JWT START-->
        <choose>
          <when condition="@(bool.Parse(context.Variables.GetValueOrDefault<string>("usePDV")))">
            <!-- user fiscal code tokenization with PDV START -->
            <!-- Post Token PDV : START-->
            <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
              <set-url>${pdv_api_base_path}/tokens</set-url>
              <set-method>PUT</set-method>
              <set-header name="x-api-key" exists-action="override">
                  <value>{{wallet-session-personal-data-vault-api-key}}</value>
              </set-header>
              <set-body>@{
                return new JObject(
                        new JProperty("pii", (string)context.Variables["userId"])
                    ).ToString();
                  }</set-body>
            </send-request>
            <choose>
              <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
                <return-response>
                  <set-status code="502" reason="Bad Gateway" />
                    <set-body>
                    {
                        "title": "Error starting session",
                        "status": 502,
                        "detail": "Error during fiscal code tokenization"
                    }
                </set-body>
                </return-response>
              </when>
            </choose>
            <!-- used as jwt claims  https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-token-claims -->
            <set-variable name="userId" value="@((string)(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())["token"])" />
            <choose>
              <when condition="@(String.IsNullOrEmpty((string)context.Variables["userId"]))">
                  <return-response>
                      <set-status code="502" />
                      <set-header name="Content-Type" exists-action="override">
                          <value>application/json</value>
                      </set-header>
                      <set-body>@{
                  return new JObject(
                    new JProperty("title", "Bad gateway - Invalid PDV response"),
                    new JProperty("status", 502),
                    new JProperty("detail", "Cannot tokenize fiscal code")
                  ).ToString();
                }</set-body>
                  </return-response>
              </when>
            </choose>
            <!-- Post Token PDV : END-->
            <!-- user fiscal code tokenization with PDV END -->
            <!-- user email tokenization with PDV START -->
            <send-request ignore-error="true" timeout="10" response-variable-name="pdv-email-token" mode="new">
              <set-url>${pdv_api_base_path}/tokens</set-url>
              <set-method>PUT</set-method>
              <set-header name="x-api-key" exists-action="override">
                  <value>{{ecommerce-personal-data-vault-api-key}}</value>
              </set-header>
              <set-body>@{
                string email = (String)context.Variables["email"];
                return new JObject(
                        new JProperty("pii",  email)
                    ).ToString();
                  }</set-body>
            </send-request>
            <choose>
              <when condition="@(((IResponse)context.Variables["pdv-email-token"]).StatusCode != 200)">
                <return-response>
                  <set-status code="502" reason="Bad Gateway" />
                </return-response>
              </when>
            </choose>
            <set-variable name="email" value="@((string)(((IResponse)context.Variables["pdv-email-token"]).Body.As<JObject>())["token"])" />
            <!-- user email tokenization with PDV END -->
          </when>
        </choose>
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
          String userId = (string)context.Variables["userId"];
          string email = (String)context.Variables["email"];

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
