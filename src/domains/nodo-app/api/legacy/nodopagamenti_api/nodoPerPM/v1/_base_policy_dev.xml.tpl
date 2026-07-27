<policies>
    <inbound>
        <base />

        <!-- REST API -->
        <set-backend-service base-url="@{
                    return context.Variables.GetValueOrDefault<string>("default-nodo-backend-dev-nexi", "");
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
