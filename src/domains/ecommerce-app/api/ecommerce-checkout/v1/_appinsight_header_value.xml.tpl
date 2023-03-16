<policies>
    <inbound>
        <set-header name="x-rpt-id" exists-action="delete" />
        <set-header name="x-transaction-id" exists-action="delete" />
        <set-variable name="requestTransactionId" value="@{
            return context.Request.MatchedParameters["transactionId"];
        }" />
        <set-variable name="transactionId" value="@(((string)((JObject)context.Request.Body.As<JObject>(preserveContent: true))["transactionId"]))" />
        <set-variable name="rptId" value="@(((string)((JObject)context.Request.Body.As<JObject>(preserveContent: true))["rptId"]))" />
        <choose>
            <when condition="@((string)context.Variables["rptId"] != "")">
                <set-header name="x-rpt-id" exists-action="override">
                    <value>@((string)context.Variables.GetValueOrDefault("rptId",""))</value>
                </set-header>
            </when>
            <when condition="@((string)context.Variables["transactionId"] != "")">
                <set-header name="x-transaction-id" exists-action="override">
                    <value>@((string)context.Variables.GetValueOrDefault("transactionId",""))</value>
                </set-header>
            </when>
            <when condition="@((string)context.Variables["requestTransactionId"] != "")">
            <set-header name="x-transaction-id" exists-action="override">
                <value>@((string)context.Variables.GetValueOrDefault("requestTransactionId",""))</value>
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