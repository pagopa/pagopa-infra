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

        <set-variable name="rptIdPostTransactions" value="@{
          var body = (JObject)context.Variables["reqBody"];
          return (string)body["paymentNotices"][0]["rptId"];
          }" />


        <set-variable name="amountPostTransactions" value="@{
           var body = (JObject)context.Variables["reqBody"];
           return (string)body["paymentNotices"][0]["amount"];
          }" />

        <set-variable name="rptIdFromClaim" value="@{
            var jwt = (Jwt)context.Variables["jwtToken"];
            if(jwt.Claims.ContainsKey("rptId")){
                return jwt.Claims["rptId"][0];
            }
            return "";
            }" />
        <set-variable name="amountFromClaim" value="@{
            var jwt = (Jwt)context.Variables["jwtToken"];
            if(jwt.Claims.ContainsKey("amount")){
                return jwt.Claims["amount"][0];
            }
            return "";
            }" />

        <choose>
            <when condition="@(
                (string)context.Variables["rptIdPostTransactions"] != (string)context.Variables["rptIdFromClaim"]
                || (string)context.Variables["amountPostTransactions"] != (string)context.Variables["amountFromClaim"]
            )">
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
                </return-response>
            </when>
        </choose>




        <set-body>@{
          JObject requestBody = (JObject)context.Variables["reqBody"];
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
