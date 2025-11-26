<policies>
    <inbound>
      <base />
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
      <set-header name="x-client-id" exists-action="override" >
        <value>IO</value>
      </set-header>
      <set-header name="x-api-key" exists-action="override">
        <value>{{payment-wallet-service-rest-api-key}}</value>
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
