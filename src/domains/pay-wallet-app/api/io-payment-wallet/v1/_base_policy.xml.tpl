<policies>
    <inbound>
      <base />
      <!-- fragment to read user id from session token jwt claims. it return userId as sessionTokenUserId variable taken from jwt claims. if the session token
      is an opaque token a "session-token-not-found" string is returned-->  
      <include-fragment fragment-id="pay-wallet-user-id-from-session-token" />
      <choose>
        <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}") || !"{{pay-wallet-family-friends-user-ids}}".Contains(((string)context.Variables["sessionTokenUserId"])) )">
          <set-variable name="sessionToken" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))" />
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
          <!-- Headers settings required for backend service END -->
          <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
          <set-backend-service base-url="@("https://${hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-wallet-service")" />
        </otherwise>
      </choose>
      <set-header name="x-client-id" exists-action="override" >
        <value>IO</value>
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
