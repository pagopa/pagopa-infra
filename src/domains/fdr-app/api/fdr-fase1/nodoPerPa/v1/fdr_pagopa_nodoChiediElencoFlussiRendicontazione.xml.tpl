<policies>
    <inbound>
        <base />
        <set-variable name="enable_fdr_ci_soap_request_switch" value="{{enable-fdr-ci-soap-request-switch}}" />
        <set-variable name="is_fdr_nodo_pagopa_enable" value="@(${is-fdr-nodo-pagopa-enable})" />
        <choose>
            <when condition="@( context.Variables.GetValueOrDefault<bool>("is_fdr_nodo_pagopa_enable", false) && context.Variables.GetValueOrDefault<string>("enable_fdr_ci_soap_request_switch", "").Equals("true") )">
              <set-variable name="readrequest" value="@(context.Request.Body.As<string>(preserveContent: true))" />
              <set-backend-service base-url="${base-url}" />
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
