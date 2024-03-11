<policies>
    <inbound>
        <base />
        <choose>
        <when condition="@("true".Equals("${ecommerce_io_with_pm_enabled}"))">
            <set-variable  name="sessionToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
            <set-variable name="requestTransactionId" value="@{
                var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
                return transactionId;
            }" />
            <send-request ignore-error="false" timeout="10" response-variable-name="pagopaProxyCcpResponse">
                <set-url>@("{{pagopa-appservice-proxy-url}}/payment-activations/" + context.Variables["requestTransactionId"])</set-url>
                <set-method>GET</set-method>
                <set-header name="X-Client-Id" exists-action="override">
                    <value>CLIENT_IO</value>
                </set-header>
            </send-request>
            <set-variable name="pagopaProxyCcpResponseHttpResponseCode" value="@((int)((IResponse)context.Variables["pagopaProxyCcpResponse"]).StatusCode)" />
            <set-variable name="pagopaProxyResponseBody" value="@(((IResponse)context.Variables["pagopaProxyCcpResponse"]).Body.As<JObject>())" />
            <choose>
                <when condition="@((int)context.Variables["pagopaProxyCcpResponseHttpResponseCode"] == 200)">
                    <send-request ignore-error="true" timeout="10" response-variable-name="pmActionsDeleteResponse">
                        <set-url>@("{{pm-host}}/pp-restapi-CD/v1/payments/" + ((JObject)context.Variables["pagopaProxyResponseBody"])["idPagamento"])</set-url>
                        <set-method>DELETE</set-method>
                        <set-header name="Authorization" exists-action="override">
                            <value>@("Bearer " + (string)context.Variables["sessionToken"])</value>
                        </set-header>
                    </send-request>
                    <choose>
                        <when condition="@((int)context.Variables["pmActionsDeleteResponse"] == 200 || (int)context.Variables["pmActionsDeleteResponse"] == 204)">
                            <return-response>
                                <set-status code="202" reason="Accepted" />
                            </return-response>
                        </when>
                        <when condition="@((int)context.Variables["pmActionsDeleteResponse"] == 401)">
                        <return-response>
                            <set-status code="401" reason="Unathorized" />
                        </return-response>
                    </when>
                        <otherwise>
                            <return-response>
                                <set-status code="502" reason="Bad Gateway" />
                            </return-response>
                        </otherwise>
                    </choose>
                </when>
                <otherwise>
                    <return-response>
                        <set-status code="404" reason="Not found" />
                        <set-header name="Content-Type" exists-action="override">
                            <value>application/json</value>
                        </set-header>
                        <set-body>{
                                "title": "Unable to found transaction",
                                "status": 404,
                                "detail": "Transaction not found",
                            }</set-body>
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
</policies>