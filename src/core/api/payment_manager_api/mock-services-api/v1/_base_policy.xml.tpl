<policies>
    <inbound>
      <base />
      <set-backend-service base-url="http://{{aks-lb-nexi}}/pmmockservice/pmmockserviceapi" />
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
