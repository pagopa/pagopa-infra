<policies>
    <inbound>
      <!-- <base /> --> <!-- to avoid Nuova Connettività policy  -->
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-backend-service base-url="@("https://${aca_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-aca-service")"/>
    </inbound>
    <outbound>
      <!-- <base /> --> <!-- to avoid Nuova Connettività policy  -->
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <!-- <base /> --> <!-- to avoid Nuova Connettività policy  -->
    </on-error>
  </policies>
