<policies>
    <inbound>
        <base />
        <choose>
            <when condition="@(${is-fdr-nodo-pagopa-enable})">
                <set-backend-service base-url="${base-url}" />
            </when>
            <otherwise>
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