<policies>
    <inbound>
        <!-- CORS: allow NPG SDK origin for font assets -->
        <cors>
            <allowed-origins>
                <origin>https://${checkout_fe_hostname}</origin>
                <origin>https://${npg_sdk_hostname}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>GET</method>
                <method>OPTIONS</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <base />
        <!-- block requests for non-.ttf files -->
        <choose>
            <when condition="@(context.Request.Headers.GetValueOrDefault("Origin","") == "https://${npg_sdk_hostname}" && !context.Request.OriginalUrl.Path.EndsWith(".ttf"))">
                <return-response>
                    <set-status code="403" reason="Forbidden" />
                </return-response>
            </when>
        </choose>
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
