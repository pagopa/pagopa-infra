<policies>
    <inbound>
        <base />

        <choose>
            <when condition="@(${is-nodo-decoupler-enabled})">
            </when>
            <otherwise>
                <set-backend-service base-url="${base-url}" />
            </otherwise>
        </choose>

        <choose>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Equals("api.prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Equals("api.prf.platform.pagopa.it"))">
                <set-backend-service base-url="{{default-nodo-backend-prf}}" />
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
