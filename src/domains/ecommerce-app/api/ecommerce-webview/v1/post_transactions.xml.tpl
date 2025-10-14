<policies>
    <inbound>
        <base />
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2.1")"/>
        <set-variable name="email" value="@{
              var jwt = (Jwt)context.Variables["jwtToken"];
              if(jwt.Claims.ContainsKey("email")){
                  return jwt.Claims["email"][0];
              }
              return "";
              }" />


        <set-variable name="reqBody" value="@{
          return context.Request.Body.As<JObject>(preserveContent:true);
          }" />

        <set-variable name="rptId_request" value="@{
          var b = (JObject)context.Variables["reqBody"];
          return (string)b?["rptId"] ?? "";
          }" />
        <set-variable name="amount_request" value="@{
          var b = (JObject)context.Variables["reqBody"];
          long a = 0;
          var t = b?["amount"];
          if (t != null) long.TryParse(t.ToString(), out a);
          return a;
          }" />

        <set-variable name="rptId_claim" value="@{
            var jwt = (Jwt)context.Variables["privateClaims"];
            return jwt.Claims.ContainsKey("rptId") ? jwt.Claims["rptId"][0] : "";
        }" />
        <set-variable name="amount_claim" value="@{
            var jwt = (Jwt)context.Variables["privateClaims"];
            // i claims arrivano come string; normalizza a long
            long a = 0;
            if (jwt.Claims.ContainsKey("amount")) long.TryParse(jwt.Claims["amount"][0], out a);
            return a;
        }" />


        <set-body>@{
          JObject requestBody = context.Request.Body.As<JObject>(preserveContent: true);
          requestBody["orderId"] = "ORDER_ID"; //To be removed since it is mandatory for transaction request body, but it should not be
          requestBody["emailToken"] = (String)context.Variables["email"];
          return requestBody.ToString();
        }</set-body>
        <set-header name="X-Client-Id" exists-action="override">
            <value>IO</value>
        </set-header>
        <set-header name="x-correlation-id" exists-action="override">
            <value>@(Guid.NewGuid().ToString())</value>
        </set-header>
        <set-header name="x-user-id" exists-action="override">
            <value>@((String)context.Variables["xUserId"])</value>
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
