<fragment>
    <!-- Delete headers required for backend service START -->
    <set-header name="x-client-id" exists-action="delete" />
    <set-header name="x-user-id" exists-action="delete" />
    <set-header name="x-client-id" exists-action="override">
        <value>IO</value>
    </set-header>
    <!-- Delete headers required for backend service END -->

    <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

    <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
    <!--try to retrieve user id from session token if the session token is a JWT token and have userId claim-->
    <set-variable name="sessionTokenUserId" value="@{
        string sessionToken = (string)context.Variables["sessionToken"];
            try {
                string[] sessionTokenParts = sessionToken.Split('.');
                string sessionTokenBody = sessionTokenParts.Length >1 ? sessionTokenParts[1] : "";
                int reminder = sessionTokenBody.Length % 4;
                int toPad = reminder > 1 ? (4-reminder) : 0;
				string padded = string.Concat(sessionTokenBody,string.Concat(Enumerable.Repeat("=", toPad)));
		  		byte[] data = Convert.FromBase64String(padded);
                string decodedString = System.Text.Encoding.UTF8.GetString(data);
                Dictionary<string,string> parsed = JsonConvert.DeserializeObject<Dictionary<string,string>>(decodedString);
                string userId = (string)parsed?["userId"];
                return String.IsNullOrEmpty(userId) ? "user-id-not-found" : userId;
            } catch(Exception){
            return "user-id-not-found";
            }
    }" />

    <choose>
      <when condition="@("false".Equals("{{enable-pm-ecommerce-io}}") && "{{pay-wallet-family-friends-user-ids}}".Contains(((string)context.Variables["sessionTokenUserId"])) )">
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
          <issuer-signing-keys>
              <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key>
              <key>{{pagopa-wallet-session-jwt-signing-key}}</key>
          </issuer-signing-keys>
          <required-claims>
            <claim name="userId" match="all">
            </claim>
          </required-claims>
        </validate-jwt>
        <set-variable name="xUserId" value="@{
          var jwt = (Jwt)context.Variables["sessionToken"];
          if(jwt.Claims.ContainsKey("userId")){
              return jwt.Claims["userId"][0];
          }
          return "";
          }" />
        <set-variable name="email" value="@{
          var jwt = (Jwt)context.Variables["sessionToken"];
          if(jwt.Claims.ContainsKey("email")){
              return jwt.Claims["email"][0];
          }
          return "";
          }" />
      </when>
      <otherwise>
          <!-- Check sessiontoken START-->
          <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
          <send-request ignore-error="true" timeout="10" response-variable-name="checkSessionResponse" mode="new">
            <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/check-session?sessionToken={(string)context.Variables["sessionToken"]}")</set-url>
            <set-method>GET</set-method>
            <set-header name="Authorization" exists-action="override">
              <value>@("Bearer " + (string)context.Variables["sessionToken"])</value>
            </set-header>
          </send-request>
          <choose>
            <when condition="@(((int)((IResponse)context.Variables["checkSessionResponse"]).StatusCode) != 200)">
              <return-response>
                <set-status code="401" reason="Unauthorized" />
                <set-body>
                  {
                      "status": 401,
                      "title": "Unauthorized",
                      "detail": "Invalid token"
                  }
                </set-body>
              </return-response>
            </when>
          </choose>
        <!-- Check sessiontoken END-->
      </otherwise>
    </choose>

    <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
    <choose>
      <when condition="@( context.Request.Url.Path.Contains("transactions") )">
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service")"/>
      </when>
      <when condition="@( context.Request.Url.Path.Contains("payment-methods") )">
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service")"/>
      </when>
    </choose>
</fragment>      
