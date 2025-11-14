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
        <choose>
          <when condition="@(context.Response.StatusCode == 200)">
            <!-- Token JWT START-->
            <set-variable name="responseBody" value="@(context.Response.Body.As<JObject>(true))" />
            <set-variable name="transactionId" value="@(((JObject)context.Variables["responseBody"])["transactionId"].ToString())" />
           
            <send-request ignore-error="true" timeout="10" response-variable-name="x-jwt-token" mode="new">
              <set-url>https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/tokens</set-url>
              <set-method>POST</set-method>
              <!-- Set jwt-issuer-service API Key header -->
              <set-header name="x-api-key" exists-action="override">
                <value>{{ecommerce-jwt-issuer-api-key-value}}</value>
              </set-header>
              <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
              </set-header>
              <set-body>@{
                var userId = ((string)context.Variables.GetValueOrDefault("xUserId",""));
                var transactionId = ((string)context.Variables.GetValueOrDefault("transactionId",""));
                return new JObject(
                        new JProperty("audience", "ecommerce-outcomes"),
                        new JProperty("duration", 1200),
                        new JProperty("privateClaims", new JObject(
                            new JProperty("transactionId", transactionId),
                            new JProperty("userId", userId)
                        ))
                    ).ToString();
              }</set-body>
            </send-request>
            <choose>
              <when condition="@(((IResponse)context.Variables["x-jwt-token"]).StatusCode != 200)">
                  <return-response>
                      <set-status code="502" reason="Bad Gateway" />
                  </return-response>
              </when>
            </choose>
            <set-variable name="token" value="@( (string) ( ((IResponse)context.Variables["x-jwt-token"] ).Body.As<JObject>(preserveContent: true)) ["token"])" />
            <!-- Token JWT END-->
            <choose>
              <when condition="@(!String.IsNullOrEmpty((string)context.Variables["token"]))">
                  <set-body>@{
                      JObject inBody = (JObject)context.Variables["responseBody"];
                      inBody["authToken"] = (string)context.Variables.GetValueOrDefault("token","");
                      return inBody.ToString();
                  }</set-body>
              </when>
            </choose>
          </when>
        </choose>
    </outbound>
    <backend>
        <base />
    </backend>
    <on-error>
        <base />
    </on-error>
</policies>
