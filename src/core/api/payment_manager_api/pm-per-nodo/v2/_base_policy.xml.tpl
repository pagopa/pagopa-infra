<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>  
        <set-variable name="transactionId" value="@(context.Request.MatchedParameters["transactionId"])" />
        <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/v2")" />
        <set-variable name="ecommerce_url" value="weudev.ecommerce.internal.dev.platform.pagopa.it" />
        <set-variable name="body_value" value="@(context.Request.Body.As<string>(preserveContent: true))" />
        <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
    </inbound>
    <outbound>
        <base />
        <choose>
            <when condition="@(context.Response.StatusCode == 200)">
                <set-variable name="outcome" value="@(((string)((JObject)context.Response.Body.As<JObject>(preserveContent: true))["outcome"]))" />
            </when>
        </choose>
        <choose>
            <when condition="@(context.Response.StatusCode != 200 || !((string)context.Variables["outcome"]).Equals("OK"))">
                <!-- addUserReceipt for ecommerce -->
                <send-request ignore-error="true" timeout="10" response-variable-name="test-transaction" mode="new">
                    <set-url>@($"https://{(string)context.Variables["ecommerce_url"]}/pagopa-ecommerce-transactions-service/transactions/{(string)context.Variables["transactionId"]}/user-receipts")</set-url>
                    <set-method>POST</set-method>
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@($"{(string)context.Variables["body_value"]}")</set-body>
                </send-request>
                <return-response response-variable-name="test-transaction" />
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