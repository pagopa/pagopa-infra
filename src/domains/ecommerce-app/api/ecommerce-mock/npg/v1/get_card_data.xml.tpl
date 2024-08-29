<policies>
  <inbound>
    <base />

    <return-response>
      <set-status code="200" reason="OK" />
      <set-header name="Content-Type" exists-action="override">
        <value>application/json</value>
      </set-header>
      <set-body template="liquid">
      {
        "bin": "434994",
        "lastFourDigits": "0000",
        "expiringDate": "0430",
        "circuit": "VISA"
      }
      </set-body>
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