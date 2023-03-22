<set-header name="x-rpt-id" exists-action="delete" />
        <set-header name="x-transaction-id" exists-action="delete" />
        <set-variable name="requestTransactionId" value="@{
            IReadOnlyDictionary<string, string> dict = context.Request.MatchedParameters;
            foreach (KeyValuePair<string, string> item in dict) {
                if(item.Key == "TRANSACTIONID") {
                    return item.Value;
                }
            }
            return "";
        }" />
        <set-variable name="method" value="@(context.Request.Method)" />
        <set-variable name="transactionId" value="" />
        <set-variable name="rptId" value="" />
        <choose>
            <when condition="@((string)context.Variables["method"] == "POST")">
                <set-variable name="transactionId" value="@(((string)((JObject)context.Request.Body.As<JObject>(preserveContent: true))["transactionId"]))" />
                <set-variable name="rptId" value="@(((string)((JObject)context.Request.Body.As<JObject>(preserveContent: true))["rptId"]))" />
            </when>
        </choose>
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