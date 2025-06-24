<policies>
    <inbound>
     <cors>
        <allowed-origins>
          <origin>${payment_wallet_origin}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
          <header>Authorization</header>
        </allowed-headers>
      </cors>
      <base />
      <set-header name="x-user-id" exists-action="delete" />
      <set-variable name="walletId" value="@{
          return context.Request.MatchedParameters.GetValueOrDefault("walletId","");
      }" />
      <!--  Check if Authorization header is present -->
      <choose>
          <when condition="@(!context.Request.Headers.ContainsKey("Authorization"))">
              <return-response>
                  <set-status code="401" reason="Unauthorized" />
                  <set-body>Missing Authorization header</set-body>
              </return-response>
          </when>
      </choose>
      <!-- Extract 'iss' claim -->
      <set-variable name="jwtIssuer" value="@{
          Jwt jwt;
          context.Request.Headers.GetValueOrDefault("Authorization", "").Split(' ').Last().TryParseJwt(out jwt);
          return jwt?.Claims.GetValueOrDefault("iss", "");
      }" />
      <!-- Store useOpenId as string 'true' or 'false' -->
      <set-variable name="useOpenId" value="@(
          (context.Variables.GetValueOrDefault<string>("jwtIssuer")?.Contains("jwt-issuer-service") == true).ToString()
      )" />
      <!-- Conditional validation -->
      <choose>
          <when condition="@(bool.Parse(context.Variables.GetValueOrDefault<string>("useOpenId")))">
              <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
                  <openid-config url="https://${hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
                  <audiences>
                    <audience>wallet</audience>
                  </audiences>
                  <required-claims>
                      <claim name="walletId" match="all">
                        <value>@((string)context.Variables.GetValueOrDefault("walletId",""))</value>
                      </claim>
                  </required-claims>
              </validate-jwt>
          </when>
          <otherwise>
              <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
                  <issuer-signing-keys>
                      <key>{{wallet-jwt-signing-key}}</key>
                  </issuer-signing-keys>
                  <required-claims>
                    <claim name="walletId" match="all">
                      <value>@((string)context.Variables.GetValueOrDefault("walletId",""))</value>
                    </claim>
                 </required-claims>
                </validate-jwt>
          </otherwise>
      </choose>
        <set-variable name="xUserId" value="@{
          var jwt = (Jwt)context.Variables["jwtToken"];
          if(jwt.Claims.ContainsKey("userId")){
              return jwt.Claims["userId"][0];
          }
          return "";
          }" />
          <set-header name="x-user-id" exists-action="override">
              <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
          </set-header>

          <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
          <set-backend-service base-url="@("https://${hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-wallet-service")" />
          <set-header name="x-api-key" exists-action="override">
            <value>{{payment-wallet-service-api-key-for-ecommerce-auth-value}}</value>
          </set-header>
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
