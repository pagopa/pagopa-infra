<policies>
    <inbound>
      <base />
      
      <!-- Delete headers required for backend service START -->
      <set-header name="x-user-id" exists-action="delete" />
      <set-header name="x-client-id" exists-action="delete" />
      <!-- Delete headers required for backend service END -->

      <!-- Check JWT START-->
      <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
        <issuer-signing-keys>
          <key>{{wallet-session-jwt-signing-key}}</key>
        </issuer-signing-keys>
        <required-claims>
          <claim name="userId" />
        </required-claims>
      </validate-jwt>
      <set-variable name="xUserId" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("userId")){
            return jwt.Claims["userId"][0];
        }
        return "";
        }"
      />
      <!-- Check JWT END-->
      
      <!-- Headers settings required for backend service START -->
      <set-header name="x-user-id" exists-action="override">
        <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
      </set-header>
      <set-header name="x-client-id" exists-action="override">
        <value>IO</value>
      </set-header>
      <!-- Headers settings required for backend service END -->

      <set-backend-service base-url="https://${hostname}/pagopa-wallet-service" />
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
