<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>
      <set-backend-service base-url="http://{{aks-lb-nexi}}:80/tkmacquirermanager" />
      <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
        <value>${cstar_outbound_ip_1}</value>
        <value>${cstar_outbound_ip_2}</value>
      </check-header>
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
