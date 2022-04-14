<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pm-onprem-hostname}}/pp-restapi-CD/v1" />
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
