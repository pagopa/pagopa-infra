<policies>

  <inbound>
    <cors>
      <allowed-origins>
        <origin>https://${checkout_fe_hostname}</origin>
      </allowed-origins>
      <allowed-methods>
        <method>*</method>
      </allowed-methods>
      <allowed-headers>
        <header>*</header>
      </allowed-headers>
    </cors>
    <base />

    <!-- URL Rewrites: replicate CDN delivery rules -->
    <choose>
      <!-- /dona or /dona/ -> /dona.html -->
      <when condition="@(Regex.IsMatch(context.Request.OriginalUrl.Path, @"\/dona\/?$", RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(500)))">
        <rewrite-uri template="/dona.html" />
      </when>
      <!-- /termini-di-servizio or /termini-di-servizio/ -> /terms/it.html -->
      <when condition="@(Regex.IsMatch(context.Request.OriginalUrl.Path, @"\/termini-di-servizio\/?$", RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(500)))">
        <rewrite-uri template="/terms/it.html" />
      </when>
    </choose>

    <!-- Remove Origin header before forwarding to storage backend to avoid CORS issues -->
    <set-header name="Origin" exists-action="delete" />

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

    <!-- Content-Security-Policy -->
    <set-header name="Content-Security-Policy" exists-action="override">
      <value>${csp_value}</value>
    </set-header>

    <!-- CORS: Access-Control-Allow-Origin for NPG SDK font requests only -->
    <choose>
      <when condition="@(context.Request.Headers.GetValueOrDefault("Origin","") == "https://${npg_sdk_hostname}" && context.Request.Url.Path.Contains("/fonts/"))">
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
