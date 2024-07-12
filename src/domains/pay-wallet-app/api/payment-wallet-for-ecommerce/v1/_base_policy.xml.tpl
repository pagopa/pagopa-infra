<policies>
    <inbound>
      <base />
      <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" caching-type="internal" />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-backend-service base-url="@("https://${hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-wallet-service")" />
    </inbound>
    <outbound>
      <base />
        <cache-store duration="300" /> <!-- 5 minutes-->
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
