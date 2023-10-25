<policies>
    <inbound>
      <base />
      <set-variable name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <!-- Get User IO START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="user-auth-body" mode="new">
          <set-url>@("${io_backend_base_path}/pagopa/api/v1/user?version=20200114")</set-url> 
          <set-method>GET</set-method>
          <set-header name="Accept" exists-action="override">
            <value>@("application/json")</value>
          </set-header>
          <set-header name="Authorization" exists-action="override">
            <value>@("Bearer " + (string)context.Variables.GetValueOrDefault("walletToken"))</value>
          </set-header>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["user-auth-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="userAuth" value="@(((IResponse)context.Variables["user-auth-body"]).Body.As<JObject>())" />
      <!-- Get User IO END-->
      <!-- Post Token PDV START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
        <set-url>@($"${pdv_api_base_path}/tokens")</set-url>
        <set-method>PUT</set-method>
        <set-header name="x-api-key" exists-action="override">
            <value>{{personal-data-vault-api-key}}</value>
        </set-header>
        <set-body>@{
          JObject requestBody = (JObject)context.Variables["userAuth"];
          return new JObject(
                  new JProperty("pii",  (string)requestBody["fiscal_code"])
              ).ToString();
            }</set-body>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="pdvToken" value="@(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())" />
      <set-variable name="fiscalCodeTokenized" value="@((string)((JObject)context.Variables["pdvToken"])["token"])" />
      <choose>
      <when condition="@((string)context.Variables["fiscalCodeTokenized"] != "")">
          <set-header name="x-fiscal-code-tokenized" exists-action="override">
              <value>@((string)context.Variables.GetValueOrDefault("fiscalCodeTokenized",""))</value>
          </set-header>
      </when>
      <otherwise>
              <return-response>
                  <set-status code="502"/>
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
          </otherwise>
    </choose>
      <!-- Post Token PDV END-->
      <!-- Token JWT START-->
      <set-header name="x-jwt-token" exists-action="override">
      <value>@{
          // 1) Construct the Base64Url-encoded header
          var header = new { typ = "JWT", alg = "HS256" };
          var jwtHeaderBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(header))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
          // As the header is a constant, you may use this equivalent Base64Url-encoded string instead to save the repetitive computation above.
          // var jwtHeaderBase64UrlEncoded = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9";

          // 2) Construct the Base64Url-encoded payload 
          var exp = new DateTimeOffset(DateTime.Now.AddMinutes(10)).ToUnixTimeSeconds();  // sets the expiration of the token to be 10 minutes from now
          var username = "john_doe"; // wihich is the value to pass to the payload as a claim? wallet_token?
          var payload = new { exp, username }; 
          var jwtPayloadBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(payload))).Replace("/", "_").Replace("+", "-"). Replace("=", "");

          // 3) Construct the Base64Url-encoded signature                
          var signature = new HMACSHA256(Encoding.UTF8.GetBytes("{{wallet-jwt-signing-key}}")).ComputeHash(Encoding.UTF8.GetBytes($"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}"));
          var jwtSignatureBase64UrlEncoded = Convert.ToBase64String(signature).Replace("/", "_").Replace("+", "-"). Replace("=", "");

          // 4) Return the HMAC SHA256-signed JWT as the value for the Authorization header
          return $"Bearer {jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}.{jwtSignatureBase64UrlEncoded}"; 
      }</value>
  </set-header>
      <!-- Token JWT END-->
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
