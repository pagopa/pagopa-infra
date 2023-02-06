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
    <return-response>
      <set-status code="200"/>
      <set-header name="Content-Type" exists-action="override">
        <value>text/html</value>
      </set-header>
        <set-body template="liquid">
          <head>
            <meta http-equiv="refresh" content="0; URL=https://${checkout_hostname}/c/{{(string)context.Request.MatchedParameters['id_cart']}}"/>
          </head>
        </set-body>
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