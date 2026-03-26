<policies>
    <inbound>
        <base />
        <set-method>POST</set-method>
        <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
        </set-header>
        <rewrite-uri template="/wallets/searchBy" />

        <set-body>@{
            JObject json = new JObject();
            json["userFiscalCode"] = (string)context.Variables["userId"];
            json["type"] = "USER_FISCAL_CODE";

            return json.ToString();
        }</set-body>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
