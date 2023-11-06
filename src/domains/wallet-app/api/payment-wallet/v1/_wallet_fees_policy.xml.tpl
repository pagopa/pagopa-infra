<policies>
    <inbound>
     <base />
        <!-- TODO check payment method according to bpay e PPAY - to define -->
        <set-variable  name="walletToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
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
        <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="walletId" value="@(context.Request.MatchedParameters["walletId"])" />
        <set-variable name="idWallet" value="@{
                string walletIdUUID = (string)context.Variables["walletId"];
                string walletIdHex = walletIdUUID.Substring(walletIdUUID.Length-17 , 17).Replace("-" , ""); 
                return Convert.ToInt64(walletIdHex , 16).ToString();
           }" />
        <set-variable name="idPayment" value="@((string)((JObject) context.Variables["body"])["paymentToken"])" />
        <set-variable name="language" value="@((string)((JObject) context.Variables["body"])["language"])" />
        <send-request ignore-error="true" timeout="10" response-variable-name="getPspForCardsResponse">
            <set-url>@($"{{pm-host}}/pp-restapi-CD/v2/payments/{(string)context.Variables["idPayment"]}/psps?idWallet={(string)context.Variables["idWallet"]}&language={(string)context.Variables["language"]}&isList=true")</set-url>
            <set-method>GET</set-method>
            <set-header name="Authorization" exists-action="override">
                 <value>@($"Bearer {((JObject)context.Variables["pmSession"])["data"]["sessionToken"].ToString()}")</value>
            </set-header>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["getPspForCardsResponse"]).StatusCode) == 200)">
                <set-variable name="pmPspsResponse" value="@(((IResponse)context.Variables["getPspForCardsResponse"]).Body.As<JObject>(preserveContent: true))" />
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-body>@{
                            JArray psps = (JArray)(((JObject)context.Variables["pmPspsResponse"])["data"]);
                            JObject response = new JObject();
                            JArray pspResponse = new JArray();
                            foreach (JObject pmPsp in psps) {
                                JObject psp = new JObject();
                                psp["abi"] = pmPsp["codiceAbi"];
                                psp["bundleName"] = pmPsp["ragioneSociale"];
                                psp["idPsp"] = pmPsp["idPsp"];
                                psp["idBundle"] = pmPsp["id"];
                                psp["taxPayerFee"] = pmPsp["fee"];
                                pspResponse.Add(psp);
                            }
                            response["paymentMethodName"] = "CARDS";
                            response["paymentMethodDescription"] = "Carte di credito o debito";
                            response["paymentMethodStatus"] = "ENABLED";
                            response["belowThreshold"] = "false";
                            response["bundles"] = (JArray)pspResponse;
                            return response.ToString();
                        }</set-body>
                </return-response>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["getPspForCardsResponse"]).StatusCode) == 401)">
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="404" reason="Not found" />
                    <set-body>{
                            "title": "Unable to get Psps",
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