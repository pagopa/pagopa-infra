<policies>
    <inbound>
        <base />
        <set-variable name="email" value="@{
              var jwt = (Jwt)context.Variables["jwtToken"];
              if(jwt.Claims.ContainsKey("email")){
                  return jwt.Claims["email"][0];
              }
              return "";
              }" />
        <set-body>@{
          JObject requestBody = context.Request.Body.As<JObject>(preserveContent: true);
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
