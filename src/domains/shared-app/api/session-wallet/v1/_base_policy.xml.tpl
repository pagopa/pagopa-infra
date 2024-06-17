<policies>
    <inbound>
      <base />
      <set-variable name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
     
      <choose>
        <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))">
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
          <!-- Session PM END-->
          <!-- pagoPA platform wallet JWT session token : START -->
          <set-variable name="x-jwt-token" value="@(((JObject)context.Variables["pmSession"])["data"]["sessionToken"].ToString())" />
          <!-- pagoPA platform wallet JWT session token : END -->
        </when>
        <otherwise>
            <!-- Get User IO : START-->
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
              <when condition="@(((IResponse)context.Variables["user-auth-body"]).StatusCode == 401)">
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
              <when condition="@(((IResponse)context.Variables["user-auth-body"]).StatusCode != 200)">
                  <return-response>
                      <set-status code="502" reason="Bad Gateway" />
                      <set-header name="Content-Type" exists-action="override">
                          <value>application/json</value>
                      </set-header>
                      <set-body>
                          {
                              "title": "Error starting session",
                              "status": 502,
                              "detail": "There was an error while getting user info"
                          }
                      </set-body>
                  </return-response>
              </when>
            </choose>
            <set-variable name="userAuthBody" value="@(((IResponse)context.Variables["user-auth-body"]).Body.As<JObject>())" />
            <!-- Get User IO : END-->
            <!-- Post Token PDV : START-->
            <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
              <set-url>${pdv_api_base_path}/tokens</set-url>
              <set-method>PUT</set-method>
              <set-header name="x-api-key" exists-action="override">
                  <value>{{wallet-session-personal-data-vault-api-key}}</value>
              </set-header>
              <set-body>@{
                JObject requestBody = (JObject)context.Variables["userAuthBody"];
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
            <!-- used as jwt claims  https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-token-claims -->      
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
            <!-- Post Token PDV : END-->

            <!-- pagoPA platform wallet JWT session token : START -->
            <!-- Token JWT START-->
                  <set-variable name="x-jwt-token" value="@{
                    //Construct the Base64Url-encoded header
                    var header = new { typ = "JWT", alg = "HS512" };
                    var jwtHeaderBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(header))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
                    
                    // Construct the Base64Url-encoded payload 
                    var jti = Guid.NewGuid().ToString(); //sets the iat claim. Random uuid added to prevent the reuse of this token
                    var date = DateTime.Now;
                    var iat = new DateTimeOffset(date).ToUnixTimeSeconds(); // sets the issued time of the token now
                    var exp = new DateTimeOffset(date.AddMinutes(20)).ToUnixTimeSeconds();  // sets the expiration of the token to be 20 minutes from now
                    String userId = ((string)context.Variables.GetValueOrDefault("userId","")); 
                    
                    // Read email and pass it to the JWT. By now the email in shared as is. It MUST be encoded (by pdv) but POST transaction need to updated to not match email address as email field
                    JObject userAuth = (JObject)context.Variables["userAuthBody"];
                    String spidEmail = (String)userAuth["spid_email"];
                    String noticeEmail = (String)userAuth["notice_email"];
                    String email = String.IsNullOrEmpty(noticeEmail) ? spidEmail : noticeEmail;
                    
                    var payload = new { iat, exp, jti, email, userId}; 
                    var jwtPayloadBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(payload))).Replace("/", "_").Replace("+", "-"). Replace("=", "");
                    
                    // Construct the Base64Url-encoded signature                
                    var signature = new HMACSHA512(Convert.FromBase64String("{{wallet-session-jwt-signing-key}}")).ComputeHash(Encoding.UTF8.GetBytes($"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}"));
                    var jwtSignatureBase64UrlEncoded = Convert.ToBase64String(signature).Replace("/", "_").Replace("+", "-"). Replace("=", "");

                    // Return the HMAC SHA512-signed JWT as the value for the Authorization header
                    return $"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}.{jwtSignatureBase64UrlEncoded}"; 
                }" />
            <!-- Token JWT END-->
            <!-- pagoPA platform wallet JWT session token : END -->
        </otherwise>
      </choose>
      

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