<policies>
    <inbound>
    <base />
    </inbound>
    <outbound>
        <base />
        <!-- APM test START -->
        <choose>
            <when condition="@(!((string)context.Request.Headers.GetValueOrDefault("X-Forwarded-For","")).Contains("PLACEHOLDER") && ((string)context.Request.Headers.GetValueOrDefault("origin","")).Equals("https://checkout.pagopa.it"))">
                <set-variable name="responseBody" value="@(context.Response.Body.As<JObject>(preserveContent: true))" />
                    <set-body>@{ 

                        JObject inResponseBody = (JObject)context.Variables["responseBody"]; 
                        JArray methods = (JArray)(inResponseBody["paymentMethods"]);
                        HashSet<String> allowedPaymentTypeCodes = new HashSet<String>();
                        allowedPaymentTypeCodes.Add("CP"); //CARTE
                        allowedPaymentTypeCodes.Add("RBPB");//Conto BancoPosta Impresa BPIOL
                        allowedPaymentTypeCodes.Add("RBPP");//Paga con Postepay
                        allowedPaymentTypeCodes.Add("RBPR");//Conto BancoPosta
                        allowedPaymentTypeCodes.Add("RPIC");//Redirect Intesa
                        //allowedPaymentTypeCodes.Add("BPAY");
                        //allowedPaymentTypeCodes.Add("PPAL");
                        //allowedPaymentTypeCodes.Add("BPAY");
                        for(int i = methods.Count - 1; i >= 0; i--) {
                            String paymentTypeCode = (string)((JObject)methods[i])["paymentTypeCode"];
                            if( !allowedPaymentTypeCodes.Contains(paymentTypeCode) ) {
                                methods.RemoveAt(i);
                            }
                        }
                        inResponseBody["paymentMethods"] = (JArray) methods;
                        return inResponseBody.ToString(); 

                    }</set-body>
            </when>
        </choose>
        <!-- APM test END -->
    </outbound>
    <backend>
        <base />
    </backend>
    <on-error>
        <base />
    </on-error>
</policies>
