<policies>
    <inbound>
     <base />
      <set-variable name="sessionToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <set-backend-service base-url="https://${wallet-basepath}/pagopa-wallet-service" />
    </inbound>
    <outbound>
      <base />
      <set-body>@{
          JObject inBody = context.Response.Body.As<JObject>(preserveContent: true);
          var redirectUrl = inBody["redirectUrl"];
          if(redirectUrl != null){
              inBody["redirectUrl"] = redirectUrl + "&sessionToken=" + ((string)context.Variables.GetValueOrDefault("sessionToken",""));
          }
          return inBody.ToString();
      }</set-body>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
