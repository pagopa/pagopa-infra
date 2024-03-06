<policies>
    <inbound>
        <set-variable  name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
        <!-- Session PM START-->
        <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
            <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletToken"]}")</set-url>
            <set-method>GET</set-method>
        </send-request>
        <choose>
            <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode != 200)">
                <return-response>
                <set-status code="502" reason="Bad Gateway" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    {
                    "title": "Error starting session",
                    "status": 502,
                    "detail": "There was an error starting session for input wallet token"
                    }
                </set-body>
                </return-response>
            </when>
        </choose>
        <set-variable name="pmSession" value="@(((IResponse)context.Variables["pm-session-body"]).Body.As<JObject>())" />
        <!-- START delete wallet -->
        <set-variable name="idWalletPM" value="@{
            string walletId = context.Request.MatchedParameters["walletId"];
            return Convert.ToInt32("0x" + walletId.Substring(walletId.Length - 12), 16);
        }" />
        <send-request ignore-error="false" timeout="10" response-variable-name="pmWalletDeleteResponse">
            <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/wallet/{(string)context.Variables["idWalletPM"]}")</set-url>
            <set-method>DELETE</set-method>
            <set-header name="Authorization" exists-action="override">
                <value>@($"Bearer {((JObject)context.Variables["pmSession"])["data"]["sessionToken"].ToString()}")</value>
            </set-header>
        </send-request>
        <!-- END delete wallet -->
        <choose>
            <set-variable name="deleteStatusCode" value="@((IResponse)context.Variables["pmWalletDeleteResponse"]).StatusCode)" />
            <when condition="@(((int)context.Variables["deleteStatusCode"]).StatusCode == 200 || ((int)context.Variables["deleteStatusCode"]).StatusCode == 204)">
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