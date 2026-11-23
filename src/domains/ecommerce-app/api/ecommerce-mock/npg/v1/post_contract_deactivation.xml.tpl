<policies>
  <inbound>
    <base />
    <set-variable name="contractId" value="@(context.Request.MatchedParameters["contractId"])"/>
    <choose>
      <when condition="@(((string)(context.Variables["contractId"])).Equals("C00000000000000001"))">
        <return-response>
          <set-status code="400" reason="Invalid request data" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
              "errors": [
                {
                  "code": "PS0017",
                  "description": "Merchant contract id not found"
                }
              ]
            }
          </set-body>
        </return-response>
      </when>

      <when condition="@(((string)(context.Variables["contractId"])).Equals("C00000000000000002"))">
        <return-response>
          <set-status code="500" reason="Internal Server Error" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
              "errors": [
                {
                  "code": "GW0001",
                  "description": "Internal Server Error"
                }
              ]
            }
          </set-body>
        </return-response>
      </when>

      <otherwise>
        <return-response>
          <set-status code="200" reason="Contract deactivation successful" />
          </return-response>
      </otherwise>
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
