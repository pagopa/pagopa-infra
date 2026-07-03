<policies>
    <inbound>
        <base />

        <!-- endpoint called hourly by the checkout NPG SDK sync pipeline -->
        <rate-limit-by-key calls="10" renewal-period="60" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

        <!-- auth to the payment-methods-handler backend -->
        <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-payment-methods-api-key-value}}</value>
        </set-header>

        <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-payment-methods-handler" />
        <rewrite-uri template="/npg/sdk/integrity" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
