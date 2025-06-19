<policies>
    <inbound>
        <base />
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service/v2.1")"/>
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
