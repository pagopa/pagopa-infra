<policies>
    <inbound>
        <set-variable name="requestPath" value="@(context.Request.Url.Path)" />
        <choose>
            <when condition="@(context.Request.Url.Path.Contains("xpay"))">
                <rewrite-uri template="@(((string)context.Variables["requestPath"]).Replace("pgs/xpay","xpay"))" />
            </when>
            <when condition="@(context.Request.Url.Path.Contains("vpos"))">
                <rewrite-uri template="@(((string)context.Variables["requestPath"]).Replace("pgs/vpos","vpos"))" />
            </when>
        </choose>
        <set-backend-service base-url="@($"{{pm-host}}/payment-gateway")" />
    </inbound>
    <outbound>
        <base/>
        <choose>
          <when condition="@(context.Response.StatusCode == 200)">
            <set-variable name="responseBody" value="@(context.Response.Body.As<JObject>())" />
            <set-body>@{
                return new JObject(
                    new JProperty("status", (string) ((JObject) context.Variables["responseBody"])["status"])
                ).ToString();
            }</set-body>
          </when>
        </choose>  
    </outbound>
    <backend>
        <base/>
    </backend>
    <on-error>
        <base/>
    </on-error>
</policies>
