<policies>
    <inbound>
        <base />
        <set-backend-service base-url="{{pagopa-appservice-proxy-url}}" />
        <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
            <value>${ip_allowed_1}</value>
            <value>${ip_allowed_2}</value>
            <value>${ip_allowed_3}</value>
        </check-header>
        <choose>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("checkout-rate-no-limit"))" />
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("checkout-rate-limit-300"))">
                <rate-limit-by-key calls="300" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
            </when>
            <otherwise>
                <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
            </otherwise>
        </choose>
        <!-- Handle X-Client-Id - pagopa-proxy multi channel - START -->
        <set-header name="X-Client-Id" exists-action="delete" />
        <choose>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("client-io"))">
                <set-header name="X-Client-Id" exists-action="override">
                    <value>CLIENT_IO</value>
                </set-header>
            </when>
            <when condition="@(context.User.Groups.Select(g => g.Id).Contains("piattaforma-notifiche"))" >
              <set-header name="X-Client-Id" exists-action="override">
                <value>CLIENT_PN</value>
              </set-header>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="401" reason="Unauthorized X-Client-Id" />
                </return-response>
            </otherwise>
        </choose>
        <!-- Handle X-Client-Id - pagopa-proxy multi channel - END -->
    </inbound>
    <outbound>
        <set-header name="cache-control" exists-action="override">
            <value>no-store</value>
        </set-header>
        <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
