<!--
    IMPORTANT:
    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.
    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.
    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.
    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.
    - To remove a policy, delete the corresponding policy statement from the policy document.
    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.
    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.
    - Policies are applied in the order of their appearance, from the top down.
    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.
-->

<!-- policy closePaymentV2 & sendPaymentResultV2 :
- On outbound call /receipt/KO wisp-conv
- On inbound  call /receipt/timer wisp-conv
-->

<policies>
  <inbound>
    <base />

    <set-variable name="transactionId" value="@(context.Request.MatchedParameters["transactionId"])" />
    <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/v2")" />
    <set-variable name="ecommerce_url" value="${ecommerce_ingress_hostname}" />
    <set-variable name="body_value" value="@(context.Request.Body.As<string>(preserveContent: true))" />
    <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />

    <!-- policy for WISP Dismantling -->
    <set-variable name="enable_wisp_dismantling_switch" value="{{enable-wisp-dismantling-switch}}" />
    <choose>
      <when condition="@(context.Variables.GetValueOrDefault<string>("enable_wisp_dismantling_switch", "").Equals("true"))">
      <set-variable name="primitive-ko" value="sendPaymentResultV2" />
      <set-variable name="request-body" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
      <set-variable name="wisp-payment-tokens" value="@{
              try {
                            JObject request = (JObject) context.Variables["request-body"];
                            JArray payments = (JArray) request.Property("payments").Value;
                            return string.Join(",", payments.Select(payment => payment["paymentToken"].ToString()));
      } catch (Exception e) {
      return "";
      }
      }" />
      <include-fragment fragment-id="wisp-disable-payment-token-timer" />
    </when>
  </choose>
</inbound>
<backend>
<base />
</backend>
<outbound>
<base />
<!-- fragment necessary for WISP Dismantling -->
<include-fragment fragment-id="wisp-receipt-ko" />

<choose>
  <when condition="@(context.Response.StatusCode == 200)">
    <set-variable name="outcome" value="@(((string)((JObject)context.Response.Body.As<JObject>(preserveContent: true))["outcome"]))" />
  </when>
</choose>
<choose>
  <when condition="@(context.Response.StatusCode != 200 || !((string)context.Variables.GetValueOrDefault("outcome","")).Equals("OK"))">
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
<on-error>
<base />
</on-error>
  </policies>
