<policies>
  <inbound>
    <base />

    <return-response>
      <set-status code="200" reason="OK" />
      <set-header name="Content-Type" exists-action="override">
        <value>application/json</value>
      </set-header>
      <set-body template="liquid">
      {
        "state": "PAYMENT_COMPLETE",
        "operation": {
          "orderId": "btid2384983",
          "operationId": "3470744",
          "channel": "ECOMMERCE",
          "operationType": "CAPTURE",
          "operationResult": "AUTHORIZED",
          "operationTime": "2022-09-01T01:20:00.001Z",
          "paymentMethod": "CARD",
          "paymentCircuit": "VISA",
          "paymentInstrumentInfo": "***6152",
          "paymentEndToEndId": "e723hedsdew",
          "cancelledOperationId": "",
          "operationAmount": "3545",
          "operationCurrency": "EUR",
          "customerInfo": {
            "cardHolderName": "Mauro Morandi",
            "cardHolderEmail": "mauro.morandi@nexi.it",
            "billingAddress": {
              "name": "Mario Rossi",
              "street": "Piazza Maggiore, 1",
              "additionalInfo": "Quinto Piano, Scala B",
              "city": "Bologna",
              "postCode": "40124",
              "province": "BO",
              "country": "ITA"
            },
            "shippingAddress": {
              "name": "Mario Rossi",
              "street": "Piazza Maggiore, 1",
              "additionalInfo": "Quinto Piano, Scala B",
              "city": "Bologna",
              "postCode": "40124",
              "province": "BO",
              "country": "ITA"
            },
            "mobilePhoneCountryCode": "39",
            "mobilePhone": "3280987654",
            "homePhone": "391231234567",
            "workPhone": "391231234567",
            "cardHolderAcctInfo": {
              "chAccDate": "2019-02-11",
              "chAccAgeIndicator": "01",
              "chAccChangeDate": "2019-02-11",
              "chAccChangeIndicator": "01",
              "chAccPwChangeDate": "2019-02-11",
              "chAccPwChangeIndicator": "01",
              "nbPurchaseAccount": 0,
              "destinationAddressUsageDate": "2019-02-11",
              "destinationAddressUsageIndicator": "01",
              "destinationNameIndicator": "01",
              "txnActivityDay": 0,
              "txnActivityYear": 0,
              "provisionAttemptsDay": 0,
              "suspiciousAccActivity": "01",
              "paymentAccAgeDate": "2019-02-11",
              "paymentAccIndicator": "0"
            },
            "merchantRiskIndicator": {
              "deliveryEmail": "john.doe@email.com",
              "deliveryTimeframe": "01",
              "giftCardAmount": null,
              "giftCardCount": 0,
              "preOrderDate": "2019-02-11",
              "preOrderPurchaseIndicator": "01",
              "reorderItemsIndicator": "01",
              "shipIndicator": "01"
            }
          },
          "warnings": [
            {
              "code": "TRA001",
              "description": "3DS warning"
            }
          ],
          "paymentLinkId": "234244353",
          "additionalData": {
            "authorizationCode": "647189",
            "cardCountry": "ITA",
            "threeDS": "FULL_SECURE",
            "schemaTID": "MCS01198U",
            "multiCurrencyConversion": {
              "amount": "2662",
              "currency": "JPY",
              "exchangeRate": "0.007510523"
            }
          }
        }
      }
      </set-body>
    </return-response>
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