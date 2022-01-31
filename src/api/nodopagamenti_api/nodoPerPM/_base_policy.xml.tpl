<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{urlnodo}}" />
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
