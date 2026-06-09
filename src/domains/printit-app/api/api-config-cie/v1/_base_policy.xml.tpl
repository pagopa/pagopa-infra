<!--
    IMPORTANT:
    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.
    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.
    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.
    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.
    - To remove a policy, delete the corresponding policy statement from the policy document.
    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.
    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.
    - Policies are applied in the order of their appearance, from the top down.
    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.
-->
<policies>
    <inbound>
        <base />

      <choose>
        <!-- Allow invocation only to getCreditorInstitution API, otherwise return 403-->
        <when condition="@(context.Operation.Id == "getCreditorInstitution")">

        <!-- Retrieve EC tax code from path parameter -->
        <set-variable name="ecTaxCode" value="@(context.Request.MatchedParameters["creditorinstitutioncode"])" />

          <cache-lookup-value key="@("CIE_" + (string) context.Variables["ecTaxCode"])"
            variable-name="api_config_creditor_institution_detail_cached_response"
            caching-type="internal" />

          <choose>
            <when condition="@(context.Variables.ContainsKey("api_config_creditor_institution_detail_cached_response"))">
              <!-- CACHE HIT -->
              <return-response>
                <set-status code="200" reason="Success" />
                <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
                </set-header>
                <set-body>
                  @((string)context.Variables["api_config_creditor_institution_detail_cached_response"])
                </set-body>
              </return-response>
            </when>
          </choose>

        <!-- CACHE MISS -->
        <!-- Call Api Config to get Creditor Institution details-->
        <set-backend-service base-url="https://${hostname}/pagopa-api-config-core-service/p" />

        </when>
        <otherwise>
          <return-response>
            <set-status code="403" reason="Forbidden" />
            <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
            </set-header>
            <set-body>
              {
              "title": "Forbidden",
              "status": 403,
              "detail": "The requested operation is not allowed"
              }
            </set-body>
          </return-response>
        </otherwise>
      </choose>

    </inbound>

    <backend>
      <base />
    </backend>

    <outbound>
        <base />
        <choose>
          <!-- Only if is a successful response of getCreditorInstitution API cache the response for 12h-->
          <when condition="@(context.Operation.Id == "getCreditorInstitution"
                            && context.Response.StatusCode == 200
                            && context.Variables.ContainsKey("ecTaxCode"))">

            <cache-store-value
              key="@("CIE_" + (string) context.Variables["ecTaxCode"])"
              value="@(context.Response.Body.As<string>(preserveContent: true))"
              duration="43200"
              caching-type="internal"/>
          </when>
        </choose>

    </outbound>

    <on-error>
        <base />
    </on-error>
</policies>
