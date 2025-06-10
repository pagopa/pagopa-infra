<policies>
    <inbound>
        <base />
        <!-- if prf env set backend-service -->
        <!-- is_perf_env is defined in ndphost_header fragment -->
        <choose>
          <when condition="@(context.Variables.GetValueOrDefault<bool>("is_perf_env", false))">
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
