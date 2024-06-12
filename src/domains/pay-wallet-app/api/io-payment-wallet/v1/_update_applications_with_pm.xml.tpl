<policies>
    <inbound>
    <!-- Session PM START-->
    <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
        <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletToken"]}")</set-url>
        <set-method>GET</set-method>
    </send-request>
    <choose>
        <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode == 401)">
            <return-response>
                <set-status code="401" reason="Unauthorized" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>
                    {
                        "title": "Unauthorized",
                        "status": 401,
                        "detail": "Invalid session token"
                    }
                </set-body>
            </return-response>
        </when>
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
            <value>@($"Bearer {((JObject)context.Variables["pmSession"])["data"]["sessionToken"].ToString()}")</value>
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