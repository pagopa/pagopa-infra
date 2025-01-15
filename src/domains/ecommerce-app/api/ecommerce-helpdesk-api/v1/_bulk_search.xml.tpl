<policies>
    <inbound>
        <base/>
        <set-body>
            {
                "type": "TRANSACTION_ID_RANGE",
                "transactionIdRange": {
                    "startTransactionId": "@(context.Request.Body.As<JObject>().SelectToken('tR.sTId').ToString())",
                    "endTransactionId": "@(context.Request.Body.As<JObject>().SelectToken('tR.eTId').ToString())"
                }
            }
        </set-body>
    </inbound>
    <outbound>
        <base/>
    </outbound>
    <backend>
        <base/>
    </backend>
    <on-error>
        <base/>
    </on-error>
</policies>
