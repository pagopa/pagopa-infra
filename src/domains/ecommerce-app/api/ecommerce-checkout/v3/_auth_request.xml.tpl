<policies>
  <inbound>
    <base />
    <set-header name="x-pgs-id" exists-action="delete" />
    <set-header name="x-transaction-id" exists-action="delete" />
    <set-header name="x-user-id" exists-action="delete" />
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
    <set-variable name="requestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
    <set-variable name="detailType" value="@((string)((JObject)((JObject)context.Variables["requestBody"])["details"])["detailType"])" />
    <set-variable name="gatewayId" value="@{
        string detailType = (string)(context.Variables.GetValueOrDefault("detailType",""));
        string gatewayId = "";
        // cards or apm -> ecommerce with NPG request
        if ( detailType == "cards" || detailType == "apm"){
          gatewayId = "NPG";
        // redirect -> ecommerce with redirect
        } else if ( detailType == "redirect"){
          gatewayId = "REDIRECT";
        }
        return gatewayId;
    }" />
    <choose>
      <when condition="@((string)context.Variables.GetValueOrDefault("tokenTransactionId","") != (string)context.Variables.GetValueOrDefault("requestTransactionId",""))">
        <return-response>
          <set-status code="401" reason="Unauthorized" />
        </return-response>
      </when>
      <when condition="@((string)context.Variables["gatewayId"] != "")">
        <set-header name="x-pgs-id" exists-action="override">
          <value>@((string)context.Variables.GetValueOrDefault("gatewayId",""))</value>
        </set-header>
      </when>
      <otherwise>
        <return-response>
          <set-status code="400" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body>@{
            return new JObject(
            new JProperty("title", "Bad request"),
            new JProperty("status", 400),
            new JProperty("detail", "Cannot retrieve gateway for request")
            ).ToString();
            }</set-body>
        </return-response>
      </otherwise>
    </choose>
    <set-header name="x-transaction-id" exists-action="override">
      <value>@((string)context.Variables.GetValueOrDefault("requestTransactionId",""))</value>
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
