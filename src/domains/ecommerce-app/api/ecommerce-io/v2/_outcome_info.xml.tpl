<policies>
    <inbound>
        <base />
    </inbound>
    <outbound>
        <base />
         <set-body>@{
          JObject inBody = context.Response.Body.As<JObject>(preserveContent: true);
          inBody.Remove("totalAmount");
          inBody.Remove("fees");
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
