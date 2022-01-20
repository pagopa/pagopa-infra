<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pagopa-appservice-proxy-url}}/FespCdService" />
      <ip-filter action="allow">
        <address>${Nodo-Ip-Filter}</address>
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
