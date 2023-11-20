<policies>
  <inbound>
    <base />
    <choose>
      <when condition="@(((string)(context.Request.Url.Path)).Contains("checkPosition"))">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
                "outcome": "OK",
                "positionslist": [
                    {
                        "fiscalCode": "77777777777",
                        "noticeNumber": "302047770004456788",
                        "state": "OK"
                    }
                ]
            }
          </set-body>
        </return-response>
      </when>
      <when condition="@(((string)(context.Request.Url.Path)).Contains("closepayment"))">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body>
            {
                "outcome": "OK"
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