<policies>
    <inbound>
      <base />
      <set-backend-service base-url="http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/v2" />
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
