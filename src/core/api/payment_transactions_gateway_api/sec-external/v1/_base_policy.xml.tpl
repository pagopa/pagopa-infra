<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>${origin}</origin>
        </allowed-origins>
        <allowed-methods preflight-result-max-age="300">
          <method>*</method>
        </allowed-methods>
        <allowed-headers>
          <header>*</header>
        </allowed-headers>
        <expose-headers>
          <header>*</header>
        </expose-headers>
      </cors>
      <base />
      <set-variable name="requestTransactionId" value="@{
        return context.Request.MatchedParameters["transactionId"];
      }" />
      <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
          <issuer-signing-keys>
              <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key>
          </issuer-signing-keys>
      </validate-jwt>
      <set-variable name="tokenTransactionId" value="@{
      var jwt = (Jwt)context.Variables["jwtToken"];
      if(jwt.Claims.ContainsKey("transactionId")){
          return jwt.Claims["transactionId"][0];
      }
      return "";
      }" />
      <choose>
          <when condition="@((string)context.Variables.GetValueOrDefault("tokenTransactionId","") != (string)context.Variables.GetValueOrDefault("requestTransactionId",""))">
              <return-response>
                  <set-status code="401" reason="Unauthorized" />
              </return-response>
          </when>
      </choose>
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/payment-gateway")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/payment-gateway")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
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
