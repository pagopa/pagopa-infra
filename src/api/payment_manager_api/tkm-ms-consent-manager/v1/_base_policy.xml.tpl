<policies>
    <inbound>
      <base />
      <set-backend-service base-url="https://{{aks-lb-nexi}}/tkm/tkmconsentmanager" />
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
