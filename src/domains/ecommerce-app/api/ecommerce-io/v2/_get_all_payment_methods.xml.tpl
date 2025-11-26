<policies>
    <inbound>
        <base />
        <set-variable name="totalAmount" value="@(context.Request.Url.Query.GetValueOrDefault("amount",""))" />
    </inbound>
    <outbound>
        <base />
        <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
            <set-url>https://${ecommerce_ingress_hostname}/pagopa-ecommerce-payment-methods-handler/payment-methods</set-url>
            <set-method>POST</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-header name="x-client-id" exists-action="override">
                <value>IO</value>
            </set-header>
            <!-- Set payment-methods API Key header -->
            <set-header name="x-api-key" exists-action="override">
                <value>{{ecommerce-payment-methods-api-key-value}}</value>
            </set-header>
            <set-body>@{
                    var userTouchpoint = "IO";
                    var totalAmountValue = Convert.ToInt64(context.Variables.GetValueOrDefault("totalAmount", "0"));                    var paymentNotice = new JObject();
                    paymentNotice["paymentAmount"] = totalAmountValue;
                    paymentNotice["primaryCreditorInstitution"] = "77777777777";
                    var paymentNoticeList = new JArray();
                    paymentNoticeList.Add(paymentNotice);
                    return new JObject(
                            new JProperty("userTouchpoint", userTouchpoint),
                            new JProperty("totalAmount", totalAmountValue),
                            new JProperty("paymentNotice", paymentNoticeList)
                        ).ToString();
                  }</set-body>
        </send-request>
        <set-variable name="paymentMethodsResponseBody" value="@(((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />
        <choose>
            <when condition="@(((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode != 200)">
                <return-response>
                    <set-status code="502" reason="Bad Gateway" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>{
                                    "title": "Error retrieving eCommerce payment methods",
                                    "status": 502,
                                    "detail": "There was an error retrieving eCommerce payment methods"
                                }</set-body>
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@{
                        JObject paymentMethodsResponseBody = context.Response.Body.As<JObject>(preserveContent: true);
                        JArray paymentMethodsResponse = (JArray)paymentMethodsResponseBody["paymentMethods"];
                        JArray paymentHandlerResponse = new JArray();

                        var totalAmountValue = Convert.ToInt64(context.Variables.GetValueOrDefault("totalAmount", "0"));
                        foreach (JObject sourceMethod in paymentMethodsResponse)
                        {
                            JObject targetMethod = new JObject();

                            // Mapping
                            targetMethod["id"] = sourceMethod["id"];
                            targetMethod["status"] = sourceMethod["status"];
                            targetMethod["paymentTypeCode"] = sourceMethod["paymentTypeCode"];
                            targetMethod["methodManagement"] = sourceMethod["methodManagement"];
                            targetMethod["asset"] = sourceMethod["paymentMethodAsset"];

                            // Mapping multilanguage fields

                                targetMethod["name"] = "No_Name";
                                targetMethod["description"] = "No_Description";


                            JArray rangesArray = new JArray();

                            JObject rangeItem = new JObject(
                                new JProperty("min",0),
                                new JProperty("max",99999999)
                            );
                            rangesArray.Add(rangeItem);

                            targetMethod["ranges"] = rangesArray;
                            if (sourceMethod.ContainsKey("paymentMethodsBrandAssets") && sourceMethod["paymentMethodsBrandAssets"].HasValues)
                            {
                                targetMethod["brandAssets"] = sourceMethod["paymentMethodsBrandAssets"];
                            }
                            paymentHandlerResponse.Add(targetMethod);
                        }

                        JObject targetJson = new JObject(
                            new JProperty("paymentMethods", paymentHandlerResponse)
                        );

                        return targetJson.ToString();
                    }</set-body>
                </return-response>
            </otherwise>
        </choose>
    </outbound>
    <on-error>
        <base />
    </on-error>
    <backend>
        <base />
    </backend>
</policies>
