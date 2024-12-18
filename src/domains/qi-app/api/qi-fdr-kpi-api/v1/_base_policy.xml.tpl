<policies>
    <inbound>
      <base />
      <!-- Calling Authorizer's fragment START -->
      <set-variable name="application_domain" value="qi" />
      <choose>
        <!-- Making sure that will excludes all APIs that does not includes CI fiscal code -->
        <when condition="@(context.Request.Url.Query.GetValueOrDefault("pspId","") != "")">
          <set-variable name="authorization_entity" value="@(context.Request.Url.Query.GetValueOrDefault("pspId",""))" />
          <include-fragment fragment-id="authorizer" />
        </when>
        <otherwise>
          <return-response>
            <set-status code="403" reason="Unauthorized" />
          </return-response>
        </otherwise>
      </choose>
      <!-- Calling Authorizer's fragment END -->
      <set-backend-service base-url="https://${hostname}/pagopa-qi-fdr-kpi-service" />
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
