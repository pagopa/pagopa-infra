<policies>
    <inbound>
        <base />
        <set-variable name="totalAmount" value="@(context.Request.Url.Query.GetValueOrDefault("amount",""))" />
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
                        var totalAmountValue = Convert.ToInt64(context.Variables.GetValueOrDefault("totalAmount", "0"));

                        JObject paymentMethodsResponseBody = ((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>();
                        JArray paymentHandlerResponse = new JArray();

                        JArray rangesArray = new JArray();
                        JObject rangeItem = new JObject
                        {
                            { "min", totalAmountValue - 1 },
                            { "max", totalAmountValue + 1 }
                        };
                        rangesArray.Add(rangeItem);

                        foreach (var sourceMethod in paymentMethodsResponseBody["paymentMethods"]) {
                            JObject paymentMethod = new JObject(
                                new JProperty("id", sourceMethod["id"]),
                                new JProperty("status", sourceMethod["status"]),
                                new JProperty("paymentTypeCode",sourceMethod["paymentTypeCode"]),
                                new JProperty("methodManagement", sourceMethod["methodManagement"]),
                                new JProperty("asset", sourceMethod["paymentMethodAsset"]),
                                new JProperty("ranges", rangesArray)
                            );

                            if (sourceMethod["paymentMethodsBrandAssets"] != null) {
                                paymentMethod["brandAssets"] = sourceMethod["paymentMethodsBrandAssets"];
                            }

                            if(sourceMethod["description"] != null) {
                                 paymentMethod["description"] = sourceMethod["description"]["IT"];
                            }

                            if(sourceMethod["name"] != null) {
                                string name = "";
                                if(((string)sourceMethod["paymentTypeCode"]) == "CP" && sourceMethod["name"]["EN"] != null) {
                                    name = (string)sourceMethod["name"]["EN"];
                                }
                                if(((string)sourceMethod["paymentTypeCode"]) != "CP" && sourceMethod["name"]["IT"] != null) {
                                    name = (string)sourceMethod["name"]["IT"];
                                }
                                if(name == "") {
                                    name = "no_name";
                                }
                                paymentMethod["name"] = name.ToUpper();
                            }

                            paymentHandlerResponse.Add(paymentMethod);
                        }


                        JObject targetJson = new JObject(
                            new JProperty("paymentMethods", paymentHandlerResponse)
                        );

                        return targetJson.ToString();
                    }</set-body>
                </return-response>
            </otherwise>
        </choose>
    </inbound>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
    <backend>
        <base />
    </backend>
</policies>
