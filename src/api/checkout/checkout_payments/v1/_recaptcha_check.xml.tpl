<policies>
    <inbound>
      <base />
      <!-- Check google reCAPTCHA token validity START -->
      <set-variable name="recaptchaSecret" value="{{google-recaptcha-secret}}" />
      <set-variable name="recaptchaToken" value="@(context.Request.OriginalUrl.Query.GetValueOrDefault("recaptchaResponse"))" />
      <set-variable name="recaptchaBodyRequest" value="@{
            return $"secret=${context.Variables["recaptchaSecret"]}&response=${context.Variables["recaptchaToken"]}";
        }" />
      <send-request ignore-error="true" timeout="10" response-variable-name="recaptcha-check" mode="new">
        <set-url>https://www.google.com/recaptcha/api/siteverify</set-url>
        <set-method>POST</set-method>
        <set-header name="Content-Type" exists-action="override">
            <value>application/x-www-form-urlencoded</value>
        </set-header>
        <set-body>{{context.Variables["recaptchaBodyRequest"]}}</set-body>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["recaptcha-check"]).StatusCode != 200)">
              <return-response>
                  <set-status code="401" reason="Unauthorized" />
              </return-response>
          </when>
      </choose>
      <!-- Check google reCAPTCHA token validity END -->
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
