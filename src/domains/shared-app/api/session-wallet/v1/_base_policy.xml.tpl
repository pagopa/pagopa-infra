<policies>
    <inbound>
      <base />
      <set-variable name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <!-- Perform PM start api call: for family&friends handling NPG flow must be activated only for 
        users that have been enabled in pay-wallet-family-friends-user-ids named value (list of user id = PDV fiscal code tokenization)
        For family&friends flow we expect that all clients will go with PM flow except the ones in the above list, that will be restricted
        to few selected users. Anticipating PM start session will prevent further api calls.
       -->
      <!-- Session PM START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
          <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletToken"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
      <choose>
          <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode != 200)">
              <!-- PM answers with 500 if the token is invalid -->
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
      </choose>
      <set-variable name="pmSession" value="@(((IResponse)context.Variables["pm-session-body"]).Body.As<JObject>())" />
      <!-- Session PM END-->
      <!-- user fiscal code tokenization with PDV START -->
      <set-variable name="userFiscalCode" value="@{
          String userFiscalCode = ((JObject)context.Variables["pmSession"])?["data"]?["user"]?["fiscalCode"]?.ToString();
          return userFiscalCode;
      }" 
      />
      <choose>
          <when condition="@(String.IsNullOrEmpty((String)context.Variables["userFiscalCode"]))">
              <return-response>
                <set-status code="502" reason="Bad Gateway" />
                <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
                </set-header>
                <set-body>
                    {
                        "title": "Error starting session",
                        "status": 502,
                        "detail": "Cannot tokenize user fiscal code: PM start-session fiscalCode is null"
                    }
                </set-body>
              </return-response>
          </when>
          <otherwise>
              <!-- Post Token PDV : START-->
              <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
                <set-url>${pdv_api_base_path}/tokens</set-url>
                <set-method>PUT</set-method>
                <set-header name="x-api-key" exists-action="override">
                    <value>{{wallet-session-personal-data-vault-api-key}}</value>
                </set-header>
                <set-body>@{
                  return new JObject(
                          new JProperty("pii", (string)context.Variables["userFiscalCode"])
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
            </otherwise>
      </choose>
      <!-- user fiscal code tokenization with PDV END -->
      <choose>
      <when condition="@("PM".Equals("{{ecommerce-for-io-pm-npg-ff}}") || 
      ("FF".Equals("{{ecommerce-for-io-pm-npg-ff}}") && !"{{pay-wallet-family-friends-user-ids}}".Contains(((string)context.Variables["sessionTokenUserId"])))
      )"> 
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

            <!-- user email tokenization with PDV START -->
            <send-request ignore-error="true" timeout="10" response-variable-name="pdv-email-token" mode="new">
              <set-url>${pdv_api_base_path}/tokens</set-url>
              <set-method>PUT</set-method>
              <set-header name="x-api-key" exists-action="override">
                  <value>{{ecommerce-personal-data-vault-api-key}}</value>
              </set-header>
              <set-body>@{
                JObject userAuthBody = (JObject)context.Variables["userAuthBody"];
                string spidEmail = (String)userAuthBody["spid_email"];
                string noticeEmail = (String)userAuthBody["notice_email"];
                string email = String.IsNullOrEmpty(noticeEmail) ? spidEmail : noticeEmail;
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

            <set-variable name="pdvEmailToken" value="@(((IResponse)context.Variables["pdv-email-token"]).Body.As<JObject>())" />
            <set-variable name="email" value="@((string)((JObject)context.Variables["pdvEmailToken"])["token"])" />
            <!-- user email tokenization with PDV END -->

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
                    string email = (string) context.Variables["email"];
                    
                    var payload = new { iat, exp, jti, email, userId};
                    var jwtPayloadBase64UrlEncoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(payload))).Replace("/", "_").Replace("+", "-"). Replace("=", "");

                    // Construct the Base64Url-encoded signature
                    var signature = new HMACSHA512(Convert.FromBase64String("{{pagopa-wallet-session-jwt-signing-key}}")).ComputeHash(Encoding.UTF8.GetBytes($"{jwtHeaderBase64UrlEncoded}.{jwtPayloadBase64UrlEncoded}"));
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