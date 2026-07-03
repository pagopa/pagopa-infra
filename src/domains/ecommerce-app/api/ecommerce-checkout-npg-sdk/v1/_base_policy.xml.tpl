<policies>
    <inbound>
        <base />

        <!-- Batch endpoint: called hourly by the checkout NPG SDK sync pipeline.
             Stricter rate limit than the rest of the ecommerce-for-checkout group. PIDM-2190 -->
        <rate-limit-by-key calls="10" renewal-period="60" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

        <!-- Authenticate to the payment-methods-handler backend; the npg-api-key stays in the eCommerce domain -->
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
