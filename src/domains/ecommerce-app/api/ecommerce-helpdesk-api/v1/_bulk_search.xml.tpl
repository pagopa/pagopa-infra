<policies>
    <inbound>
        <set-body>@{
            var requestBody = context.Request.Body.As<JObject>();

            var startTransactionId = requestBody["tR"]?["sTId"]?.ToString();
            var endTransactionId = requestBody["tR"]?["eTId"]?.ToString();

            return new JObject(
                new JProperty("type", "TRANSACTION_ID_RANGE"),
                new JProperty("transactionIdRange", new JObject(
                    new JProperty("startTransactionId", startTransactionId),
                    new JProperty("endTransactionId", endTransactionId)
                ))
            ).ToString();
        }</set-body>
        <base/>
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
