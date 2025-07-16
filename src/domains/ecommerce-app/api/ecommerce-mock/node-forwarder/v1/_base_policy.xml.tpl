<policies>
    <inbound>
        <base />
        <set-variable name="requestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <set-variable name="transactionId" value="@(((JObject)context.Variables["requestBody"]).Value<String>("idTransaction")?.ToString() ?? "N/A")" />
        <choose>
            <when condition="@(context.Request.Headers.GetValueOrDefault("X-Host-Path", "").Contains("redirections/refunds"))">
                <choose>
                    <when condition="@(((string)context.Variables["transactionId"]).Equals("00000000000000000000000000000001"))">
                        <return-response>
                            <set-status code="200" reason="OK" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                                {
                                    "idTransaction": "00000000000000000000000000000001",
                                    "outcome": "KO"
                                }       
                            </set-body>
                        </return-response>
                    </when>
                    <when condition="@(((string)context.Variables["transactionId"]).Equals("00000000000000000000000000000002"))">
                        <return-response>
                            <set-status code="404" reason="Not found" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                               {
                                    "title": "Not found",
                                    "status": 404,
                                    "detail": "Not found",
                                    "idTransaction": "00000000000000000000000000000002"
                                }    
                            </set-body>
                        </return-response>
                    </when>
                    <when condition="@(((string)context.Variables["transactionId"]).Equals("00000000000000000000000000000003"))">
                        <return-response>
                            <set-status code="500" reason="Internal server error" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                               {
                                    "title": "Internal server error",
                                    "status": 500,
                                    "detail": "Internal server error",
                                    "idTransaction": "00000000000000000000000000000003"
                                }    
                            </set-body>
                        </return-response>
                    </when>
                    <otherwise>
                        <return-response>
                            <set-status code="200" reason="OK" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                                {
                                    "idTransaction": "123",
                                    "outcome": "OK"
                                }       
                            </set-body>
                        </return-response>
                    </otherwise>
                </choose>
            </when>
            <when condition="@(context.Request.Headers.GetValueOrDefault("X-Host-Path", "").Contains("redirections"))">
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "url": "http://redirect.url.io/",
                            "idTransaction": "123",
                            "idPSPTransaction": "456",
                            "amount": 10000,
                            "timeout": 60000
                        }
                    </set-body>
                </return-response>
            </when>
        </choose>
    </inbound>
    <outbound>
        <base />
    </outbound>
    <backend>
        <base />
    </backend>
    <on-error>
        <base />
    </on-error>
</policies>