<policies>
    <inbound>
        <choose>
            <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))">
                <!-- START delete wallet -->
                <set-variable name="idWalletPM" value="@{
                    string walletId = context.Request.MatchedParameters["walletId"];
                    return Convert.ToInt32("0x" + walletId.Substring(walletId.Length - 12), 16).ToString();
                }" />
                <send-request ignore-error="false" timeout="10" response-variable-name="pmWalletDeleteResponse">
                    <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/wallet/{(string)context.Variables["idWalletPM"]}")</set-url>
                    <set-method>DELETE</set-method>
                    <set-header name="Authorization" exists-action="override">
                        <value>@($"Bearer {((JObject)context.Variables["sessionToken"]).ToString()}")</value>
                    </set-header>
                </send-request>
                <!-- END delete wallet -->
                <set-variable name="deleteStatusCode" value="@(((IResponse)context.Variables["pmWalletDeleteResponse"]).StatusCode)" />
                <choose>
                    <when condition="@(((int)context.Variables["deleteStatusCode"]) == 200 || ((int)context.Variables["deleteStatusCode"]) == 204)">
                        <return-response>
                            <set-status code="204" reason="No content" />
                        </return-response>
                    </when>     
                    <when condition="@(((int)context.Variables["deleteStatusCode"]) == 401)">
                        <return-response>
                            <set-status code="401" reason="Unauthorized" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                                {
                                "title": "Unauthorized",
                                "status": 401,
                                "detail": "Unauthorized"
                                }
                            </set-body>
                        </return-response>
                    </when>
                    <when condition="@(((int)context.Variables["deleteStatusCode"]) == 404)">
                        <return-response>
                            <set-status code="404" reason="Not Found" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                                {
                                "title": "Not Found",
                                "status": 404,
                                "detail": "Wallet not found"
                                }
                            </set-body>
                        </return-response>
                    </when>
                    <otherwise>
                        <return-response>
                            <set-status code="502" reason="Bad Gateway" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                                {
                                "title": "Error deleting wallet",
                                "status": 502,
                                "detail": "There was an error deleting wallet"
                                }
                            </set-body>
                        </return-response>
                    </otherwise>
                </choose>
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