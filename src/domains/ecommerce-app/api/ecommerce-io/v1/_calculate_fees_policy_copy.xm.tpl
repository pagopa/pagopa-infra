<policies>
    <inbound>
        <base />
        <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
        <set-variable name="body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="walletId" value="@((string)((JObject) context.Variables["body"])["walletId"])" />
        <send-request ignore-error="false" timeout="10" response-variable-name="authDataResponse">
            <set-url>@($"https://${wallet-basepath}/pagopa-wallet-service/wallets/{(string)context.Variables["walletId"]}/auth-data")</set-url>
            <set-method>GET</set-method>
            <set-header name="ocp-apim-subscription-key" exists-action="override">
                <value>{{ocp-apim-subscription-key}}</value>
            </set-header>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["authDataResponse"]).StatusCode) == 200)">
                <set-variable name="authDataBody" value="@((JObject)((IResponse)context.Variables["authDataResponse"]).Body.As<JObject>())" />
                <!-- <set-variable name="contractId" value="@((string)((JObject)context.Variables["authDataBody"])["contractId"])" NO NEED FOR THIS MOMENT /> -->
                <set-variable name="bin" value="@((string)((JObject)context.Variables["authDataBody"])["bin"])" />
                <set-body>@{ 
                    var bin = (string)context.Variables["bin"];
                    JObject inBody = (JObject)context.Variables["body"]; 
                    inBody.Remove("walletId");
                    inBody.Remove("paymentToken");
                    inBody.Remove("language");
                    inBody.Add("bin", bin);
                    inBody.Add("touchpint","IO");
                    return inBody.ToString(); 
                }</set-body>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["authDataResponse"]).StatusCode) == 404)">
                <return-response>
                    <set-status code="404" reason="Not found" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
                          "title": "Unable to get auth data",
                          "status": 404,
                          "detail": "Unable to get auth data",
                      }</set-body>
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="502" reason="Bad Request" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
                          "title": "Bad gateway",
                          "status": 502,
                          "detail": "Payment method not found",
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
    <on-error>
        <base />
    </on-error>
</policies>
