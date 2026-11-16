<policies>
    <inbound>
        <base />

        <!-- called ~hourly by the checkout NPG SDK sync pipeline: tight in prod, higher in dev/uat for api-tests -->
        <rate-limit-by-key calls="${rate_limit_calls}" renewal-period="60" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

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
