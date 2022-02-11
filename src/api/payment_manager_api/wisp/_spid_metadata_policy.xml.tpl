<policies>
    <inbound>
      <base />
        <return-response>
          <set-header name="Content-Type" exists-action="override">
              <value>application/xml</value>
          </set-header>
          <set-body template="liquid">${metadata}</set-body>
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
