<policies>
  <inbound>
    <!-- pass rptId value into header START -->
    <set-header name="x-rpt-id" exists-action="delete" />
    <choose>
      <when condition="@((string)context.Request.Headers.GetValueOrDefault("x-rpt-id","") != "")">
          <set-header name="x-rpt-id" exists-action="override">
              <value>@((string)context.Request.Headers.GetValueOrDefault("x-rpt-id",""))</value>
          </set-header>
      </when>
    </choose>
    <!-- pass rptId value into header END -->
    <base />
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