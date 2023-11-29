<policies>
    <inbound>
        <return-response>
            <set-status code="200" reason="OK" />          
        </return-response>
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
