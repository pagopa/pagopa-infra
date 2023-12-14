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
    <set-header name="x-client-id" exists-action="delete" />
    <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
    <!-- Session eCommerce START-->
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
        <issuer-signing-keys>
            <key>{{ecommerce-io-jwt-signing-key}}</key>
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
    <set-header name="x-user-id" exists-action="override">
        <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
    </set-header>
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
