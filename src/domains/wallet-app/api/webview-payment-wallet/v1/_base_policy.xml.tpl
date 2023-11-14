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
      <set-variable name="walletId" value="@{
          return context.Request.MatchedParameters.GetValueOrDefault("walletId","");
      }" />
      <!--
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
      -->
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
