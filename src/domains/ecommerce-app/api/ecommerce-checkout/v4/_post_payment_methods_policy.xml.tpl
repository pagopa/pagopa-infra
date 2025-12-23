<policies>
  <inbound>
    <base />
    <set-variable name="paymentMethodsRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
    <set-body>
      @{
      var languages = new string[]{"IT", "EN", "FR", "DE", "SL"};
      JObject requestBody = (JObject)context.Variables["paymentMethodsRequestBody"];
      string language = (string)requestBody["language"];
      if(language.Contains("-")) {
      language = language.Split('-')[0];
      }
      if(!languages.Contains(language)) {
      language = "IT";
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
