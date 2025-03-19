<policies>
  <inbound>
    <base />
    <set-variable name="requestTransactionId" value="@{
      var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
      if(transactionId == ""){
        transactionId = context.Request.Headers.GetValueOrDefault("x-transaction-id-from-client","");
      }
      return transactionId;
    }" />
    <set-header name="x-transaction-id" exists-action="delete" />
    <set-header name="x-user-id" exists-action="delete" />
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
    <set-variable name="userId" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("userId")){
           return jwt.Claims["userId"][0];
        }
        return "";
    }" />
    <set-header name="x-user-id" exists-action="override">
      <value>@((string)context.Variables.GetValueOrDefault("userId",""))</value>
    </set-header>
    <choose>
      <when condition="@((string)context.Variables.GetValueOrDefault("tokenTransactionId","") != (string)context.Variables.GetValueOrDefault("requestTransactionId",""))">
        <return-response>
          <set-status code="401" reason="Unauthorized" />
        </return-response>
      </when>
      <when condition="@((string)context.Variables["requestTransactionId"] != "")">
        <set-header name="x-transaction-id" exists-action="override">
          <value>@((string)context.Variables.GetValueOrDefault("requestTransactionId",""))</value>
        </set-header>
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
