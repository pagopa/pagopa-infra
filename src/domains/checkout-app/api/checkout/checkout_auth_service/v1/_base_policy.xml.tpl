<policies>

  <inbound>
    <!-- Rate limit policy -->
    <rate-limit-by-key
      calls="150"
      renewal-period="10"
      counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))"
    />
    <!-- End rate limit policy -->
      <cors>
        <allowed-origins>
          <origin>${checkout_origin}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
          <header>Authorization</header>
          <header>x-rpt-ids</header>
          <header>x-rpt-id</header>
        </allowed-headers>
      </cors>
      <!-- Feature flag check - is authentication enabled -->
      <include-fragment fragment-id="fragment-checkout-feature-flag-filter" />
      <choose>
        <when condition="@{
                  var result = JObject.Parse(context.Variables.GetValueOrDefault<string>("checkout-feature-flag"));
                      return !(bool)result["isAuthenticationEnabled"];
                  }">
          <return-response>
            <set-status code="403" reason="Forbidden" />
            <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
            </set-header>
            <set-body>{ "error" : "Forbidden" }</set-body>
          </return-response>
        </when>
      </choose>
      <!-- End feature flag -->
      <base />
      <set-backend-service base-url="@("https://${checkout_ingress_hostname}"+"/pagopa-checkout-auth-service")"/>
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
