<policies>
    <inbound>
        <base />
        <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body template="liquid">
            {
                "paymentMethodId": "5bdc0d63-a5b8-4221-bbb1-3e8b45a1b40f",
                "date": "2024-10-02T22:45:47.355Z",
                "type": "guest"
            }
            </set-body>
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
