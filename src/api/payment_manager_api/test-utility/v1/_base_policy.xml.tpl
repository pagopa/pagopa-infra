<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="100" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
      <!-- Test login START-->
      <set-variable name="userPMTest" value="{{user-pm-test}}" />
      <set-variable name="passwordPMTest" value="{{password-pm-test}}" />
      <send-request ignore-error="true" timeout="10" response-variable-name="test-login-body" mode="new">
          <set-url>https://app-backend.io.italia.it/test-login</set-url>
          <set-method>POST</set-method>
          <set-header name="Content-Type" exists-action="override">
             <value>application/json</value>
          </set-header>
          <set-body>@{
                      return new JObject(
                              new JProperty("username", (string)context.Variables["userPMTest"]),
                              new JProperty("password", (string)context.Variables["passwordPMTest"])
                            ).ToString();
                    }
          </set-body>
      </send-request>
      <set-variable name="test-login-response" value="@(((IResponse)context.Variables["test-login-body"]).Body.As<JObject>())" />
      <choose>
        <when condition="@(((IResponse)context.Variables["test-login-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
            </return-response>
        </when>
      </choose> 
      <send-request ignore-error="true" timeout="10" response-variable-name="session-body" mode="new">
          <set-url>https://app-backend.io.italia.it/api/v1/session</set-url>
          <set-method>GET</set-method>
          <set-header name="Authorization" exists-action="override">
             <value>@($"Bearer {(string) ((JObject) context.Variables["test-login-response"])["token"]}")</value>
          </set-header>
      </send-request>
      <set-variable name="session-response" value="@(((IResponse)context.Variables["session-body"]).Body.As<JObject>())" />
      <choose>
        <when condition="@(((IResponse)context.Variables["session-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="walletTokenTest" value="@((string) ((JObject) context.Variables["session-response"])["walletToken"])" />
      <!-- Test login END-->
      <!-- Test Session PM START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
          <set-url>@($"https://acardste.vaservices.eu/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletTokenTest"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
       <choose>
        <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="pmSessionTest" value="@(((IResponse)context.Variables["pm-session-body"]).Body.As<JObject>())" />
      <!-- Test Session PM END-->
      <!-- Test get idPayment START-->

      <!-- Test get idPayment START-->
      <return-response>
              <set-status code="200" />
              <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
              </set-header>
              <set-body>@{
                  return new JObject(
                          new JProperty("sessionToken", (string) ((JObject)((JObject) context.Variables["pmSessionTest"])["data"])["sessionToken"])
                      ).ToString();
             }</set-body>
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
