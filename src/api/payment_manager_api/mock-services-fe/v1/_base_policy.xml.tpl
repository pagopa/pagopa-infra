<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>*</origin>
        </allowed-origins>
        <allowed-methods preflight-result-max-age="300">
          <method>*</method>
        </allowed-methods>
        <allowed-headers>
          <header>*</header>
        </allowed-headers>
        <expose-headers>
          <header>*</header>
        </expose-headers>
      </cors>
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
