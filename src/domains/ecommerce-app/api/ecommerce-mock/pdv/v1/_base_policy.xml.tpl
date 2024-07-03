<policies>
  <inbound>
    <base />
    <retry condition="@(true)" count="1" interval="1" />
    <choose>
      <when condition="@(((string)(context.Request.Method)).Contains("PUT"))">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
               "token": "b282accf-995f-4211-939c-1ba0b4f3f255"
            }
          </set-body>
        </return-response>
      </when>
      <when condition="@(((string)(context.Request.Method)).Contains("GET"))">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
               "pii": "test@mock.it"
            }
          </set-body>
        </return-response>
      </when>
    </choose>
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