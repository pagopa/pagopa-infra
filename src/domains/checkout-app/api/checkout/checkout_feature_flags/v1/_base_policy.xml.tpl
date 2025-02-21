<policies>
  <inbound>
    <cors>
      <allowed-origins>
        <origin>${checkout_origin}</origin>
      </allowed-origins>
      <allowed-methods>
        <method>GET</method>
        <method>OPTIONS</method>
      </allowed-methods>
      <allowed-headers>
        <header>Content-Type</header>
      </allowed-headers>
    </cors>
    <base />

    <include-fragment fragment-id="fragment-checkout-feature-flag-filter" />

    <return-response>
      <set-status code="200" reason="OK" />
      <set-header name="Content-Type" exists-action="override">
        <value>application/json</value>
      </set-header>
      <set-body>@(context.Variables.GetValueOrDefault("checkout-feature-flag", "{}"))</set-body>
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

