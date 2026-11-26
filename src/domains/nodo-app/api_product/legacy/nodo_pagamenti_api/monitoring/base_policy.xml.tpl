<policies>
  <inbound>
    <base/>
    <!-- set ndphost header -->
    <include-fragment fragment-id="ndphost-header" />

    <include-fragment fragment-id="decoupler-configuration" />

    <!-- the following is to set the baseUrl according to decoupler configuration -->
    <set-variable name="ndpTarget" value="@(context.Request.Headers.GetValueOrDefault("X-Ndp-Target", "NONE"))" />

    <set-variable name="baseUrl" value="@{
        var configuration = JArray.Parse(context.Variables.GetValueOrDefault<string>("configuration"));
        var ndpTarget = context.Variables.GetValueOrDefault<string>("ndpTarget");
        foreach (JObject item in configuration) {
            var serviceIdentifier = (string) item["node_id"];
            if (string.Equals(serviceIdentifier, ndpTarget, StringComparison.OrdinalIgnoreCase)) {
              return (string) item["node_uri"];
            }
        }
        return "{{schema-ip-nexi}}";
    }"
    />

</inbound>
  <backend>
    <base/>
  </backend>
  <outbound>
    <base/>
  </outbound>
  <on-error>
    <base/>
  </on-error>
</policies>
