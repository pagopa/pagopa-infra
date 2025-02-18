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
        <set-variable name="requestIpAddress" value="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For",""))" />
      
        <!-- default -->
        <set-variable name="isTesterIp" value="false" />

        <choose>
          <!-- Reference Named Values for EnableAuthentication -->
          <when condition="@(context.Variables["requestedFeature"] == "EnableAuthentication")">

            <set-variable name="allowedIps" value="{{EnableAuthenticationIpWhitelist}}" />

            <set-variable name="isTesterIp" value="@{
                if(allowedIps == "*"){
                  return true;
                }

                var allowedIps = new HashSetstring(context.Variables.GetValueOrDefault("allowedIps","").Split(','));
                string[] callerIps = context.Variables.GetValueOrDefault("callerIps","").Split(',');
                foreach (string callerIp in callerIps){
                    if(allowedIps.Contains(callerIp)){
                        return true;
                    }
                }
                return false;
            }" />
          </when>
          <!-- Add more feature flags as needed -->
        </choose>

         <!-- Begin IP Validation -->
        <choose>
            <when condition="@(((Boolean)context.Variables.GetValueOrDefault("isTesterIp",false)))">
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
