<policies>
    <inbound>
    <base />
        <choose>
            <when condition="@("PM".Equals("{{ecommerce-for-io-pm-npg-ff}}") || ("NPGFF".Equals("{{ecommerce-for-io-pm-npg-ff}}") && !"{{pay-wallet-family-friends-user-ids}}".Contains(((string)context.Variables["sessionTokenUserId"]))))"> 
                <!-- START payment status wallet -->
                <set-variable name="requestBody" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
                <set-variable name="idWalletPM" value="@{
                    string walletId = context.Request.MatchedParameters["walletId"];
                    return Convert.ToInt32("0x" + walletId.Substring(walletId.Length - 12), 16).ToString();
                }" />
                <send-request ignore-error="false" timeout="10" response-variable-name="pmWalletStatusResponse">
                    <set-url>@($"{{pm-host}}/pp-restapi-CD/v2/wallet/{(string)context.Variables["idWalletPM"]}/payment-status")</set-url>
                    <set-method>PUT</set-method>
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-header name="Authorization" exists-action="override">
                        <value>@($"Bearer {((String)context.Variables["sessionToken"])}")</value>
                    </set-header>
                    <set-body>@{
                        JObject requestBody = (JObject)context.Variables["requestBody"]; 
                        JArray applications = (JArray)requestBody["applications"];
                        foreach(JObject application in applications){
                            String name = application["name"].ToString();
                            String status = application["status"].ToString();
                            if(name.Equals("PAGOPA")) {
                                return new JObject(
                                new JProperty("data", new JObject(
                                new JProperty("pagoPA", status.Equals("ENABLED"))
                                ))
                                ).ToString(); 
                            }
                        }
                        return new JObject().ToString();
                }</set-body>
                </send-request>
                <!-- END payment status wallet -->
                <set-variable name="updateStatusCode" value="@(((IResponse)context.Variables["pmWalletStatusResponse"]).StatusCode)" />
                <choose>
                    <when condition="@(((int)context.Variables["updateStatusCode"]) == 200 || ((int)context.Variables["updateStatusCode"]) == 201)">
                        <return-response>
                            <set-status code="204" reason="No content" />
                        </return-response>
                    </when>     
                    <when condition="@(((int)context.Variables["updateStatusCode"]) == 401)">
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
                    <when condition="@(((int)context.Variables["updateStatusCode"]) == 403)">
                        <return-response>
                            <set-status code="403" reason="Forbidden" />
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/json</value>
                            </set-header>
                            <set-body>
                                {
                                "title": "Forbidden",
                                "status": 403,
                                "detail": "Forbidden"
                                }
                            </set-body>
                        </return-response>
                    </when>
                    <when condition="@(((int)context.Variables["updateStatusCode"]) == 404)">
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
                                "title": "Error changing wallet status",
                                "status": 502,
                                "detail": "There was an error changing wallet status"
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