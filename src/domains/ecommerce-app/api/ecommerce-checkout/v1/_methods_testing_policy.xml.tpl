<policies>
    <inbound>
    <base />
    </inbound>
    <outbound>
        <base />
        <!-- APM test START -->
        <set-variable name="allowedIps" value="PLACEHOLDER1,PLACEHOLDER2" />
        <set-variable name="callerIps" value="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For",""))" />
        <set-variable name="isTesterIp" value="@{
            var allowedIps = new HashSet<string>(context.Variables.GetValueOrDefault("allowedIps","").Split(','));
            string[] callerIps = context.Variables.GetValueOrDefault("callerIps","").Split(',');
            foreach (string callerIp in callerIps){
                if(allowedIps.Contains(callerIp)){
                    return true;
                }
            }
            return false;
        }" />
        <choose>
            <when condition="@(((Boolean)context.Variables.GetValueOrDefault("isTesterIp",false)) == false && ((string)context.Request.Headers.GetValueOrDefault("origin","")).Equals("https://checkout.pagopa.it"))">
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
                        allowedPaymentTypeCodes.Add("BPAY");//Bancompatpay
                        allowedPaymentTypeCodes.Add("PPAL");//Paypal
                        allowedPaymentTypeCodes.Add("MYBK");//Mybank
                        allowedPaymentTypeCodes.Add("RBPS");//Sondrio
                        allowedPaymentTypeCodes.Add("SATY");//Satispay
                        allowedPaymentTypeCodes.Add("APPL");//Applepay
                        allowedPaymentTypeCodes.Add("RICO");//iConto
                        allowedPaymentTypeCodes.Add("KLAR");//Klarna
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
