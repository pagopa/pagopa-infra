<policies>
    <inbound>
      <base />
      <choose>
        <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))">
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
