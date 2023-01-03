<policies>
  <inbound>
    <set-header name="x-transaction-origin" exists-action="override" >
      <value>CHECKOUT</value>
    </set-header>
    <base />
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
