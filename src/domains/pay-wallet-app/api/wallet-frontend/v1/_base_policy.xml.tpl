<policies>
    <inbound>
        <!-- direct APIM access: redirect to custom domain, or serve if FF enabled -->
        <set-variable name="apimFrontendEnabled" value="{{pay-wallet-apim-frontend-enabled}}" />
        <choose>
            <when condition="@(context.Request.OriginalUrl.Host != "${wallet_fe_hostname}" && context.Variables.GetValueOrDefault<string>("apimFrontendEnabled") != "true")">
                <return-response>
                    <set-status code="302" reason="Found" />
                    <set-header name="Location" exists-action="override">
                        <value>https://${wallet_fe_hostname}/</value>
                    </set-header>
                </return-response>
            </when>
        </choose>
        <!-- requests from App GW continue with normal logic -->
        <cors>
            <allowed-origins>
                <origin>https://${wallet_fe_hostname}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>*</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <!-- Backend: storage static website (bypasses CDN in case of downtime) -->
        <set-backend-service base-url="https://${storage_web_hostname}" />
    </inbound>
    <outbound>
        <base />
        <!-- Security Headers: replicate CDN global delivery rules -->
        <!-- HSTS -->
        <set-header name="Strict-Transport-Security" exists-action="override">
            <value>max-age=31536000</value>
        </set-header>
        <!-- X-Frame-Options -->
        <set-header name="X-Frame-Options" exists-action="override">
            <value>SAMEORIGIN</value>
        </set-header>
        <!-- Content-Security-Policy -->
        <set-header name="Content-Security-Policy" exists-action="override">
            <value>${csp_value}</value>
        </set-header>
    </outbound>
    <backend>
        <base />
    </backend>
    <on-error>
        <base />
    </on-error>
</policies>
