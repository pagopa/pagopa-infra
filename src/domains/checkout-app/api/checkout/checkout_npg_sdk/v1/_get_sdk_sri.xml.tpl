<policies>
    <inbound>
        <base />
        <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" caching-type="internal" />
        <send-request ignore-error="true" timeout="10" response-variable-name="sdk-sri" mode="new">
            <set-url>https://${npg_hostname}/api/phoenix-0.0/psp/api/v1/build/integrity</set-url>
            <set-method>GET</set-method>
            <set-header name="Correlation-Id" exists-action="override">
                <value>@(Guid.NewGuid().ToString())</value>
            </set-header>
            <set-header name="X-Api-Key" exists-action="override">
                <value>{{npg-pagopa-api-key}}</value>
            </set-header>
        </send-request>
        <choose>
            <when condition="@(((IResponse)context.Variables["sdk-sri"]).StatusCode != 200)">
                <return-response>
                    <set-status code="500" reason="Internal server error" />
                    <set-body>
                        {
                            "title": "Internal Server Error",
                            "status": 500,
                            "detail": "Error processing the request",
                        }
                    </set-body>
                </return-response>
            </when>
            <otherwise>
                <set-variable name="npg-sri-response-body" value="@(((IResponse)context.Variables["sdk-sri"]).Body.As<JObject>())" />
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@{
                    var npgIntegrityHash = ((JObject) context.Variables["npg-sri-response-body"])["integrity"];
                    return new JObject(
                            new JProperty("integrityHash", npgIntegrityHash)
                           ).ToString();
             }</set-body>
                </return-response>
            </otherwise>
       </choose>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
        <cache-store duration="10" />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
