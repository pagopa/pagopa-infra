<policies>
    <inbound>
        <base />
        <set-backend-service base-url="{{default-nodo-backend}}" />

        <choose>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Equals("api.prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Equals("api.prf.platform.pagopa.it"))">
                <set-backend-service base-url="{{default-nodo-backend-prf}}" />
            </when>
        </choose>

        <choose>
        <when condition="@(context.Request.Headers.GetValueOrDefault("X-Environment", "").Equals("uat") || context.Request.Headers.GetValueOrDefault("X-Environment", "").Equals("prod"))">
            <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
                <value>${allowed_ip_1}</value>
                <value>${allowed_ip_2}</value>
                <value>${allowed_ip_3}</value>
                <value>${allowed_ip_4}</value>
                <value>${allowed_ip_5}</value>
            </check-header>
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
