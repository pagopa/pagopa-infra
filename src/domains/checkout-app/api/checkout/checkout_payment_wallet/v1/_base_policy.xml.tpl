<policies>
  <inbound>
      <cors>
        <allowed-origins>
          <origin>${checkout_origin}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>GET</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
          <header>Authorization</header>
          <header>lang</header>
        </allowed-headers>
      </cors>
      <base />
      <set-variable name="authToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
      <choose>
        <when condition="@(((string)(context.Variables["authToken"])).Equals(""))">
        <return-response>
          <set-status code="401" reason="Unauthorized" />
        </return-response>
        </when>
      </choose>
      <rate-limit-by-key calls="10" renewal-period="5" counter-key="@(context.Request.Headers.GetValueOrDefault("Authorization",""))" />
      <!-- use same threshold as for other checkout api's for IP rate limits -->
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-header name="X-Client-Id" exists-action="override" >
        <value>CHECKOUT</value>
      </set-header>
      <set-variable name="walletOperationId" value="getCheckoutPaymentWalletsByIdUser" />
      <choose>
        <when condition="@(Array.Exists(context.Variables.GetValueOrDefault("walletOperationId","").Split(','), operations => operations == context.Operation.Id))">
          <set-header name="x-api-key" exists-action="override">
            <value>{{payment-wallet-service-rest-api-key}}</value>
          </set-header>
          <set-backend-service base-url="@("https://${hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-wallet-service")" />
        </when>
      </choose>

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
      <set-header name="x-user-id" exists-action="override">
          <value>@((string)((JObject)context.Variables["userResponseJson"])["userId"])</value>
      </set-header>
      <!-- pass x-user-id into header END-->

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
