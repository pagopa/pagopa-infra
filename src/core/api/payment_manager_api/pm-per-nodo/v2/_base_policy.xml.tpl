<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <!-- <address-range from="10.1.128.0" to="10.1.128.255" /> -->
      </ip-filter>  
      <!-- addUserReceipt for pm -->
      <set-variable name="transactionId" value="@(context.Request.MatchedParameters["transactionId"])" />
      <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/v2")" />
      <set-variable name="ecommerce_url" value="${ecommerce_ingress_hostname}"/>
      <set-variable name="body_value" value="@(context.Request.Body.As<string>())" />
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
    </inbound>
    <outbound>
        <set-variable name="body_response" value="@(context.Response.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="outcome" value="@(((string)((JObject)context.Variables["body_response"])["outcome"]))" />
        <base />
        <choose>
            <when condition="@(!((string)context.Variables["outcome"]).Equals("OK"))">
                <!-- addUserReceipt for ecommerce -->
                <send-request ignore-error="true" timeout="10" response-variable-name="test-transaction" mode="new">
                    <set-url>@($"https://{(string)context.Variables["ecommerce_url"]}/pagopa-ecommerce-transactions-service/transactions/{(string)context.Variables["transactionId"]}/user-receipts")</set-url>
                    <set-method>POST</set-method>
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@($"{(string)context.Variables["body_value"]}")</set-body>
                </send-request>
                <!-- <set-variable name="ecommerce_response" value="@(((IResponse)context.Variables["test-transaction"]).StatusCode)" /> -->
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
