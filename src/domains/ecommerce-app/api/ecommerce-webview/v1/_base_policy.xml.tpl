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
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
        <issuer-signing-keys>
            <key>{{ecommerce-webview-jwt-signing-key}}</key>
            <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key> <!-- TODO Need to review the key management for validation of the token used in this call as currently for payment wallet cards and apm tokens are signed differently -->
        </issuer-signing-keys>
    </validate-jwt>
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
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service")"/>
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
