<policies>
    <inbound>
      <base />
      <!-- pagoPA platform get payment methods redirect url : START -->
      <!-- Get Method Info : START -->
      <set-variable name="paymentMethodId" value="@(context.Request.MatchedParameters["id"])" />
      <set-variable name="rptId" value="@(context.Request.Url.Query.GetValueOrDefault("rpt_id", ""))" />
      <set-variable name="amount" value="@(context.Request.Url.Query.GetValueOrDefault("amount", ""))" />
      <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
          <set-url>@($"https://${ecommerce_ingress_hostname}/pagopa-ecommerce-payment-methods-service/payment-methods/{(string)context.Variables["paymentMethodId"]}")</set-url>
          <set-method>GET</set-method>
          <set-header name="X-Client-Id" exists-action="override">
              <value>IO</value>
          </set-header>
          <!-- Set payment-methods API Key header -->
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-payment-methods-api-key-value}}</value>
          </set-header>
      </send-request>
      <choose>
        <when condition="@(((int)((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode) == 200)">
            <set-variable name="paymentMethod" value="@((JObject)((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />
            <set-variable name="paymentTypeCode" value="@((string)((JObject)context.Variables["paymentMethod"])["paymentTypeCode"])" />
        </when>
        <when condition="@(((int)((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode) == 404)">
            <return-response>
                <set-status code="404" reason="Not found" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>{
                    "title": "Unable to get payment method",
                    "status": 404,
                    "detail": "Payment method not found",
                }</set-body>
            </return-response>
        </when>
        <otherwise>
            <return-response>
                <set-status code="502" reason="Bad Request" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>{
                    "title": "Bad gateway",
                    "status": 502,
                    "detail": "Payment method not available",
                }</set-body>
            </return-response>
        </otherwise>
      </choose>
      <!-- Get Method Info: END -->
      <!-- Token JWT START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="x-jwt-token" mode="new">
          <set-url>https://${ecommerce_ingress_hostname}/pagopa-jwt-issuer-service/tokens</set-url>
          <set-method>POST</set-method>
          <!-- Set jwt-issuer-service API Key header -->
          <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-jwt-issuer-api-key-value}}</value>
          </set-header>
          <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
          </set-header>
          <set-body>@{
            var userId = ((string)context.Variables.GetValueOrDefault("xUserId",""));
            var email = ((string)context.Variables.GetValueOrDefault("email",""));
            return new JObject(
                    new JProperty("audience", "ecommerce"),
                    new JProperty("duration", 900),
                    new JProperty("privateClaims", new JObject(
                        new JProperty("userId", userId),
                        new JProperty("email", email)
                    ))
                ).ToString();
          }</set-body>
      </send-request>
    <choose>
        <when condition="@(((IResponse)context.Variables["x-jwt-token"]).StatusCode != 200)">
            <return-response>
                <set-status code="502" reason="Bad Gateway" />
            </return-response>
        </when>
    </choose>
    <set-variable name="token" value="@( (string) ( ((IResponse)context.Variables["x-jwt-token"] ).Body.As<JObject>(preserveContent: true)) ["token"])" />
    <!-- Token JWT END-->
    <set-variable name="baseUrl" value="@{
        string ecommerceMethodsRedirectUrlMap = "{{ecommerce-methods-redirect-url-map}}";
        string paymentTypeCode = context.Variables.GetValueOrDefault<string>("paymentTypeCode", string.Empty);
        if (string.IsNullOrEmpty(ecommerceMethodsRedirectUrlMap) || string.IsNullOrEmpty(paymentTypeCode))
        {
            return null;
        }
        JObject urlsObject = JObject.Parse(ecommerceMethodsRedirectUrlMap);
        return urlsObject.GetValue(paymentTypeCode, StringComparison.OrdinalIgnoreCase)?.ToString();
    }" />
    <choose>
        <when condition="@(string.IsNullOrEmpty((string)context.Variables["baseUrl"]))">
            <return-response>
                <set-status code="404" reason="Not Found" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>@{
                    return new JObject(
                        new JProperty("title", "Configuration Not Found"),
                        new JProperty("detail", $"No redirect URL configured for the payment type: '{context.Variables.GetValueOrDefault<string>("paymentTypeCode", "N/A")}'."),
                        new JProperty("status", 404)
                    ).ToString();
                }</set-body>
            </return-response>
        </when>
        <otherwise>
            <return-response>
              <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
              </set-header>
              <set-body>@{
                  string sessionToken = context.Variables.GetValueOrDefault<string>("token", string.Empty);
                  string paymentMethodId = context.Variables.GetValueOrDefault<string>("paymentMethodId", string.Empty);
                  string rptId = context.Variables.GetValueOrDefault<string>("rptId", string.Empty);
                  string amount = context.Variables.GetValueOrDefault<string>("amount", string.Empty);
                  string finalRedirectUrl = (string)context.Variables["baseUrl"]
                         + "#clientId=IO&sessionToken=" + sessionToken
                         + "&paymentMethodId=" + paymentMethodId
                         + "&rptId=" + rptId
                         + "&amount=" + amount;

                  var response = new JObject();
                  response["redirectUrl"] = finalRedirectUrl;
                  return response.ToString();
              }</set-body>
            </return-response>
        </otherwise>
    </choose>
    <!-- pagoPA platform get payment methods redirect url : END -->
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
