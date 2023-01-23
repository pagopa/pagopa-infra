<policies>
  <inbound>
    <base />
    <validate-jwt header-name="Authorization" require-scheme="Bearer" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized">
      <issuer-signing-keys>
        <key>{{transaction-jwt-signing-key}}</key>  <!-- the received token signature verification key -->
      </issuer-signing-keys>
    </validate-jwt>
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