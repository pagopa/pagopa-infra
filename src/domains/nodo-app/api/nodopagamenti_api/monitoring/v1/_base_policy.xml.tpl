<policies>
    <inbound>
        <base />

        <choose>
            <!-- check URI request contains pagopa to set our internal service -->
            <when condition="@(context.Request.Url.Path.IndexOf("pagopa", StringComparison.OrdinalIgnoreCase) >= 0)">
                <set-backend-service base-url="${pagopa-base-url}" />
                <!-- in this case remove /pagopa from the request path to forward to the backend service -->
                <rewrite-uri template="@{
                    var path = context.Request.Url.Path;
                    var index = path.IndexOf("/pagopa", StringComparison.OrdinalIgnoreCase);
                    return path.Substring(index + "/pagopa".Length);
                }" copy-unmatched-params="true" />
            </when>
            <otherwise>
                <set-backend-service base-url="@(context.Variables.GetValueOrDefault<string>("baseUrl", "{{schema-ip-nexi}}"))" />
            </otherwise>
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
