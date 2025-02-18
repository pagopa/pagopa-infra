<policies>
  <inbound>
    <cors>
      <allowed-origins>
        <origin>${checkout_origin}</origin>
      </allowed-origins>
      <allowed-methods>
        <method>GET</method>
        <method>OPTIONS</method>
      </allowed-methods>
      <allowed-headers>
        <header>Content-Type</header>
      </allowed-headers>
    </cors>
    <base />
    <set-backend-service base-url="@("https://${checkout_ingress_hostname}"+"/pagopa-checkout-feature-flags")"/>
    <choose>
      <when condition="@(context.Request.MatchedParameters["featureKey"] != null)">
        <set-variable name="requestedFeature" value="@(context.Request.MatchedParameters["featureKey"])" />

        <!-- Save request IP address -->
        <set-variable name="requestIpAddress" value="@((string)context.Request.IpAddress)" />

        <!-- default ipWhitelist init -->
        <set-variable name="ipWhitelist" value="" />

        <choose>
          <when condition="@(context.Variables["requestedFeature"] == "EnableAuthentication")">
            <!-- Reference Named Values for EnableAuthentication -->
            <set-variable name="ipWhitelist" value="@((string)context.Variables.GetValueOrDefault("EnableAuthentication-Ip-Whitelist", ""))" />
          </when>
          <!-- Add more feature flags as needed -->
        </choose>

         <!-- Begin IP Validation -->
        <choose>
          <when condition="@(context.Variables["ipWhitelist"] == "*")">
            <!-- Feature is enabled and IP is whitelisted -->
            <return-response>
              <set-status code="200" reason="OK" />
              <set-body>{"enabled":true}</set-body>
            </return-response>
          </when>
          <otherwise>
            <!-- IP is not whitelisted -->
            <return-response>
              <set-status code="200" reason="OK" />
              <set-body>{"enabled":false}</set-body>
            </return-response>
          </otherwise>
        </choose>

        <!-- End IP Validation -->

      </when>
      <otherwise>
        <!-- No featureKey parameter -->
        <return-response>
          <set-status code="400" reason="Bad Request" />
          <set-body>{"error":"featureKey parameter is missing"}</set-body>
        </return-response>
      </otherwise>
    </choose>

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
