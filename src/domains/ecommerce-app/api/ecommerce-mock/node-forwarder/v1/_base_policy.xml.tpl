<policies>
    <inbound>
        <base />
        <choose>
            <when condition="@(context.Request.Headers.GetValueOrDefault("X-Host-Path", "").Contains("redirections/refunds"))">
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
              "idTransaction": "123",
              "outcome": "OK"
              }</set-body>
                </return-response>
            </when>
            <when condition="@(context.Request.Headers.GetValueOrDefault("X-Host-Path", "").Contains("redirections"))">
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
              "url": "http://redirect.url.io/",
              "idTransaction": "123",
              "idPSPTransaction": "456",
              "amount": 10000,
              "timeout": 60000
              }</set-body>
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