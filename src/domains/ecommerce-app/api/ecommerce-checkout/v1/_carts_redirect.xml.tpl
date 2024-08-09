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
    <set-variable name="cartId" value="@(context.Request.MatchedParameters["cart_id"])" />
    <set-variable name="clientId" value="@(context.Request.Url.Query.GetValueOrDefault("clientId", ""))" />
    <return-response>
      <set-status code="200"/>
      <set-header name="Content-Type" exists-action="override">
        <value>text/html</value>
      </set-header>
        <set-body template="liquid">
          <head>
            <meta http-equiv="refresh" content="0; URL=https://${checkout_hostname}/c/{{context.Variables['cartId']}}?clientId={{context.Variables['clientId']}}"/>
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