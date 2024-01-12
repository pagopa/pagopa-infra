<policies>
    <inbound>
        <base />
        <set-header name="x-pgs-id" exists-action="delete" />
        <set-header name="x-pgs-id" exists-action="override">
            <value>NPG</value>
        </set-header>
        <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
        <choose>
            <when condition="@("true".Equals("${ecommerce_io_with_pm_enabled}"))">
                <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
                <set-variable name="walletId" value="@((string)((JObject) context.Variables["body"])["details"]["walletId"])" />
                <set-variable name="idPsp" value="@((string)((JObject) context.Variables["body"])["pspId"])" />
                <set-variable name="idWallet" value="@{
                    string walletIdUUID = (string)context.Variables["walletId"];
                    string walletIdHex = walletIdUUID.Substring(walletIdUUID.Length-17 , 17).Replace("-" , "");
                    return Convert.ToInt64(walletIdHex , 16).ToString();
                }" />
                <set-variable name="requestTransactionId" value="@{
                var transactionId = context.Request.MatchedParameters.GetValueOrDefault("transactionId","");
                return transactionId;
            }" />
                <!-- Check wallet type to call or not putWallet. To do only when wallet type is credit card -->
                <send-request response-variable-name="wallet" timeout="10">
                    <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/wallet/{(string)context.Variables["idWallet"]}")</set-url>
                    <set-method>GET</set-method>
                    <set-header name="Authorization" exists-action="override">
                        <value>@($"Bearer {(string)context.Variables.GetValueOrDefault("sessionToken","")}")</value>
                    </set-header>
                </send-request>
                <choose>
                    <when condition="@(((int)((IResponse)context.Variables["wallet"]).StatusCode) == 200)">
                        <set-variable name="walletBody" value="@((JObject)((IResponse)context.Variables["wallet"]).Body.As<JObject>())" />
                        <set-variable name="walletType" value="@((string)((JObject) context.Variables["walletBody"])["data"]["type"])" />
                    </when>
                    <otherwise>
                        <return-response>
                            <set-status code="502" reason="Bad gateway" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>{
                                "title": "Unable to get wallet type",
                                "status": 502,
                                "detail": "Unable to get wallet type",
                            }</set-body>
                        </return-response>
                    </otherwise>
                </choose>
                <!-- Check ccp/idPagamento given transactionId -->
                <send-request response-variable-name="pagopaProxyResponse" timeout="10">
                    <set-url>@("{{pagopa-appservice-proxy-url}}/payment-activations/" + context.Variables["requestTransactionId"])</set-url>
                    <set-method>GET</set-method>
                    <set-header name="X-Client-Id" exists-action="override">
                        <value>CLIENT_IO</value>
                    </set-header>
                </send-request>
                <choose>
                    <when condition="@(((int)((IResponse)context.Variables["pagopaProxyResponse"]).StatusCode) == 200)">
                        <set-variable name="idPayment" value="@((string)((IResponse)context.Variables["pagopaProxyResponse"]).Body.As<JObject>()["idPagamento"])" />
                        <choose>
                            <when condition="@((string)(context.Variables["walletType"]) == "CREDIT_CARD")">
                                <set-variable name="putWalletRequest" value="@{
                                JObject response = new JObject();
                                JObject data = new JObject();
                                data["idWallet"] = long.Parse((string)context.Variables["idWallet"]);
                                data["idPsp"] = long.Parse((string)context.Variables["idPsp"]);
                                data["idPagamentoFromEC"] = $"{(string)context.Variables["idPayment"]}";
                                response["data"] = data;
                                return response.ToString();
                                }" />
                                <send-request ignore-error="true" timeout="10" response-variable-name="putWalletForPsp">
                                    <set-url>@($"{{pm-host}}/pp-restapi-CD/v2/wallet/{(string)context.Variables["idWallet"]}")</set-url>
                                    <set-method>PUT</set-method>
                                    <set-header name="Authorization" exists-action="override">
                                        <value>@($"Bearer {(string)context.Variables.GetValueOrDefault("sessionToken","")}")</value>
                                    </set-header>
                                    <set-header name="Content-Type" exists-action="override">
                                        <value>application/json</value>
                                    </set-header>
                                    <set-body>@((string)context.Variables["putWalletRequest"])</set-body>
                                </send-request>
                                <choose>
                                    <when condition="@(((int)((IResponse)context.Variables["putWalletForPsp"]).StatusCode) != 200)">
                                        <return-response>
                                            <set-status code="502" reason="Bad gateway" />
                                            <set-header name="Content-Type" exists-action="override">
                                                <value>application/json</value>
                                            </set-header>
                                            <set-body>{
                                        "title": "Unable to set Psp",
                                        "status": 502,
                                        "detail": "Unable to set Psp",
                                    }</set-body>
                                        </return-response>
                                    </when>
                                </choose>
                            </when>
                        </choose>
                        <!-- Return url to execute PM webview -->
                        <return-response>
                            <set-status code="200" reason="OK" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>@{
                            JObject response = new JObject();
                            response["authorizationUrl"] = $"https://${authurl-basepath}/ecommerce/io-webview/v1/pay?transactionId={(string)context.Variables["requestTransactionId"]}#idWallet={(string)context.Variables["idWallet"]}&idPayment={(string)context.Variables["idPayment"]}&sessionToken={(string)context.Variables["sessionToken"]}&language=IT";
                            response["authorizationRequestId"] = (string)context.Variables["requestTransactionId"];
                            return response.ToString();
                        }</set-body>
                        </return-response>
                    </when>
                    <otherwise>
                        <return-response response-variable-name="existing context variable">
                            <set-status code="404" reason="Not found" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>{
                                "title": "Unable to execute auth request",
                                "status": 404,
                                "detail": "Transaction not found",
                            }</set-body>
                        </return-response>
                    </otherwise>
                </choose>
            </when>
            <otherwise>
              <set-body>@{
                  JObject requestBody = context.Request.Body.As<JObject>(preserveContent: true);
                  var walletId = requestBody["walletId"];
                  JObject requestBodyDetails = null;
                  if(walletId != null){
                      requestBody.Remove("walletId");
                      requestBodyDetails=new JObject(
                          new JProperty("detailType", "wallet"),
                          new JProperty("walletId", requestBody["walletId"])
                      );
                  }else{
                      requestBodyDetails=new JObject(
                          new JProperty("detailType", "apm"),
                          new JProperty("walletId", requestBody["walletId"])
                      );
                  }
                  requestBody["details"] = requestBodyDetails;
                  return requestBody.ToString();
              }</set-body>
            </otherwise>
        </choose>
    </inbound>
    <outbound>
        <base />
        <choose>
            <when condition="@("false".Equals("${ecommerce_io_with_pm_enabled}") && context.Response.StatusCode == 200)">
                <set-body>@{
                    JObject inBody = context.Response.Body.As<JObject>(preserveContent: true);
                    var authorizationUrl = (string)inBody["authorizationUrl"];
                    if(authorizationUrl.Contains("checkout.pagopa.it")){
                        authorizationUrl = authorizationUrl + "&sessionToken=" + ((string)context.Variables.GetValueOrDefault("sessionToken",""));
                    }
                    inBody["authorizationUrl"] = authorizationUrl;
                    return inBody.ToString();
                }</set-body>
            </when>
        </choose>
    </outbound>
    <backend>
        <base />
    </backend>
    <on-error>
        <base />
    </on-error>
</policies>
