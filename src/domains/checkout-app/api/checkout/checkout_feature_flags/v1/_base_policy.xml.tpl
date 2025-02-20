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
    <set-variable name="requestIpAddress" value="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For",""))" />
    <set-variable name="allowedIpsEnabledAuthentication" value="{{EnableAuthenticationIpWhitelist}}" />

    <!-- example of more feature flags -->
    <set-variable name="allowedIpsFeature_1" value="{{Feature1IpWhitelist}}" />
    <set-variable name="allowedIpsFeature_2" value="{{Feature2IpWhitelist}}" />
    <set-variable name="allowedIpsFeature_3" value="{{Feature3IpWhitelist}}" />

    <return-response>
      <set-status code="200" reason="OK" />
      <set-header name="Content-Type" exists-action="override">
        <value>application/json</value>
      </set-header>
      <set-body>@{
        var response = new {
          EnableAuthentication = IsIpAllowed(context.Variables.GetValueOrDefault("allowedIpsEnabledAuthentication", ""), context.Variables.GetValueOrDefault("requestIpAddress", "")),
          Feature_1 = IsIpAllowed(context.Variables.GetValueOrDefault("allowedIpsFeature_1", ""), context.Variables.GetValueOrDefault("requestIpAddress", "")),
          Feature_2 = IsIpAllowed(context.Variables.GetValueOrDefault("allowedIpsFeature_2", ""), context.Variables.GetValueOrDefault("requestIpAddress", "")),
          Feature_3 = IsIpAllowed(context.Variables.GetValueOrDefault("allowedIpsFeature_3", ""), context.Variables.GetValueOrDefault("requestIpAddress", ""))
        };
        return JsonConvert.SerializeObject(response);
      }</set-body>
    </return-response>
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

<helpers>
  <code>
    @{
      bool IsIpAllowed(string allowedIps, string requestIpAddress) {
        if (allowedIps == "*") {
          return true;
        }
        var allowedIpsList = allowedIps.Split(',');
        string[] callerIps = requestIpAddress.Split(',');
        foreach (string callerIp in callerIps) {
          if (allowedIpsList.Contains(callerIp)) {
            return true;
          }
        }
        return false;
      }
    }
  </code>
</helpers>
