<policies>
  <inbound>
    <base />
    <return-response>
      <set-status code="404" reason="Not found" />
      <set-header name="Content-Type" exists-action="override">
        <value>application/json</value>
      </set-header>
      <set-body template="liquid">
        {
            "description": "Mock not implemented"
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