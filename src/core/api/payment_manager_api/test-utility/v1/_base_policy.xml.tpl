<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="100" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
      <!-- Test login START
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
       Test login END-->
      <!-- Test Session PM START
      <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
          <set-url>@($"https://api.uat.platform.pagopa.it/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletTokenTest"]}")</set-url>
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
      Test Session PM END-->
      <!-- Test get idPayment START-->
      <set-variable name="noticeCode" value="@((string)(new Random(context.RequestId.GetHashCode()).Next(000000000, 999999999) ).ToString())" />
      <set-variable name="cfPA" value="77777777777" />
      <set-variable name="ccp" value="@(Guid.NewGuid().ToString().Replace("-",""))" />
      <send-request ignore-error="true" timeout="10" response-variable-name="activate-body" mode="new">
          <set-url>https://api.uat.platform.pagopa.it/checkout/auth/payments/v2/payment-activations</set-url>
          <set-method>POST</set-method>
          <set-header name="Content-Type" exists-action="override">
             <value>application/json</value>
          </set-header>
          <set-header name="ocp-apim-subscription-key" exists-action="override">
              <value>{{checkout-v2-testing-api-key}}</value>
          </set-header>
          <set-body>@{
                      return new JObject(
                              new JProperty("rptId", (string)context.Variables["cfPA"] + "302001000" +(string)context.Variables["noticeCode"]),
                              new JProperty("importoSingoloVersamento", 120000),
                              new JProperty("codiceContestoPagamento", (string)context.Variables["ccp"])
                            ).ToString();
                    }
          </set-body>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["activate-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <send-request ignore-error="true" timeout="10" response-variable-name="get-activate-body" mode="new">
          <set-url>@($"https://api.uat.platform.pagopa.it/checkout/auth/payments/v2/payment-activations/{(string)context.Variables["ccp"]}")</set-url>
          <set-method>GET</set-method>
          <set-header name="ocp-apim-subscription-key" exists-action="override">
              <value>{{checkout-v2-testing-api-key}}</value>
          </set-header>
      </send-request>
       <choose>
        <when condition="@(((IResponse)context.Variables["get-activate-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="get-activate-response" value="@(((IResponse)context.Variables["get-activate-body"]).Body.As<JObject>())" />
      <!-- Test get idPayment END-->
      <return-response>
              <set-status code="200" />
              <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
              </set-header>
              <set-body>@{
                  return new JObject(
                          // new JProperty("sessionToken", (string) ((JObject)((JObject) context.Variables["pmSessionTest"])["data"])["sessionToken"]),
                          new JProperty("idPayment", (string)((JObject) context.Variables["get-activate-response"])["idPagamento"]),
                          new JProperty("wisp", $"https://uat.wisp2.pagopa.gov.it/wallet/welcome?idSession={((string)((JObject) context.Variables["get-activate-response"])["idPagamento"])}")
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
