<policies>
    <inbound>
      <base />
      <choose>
        <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))">
          <!-- Do we need this checking -->
          <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
          <send-request ignore-error="true" timeout="10" response-variable-name="checkSessionResponse" mode="new">
            <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/check-session?sessionToken={(string)context.Variables["sessionToken"]}")</set-url>
            <set-method>GET</set-method>
            <set-header name="Authorization" exists-action="override">
              <value>@("Bearer " + (string)context.Variables["sessionToken"])</value>
            </set-header>
          </send-request>
          <choose>
            <when condition="@(((IResponse)context.Variables["checkSessionResponse"]).StatusCode == 401)">
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
            <when condition="@(((IResponse)context.Variables["checkSessionResponse"]).StatusCode != 200)">
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

        </when>
        <otherwise>
          <!-- Delete headers required for backend service START -->
          <set-header name="x-user-id" exists-action="delete" />
          <set-header name="x-client-id" exists-action="delete" />
          <!-- Delete headers required for backend service END -->
    
          <!-- Check JWT START-->
          <include-fragment fragment-id="jwt-chk-wallet-session" />
          <!-- Check JWT END-->
          <!-- Headers settings required for backend service START -->
          <set-header name="x-user-id" exists-action="override">
              <value>@((string)context.Variables.GetValueOrDefault("xUserId",""))</value>
          </set-header>
          <set-header name="x-client-id" exists-action="override" >
            <value>IO</value>
          </set-header>
          <!-- Headers settings required for backend service END -->
          <set-backend-service base-url="https://${hostname}/pagopa-wallet-service" />
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
