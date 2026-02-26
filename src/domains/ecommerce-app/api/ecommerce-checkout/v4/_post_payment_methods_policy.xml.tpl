<policies>
  <inbound>
    <base />
    <set-variable name="paymentMethodsRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
    <set-body>
      @{
      var languages = new string[]{"IT", "EN", "FR", "DE", "SL"};
      JObject requestBody = (JObject)context.Variables["paymentMethodsRequestBody"];
      string language = (string)requestBody["language"];
      if(string.IsNullOrEmpty(language)) {
      language = "IT";
      } else {
      if(language.Contains("-")) {
      language = language.Split('-')[0].ToUpperInvariant();
      }
      if(!languages.Contains(language.ToUpperInvariant())) {
      language = "IT";
      } else {
      language = language.ToUpperInvariant();
      }
      }
      requestBody["language"] = language;
      return requestBody.ToString();
      }
    </set-body>
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
