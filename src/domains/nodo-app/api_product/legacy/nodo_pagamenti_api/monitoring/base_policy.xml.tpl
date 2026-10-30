<policies>
  <inbound>
    <base/>
    <!-- set ndphost header -->
    <include-fragment fragment-id="ndphost-header" />

    <include-fragment fragment-id="decoupler-configuration" />

    <!-- the following is to set the baseUrl according to decoupler configuration -->
    <set-variable name="ndpTarget" value="@(context.Response.Headers.GetValueOrDefault("X-Ndp-Target", "NONE"))" />

    <set-variable name="baseUrl" value="@{
          var configuration = JArray.Parse(context.Variables.GetValueOrDefault<string>("configuration"));
          foreach (JObject item in configuration) {
            bool serviceIdentifierFound = false;

            var serviceIdentifier = item.GetValue("node_id").ToString();

            if (serviceIdentifier.Equals(context.Variables["ndpTarget"])) {
                return item.GetValue("node_uri").ToString();
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
