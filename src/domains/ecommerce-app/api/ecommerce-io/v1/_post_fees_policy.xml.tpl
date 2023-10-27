<policies>
    <inbound>
        <base />
        <set-variable name="requestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <set-variable name="idWallet" value="(string)context.Variables["requestBody"]["walletId"]" />
        <set-variable name="idPayment" value="(string)context.Variables["requestBody"]["idPayment"]" />
        <set-variable name="language" value="(string)context.Variables["requestBody"]["language"]" />

        <send-request ignore-error="true" timeout="10" response-variable-name="getPspForCardsResponse">
            <set-url>@("{{pm-host}}/pp-restapi-CD/v2/payments/{(string)context.Variables["idPayment"]}/psps?idWallet={(string)context.Variables["idWallet"]}&language={(string)context.Variables["language"]}&isList=true")</set-url>
            <set-method>GET</set-method>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["getPspForCardsResponse"]).StatusCode) == 200)">
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-body>
                        @{
                            JObject eCommerceResponseBody = new JObject();
                            eCommerceResponseBody["transactionId"] = "t";
                            eCommerceResponseBody["status"] = "t";
                            return eCommerceResponseBody.ToString();
                        }
                    </set-body>
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="404" reason="Not found" />
                    <set-body>{
                            "title": "Unable to get get Psps",
                            "status": 404,
                            "detail": "Psps not found",
                        }</set-body>
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
</policies>