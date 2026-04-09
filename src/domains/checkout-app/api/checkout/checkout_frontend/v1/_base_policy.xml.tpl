<policies>
    <inbound>
        <!-- direct APIM access: redirect to custom domain, or serve if FF enabled -->
        <set-variable name="apimFrontendEnabled" value="{{checkout-apim-frontend-enabled}}" />
        <choose>
            <when condition="@(context.Request.OriginalUrl.Host != "${checkout_fe_hostname}" && context.Variables.GetValueOrDefault<string>("apimFrontendEnabled") != "true")">
                <return-response>
                    <set-status code="302" reason="Found" />
                    <set-header name="Location" exists-action="override">
                        <value>https://${checkout_fe_hostname}/</value>
                    </set-header>
                </return-response>
            </when>
        </choose>
        <!-- requests from App GW continue with normal logic -->
        <cors>
            <allowed-origins>
                <origin>https://${checkout_fe_hostname}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>*</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <!-- URL Rewrites: replicate CDN delivery rules -->
        <choose>
            <!-- /dona or /dona/ -> /dona.html -->
            <when condition="@(Regex.IsMatch(context.Request.OriginalUrl.Path, @"\/dona\/?$", RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(500)))">
                <rewrite-uri template="/dona.html" />
            </when>
            <!-- /termini-di-servizio or /termini-di-servizio/ -> /terms/it.html -->
            <when condition="@(Regex.IsMatch(context.Request.OriginalUrl.Path, @"\/termini-di-servizio\/?$", RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(500)))">
                <rewrite-uri template="/terms/it.html" />
            </when>
        </choose>
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