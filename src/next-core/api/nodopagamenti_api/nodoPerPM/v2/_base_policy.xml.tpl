<policies>
    <inbound>
        <base />

        <set-backend-service base-url="@{
                    var defaultBackend = context.Variables.GetValueOrDefault<string>("default-nodo-backend", "");
                    var baseUrl = context.Variables.GetValueOrDefault<string>("baseUrl", defaultBackend);
                    return baseUrl + "/v2";
                }" />

        <choose>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Equals("api.prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Equals("api.prf.platform.pagopa.it"))">
                <set-backend-service base-url="{{default-nodo-backend-prf}}/v2" />
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
