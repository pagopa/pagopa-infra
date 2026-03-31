<policies>
    <inbound>
        <!-- feature flag: if disabled, redirect all traffic to the CDN/custom domain -->
        <set-variable name="apimFrontendEnabled" value="{{checkout-apim-frontend-enabled}}" />
        <choose>
            <when condition="@(context.Variables.GetValueOrDefault<string>("apimFrontendEnabled") != "true")">
                <return-response>
                    <set-status code="302" reason="Found" />
                    <set-header name="Location" exists-action="override">
                        <value>@("https://${checkout_fe_hostname}" + context.Request.OriginalUrl.Path + context.Request.OriginalUrl.QueryString)</value>
                    </set-header>
                </return-response>
            </when>
        </choose>
        <!-- direct APIM access -> redirect to the custom domain -->
        <choose>
            <when condition="@(context.Request.OriginalUrl.Host != "${checkout_fe_hostname}")">
                <return-response>
                    <set-status code="302" reason="Found" />
                    <set-header name="Location" exists-action="override">
                        <value>https://${checkout_fe_hostname}/</value>
                    </set-header>
                </return-response>
            </when>
        </choose>
        <!-- block NPG requests for non-.ttf files (specific fonts extension) -->
        <choose>
            <when condition="@(context.Request.Headers.GetValueOrDefault("Origin","") == "https://${npg_sdk_hostname}" && !context.Request.OriginalUrl.Path.EndsWith(".ttf"))">
                <return-response>
                    <set-status code="403" reason="Forbidden" />
                </return-response>
            </when>
        </choose>
        <!-- CORS: allow NPG SDK origin for font assets -->
        <cors>
            <allowed-origins>
                <origin>https://${checkout_fe_hostname}</origin>
                <origin>https://${npg_sdk_hostname}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>GET</method>
                <method>OPTIONS</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <set-backend-service base-url="https://${storage_web_hostname}" />
    </inbound>
    <outbound>
        <base />
        <!-- Security Headers -->
        <set-header name="Strict-Transport-Security" exists-action="override">
            <value>max-age=31536000</value>
        </set-header>
        <set-header name="X-Frame-Options" exists-action="override">
            <value>SAMEORIGIN</value>
        </set-header>
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
