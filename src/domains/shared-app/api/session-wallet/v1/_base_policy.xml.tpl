<policies>
    <inbound>
      <base />
      <set-variable name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <!-- Get User IO : START-->
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
                        "detail": "There was an error while getting user info"
                    }
                </set-body>
            </return-response>
        </when>
      </choose>
      <set-variable name="userAuthBody" value="@(((IResponse)context.Variables["user-auth-body"]).Body.As<JObject>())" />
      <set-variable name="userFiscalCode" value="@((string)((JObject)context.Variables["userAuthBody"])["fiscal_code"])" />
      <!-- Get User IO : END-->

      <!-- user fiscal code tokenization with PDV START -->
      <!-- Post Token PDV : START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
        <set-url>${pdv_api_base_path}/tokens</set-url>
        <set-method>PUT</set-method>
        <set-header name="x-api-key" exists-action="override">
            <value>{{wallet-session-personal-data-vault-api-key}}</value>
        </set-header>
        <set-body>@{
          return new JObject(
                  new JProperty("pii", (string)context.Variables["userFiscalCode"])
              ).ToString();
            }</set-body>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
              <set-body>
              {
                  "title": "Error starting session",
                  "status": 502,
                  "detail": "Error during fiscal code tokenization"
              }
          </set-body>
          </return-response>
        </when>
      </choose>
      <!-- used as jwt claims  https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-token-claims -->
      <set-variable name="userId" value="@((string)(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())["token"])" />
      <choose>
        <when condition="@(String.IsNullOrEmpty((string)context.Variables["userId"]))">
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
      <!-- Post Token PDV : END-->
      <!-- user fiscal code tokenization with PDV END -->

      <!-- user email tokenization with PDV START -->
      <send-request ignore-error="true" timeout="10" response-variable-name="pdv-email-token" mode="new">
        <set-url>${pdv_api_base_path}/tokens</set-url>
        <set-method>PUT</set-method>
        <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-personal-data-vault-api-key}}</value>
        </set-header>
        <set-body>@{
          JObject userAuthBody = (JObject)context.Variables["userAuthBody"];
          string spidEmail = (String)userAuthBody["spid_email"];
          string noticeEmail = (String)userAuthBody["notice_email"];
          string email = String.IsNullOrEmpty(noticeEmail) ? spidEmail : noticeEmail;
          return new JObject(
                  new JProperty("pii",  email)
              ).ToString();
            }</set-body>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["pdv-email-token"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>

      <set-variable name="email" value="@((string)(((IResponse)context.Variables["pdv-email-token"]).Body.As<JObject>())["token"])" />

      <!-- user email tokenization with PDV END -->

      <!-- pagoPA platform wallet JWT session token : START -->
      <!-- Token JWT START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="x-jwt-token" mode="new">
          <set-url>https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/tokens</set-url>
          <set-method>POST</set-method>
          <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
          </set-header>
          <set-body>@{
          String userId = ((string)context.Variables.GetValueOrDefault("userId",""));
          string email = (string) context.Variables["email"];
          return new JObject(
                  new JProperty("audience", "iosession"),
                  new JProperty("duration", 1200),
                  new JProperty("privateClaims", new JObject(
                      new JProperty("email", email),
                      new JProperty("userId", userId)
                  ))
              ).ToString();
          }</set-body>
      </send-request>
      <choose>
          <when condition="@(((IResponse)context.Variables["x-jwt-token"]).StatusCode != 200)">
              <return-response>
                  <set-status code="502" reason="Bad Gateway" />
              </return-response>
          </when>
      </choose>
      <!-- Token JWT END-->
      <!-- pagoPA platform wallet JWT session token : END -->
      <return-response>
          <set-status code="201" />
          <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
          </set-header>
          <set-body>@{ return ((IResponse)context.Variables["x-jwt-token"]).Body.As<string>();; }</set-body>
      </return-response>
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
