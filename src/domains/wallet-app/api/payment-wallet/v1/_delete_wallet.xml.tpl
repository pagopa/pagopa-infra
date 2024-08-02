<policies>
    <inbound>
    <base />
    <set-variable name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
    <!-- Get User IO START
    <send-request ignore-error="true" timeout="10" response-variable-name="user-auth-body" mode="new">
        <set-url>@("${io_backend_base_path}/pagopa/api/v1/user?version=20200114")</set-url> 
        <set-method>GET</set-method>
        <set-header name="Accept" exists-action="override">
          <value>application/json</value>
        </set-header>
        <set-header name="Authorization" exists-action="override">
          <value>@("Bearer " + (string)context.Variables.GetValueOrDefault("walletToken"))</value>
        </set-header>
    </send-request>
    <choose>
      <when condition="@(((IResponse)context.Variables["user-auth-body"]).StatusCode == 401)">
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
      <when condition="@(((IResponse)context.Variables["user-auth-body"]).StatusCode != 200)">
          <return-response>
              <set-status code="502" reason="Bad Gateway" />
              <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
              </set-header>
              <set-body>
                  {
                      "title": "Error starting session",
                      "status": 502,
                      "detail": "There was an error while retrieving user info"
                  }
              </set-body>
          </return-response>
      </when>
    </choose>
    <set-variable name="userAuth" value="@(((IResponse)context.Variables["user-auth-body"]).Body.As<JObject>())" />
    Get User IO END-->
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
                <set-body>{
                      "title": "Unauthorized",
                      "status": 401,
                      "detail": "Invalid session token"
                  }</set-body>
            </return-response>
        </when>
        <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode != 200)">
            <return-response>
                <set-status code="502" reason="Bad Gateway" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>{
                      "title": "Error starting session",
                      "status": 502,
                      "detail": "There was an error starting session for input wallet token"
                  }</set-body>
            </return-response>
        </when>
    </choose>
    <set-variable name="pmSession" value="@(((IResponse)context.Variables["pm-session-body"]).Body.As<JObject>())" />
    <!-- Session PM End -->
    <!-- Post Token PDV START-->
    <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
      <set-url>${pdv_api_base_path}/tokens</set-url>
      <set-method>PUT</set-method>
      <set-header name="x-api-key" exists-action="override">
          <value>{{wallet-personal-data-vault-api-key}}</value>
      </set-header>
      <!-- <set-body>@{
        JObject requestBody = (JObject)context.Variables["userAuth"];
        return new JObject(
                new JProperty("pii",  (string)requestBody["fiscal_code"])
            ).ToString();
          }</set-body> -->
          <set-body>@{
            string fiscalCode = ((JObject)context.Variables["pmSession"])["data"]["user"]["fiscalCode"].ToString();
            
            return new JObject(
                    new JProperty("pii", fiscalCode)
                ).ToString();
              }</set-body>
    </send-request>
    <choose>
      <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
        <return-response>
          <set-status code="502" reason="Bad Gateway" />
        </return-response>
      </when>
    </choose>
    <set-variable name="pdvToken" value="@(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())" />
    <set-variable name="fiscalCodeTokenized" value="@((string)((JObject)context.Variables["pdvToken"])["token"])" />
    <choose>
      <when condition="@(String.IsNullOrEmpty((string)context.Variables["fiscalCodeTokenized"]))">
          <return-response>
              <set-status code="502" />
              <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
              </set-header>
              <set-body>@{
          return new JObject(
            new JProperty("title", "Bad gateway - Invalid PDV response"),
            new JProperty("status", 502),
            new JProperty("detail", "Cannot tokenize fiscal code")
          ).ToString();
        }</set-body>
          </return-response>
      </when>
    </choose>
    <!-- Post Token PDV END-->
    <set-header name="x-user-id" exists-action="override">
        <value>@((string)context.Variables.GetValueOrDefault("fiscalCodeTokenized",""))</value>
    </set-header>
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