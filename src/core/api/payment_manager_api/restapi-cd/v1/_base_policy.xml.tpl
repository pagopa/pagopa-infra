<policies>
    <inbound>
      <base />
      <set-backend-service base-url="@(String.Format("{{pm-gtw-hostname}}:{0}/pp-restapi-CD/v1", (string)context.Variables["pm-gtw-port"]))" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
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
