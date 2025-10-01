<policies>

  <inbound>
      <cors>
        <allowed-origins>
          <origin>*</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
          <header>Authorization</header>
          <header>lang</header>
          <header>x-correlation-id</header>
          <header>x-client-id-from-client</header>
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
      <rate-limit-by-key calls="10" renewal-period="5" counter-key="@((string) context.Variables["authToken"])" />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <set-variable name="allowedClientIdFromClient" value="IO" />
      <set-variable name="clientIdFromClient" value="@((string)context.Request.Headers.GetValueOrDefault("x-client-id-from-client",""))" />
      <choose>
        <when condition="@{
          HashSet<string> allowedClientIds = new HashSet<String>(((string)context.Variables["allowedClientIdFromClient"]).Split(','));
            string clientIdFromClient = (string)context.Variables.GetValueOrDefault("clientIdFromClient","");
            return allowedClientIds.Contains(clientIdFromClient);
        }">
            <set-header name="x-client-id" exists-action="override">
                <value>@((string)context.Variables["clientIdFromClient"])</value>
            </set-header>
        </when>
        <otherwise>
            <return-response>
                <set-status code="400" reason="Bad request" />
                <set-body template="liquid">
                {
                    "title": "Invalid input x-client-id-from-client",
                    "status": 400,
                    "detail": "x-client-id-from-client: [{{context.Variables["clientIdFromClient"]}}] is invalid",
                }
                </set-body>
            </return-response>
        </otherwise>
    </choose>
      
    <!-- Set payment-methods API Key header -->
    <set-header name="x-api-key" exists-action="override">
      <value>{{ecommerce-payment-methods-api-key-value}}</value>
    </set-header>
    <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-payment-methods-service")"/>
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
