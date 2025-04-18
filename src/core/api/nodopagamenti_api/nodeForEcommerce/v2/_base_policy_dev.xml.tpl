<policies>
    <inbound>
        <base />
        <set-backend-service base-url="@{
                    return context.Variables.GetValueOrDefault<string>("default-nodo-backend-dev-nexi", "")+"/v2";
                  }" />
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
