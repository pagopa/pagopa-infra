<policies>
  <inbound>
    <!-- pass rptId value into header START -->
    <set-header name="x-rpt-ids" exists-action="delete" />
    <set-variable name="rptId" value="@{
      return context.Request.MatchedParameters["rpt_id"];
    }" />
    <choose>
      <when condition="@((string)context.Variables["rptId"] != "")">
        <set-header name="x-rpt-ids" exists-action="override">
          <value>@((string)context.Variables.GetValueOrDefault("rptId",""))</value>
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
