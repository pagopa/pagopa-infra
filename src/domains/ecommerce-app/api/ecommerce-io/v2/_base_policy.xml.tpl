<policies>

  <inbound>
    <base />

    <!-- Delete headers required for backend service START -->
    <set-header name="x-client-id" exists-action="delete" />
    <set-header name="x-user-id" exists-action="delete" />
    <set-header name="x-client-id" exists-action="override">
        <value>IO</value>
    </set-header>
    <!-- Delete headers required for backend service END -->

    <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
    <!-- fragment to read user id from session token jwt claims. it return userId as sessionTokenUserId variable taken from jwt claims. if the session token
             is an opaque token a "session-token-not-found" string is returned-->  
    <include-fragment fragment-id="pay-wallet-user-id-from-session-token" />
    <!-- Session eCommerce START-->
        <choose>
          <when condition="@("false".Equals("{{enable-pm-ecommerce-io}}")  )">
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
          </when>
          <otherwise>
          <!-- Check sessiontoken START-->
            <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
            <send-request ignore-error="true" timeout="10" response-variable-name="checkSessionResponse" mode="new">
              <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/check-session?sessionToken={(string)context.Variables["sessionToken"]}")</set-url>
              <set-method>GET</set-method>
              <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["sessionToken"])</value>
              </set-header>
            </send-request>
            <choose>
              <when condition="@(((int)((IResponse)context.Variables["checkSessionResponse"]).StatusCode) != 200)">
                <return-response>
                  <set-status code="401" reason="Unauthorized" />
                  <set-body>
                    {
                        "status": 401,
                        "title": "Unauthorized",
                        "detail": "Invalid token"
                    }
                  </set-body>
                </return-response>
              </when>
            </choose>
          <!-- Check sessiontoken END-->
          </otherwise>
        </choose>

    <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
    <choose>
      <when condition="@( context.Request.Url.Path.Contains("transactions") )">
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-transactions-service")"/>
      </when>
      <when condition="@( context.Request.Url.Path.Contains("payment-methods") )">
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service")"/>
      </when>
      <when condition="@( context.Request.Url.Path.Contains("payment-requests") )">
        <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-requests-service")"/>
      </when>
      <when condition="@( context.Request.Url.Path.Contains("wallets") )">
        <set-backend-service base-url="@("https://${wallet_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-wallet-service")"/>
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
