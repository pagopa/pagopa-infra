<policies>
  <inbound>
    <base />

    <set-variable name="requestBody" value="@( (JObject) context.Request.Body.As<JObject>(preserveContent: true) )" />
    <set-variable name="sessionId" value="@( (string) ((JObject) context.Variables["requestBody"])["sessionId"] )" />

    <cache-lookup-value variable-name="paymentMethod" key="@( (string) context.Variables["sessionId"] )" />
    <choose>
      <when condition="@( ((string) context.Variables["paymentMethod"]) == "CARDS")">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body>
            @{
              var response = "{\n" +
              "  \"state\": \"PAYMENT_COMPLETE\",\n" +
              "  \"operation\": {\n" +
              "    \"orderId\": \"btid2384983\",\n" +
              "    \"operationId\": \"3470744\",\n" +
              "    \"channel\": \"ECOMMERCE\",\n" +
              "    \"operationType\": \"CAPTURE\",\n" +
              "    \"operationResult\": \"THREEDS_FAILED\",\n" +
              "    \"operationTime\": \"2022-09-01T01:20:00.001Z\",\n" +
              "    \"paymentMethod\": \"CARD\",\n" +
              "    \"paymentCircuit\": \"VISA\",\n" +
              "    \"paymentInstrumentInfo\": \"***6152\",\n" +
              "    \"paymentEndToEndId\": \"e723hedsdew\",\n" +
              "    \"cancelledOperationId\": \"\",\n" +
              "    \"operationAmount\": \"3545\",\n" +
              "    \"operationCurrency\": \"EUR\",\n" +
              "    \"customerInfo\": {\n" +
              "      \"cardHolderName\": \"Mauro Morandi\",\n" +
              "      \"cardHolderEmail\": \"mauro.morandi@nexi.it\",\n" +
              "      \"billingAddress\": {\n" +
              "        \"name\": \"Mario Rossi\",\n" +
              "        \"street\": \"Piazza Maggiore, 1\",\n" +
              "        \"additionalInfo\": \"Quinto Piano, Scala B\",\n" +
              "        \"city\": \"Bologna\",\n" +
              "        \"postCode\": \"40124\",\n" +
              "        \"province\": \"BO\",\n" +
              "        \"country\": \"ITA\"\n" +
              "      },\n" +
              "      \"shippingAddress\": {\n" +
              "        \"name\": \"Mario Rossi\",\n" +
              "        \"street\": \"Piazza Maggiore, 1\",\n" +
              "        \"additionalInfo\": \"Quinto Piano, Scala B\",\n" +
              "        \"city\": \"Bologna\",\n" +
              "        \"postCode\": \"40124\",\n" +
              "        \"province\": \"BO\",\n" +
              "        \"country\": \"ITA\"\n" +
              "      },\n" +
              "      \"mobilePhoneCountryCode\": \"39\",\n" +
              "      \"mobilePhone\": \"3280987654\",\n" +
              "      \"homePhone\": \"391231234567\",\n" +
              "      \"workPhone\": \"391231234567\",\n" +
              "      \"cardHolderAcctInfo\": {\n" +
              "        \"chAccDate\": \"2019-02-11\",\n" +
              "        \"chAccAgeIndicator\": \"01\",\n" +
              "        \"chAccChangeDate\": \"2019-02-11\",\n" +
              "        \"chAccChangeIndicator\": \"01\",\n" +
              "        \"chAccPwChangeDate\": \"2019-02-11\",\n" +
              "        \"chAccPwChangeIndicator\": \"01\",\n" +
              "        \"nbPurchaseAccount\": 0,\n" +
              "        \"destinationAddressUsageDate\": \"2019-02-11\",\n" +
              "        \"destinationAddressUsageIndicator\": \"01\",\n" +
              "        \"destinationNameIndicator\": \"01\",\n" +
              "        \"txnActivityDay\": 0,\n" +
              "        \"txnActivityYear\": 0,\n" +
              "        \"provisionAttemptsDay\": 0,\n" +
              "        \"suspiciousAccActivity\": \"01\",\n" +
              "        \"paymentAccAgeDate\": \"2019-02-11\",\n" +
              "        \"paymentAccIndicator\": \"0\"\n" +
              "      },\n" +
              "      \"merchantRiskIndicator\": {\n" +
              "        \"deliveryEmail\": \"john.doe@email.com\",\n" +
              "        \"deliveryTimeframe\": \"01\",\n" +
              "        \"giftCardAmount\": null,\n" +
              "        \"giftCardCount\": 0,\n" +
              "        \"preOrderDate\": \"2019-02-11\",\n" +
              "        \"preOrderPurchaseIndicator\": \"01\",\n" +
              "        \"reorderItemsIndicator\": \"01\",\n" +
              "        \"shipIndicator\": \"01\"\n" +
              "      }\n" +
              "    },\n" +
              "    \"warnings\": [\n" +
              "      {\n" +
              "        \"code\": \"TRA001\",\n" +
              "        \"description\": \"3DS warning\"\n" +
              "      }\n" +
              "    ],\n" +
              "    \"paymentLinkId\": \"234244353\",\n" +
              "    \"additionalData\": {\n" +
              "      \"authorizationCode\": \"647189\",\n" +
              "      \"cardCountry\": \"ITA\",\n" +
              "      \"threeDS\": \"FULL_SECURE\",\n" +
              "      \"schemaTID\": \"MCS01198U\",\n" +
              "      \"multiCurrencyConversion\": {\n" +
              "        \"amount\": \"2662\",\n" +
              "        \"currency\": \"JPY\",\n" +
              "        \"exchangeRate\": \"0.007510523\"\n" +
              "      }\n" +
              "    }\n" +
              "  }\n" +
              "}\n";
              
              return response;
            }
          </set-body>
        </return-response>
      </when>
      <otherwise>
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body>
          @{
            var response =
            "{\n" +
            "  \"sessionId\": \"" + context.Variables["sessionId"] + "\",\n" +
            "  \"securityToken\": \"SECURITY_TOKEN\",\n" +
            "  \"state\": \"REDIRECT_TO_EXTERNAL_DOMAIN\",\n" +
            "  \"url\": \"https://example.com\"\n" +
            "}\n";

            return response;
          }
          </set-body>
        </return-response>
      </otherwise>
    </choose>
  </inbound>
  <outbound>
    <base />
  </outbound>
  <backend>
    <base />
  </backend>
  <on-error>
    <base />
  </on-error>
</policies>