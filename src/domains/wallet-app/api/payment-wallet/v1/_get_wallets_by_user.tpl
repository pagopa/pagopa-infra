<policies>
    <inbound>
      <set-variable name="x-user-id" value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <choose>
        <when condition="@((string)context.Variables.GetValueOrDefault("requestTransactionId","") != "")">
            <set-header name="x-user-id" exists-action="override">
                <value>@((string)context.Variables.GetValueOrDefault("x-user-id",""))</value>
            </set-header>
        </when>
        <otherwise>
            <return-response>
                <set-status code="401" reason="Unauthorized" />
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
