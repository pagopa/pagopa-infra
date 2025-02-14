<policies>
    <inbound>
        <base />

        <rate-limit-by-key calls="10" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />

        <send-request ignore-error="true" mode="new" response-variable-name="transactionServiceLiveness" timeout="10">
            <set-url>
                https://${hostname}/pagopa-ecommerce-transactions-service/actuator/health/liveness
            </set-url>
            <set-method>GET</set-method>
        </send-request>

         <send-request ignore-error="true" mode="new" response-variable-name="paymentMethodServiceLiveness" timeout="10">
            <set-url>
                https://${hostname}/pagopa-ecommerce-payment-methods-service/actuator/health/liveness
            </set-url>
            <set-method>GET</set-method>
        </send-request>

        <send-request ignore-error="true" mode="new" response-variable-name="paymentRequestServiceLiveness" timeout="10">
            <set-url>
                https://${hostname}/pagopa-ecommerce-payment-requests-service/actuator/health/liveness
            </set-url>
            <set-method>GET</set-method>
        </send-request>

        <send-request ignore-error="true" mode="new" response-variable-name="userStatServiceLiveness" timeout="10">
            <set-url>
                https://${hostname}/pagopa-ecommerce-user-stats-service/actuator/health/liveness
            </set-url>
            <set-method>GET</set-method>
        </send-request>

        <send-request ignore-error="true" mode="new" response-variable-name="eventDispatcherServiceLiveness" timeout="10">
            <set-url>
                https://${hostname}/pagopa-ecommerce-event-dispatcher/actuator/health/liveness
            </set-url>
            <set-method>GET</set-method>
        </send-request>

        <send-request ignore-error="true" mode="new" response-variable-name="transactionSchedulerServiceLiveness" timeout="10">
            <set-url>
                https://${hostname}/pagopa-ecommerce-transactions-scheduler-service/actuator/health/liveness
            </set-url>
            <set-method>GET</set-method>
        </send-request>

    </inbound>
    <backend>
    </backend>
    <outbound>
        <base />
        <set-body>
            @{ 
                var services = new[] {
                    "transactionServiceLiveness",
                    "paymentMethodServiceLiveness",
                    "paymentRequestServiceLiveness",
                    "userStatServiceLiveness",
                    "eventDispatcherServiceLiveness",
                    "transactionSchedulerServiceLiveness"
                };

                var combinedResults = new JObject();

                bool allUp = true;
 
                foreach (var service in services) {

                    var serviceResponse = context.Variables[service] as IResponse;
                    
                    bool isServiceUp = serviceResponse.StatusCode == 200;
                    JObject parsedResponse = isServiceUp ? serviceResponse.Body.As<JObject>() : new JObject(new JProperty("status", "DOWN"));
                    
                    combinedResults[service] = parsedResponse;

                    if (isServiceUp && (string)parsedResponse["status"] != "UP" || !isServiceUp) {
                        allUp = false;
                    } 
                }
 
                var response = new JObject();
                 
                response["status"] = allUp ? "UP" : "DOWN";
                response["details"] = combinedResults;

                return response.ToString();
            }
        </set-body>
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
