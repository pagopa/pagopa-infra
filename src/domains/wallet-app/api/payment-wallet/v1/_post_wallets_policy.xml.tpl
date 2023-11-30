<policies>
    <inbound>
      <base />
      <set-header name="x-user-id" exists-action="delete" />
      <set-variable name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <!-- Get User IO START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="user-auth-body" mode="new">
          <set-url>@("${io_backend_base_path}/pagopa/api/v1/user?version=20200114")</set-url> 
          <set-method>GET</set-method>
          <set-header name="Accept" exists-action="override">
            <value>application/json</value>
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
        <set-url>${pdv_api_base_path}/tokens</set-url>
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
      <set-variable name="userId" value="@((string)((JObject)context.Variables["pdvToken"])["token"])" />
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
      <!-- Post Token PDV END-->
      <set-header name="x-user-id" exists-action="override">
          <value>@((string)context.Variables.GetValueOrDefault("userId",""))</value>
      </set-header>
    </inbound>
    <outbound>
    <base />
    <choose>
        <when condition="@(context.Response.StatusCode == 201)">
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
