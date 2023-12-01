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
            <otherwise>
                <set-backend-service base-url="${base-url}" />
            </otherwise>
        </choose>

        <choose>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Equals("api.prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Equals("api.prf.platform.pagopa.it"))">
                <set-backend-service base-url="@{
                  return context.Variables.GetValueOrDefault<string>("default-nodo-backend-prf", "") + "/webservices/input";
                }" /> <!-- PRF -->
                <!--<set-backend-service base-url="http://{{aks-lb-nexi}}/nodo-prf/webservices/input" />--> <!-- PRF -->
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
