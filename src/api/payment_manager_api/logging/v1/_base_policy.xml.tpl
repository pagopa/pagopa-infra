<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pm-gtw-hostname}}/db-logging" />
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
