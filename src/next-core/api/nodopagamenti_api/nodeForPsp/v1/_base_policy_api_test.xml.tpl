<policies>
    <inbound>
        <base />

        <choose>
            <when condition="@(${is-nodo-decoupler-enabled})">
                <!-- URL by decoupler -->
                <choose>
                <when condition="@(!((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Equals("api.prf.platform.pagopa.it") && !((string)context.Request.OriginalUrl.ToUri().Host).Equals("api.prf.platform.pagopa.it"))">
                    <rewrite-uri template="/webservices/input/" copy-unmatched-params="true" />
                </when>
                </choose>
            </when>
        </choose>

        <choose>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Equals("api.prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Equals("api.prf.platform.pagopa.it"))">
                <set-backend-service base-url="{{default-nodo-backend-prf}}/webservices/input" />
            </when>
        </choose>
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
