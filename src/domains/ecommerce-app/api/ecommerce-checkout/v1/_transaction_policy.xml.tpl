<policies>
    <inbound>
    <!-- Check google reCAPTCHA token validity START -->
    <set-variable name="recaptchaSecret" value="{{ecommerce-for-checkout-google-recaptcha-secret}}" />
    <set-variable name="recaptchaToken" value="@(context.Request.OriginalUrl.Query.GetValueOrDefault("recaptchaResponse"))" />
    <choose>
        <when condition="@(context.Variables["recaptchaToken"] == null || context.Variables["recaptchaToken"] == "")">
            <return-response>
                <set-status code="401" reason="Unauthorized" />
            </return-response>
        </when>
    </choose>
    <send-request ignore-error="true" timeout="10" response-variable-name="recaptcha-check" mode="new">
        <set-url>https://www.google.com/recaptcha/api/siteverify</set-url>
        <set-method>POST</set-method>
        <set-header name="Content-Type" exists-action="override">
            <value>application/x-www-form-urlencoded</value>
        </set-header>
        <set-body>@($"secret={(string)context.Variables["recaptchaSecret"]}&response={(string)context.Variables["recaptchaToken"]}")</set-body>
    </send-request>
    <set-variable name="recaptcha-check-body" value="@(((IResponse)context.Variables["recaptcha-check"]).Body.As<JObject>())" />
    <choose>
      <when condition="@(((IResponse)context.Variables["recaptcha-check"]).StatusCode != 200 || ((bool) ((JObject) context.Variables["recaptcha-check-body"])["success"]) != true)">
        <return-response>
          <set-status code="401" reason="Unauthorized" />
          </return-response>
      </when>
    </choose>
    <!-- Check google reCAPTCHA token validity END -->
    <!-- pass rptId value into header START -->
    <set-header name="x-rpt-ids" exists-action="delete" />
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
            <set-header name="x-rpt-ids" exists-action="override">
                <value>@((string)context.Variables.GetValueOrDefault("rptIds",""))</value>
            </set-header>
        </when>
    </choose>
    <!-- pass rptId value into header END -->
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
