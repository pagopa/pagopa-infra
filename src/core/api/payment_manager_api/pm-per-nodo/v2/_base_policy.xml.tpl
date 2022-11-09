<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>  
      <!-- addUserReceipt for pm -->
      <set-variable name="transId" value="@(context.Request.OriginalUrl.Query.GetValueOrDefault("transactionId"))" />
      <set-variable name="host" value="${host}" />
      <set-variable name="backend-base-url" value="@($"https://{(string)context.Variables["host"]}/pp-restapi-CD/v2")" />
      <set-variable name="ecommerce_url" value="${ecommerce_ingress_hostname}"/>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
    </inbound>
    <outbound>
      <base />
      <choose>
        <when condition="@(context.Response.StatusCode != 200)">
        <!-- addUserReceipt for ecommerce -->
          <send-request ignore-error="true" timeout="10" response-variable-name="test-transaction" mode="new">
            <set-url> @($"https://{(string)context.Variables["ecommerce_url"]}/pagopa-ecommerce-transactions-service/transactions/{(string)context.Variables["transId"]}/user-receipts")</set-url>
            <set-method>POST</set-method>
            <set-body>
              @{ 
                  string inBody = context.Request.Body.As<string>(preserveContent: true); 
                  return inBody; 
              }
            </set-body>
          </send-request>
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
