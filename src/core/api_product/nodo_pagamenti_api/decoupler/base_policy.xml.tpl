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
<policies>
  <inbound>
    <base/>
    <!-- blacklist for appgateway-snet  -->
    <ip-filter action="forbid">
      <address-range from="${address-range-from}" to="${address-range-to}"/>
    </ip-filter>

    <!-- read decoupler configuration json -->
    <include-fragment fragment-id="decoupler-configuration" />
    <!-- the following is the default baseUrl -->
    <set-variable name="baseUrl" value="${base-url}" />
    <!-- used for convention in the cache key -->
    <set-variable name="domain" value="nodo" />
    <!-- used for debugging -->
    <trace source="json-configuration" severity="information">@{
      var configuration = JArray.Parse(((string) context.Variables["configuration"]));
      return configuration.FirstOrDefault()["node_id"].Value<string>();
      }</trace>
    <set-variable name="primitives" value="{{node-decoupler-primitives}}" />
    <set-variable name="soapAction" value="@((string)context.Request.Headers.GetValueOrDefault("SOAPAction"))" />
    <set-variable name="primitiveType" value="@{
            string[] primitives = ((string) context.Variables["primitives"]).Split(',');

            string verifyPaymentNotice = "verifyPaymentNotice";
            string[] activatePayment = new string[] {"activatePaymentNotice", "activateIOPayment"};
            string sendPaymentOutcome = "sendPaymentOutcome";

            bool analyzeRequest = false;

            var soapAction = (string)context.Variables["soapAction"];
            if (primitives.Contains(soapAction)) {
                return "ROUTING";
            }
            else if (activatePayment.Contains(soapAction) || soapAction.Equals(verifyPaymentNotice) || soapAction.Equals(sendPaymentOutcome)) {
                return "NM3";
            }
            return "NOTSET";
        }" />
    <!-- apply algorithm logic -->
    <include-fragment fragment-id="decoupler-algorithm" />
    <trace source="base-url" severity="information">@((string)context.Variables["baseUrl"])</trace>

    <!-- set backend service url -->
    <set-backend-service base-url="@((string)context.Variables["baseUrl"])" />

  </inbound>
  <backend>
    <base/>
  </backend>
  <outbound>
    <base/>
    <include-fragment fragment-id="decoupler-activate-outbound" />
  </outbound>
  <on-error>
    <base/>
  </on-error>
</policies>
