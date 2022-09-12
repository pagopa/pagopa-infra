<policies>
    <inbound>
      <base />
      <set-backend-service base-url="@(String.Format("{{pm-gtw-hostname}}:{0}/pp-restapi/v4", (string)context.Variables["pm-gtw-port"]))" />
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
