<policies>
  <inbound>
    <cors>
      <allowed-origins>
        <origin>${checkout_origin}</origin>
      </allowed-origins>
      <allowed-methods>
        <method>GET</method>
      </allowed-methods>
      <allowed-headers>
      </allowed-headers>
    </cors>
    <base />
    <set-backend-service base-url="@("https://${checkout_ingress_hostname}"+"/feature-flags")"/>
    <choose>
      <when condition="@(context.Request.MatchedParameters["featureKey"] != null)">
        <set-variable name="requestedFeature" value="@(context.Request.MatchedParameters["featureKey"])" />
        <choose>
          <when condition="@(context.Variables["requestedFeature"] == "EnableAuthentication")">
            <!-- Reference Named Values for EnableAuthentication -->
            <set-variable name="ipWhitelist" value="@((string)context.Variables.GetValueOrDefault("EnableAuthentication-Ip-Whitelist", ""))" />
          </when>
          <!-- Add more feature flags as needed -->
        </choose>
        <choose>
          <when condition="@(context.Variables["ipWhitelist"].Contains(context.Request.IpAddress) || context.Variables["ipWhitelist"].Contains("*"))">
            <!-- Feature is enabled and IP is whitelisted -->
            <return-response>
              <set-status code="200" reason="OK" />
              <set-body>@("{\"featureKey\":\"" + context.Variables["requestedFeature"] + "\", \"enabled\":true}")</set-body>
            </return-response>
          </when>
          <otherwise>
            <!-- IP is not whitelisted -->
            <return-response>
              <set-status code="403" reason="Forbidden" />
              <set-body>@("{\"featureKey\":\"" + context.Variables["requestedFeature"] + "\", \"enabled\":false, \"reason\":\"IP not whitelisted\"}")</set-body>
            </return-response>
          </otherwise>
        </choose>
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