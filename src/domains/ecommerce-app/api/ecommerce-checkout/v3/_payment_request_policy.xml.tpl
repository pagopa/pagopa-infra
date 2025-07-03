<policies>
  <inbound>
    <!-- pass rptId value into header START -->
    <set-header name="x-rpt-id" exists-action="delete" />
    <set-variable name="rptId" value="@{
      return context.Request.MatchedParameters["rpt_id"];
    }" />
    <choose>
      <when condition="@((string)context.Variables["rptId"] != "")">
        <set-header name="x-rpt-id" exists-action="override">
          <value>@((string)context.Variables.GetValueOrDefault("rptId",""))</value>
        </set-header>
      </when>
    </choose>
    <!-- pass rptId value into header END -->
    <!-- Set payment-requests API Key header -->
    <set-header name="x-api-key" exists-action="override">
      <value>{{ecommerce-payment-requests-api-key-value}}</value>
    </set-header>
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
