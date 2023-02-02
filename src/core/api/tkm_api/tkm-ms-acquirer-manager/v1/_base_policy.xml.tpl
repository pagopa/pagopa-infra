<policies>
    <inbound>
      <base />

      <set-backend-service base-url="http://{{aks-lb-nexi}}:80/tkmacquirermanager" />
      <!-- TODO Enable after ticket resolution -->
      <!-- <when condition="@(context.Request.Headers.GetValueOrDefault("X-Environment", "").Equals("uat"))">
        <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
          <value>${allowed_ip_1}</value>
        </check-header>
      </when> -->
      <when condition="@(context.Request.Headers.GetValueOrDefault("X-Environment", "").Equals("prod"))">
        <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
          <value>${allowed_ip_1}</value> 
        </check-header>
      </when>
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
