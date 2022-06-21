<policies>
    <inbound>
      <base />
      <set-backend-service base-url="https://{{ip-nodo}}/v1" />
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
