<policies>
    <inbound>
      <base />

      <set-backend-service base-url="http://{{aks-lb-nexi}}:80/tkmacquirermanager" />
      <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
        <value>${allowed_ip_1}</value> <!--CSTAR-->
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
