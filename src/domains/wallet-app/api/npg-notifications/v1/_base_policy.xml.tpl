<policies>
    <inbound>
      <base />
      <set-variable name="orderIdPathParam" value="@(context.Request.MatchedParameters["orderId"])" />
      <set-variable name="orderIdBodyParam" value="@((string)((JObject)((JObject)context.Variables["npgNotificationRequestBody"])["operation"])["orderId"])" />
      <choose>  
        <when condition="@(((string)context.Variables["orderIdPathParam"]).Equals((string)context.Variables["orderIdBodyParam"]) != true)">
          <return-response>
            <set-status code="400" reason="orderId mismatch" />
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>{
                    "title": "Unable to handle notification",
                    "status": 400,
                    "detail": "orderId mismatch",
                }</set-body>
          </return-response>
        </when>
      </choose>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound />
    <on-error>
        <base />
    </on-error>
</policies>
