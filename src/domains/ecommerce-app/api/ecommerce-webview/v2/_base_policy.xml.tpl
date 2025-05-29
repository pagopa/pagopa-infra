<policies>

  <inbound>
    <cors>
      <allowed-origins>
          <origin>*</origin>
      </allowed-origins>
      <allowed-methods>
          <method>GET</method>
      </allowed-methods>
      <allowed-headers>
          <header>Content-Type</header>
          <header>Authorization</header>
      </allowed-headers>
    </cors>
    <base />
    <set-header name="x-user-id" exists-action="delete" />
    <!-- Session eCommerce START-->
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
                <openid-config url="https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/.well-known/openid-configuration" />
            </validate-jwt>
        </when>
        <otherwise>
            <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
              <issuer-signing-keys>
                  <key>{{ecommerce-webview-jwt-signing-key}}</key>
                  <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key> <!-- TODO Need to review the key management for validation of the token used in this call as currently for payment wallet cards and apm tokens are signed differently -->
                  <key>{{wallet-session-jwt-signing-key}}</key> <!-- TODO Need to remove this key. The session token for webview polling MUST be different from the one used for app IO Authentication -->
              </issuer-signing-keys>
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
    <choose>
        <when condition="@(context.Variables.GetValueOrDefault("xUserId","") != "")">
            <set-header name="x-user-id" exists-action="override">
                <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
            </set-header>
        </when>
    </choose>
    <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
    <choose>
      <when condition="@( context.Request.Url.Path.Contains("transactions") )">
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2")"/>
      </when>
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
