<policies>
    <inbound>
        <base />

        <!-- Including header for service type -->
        <set-header name="X-Client-Service-Type" exists-action="override">
        	<value>ACA</value>
        </set-query-parameter>

        <rewrite-uri template="/" />
        <set-backend-service base-url="https://${hostname}/pagopa-gpd-payments/partner" />
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
