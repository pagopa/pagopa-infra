<policies>
    <inbound>
        <base />
        <set-variable name="authRequestBody" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
        <set-variable name="paymentGatewayType" value="@{
            JObject authBody = (JObject)context.Variables["authRequestBody"];
            string paymentGatewayType = null;
                var outcomeGateway = authBody["outcomeGateway"];
              if(outcomeGateway!=null && outcomeGateway.Type != JTokenType.Null){
                  paymentGatewayType = (string)((JObject)outcomeGateway)["paymentGatewayType"];
              }
            return String.IsNullOrEmpty(paymentGatewayType)? "UNKNOWN": paymentGatewayType;
                  }" />
        <set-header name="x-payment-gateway-type" exists-action="override">
            <value>@((string)context.Variables["paymentGatewayType"])</value>
        </set-header>
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