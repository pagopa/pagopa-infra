<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pm-gtw-hostname}}/pp-restapi/v4" />
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
