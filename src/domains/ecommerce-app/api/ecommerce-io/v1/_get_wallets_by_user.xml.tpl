<policies>
    <inbound>
      <base />
      <set-variable name="sessionToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />

      <send-request ignore-error="false" timeout="10" response-variable-name="walletResponse">
          <set-url>https://${wallet-hostname}/pagopa-wallet-service/wallets</set-url>
          <set-method>GET</set-method>
          <set-header name="x-user-id" exists-action="override">
              <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
          </set-header>
      </send-request>

      <choose>
        <when condition="@(((IResponse)context.Variables["walletResponse"]).StatusCode == 404)">
            <return-response>
                <set-status code="404" reason="Not found" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    {
                    "title": "Error retrieving user wallet data",
                    "status": 404,
                    "detail": "Wallets not found for user"
                    }
                </set-body>
            </return-response>
        </when>
        <when condition="@(((IResponse)context.Variables["walletResponse"]).StatusCode == 200)">
            <return-response>
                <set-status code="200" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    @{return ((IResponse)context.Variables["walletResponse"]).Body.As<JObject>().ToString();}
                </set-body>
            </return-response>
        </when>
        <otherwise>
            <return-response>
                <set-status code="502" reason="Bad Gateway" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    {
                    "title": "Error retrieving user wallet data",
                    "status": 502,
                    "detail": "There was an error retrieving user wallet data"
                    }
                </set-body>
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
