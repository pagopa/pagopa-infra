<policies>
    <inbound>
    <base />
    </inbound>
    <outbound>
        <base />
        <!-- APM test START -->
        <choose>
            <when condition="@(!((string)context.Request.Headers.GetValueOrDefault("X-Forwarded-For","")).Equals("PLACEHOLDER") && ((string)context.Request.Headers.GetValueOrDefault("origin","")).Equals("https://checkout.pagopa.it"))">
                <set-variable name="responseBody" value="@(context.Response.Body.As<JObject>(preserveContent: true))" />
                    <set-body>@{ 

                        JObject inResponseBody = (JObject)context.Variables["responseBody"]; 
                        JArray methods = (JArray)(inResponseBody["paymentMethods"]);

                        for(int i = methods.Count - 1; i >= 0; i--) {
                            String methodName = (string)((JObject)methods[i])["name"];
                            if( !methodName.Equals("CARDS") ) {
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
