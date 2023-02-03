<policies>
  <inbound>
    <cors>
      <allowed-origins>
        <origin>*</origin>
        </allowed-origins>
      <allowed-methods>
        <method>GET</method>
        <method>OPTIONS</method>
      </allowed-methods>
    </cors>
    <return-response>
      <set-status code="302" reason="Temporary Redirect" />
      <set-header name="Location" exists-action="override">
        <value>@($"https://${checkout_hostname}/c/{(string)context.Request.MatchedParameters["id_cart"]}")</value>
      </set-header>
    </return-response>
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