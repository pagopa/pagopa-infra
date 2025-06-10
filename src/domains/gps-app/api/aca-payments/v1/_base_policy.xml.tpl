<policies>
    <inbound>
        <base />

        <!-- Including query parameter for service type -->
        <set-variable name="service_type_value" value="ACA"/>
        <include-fragment fragment-id="service-type-set"/>

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
