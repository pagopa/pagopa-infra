<policies>
    <inbound>
      <base />
      <set-header name="x-client-id" exists-action="delete" />
      <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
        <issuer-signing-keys>
          <key>{{wallet-jwt-signing-key}}</key>
        </issuer-signing-keys>
      </validate-jwt>
      <set-variable name="xUserId" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("x-user-id")){
            return jwt.Claims["x-user-id"][0];
        }
        return "";
        }"
      />
      <set-header name="x-user-id" exists-action="override">
          <value>>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
      </set-header>
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
