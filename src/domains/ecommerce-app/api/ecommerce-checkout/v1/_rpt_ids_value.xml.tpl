<policies>
    <inbound>
        <set-header name="x-rpt-id" exists-action="delete" />
        <set-variable name="paymentNotices" value="@(((JArray)((JObject)context.Request.Body.As<JObject>(preserveContent: true))["paymentNotices"]))" />
        <set-variable name="rptIds" value="@{
            string result = "";
            foreach (JObject notice in ((JArray)(context.Variables["paymentNotices"]))) {
                if( notice.ContainsKey("rptId") == true )
                {
                    result += notice["rptId"].Value<string>()+", ";
                }
            }
            return result;
        }" />
        <choose>
            <when condition="@((string)context.Variables["rptIds"] != "")">
                <set-header name="x-rpt-id" exists-action="override">
                    <value>@((string)context.Variables.GetValueOrDefault("rptIds",""))</value>
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