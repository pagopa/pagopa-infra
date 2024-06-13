<policies>
    <inbound>
      <base />
      <set-variable name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
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

      <!-- pagoPA platform wallet JWT session token : START -->
      <set-variable name="x-jwt-token" value="@(((JObject)context.Variables["pmSession"])["data"]["sessionToken"].ToString())" />
      <!-- pagoPA platform wallet JWT session token : END -->

      <return-response>
          <set-status code="201" />
          <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
          </set-header>
          <set-body>@{ return new JObject(new JProperty("token", (string)context.Variables.GetValueOrDefault("x-jwt-token",""))).ToString(); }
          </set-body>
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