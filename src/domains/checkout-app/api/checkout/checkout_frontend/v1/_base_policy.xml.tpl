<policies>

  <inbound>
    <!-- CORS for NPG SDK font access -->
    <cors allow-credentials="false">
      <allowed-origins>
        <origin>https://${npg_sdk_hostname}</origin>
      </allowed-origins>
      <allowed-methods>
        <method>GET</method>
        <method>HEAD</method>
        <method>OPTIONS</method>
      </allowed-methods>
      <allowed-headers>
        <header>*</header>
      </allowed-headers>
    </cors>

    <base />
    <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

    <!-- URL Rewrites: replicate CDN delivery rules -->
    <choose>
      <!-- /dona or /dona/ -> /dona.html -->
      <when condition="@(context.Request.Url.Path.TrimEnd('/').EndsWith("/dona"))">
        <rewrite-uri template="/dona.html" />
      </when>
      <!-- /termini-di-servizio -> /terms/it.html -->
      <when condition="@(context.Request.Url.Path.TrimEnd('/').EndsWith("/termini-di-servizio"))">
        <rewrite-uri template="/terms/it.html" />
      </when>
    </choose>

    <!-- Backend: Front Door .azurefd.net endpoint -->
    <set-backend-service base-url="https://${frontdoor_endpoint_hostname}" />

    <!-- Override Host header so Front Door routes correctly -->
    <set-header name="Host" exists-action="override">
      <value>${frontdoor_endpoint_hostname}</value>
    </set-header>
  </inbound>

  <outbound>
    <base />

    <!-- Security Headers: replicate CDN global delivery rules -->

    <!-- HSTS -->
    <set-header name="Strict-Transport-Security" exists-action="override">
      <value>max-age=31536000</value>
    </set-header>

    <!-- X-Frame-Options -->
    <set-header name="X-Frame-Options" exists-action="override">
      <value>SAMEORIGIN</value>
    </set-header>

    <!-- Content-Security-Policy (assembled from CDN delivery rules) -->
    <set-header name="Content-Security-Policy" exists-action="override">
      <value>${csp_value}</value>
    </set-header>

    <!-- CORS: Access-Control-Allow-Origin for NPG SDK origin (font access) -->
    <choose>
      <when condition="@(context.Request.Headers.GetValueOrDefault("Origin","") == "https://${npg_sdk_hostname}")">
        <set-header name="Access-Control-Allow-Origin" exists-action="override">
          <value>https://${npg_sdk_hostname}</value>
        </set-header>
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
