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
        "operationId": "3470744",
        "operationTime": "2022-09-01T01:20:00.001Z"
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