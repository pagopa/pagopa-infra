<policies>
    <inbound>
        <cors allow-credentials="true">
            <allowed-origins>
                <origin>https://${portal-domain}</origin>
                <origin>https://${management-api-domain}</origin>
                <origin>https://${apim-name}.developer.azure-api.net</origin>
                <origin>https://${old-apim-name}.developer.azure-api.net</origin>
            </allowed-origins>
            <allowed-methods preflight-result-max-age="300">
                <method>*</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
            <expose-headers>
                <header>*</header>
            </expose-headers>
        </cors>
    </inbound>
    <backend>
        <forward-request />
    </backend>
    <outbound />
    <on-error />
</policies>
