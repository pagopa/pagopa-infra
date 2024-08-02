<policies>

  <inbound>
      <base />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-requests-service")"/>
      <set-header name="x-client-id" exists-action="override">
        <value>WISP_REDIRECT</value>
      </set-header>
  </inbound>

  <outbound>
      <base />
      <choose>
        <when condition="@(context.Response.StatusCode == 302)">
            <set-status code="200" />
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>
                @{
                    return new JObject(
                        new JProperty(
                            "checkoutRedirectUrl", 
                            (string)context.Response.Headers.GetValueOrDefault("Location","")
                        )
                    ).ToString();
                }
            </set-body>
        </when>
    </choose>
  </outbound>

  <backend>
      <base />
  </backend>

  <on-error>
      <base />
  </on-error>

</policies>
