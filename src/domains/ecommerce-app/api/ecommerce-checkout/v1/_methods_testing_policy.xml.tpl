<policies>
    <inbound>
    <base />
    </inbound>
    <outbound>
        <base />
        <!-- APM test START -->
        <choose>
            <set-variable name="allowedIps" value="PLACEHOLDER1|PLACEHOLDER2" />
            <set-variable name="x-forwarded-for" value="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For",""))" />
            <set-variable name="isAllowed" value="@{
                var allowedIps = new HashSet<string>(context.Variables.GetValueOrDefault("allowedIps","").Split('|'));
                string[] callerIps = context.Variables.GetValueOrDefault("x-forwarded-for","").Split(',');
                foreach (string callerIp in callerIps){
                    if(allowedIps.Contains(callerIp)){
                        return true;
                    }
                }
                return false;
            }" />
            <when condition="@(!((bool)context.Variables.GetValueOrDefault("isAllowed",""))) && ((string)context.Request.Headers.GetValueOrDefault("origin","")).Equals("https://checkout.pagopa.it"))">
                <set-variable name="responseBody" value="@(context.Response.Body.As<JObject>(preserveContent: true))" />
                    <set-body>@{ 

                        JObject inResponseBody = (JObject)context.Variables["responseBody"]; 
                        JArray methods = (JArray)(inResponseBody["paymentMethods"]);
                        HashSet<String> allowedPaymentTypeCodes = new HashSet<String>();
                        allowedPaymentTypeCodes.Add("CP"); //CARTE
                        allowedPaymentTypeCodes.Add("RBPB");//Conto BancoPosta Impresa BPIOL
                        allowedPaymentTypeCodes.Add("RBPP");//Paga con Postepay
                        allowedPaymentTypeCodes.Add("RBPR");//Conto BancoPosta
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
