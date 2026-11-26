<policies>
    <inbound>
      <base />
      <!-- Check google reCAPTCHA token validity START -->
      <set-variable name="recaptchaSecret" value="{{ecommerce-for-checkout-google-recaptcha-secret}}" />
      <set-variable name="recaptchaToken" value="@(context.Request.OriginalUrl.Query.GetValueOrDefault("recaptcha"))" />
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
