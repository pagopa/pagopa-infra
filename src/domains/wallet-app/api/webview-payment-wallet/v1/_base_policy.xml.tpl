<policies>
    <inbound>
      <base />
      <set-variable  name="sessionToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
          <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/check-session?sessionToken={(string)context.Variables["sessionToken"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
       <choose>
        <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="401" />
          </return-response>
        </when>
      </choose>
      <set-backend-service base-url="https://weudev.ecommerce.internal.dev.platform.pagopa.it/pagopa-ecommerce-payment-methods-service" />
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
