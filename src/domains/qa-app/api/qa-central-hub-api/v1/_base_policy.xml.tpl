<policies>
    <inbound>
        <cors allow-credentials="true">
            <allowed-origins>
                <origin>https://${fe_server_url}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>GET</method>
                <method>POST</method>
                <method>PUT</method>
                <method>DELETE</method>
                <method>OPTIONS</method>
                <method>PATCH</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <base />
        <set-backend-service backend-id="${backend_id}" />
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