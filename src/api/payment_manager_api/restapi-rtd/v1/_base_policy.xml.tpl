<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pm-gtw-hostname}}/pp-restapi-rtd/v1" />
      <ip-filter action="allow">
        <address>${restapi-ip-filter}</address>
      </ip-filter>
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
