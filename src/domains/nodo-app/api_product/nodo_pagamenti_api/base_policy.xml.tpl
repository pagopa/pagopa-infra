<!-- @formatter:off -->
<policies>
  <inbound>
    <!-- product before base policy -->
    <base />
    <!-- product after base policy -->

    <!-- set ndphost header -->
    <include-fragment fragment-id="ndphost-header" />

    <!-- get SOAPAction info from header -->
    <set-variable name="soapAction" value="@{
      var soapAction = (string)context.Request.Headers.GetValueOrDefault("SOAPAction", "NONE");
      return soapAction.Replace("\"", "").Replace("'","");
    }" />

    <choose>
      <when condition="@(context.Request.Body != null)">
        <!-- copy request body into renewrequest variable -->
        <set-variable name="renewrequest" value="@(context.Request.Body.As<string>(preserveContent: true))" />
      </when>
    </choose>

    <choose>
      <!-- apply nuova connettivita logic (placeholder) -->
      <when condition="@(${is-nodo-auth-pwd-replace})">
        <include-fragment fragment-id="ndp-nuova-connettivita" />
      </when>

      <!-- blacklist for appgateway-snet  -->
      <otherwise>
        <ip-filter action="forbid">
          <address-range from="${address-range-from}" to="${address-range-to}"/>
        </ip-filter>
      </otherwise>
    </choose>

    <!-- Loading decoupler configuration -->
    <include-fragment fragment-id="decoupler-configuration" />

    <!-- used for convention in the cache key -->
    <set-variable name="domain" value="nodo" />
    <set-variable name="domain_eCommerce" value="ecommerce" />

    <!-- the following is the default baseUrl and baseNodeId -->
    <set-variable name="baseUrl" value="{{default-nodo-backend}}" />
    <set-variable name="baseNodeId" value="{{default-nodo-id}}" />

    <!-- the following is the TTL used to cache tagging regarding payments -->
    <set-variable name="ndp_nodo_fiscalCode_noticeNumber_ttl" value="@{
      bool success = int.TryParse("{{ndp-nodo-fiscalCode-noticeNumber-ttl}}", out var ttl);
      return success ? ttl.ToString() : "5184000";  // 60 days
    }" />
    <set-variable name="ndp_nodo_fiscalCode_iuv_ttl" value="@{
      bool success = int.TryParse("{{ndp-nodo-fiscalCode-iuv-ttl}}", out var ttl);
      return success ? ttl.ToString() : "5184000";  // 60 days
    }" />
    <set-variable name="ndp_nodo_paymentToken_ttl" value="@{
      bool success = int.TryParse("{{ndp-nodo-paymentToken-ttl}}", out var ttl);
      return success ? ttl.ToString() : "5184000";  // 60 days
    }" />
    <set-variable name="ndp_eCommerce_transactionId_ttl" value="@{
      bool success = int.TryParse("{{ndp-eCommerce-transactionId-ttl}}", out var ttl);
      return success ? ttl.ToString() : "86400";  // 1 day
    }" />

    <!-- set backend service url -->
    <set-backend-service base-url="@((string)context.Variables["baseUrl"])" />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <!-- product before base policy -->
    <base />
    <!-- product after base policy -->
  </outbound>
  <on-error>
    <base />
  </on-error>
</policies>
