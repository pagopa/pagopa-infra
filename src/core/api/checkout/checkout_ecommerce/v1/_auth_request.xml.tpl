<policies>
  <inbound>
      <choose>
        <when condition="@( context.Request.Url.Path.Contains("auth-requests") )">
        <set-variable name="XPAYPspsList" value="${ecommerce_xpay_psps_list}" />
        <set-variable name="VPOSPspsList" value="${ecommerce_vpos_psps_list}" />
        <set-variable name="pspId" value="@(((string)((JObject)context.Request.Body.As<JObject>(preserveContent: true))["pspId"]))" />
        <set-variable name="pgsId" value="@{
            string[] xpayList = ((string)context.Variables["XPAYPspsList"]).Split(',');
            string[] vposList = ((string)context.Variables["VPOSPspsList"]).Split(',');
            string pspId = (string)(context.Variables.GetValueOrDefault("pspId",""));
            if (xpayList.Contains(pspId)) {
                return "XPAY";
            }
            if (vposList.Contains(pspId)) {
                return "VPOS";
            }
            return "";
        }" />
        <set-header name="x-pgs-id" exists-action="override">
            <value>"@((string)context.Variables.GetValueOrDefault("pgsId",""))"</value>
        </set-header>
      </when>
    </choose>
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