<policies>
    <inbound>
      <base />
      <set-backend-service base-url="{{pagopa-appservice-proxy-url}}" />
      <check-header name="X-Forwarded-For" failed-check-httpcode="403" failed-check-error-message="Unauthorized" ignore-case="true">
        <value>${ip_allowed_1}</value>
        <value>${ip_allowed_2}</value>
      </check-header>
      <choose>
        <when condition="@(context.User.Groups.All(g =&gt; g.Name != &quot;checkout-rate-no-limit&quot;))">
          <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
        </when>
      </choose>
      <!-- Handle X-Client-Id - pagopa-proxy multi channel - START -->
      <set-variable name="ioBackendSubKey" value="{{io-backend-subscription-key}}" />
      <choose>
        <when condition="@(context.Request.Headers.GetValueOrDefault("Ocp-Apim-Subscription-Key","").Equals( (string) context.Variables["ioBackendSubKey"] ) )">
          <set-header name="X-Client-Id" exists-action="override">
            <value>CLIENT_IO</value>
          </set-header>
        </when>
        <otherwise>
          <return-response>
            <set-status code="401" reason="Unauthorized" />
          </return-response>
        </otherwise>
      </choose>
      <!-- Handle X-Client-Id - pagopa-proxy multi channel - END -->
    </inbound>
    <outbound>
        <set-header name="cache-control" exists-action="override">
            <value>no-store</value>
        </set-header>
          <set-variable name="body" value="@(context.Response.Body.As<JObject>())" />
        <choose>
            <when condition="@( (context.Response.StatusCode == 500 || context.Response.StatusCode == 424) && ((JObject) context.Variables["body"])["detail_v2"] != null )">
                <return-response>
                    <set-status code="500" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@{
                    return new JObject(
                            new JProperty("status", 500),
                            new JProperty("detail_v2", ((JObject) context.Variables["body"])["detail_v2"]),
                            new JProperty("detail", ((JObject) context.Variables["body"])["detail"]),
                            new JProperty("title", ((JObject) context.Variables["body"])["title"])
                           ).ToString();
             }</set-body>
                </return-response>
            </when>
            <otherwise>
              <return-response>
                    <set-status code="@(context.Response.StatusCode)" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@(((JObject) context.Variables["body"]).ToString())</set-body>
                </return-response>
            </otherwise>
        </choose>
        <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
