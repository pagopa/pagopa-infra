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
        <header>requestedFeature</header>
      </allowed-headers>
    </cors>
    <base />
    <set-backend-service base-url="@("https://${checkout_ingress_hostname}"+"/feature-flags")"/>
    <choose>
      <when condition="@(context.Request.Headers.GetValueOrDefault("requestedFeature") != null)">
        <set-variable name="requestedFeature" value="@(context.Request.Headers.GetValueOrDefault("requestedFeature"))" />
        <choose>
          <when condition="@(context.Variables["requestedFeature"] == "featureA")">
            <set-variable name="featureEnabled" value="@((bool)context.Variables.GetValueOrDefault("featureAEnabled", false))" />
            <set-variable name="ipWhitelist" value="@((string)context.Variables.GetValueOrDefault("featureAIPWhitelist", ""))" />
          </when>
          <when condition="@(context.Variables["requestedFeature"] == "featureB")">
            <set-variable name="featureEnabled" value="@((bool)context.Variables.GetValueOrDefault("featureBEnabled", false))" />
            <set-variable name="ipWhitelist" value="@((string)context.Variables.GetValueOrDefault("featureBIPWhitelist", ""))" />
          </when>
          <!-- Add more feature flags as needed -->
        </choose>
        <choose>
          <when condition="@(context.Variables["featureEnabled"] == true)">
            <choose>
              <when condition="@(context.Variables["ipWhitelist"].Contains(context.Request.IpAddress) || context.Variables["ipWhitelist"].Contains("*"))">
                <!-- Feature is enabled and IP is whitelisted -->
                <return-response>
                  <set-status code="200" reason="OK" />
                  <set-body>@("{\"featureFlag\":\"" + context.Variables["requestedFeature"] + "\", \"enabled\":true}")</set-body>
                </return-response>
              </when>
              <otherwise>
                <!-- IP is not whitelisted -->
                <return-response>
                  <set-status code="403" reason="Forbidden" />
                  <set-body>@("{\"featureFlag\":\"" + context.Variables["requestedFeature"] + "\", \"enabled\":false, \"reason\":\"IP not whitelisted\"}")</set-body>
                </return-response>
              </otherwise>
            </choose>
          </when>
          <otherwise>
            <!-- Feature is disabled -->
            <return-response>
              <set-status code="200" reason="OK" />
              <set-body>@("{\"featureFlag\":\"" + context.Variables["requestedFeature"] + "\", \"enabled\":false}")</set-body>
            </return-response>
          </otherwise>
        </choose>
      </when>
      <otherwise>
        <!-- No requestedFeature header -->
        <return-response>
          <set-status code="400" reason="Bad Request" />
          <set-body>{"error":"requestedFeature header is missing"}</set-body>
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