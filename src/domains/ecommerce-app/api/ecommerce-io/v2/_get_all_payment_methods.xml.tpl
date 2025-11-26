<policies>
    <inbound>
        <base />
        <set-variable name="totalAmount" value="@(context.Request.Url.Query.GetValueOrDefault("amount",""))" />
    </inbound>
    <outbound>
        <base />
            <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
                <set-url>@("https://${ecommerce_ingress_hostname}/pagopa-ecommerce-payment-methods-handler/payment-methods")</set-url>
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
                    var totalAmount = (context.Variables.GetValueOrDefault("totalAmount",0));
                    var paymentNotice = new JObject();
                    paymentNotice["paymentAmount"] = totalAmount;
                    paymentNotice["primaryCreditorInstitution"] = "77777777777";
                    var paymentNoticeList = new JArray();
                    paymentNoticeList.Add(paymentNotice);
                    return new JObject(
                            new JProperty("userTouchpoint", userTouchpoint),
                            new JProperty("totalAmount", totalAmount),
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
                            <set-body>
                                {
                                    "title": "Error retrieving eCommerce payment methods",
                                    "status": 502,
                                    "detail": "There was an error retrieving eCommerce payment methods"
                                }
                            </set-body>
                        </return-response>
                    </when>
                </choose>
                <otherwise>
                    <set-body template="liquid">
                        @{
                            JObject paymentMethodsResponseBody;
                            JArray paymentMethodsResponse;
                            JArray paymentHandlerResponse = new JArray();

                            try
                            {
                                paymentMethodsResponseBody = context.Response.Body.As<JObject>(preserveContent: true);
                                paymentMethodsResponse = (JArray)paymentMethodsResponseBody["paymentMethods"];

                                foreach (JObject sourceMethod in paymentMethodsResponse)
                                {
                                    JObject targetMethod = new JObject();

                                    // Mapping
                                    targetMethod["id"] = sourceMethod["id"];
                                    targetMethod["status"] = sourceMethod["status"];
                                    targetMethod["paymentTypeCode"] = sourceMethod["paymentTypeCode"];
                                    targetMethod["methodManagement"] = sourceMethod["methodManagement"];
                                    targetMethod["asset"] = sourceMethod["paymentMethodAsset"];

                                    // Mapping multilanguage fields. No
                                    if (sourceMethod["name"] != null && sourceMethod["name"]["IT"] != null)
                                    {
                                        targetMethod["name"] = sourceMethod["name"]["IT"];
                                    } else {
                                        // throw exception
                                    }

                                    if (sourceMethod["description"] != null && sourceMethod["description"]["IT"] != null)
                                    {
                                        targetMethod["description"] = sourceMethod["description"]["IT"];
                                    } else {
                                        // throw exception
                                    }

                                    JArray rangesArray = new JArray();
                                    JObject feeRange = (JObject)sourceMethod["feeRange"];
                                    if (feeRange != null)
                                    {
                                        JObject rangeItem = new JObject
                                        {
                                            { "min", feeRange["min"] },
                                            { "max", feeRange["max"] }
                                        };
                                        rangesArray.Add(rangeItem);
                                    }
                                    targetMethod["ranges"] = rangesArray;
                                    if (sourceMethod.ContainsKey("paymentMethodsBrandAssets") && sourceMethod["paymentMethodsBrandAssets"].HasValues)
                                    {
                                         targetMethod["brandAssets"] = sourceMethod["paymentMethodsBrandAssets"];
                                    }
                                    targetMethods.Add(targetMethod);
                                }
                                JObject targetJson = new JObject(
                                  new JProperty("paymentMethods",targetMethods),
                                )

                                return targetJson.ToString();
                            }
                            catch (Exception ex)
                            {
                                var errorBody = new JObject (
                                   new JProperty("title","Error retrieving eCommerce payment methods"),
                                   new JProperty("status", 502),
                                   new JProperty("detail", "There was an error retrieving eCommerce payment methods")
                               );
                               return errorBody.ToString();
                            }
                        }
                    </set-body>
                </otherwise>
        </outbound>
        <backend>
            <base />
        </backend>
        <on-error>
            <base />
        </on-error>
    </outbound>
    </policies>
