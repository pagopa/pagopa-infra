<policies>
  <inbound>
    <base />
    <set-variable name="orderId" value="@(context.Request.MatchedParameters["orderId"])"/>
     <choose>
       <when condition="@(((string)(context.Variables["orderId"])).Equals("E00000000000000000"))">    
        <!-- transaction already refunded -->
          <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
            </set-header>
            <set-body template="liquid">
            {
                "operations": [
                    {
                        "additionalData": {
                            "maskedPan": "123456******1234",
                            "authorizationCode": "000000",
                            "cardId": "0123456789012345678901234567890123456789012345678901234567890123",
                            "cardType": "NONE",
                            "authorizationStatus": "000",
                            "cardId4": "01234567890123456789012345678901234567890123",
                            "cardExpiryDate": "203002",
                            "rrn": "012345678901"
                        },
                        "cancelledOperationId": "",
                        "customerInfo": {
                            "cardHolderName": "Test test"
                        },
                        "operationAmount": "12150",
                        "operationCurrency": "EUR",
                        "operationId": "012345678901234567",
                        "operationResult": "EXECUTED",
                        "operationTime": "2025-01-01 00:00:00.000",
                        "operationType": "AUTHORIZATION",
                        "orderId": "E00000000000000001",
                        "paymentCircuit": "MC",
                        "paymentEndToEndId": "01234567890123456",
                        "paymentInstrumentInfo": "***1234",
                        "paymentMethod": "CARD",
                        "warnings": []
                    },
                    {
                        "additionalData": {
                            "maskedPan": "123456******1234",
                            "authorizationCode": "000000",
                            "cardId": "0123456789012345678901234567890123456789012345678901234567890123",
                            "cardType": "NONE",
                            "authorizationStatus": "000",
                            "cardId4": "01234567890123456789012345678901234567890123=",
                            "cardExpiryDate": "203012",
                            "rrn": "012345678901"
                        },
                        "cancelledOperationId": "",
                        "channel": "BACKOFFICE",
                        "customerInfo": {
                            "cardHolderName": "Test test"
                        },
                        "operationAmount": "12150",
                        "operationCurrency": "EUR",
                        "operationId": "1779d43c-33ae-4a61-b1db-79c0149307ea",
                        "operationResult": "VOIDED",
                        "operationTime": "2024-05-09 12:36:53.971",
                        "operationType": "REFUND",
                        "orderId": "E00000000000000001",
                        "paymentCircuit": "MC",
                        "paymentEndToEndId": "773217006343441309",
                        "paymentInstrumentInfo": "***1234",
                        "paymentMethod": "CARD",
                        "warnings": []
                    }
                ],
                "orderStatus": {
                    "authorizedAmount": "0",
                    "capturedAmount": "0",
                    "lastOperationTime": "2024-05-09T12:36:53.971+02:00",
                    "lastOperationType": "REFUND",
                    "order": {
                        "amount": "12150",
                        "currency": "EUR",
                        "customerInfo": {
                            "cardHolderName": "M T "
                        },
                        "orderId": "E1715250857822A99g",
                        "termsAndConditionsIds": [],
                        "transactionSummary": []
                    }
                }
            }
            </set-body>
          </return-response>  
        </when>
       <when condition="@(((string)(context.Variables["orderId"])).Equals("E00000000000000001"))">
        <!-- 404 transaction not found -->
          <return-response>
            <set-status code="404" reason="Not found" />
          </return-response>
        </when>
       <when condition="@(((string)(context.Variables["orderId"])).Equals("E00000000000000002"))">
        <!-- 500 Internal server error -->
          <return-response>
            <set-status code="500" reason="Internal server error" />
          </return-response>
        </when>
        <otherwise>
        <!-- transaction authorized only -->
          <return-response>
              <set-status code="200" reason="OK" />
              <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
              </set-header>
              <set-body template="liquid">
                  {
                      "operations": [
                          {
                              "additionalData": {
                                  "maskedPan": "123456******1234",
                                  "authorizationCode": "000000",
                                  "cardId": "0123456789012345678901234567890123456789012345678901234567890123",
                                  "cardType": "NONE",
                                  "authorizationStatus": "000",
                                  "cardId4": "01234567890123456789012345678901234567890123",
                                  "cardExpiryDate": "203002",
                                  "rrn": "012345678901"
                              },
                              "cancelledOperationId": "",
                              "customerInfo": {
                                  "cardHolderName": "Test test"
                              },
                              "operationAmount": "12150",
                              "operationCurrency": "EUR",
                              "operationId": "012345678901234567",
                              "operationResult": "EXECUTED",
                              "operationTime": "2025-01-01 00:00:00.000",
                              "operationType": "AUTHORIZATION",
                              "orderId": "E01234567890123456",
                              "paymentCircuit": "MC",
                              "paymentEndToEndId": "01234567890123456",
                              "paymentInstrumentInfo": "***1234",
                              "paymentMethod": "CARD",
                              "warnings": []
                          }
                      ],
                      "orderStatus": {
                          "authorizedAmount": "0",
                          "capturedAmount": "0",
                          "lastOperationTime": "2024-05-09T12:36:53.971+02:00",
                          "lastOperationType": "CAPTURE",
                          "order": {
                              "amount": "12150",
                              "currency": "EUR",
                              "customerInfo": {
                                  "cardHolderName": "M T "
                              },
                              "orderId": "E1715250857822A99g",
                              "termsAndConditionsIds": [],
                              "transactionSummary": []
                          }
                      }
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