<policies>
    <inbound>
      <base />
      <!-- Calling Authorizer's fragment START -->
      <set-variable name="application_domain" value="qi" />
      <set-variable name="authCheck" 
              value="@((string)context.Request.Url.Query.GetValueOrDefault("brokerFiscalCode", "") != "" 
                      ? context.Request.Url.Query.GetValueOrDefault("brokerFiscalCode", "") 
                      : context.Request.Url.Query.GetValueOrDefault("pspId", ""))"/>

      <choose>
        <!-- Making sure that will excludes all APIs that does not includes CI fiscal code -->
        <when condition="@(context.Variables.GetValueOrDefault("authCheck","") != "")">
          <set-variable name="authorization_entity" value="@(context.Variables.GetValueOrDefault("authCheck",""))" />
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
