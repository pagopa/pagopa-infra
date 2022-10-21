<policies>
    <inbound>
      <base />
      <set-variable name="isBlueDeployment" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue"))" />
      <choose>
          <when condition="@(context.Variables.GetValueOrDefault<bool>("isBlueDeployment"))">
              <set-backend-service base-url="https://${hostname}/beta/pagopa-ecommerce-sessions-service" />
          </when>
          <otherwise>
              <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-sessions-service" />
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
