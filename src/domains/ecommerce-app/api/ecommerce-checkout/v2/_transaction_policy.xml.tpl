<policies>
    <inbound>
    <!-- Check google reCAPTCHA token validity START -->
    <set-variable name="recaptchaSecret" value="{{google-recaptcha-secret}}" />
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
    <!-- pass rptId value into header END -->

    <!-- Post Token PDV START-->
    <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
        <set-url>${pdv_api_base_path}/tokens</set-url>
        <set-method>PUT</set-method>
        <set-header name="x-api-key" exists-action="override">
            <value>{{ecommerce-personal-data-vault-api-key}}</value>
        </set-header>
        <set-body>@{
        JObject requestBody = (JObject)context.Request.Body.As<JObject>(true);
        return new JObject(
                new JProperty("pii",  (string)requestBody["email"])
            ).ToString();
            }</set-body>
    </send-request>
    <choose>
        <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
        <return-response>
            <set-status code="502" reason="Bad Gateway" />
        </return-response>
        </when>
    </choose>
    <set-variable name="pdvToken" value="@(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())" />
    <set-variable name="emailToken" value="@((string)((JObject)context.Variables["pdvToken"])["token"])" />
    <choose>
        <when condition="@(String.IsNullOrEmpty((string)context.Variables["emailToken"]))">
            <return-response>
                <set-status code="502" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>@{
                    return new JObject(
                    new JProperty("title", "Bad gateway - Invalid PDV response"),
                    new JProperty("status", 502),
                    new JProperty("detail", "Cannot tokenize fiscal code")
                    ).ToString();
                }
                </set-body>
            </return-response>
        </when>
    </choose>
    <!-- Post Token PDV END-->
    <set-body>@{
        JObject requestBody = (JObject)context.Request.Body.As<JObject>(true);
        string emailToken = (string) context.Variables["emailToken"];

        requestBody.Remove("email");
        requestBody["emailToken"] = emailToken;

        return requestBody.toString();
    }
    </set-body>
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