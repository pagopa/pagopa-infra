<policies>
    <inbound>
        <base />
        <!-- 1 request every 5 seconds for each subscription -->
        <rate-limit-by-key
            calls="1"
            renewal-period="5"
            counter-key="@(context.Subscription.Name + &quot;:listDeadletterTransactionsInternal&quot;)"
            increment-condition="@(true)" />
        <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-watchdog-deadletter-service" />
        <rewrite-uri template="/v2/internal/deadletter-transactions" />
        <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-watchdog-internal-api-key}}</value>
        </set-header>
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
