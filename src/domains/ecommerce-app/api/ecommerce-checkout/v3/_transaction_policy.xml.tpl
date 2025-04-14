<policies>
    <inbound>
        <base />

        <!-- custom token validate and store userId variable START -->
        <send-request ignore-error="true" timeout="10" response-variable-name="userResponse" mode="new">
            <set-url>@($"https://${checkout_ingress_hostname}/pagopa-checkout-auth-service/auth/users")</set-url>
            <set-method>GET</set-method>
            <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["authToken"])</value>
            </set-header>
            <set-header name="x-rpt-ids" exists-action="override">
                <value>@((string)context.Request.Headers.GetValueOrDefault("x-rpt-ids",""))</value>
            </set-header>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["userResponse"]).StatusCode) == 401 || ((int)((IResponse)context.Variables["userResponse"]).StatusCode) == 404)">
            <return-response>
                <set-status code="401" reason="Unauthorized" />
            </return-response>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["userResponse"]).StatusCode) == 500)">
            <return-response>
                <set-status code="502" reason="Internal server error" />
                <set-body>
                {
                    "status": 502,
                    "title": "Internal server error",
                    "detail": "Error in token validation"
                }
                </set-body>
            </return-response>
            </when>
            <when condition="@(((int)((IResponse)context.Variables["userResponse"]).StatusCode) != 200)">
            <return-response>
                <set-status code="502" reason="Internal server error" />
                <set-body>
                {
                    "status": 502,
                    "title": "Internal server error",
                    "detail": "Unexpected error in token validation"
                }
                </set-body>
            </return-response>
            </when>
            <otherwise>
                <set-variable name="userResponseJson" value="@(((IResponse)context.Variables["userResponse"]).Body.As<JObject>())" />
            </otherwise>
        </choose>

        <!-- custom token validate and store userId variable END -->

        <!-- pass x-user-id into header START-->
        <!-- Post Token PDV for CF START-->
        <send-request ignore-error="true" timeout="10" response-variable-name="cf-token" mode="new">
            <set-url>${pdv_api_base_path}/tokens</set-url>
            <set-method>PUT</set-method>
            <set-header name="x-api-key" exists-action="override">
                <value>{{wallet-session-personal-data-vault-api-key}}</value>
            </set-header>
            <set-body>@(new JObject(new JProperty("pii",  (((JObject)context.Variables["userResponseJson"])["userId"]))).ToString())</set-body>
        </send-request>
        <choose>
            <when condition="@(((IResponse)context.Variables["cf-token"]).StatusCode != 200)">
                <return-response>
                    <set-status code="502" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                    {
                        "title" : "Bad gateway - Invalid PDV response",
                        "status":  502,
                        "detail":  "Cannot tokenize fiscal code"
                    }
                    </set-body>
                </return-response>
            </when>
        </choose>
        <!-- Post Token PDV for CF END-->
        <set-variable name="cfToken" value="@(((IResponse)context.Variables["cf-token"]).Body.As<JObject>())" />
        <set-variable name="xUserId" value="@((string)((JObject)context.Variables["cfToken"])["token"])" />
        <set-header name="x-user-id" exists-action="override">
            <value>@((String)context.Variables["xUserId"])</value>
        </set-header>
        <!-- pass x-user-id into header END-->

        <!-- Post Token PDV for email START-->
        <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
            <set-url>${pdv_api_base_path}/tokens</set-url>
            <set-method>PUT</set-method>
            <set-header name="x-api-key" exists-action="override">
                <value>{{ecommerce-personal-data-vault-api-key}}</value>
            </set-header>
            <set-body>@{
            JObject requestBody = (JObject)context.Request.Body.As<JObject>(true);
            return new JObject(
                    new JProperty("pii",  (string)requestBody["email"])
                ).ToString();
                }</set-body>
        </send-request>
        <choose>
            <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
                <return-response>
                    <set-status code="502" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>
                    {
                        "title" : "Bad gateway - Invalid PDV response",
                        "status":  502,
                        "detail":  "Cannot tokenize email"
                    }
                    </set-body>
                </return-response>
            </when>
        </choose>

        <set-variable name="pdvToken" value="@(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())" />
        <set-variable name="emailToken" value="@((string)((JObject)context.Variables["pdvToken"])["token"])" />
        <!-- Post Token PDV for email END-->
        <set-body>@{
            JObject requestBody = (JObject)context.Request.Body.As<JObject>(true);
            string emailToken = (string) context.Variables["emailToken"];

            requestBody.Remove("email");
            requestBody["emailToken"] = emailToken;

            return requestBody.ToString();
        }
        </set-body>
        <set-variable name="allowedClientIdFromClient" value="CHECKOUT,CHECKOUT_CART,WISP_REDIRECT" />
        <set-variable name="clientIdFromClient" value="@((string)context.Request.Headers.GetValueOrDefault("x-client-id-from-client","CHECKOUT"))" />
        <choose>
            <when condition="@{
            HashSet<string> allowedClientIds = new HashSet<String>(((string)context.Variables["allowedClientIdFromClient"]).Split(','));
            string clientIdFromClient = (string)context.Variables.GetValueOrDefault("clientIdFromClient","");
            return allowedClientIds.Contains(clientIdFromClient);
            }">
                <set-header name="x-client-id" exists-action="override">
                    <value>@((string)context.Variables["clientIdFromClient"])</value>
                </set-header>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="400" reason="Bad request" />
                    <set-body template="liquid">
                    {
                        "title": "Invalid input x-client-id-from-client",
                        "status": 400,
                        "detail": "x-client-id-from-client: [{{context.Variables["clientIdFromClient"]}}] is invalid",
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
