{
  "openapi": "3.0.1",
  "info": {
    "title": "Node-for-eCommerce",
    "description": "Node API to support eCommerce transactions",
    "version": "2.0.0"
  },
  "servers": [
    {
      "url": "http://${host}/"
    }
  ],
  "paths": {
    "/closepayment": {
      "post": {
        "tags": [
          "nodo"
        ],
        "summary": "closePaymentV2",
        "description": "Called after the request is validated by PPay",
        "operationId": "closePaymentV2",
        "parameters": [
          {
            "name": "clientId",
            "in": "query",
            "description": "The client who made the request",
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ClosePaymentRequestV2"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ClosePaymentResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "404": {
            "description": "Not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "408": {
            "description": "Request Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "422": {
            "description": "Unprocessable entry",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        },
        "x-codegen-request-body-name": "body"
      }
    }
  },
  "components": {
    "schemas": {
      "ClosePaymentResponse": {
        "required": [
          "outcome"
        ],
        "type": "object",
        "properties": {
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          }
        }
      },
      "Error": {
        "required": [
          "outcome",
          "description"
        ],
        "type": "object",
        "properties": {
          "outcome": {
            "type": "string",
            "example": "KO"
          },
          "description": {
            "type": "string",
            "example": "error description"
          }
        }
      },
      "CardAdditionalPaymentInformations": {
        "type": "object",
        "properties": {
          "outcomePaymentGateway": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "fee": {
            "type": "string",
            "description": "commision amount, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "totalAmount": {
            "type": "string",
            "description": "sum of payment advices amount and fee, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "timestampOperation": {
            "type": "string",
            "description": "timestampOperation of payment gateway converted in string with this format 'yyyy-MM-ddThh:mm:ss'",
            "format": "yyyy-MM-ddThh:mm:ss",
            "example": "2022-02-22T14:41:58"
          },
          "rrn": {
            "type": "string",
            "description": "Transaction identifier on the card circuit"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Authorization code sent by the payment gateway, present only if `outcomePaymentGateway` is `OK`"
          },
          "email": {
            "type": "string",
            "description": "User email used for the transaction outcome notification"
          },
          "paymentGateway": {
            "type": "string",
            "description": "Transaction payment gateway"
          }
        },
        "required": [
          "outcomePaymentGateway",
          "fee",
          "totalAmount",
          "timestampOperation"
        ]
      },
      "RedirectAdditionalPaymentInformations": {
        "type": "object",
        "description": "Additional payment data pertaining to Redirect-type payments",
        "properties": {
          "idTransaction": {
            "type": "string",
            "description": "Unique identifier for the transaction"
          },
          "idPSPTransaction": {
            "type": "string",
            "description": "Unique identifier for the transaction, given by the PSP"
          },
          "totalAmount": {
            "type": "string",
            "description": "sum of payment advices amount and fee, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "fee": {
            "type": "string",
            "description": "commision amount, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "timestampOperation": {
            "type": "string",
            "format": "yyyy-MM-ddThh:mm:ss",
            "description": "Transaction timestamp"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Authorization identifier, present only in case of successful authorization"
          }
        },
        "required": [
          "idTransaction",
          "idPSPTransaction",
          "totalAmount",
          "fee",
          "timestampOperation"
        ]
      },
      "PayPalAdditionalPaymentInformations": {
        "type": "object",
        "description": "Additional payment data pertaining to PayPal payments",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "Unique identifier for the transaction, generated by the payment gateway"
          },
          "pspTransactionId": {
            "type": "string",
            "description": "Unique identifier for the transaction, generated by the PSP that handled the transaction"
          },
          "totalAmount": {
            "type": "string",
            "description": "sum of payment advices amount and fee, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "fee": {
            "type": "string",
            "description": "commision amount, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "timestampOperation": {
            "type": "string",
            "format": "yyyy-MM-ddThh:mm:ss",
            "description": "Transaction timestamp"
          },
          "email": {
            "type": "string",
            "description": "User email used for the transaction outcome notification"
          }
        },
        "required": [
          "transactionId",
          "pspTransactionId",
          "totalAmount",
          "fee",
          "timestampOperation"
        ]
      },
      "BancomatPayAdditionalPaymentInformations": {
        "type": "object",
        "description": "Additional payment data pertaining to BancomatPay payments",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "Unique identifier for the transaction, generated by the payment gateway"
          },
          "outcomePaymentGateway": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ],
            "description": "Payment outcome"
          },
          "totalAmount": {
            "type": "string",
            "description": "sum of payment advices amount and fee, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "fee": {
            "type": "string",
            "description": "commision amount, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "timestampOperation": {
            "type": "string",
            "format": "yyyy-MM-ddThh:mm:ss",
            "description": "Transaction timestamp"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Unique identifier for the transaction, generated by the payment gateway"
          },
          "email": {
            "type": "string",
            "description": "User email used for the transaction outcome notification"
          }
        },
        "required": [
          "transactionId",
          "outcomePaymentGateway",
          "totalAmount",
          "fee",
          "timestampOperation",
          "authorizationCode"
        ]
      },
      "MyBankAdditionalPaymentInformations": {
        "type": "object",
        "description": "Additional payment data pertaining to MyBank payments",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "Unique identifier for the transaction, generated by the payment gateway"
          },
          "myBankTransactionId": {
            "type": "string",
            "description": "MyBank unique identifier for the transaction, generated by the payment gateway"
          },
          "totalAmount": {
            "type": "string",
            "description": "sum of payment advices amount and fee, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "fee": {
            "type": "string",
            "description": "commision amount, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "validationServiceId": {
            "type": "string",
            "description": "Value used for commission handling, generated by the payment gateway"
          },
          "timestampOperation": {
            "type": "string",
            "format": "yyyy-MM-ddThh:mm:ss",
            "description": "Transaction timestamp"
          },
          "email": {
            "type": "string",
            "description": "User email used for the transaction outcome notification"
          }
        },
        "required": [
          "transactionId",
          "myBankTransactionId",
          "totalAmount",
          "fee",
          "validationServiceId",
          "timestampOperation"
        ]
      },
      "SatispayAdditionalPaymentInformations": {
        "type": "object",
        "description": "Additional payment data pertaining to Satispay payments",
        "properties": {
          "satispayTransactionId": {
            "type": "string",
            "description": "Unique identifier for the transaction, generated by the payment gateway"
          },
          "totalAmount": {
            "type": "string",
            "description": "sum of payment advices amount and fee, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "fee": {
            "type": "string",
            "description": "commision amount, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "timestampOperation": {
            "type": "string",
            "format": "yyyy-MM-ddThh:mm:ss",
            "description": "Transaction timestamp"
          },
          "email": {
            "type": "string",
            "description": "User email used for the transaction outcome notification"
          }
        },
        "required": [
          "satispayTransactionId",
          "totalAmount",
          "fee",
          "timestampOperation"
        ]
      },
      "ApplePayAdditionalPaymentInformations": {
        "type": "object",
        "description": "Additional payment data pertaining to ApplePay payments",
        "properties": {
          "rrn": {
            "type": "string",
            "description": "Transaction identifier on the apple pay circuit"
          },
          "totalAmount": {
            "type": "string",
            "description": "sum of payment advices amount and fee, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "fee": {
            "type": "string",
            "description": "commision amount, converted in string",
            "format": "###.##",
            "example": "10.00"
          },
          "timestampOperation": {
            "type": "string",
            "format": "yyyy-MM-ddThh:mm:ss",
            "description": "Transaction timestamp present only in case of successful authorization"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Authorization identifier, present only in case of successful authorization"
          },
          "email": {
            "type": "string",
            "description": "User email used for the transaction outcome notification present only in case of successful authorization"
          },
          "authorizationRequestId": {
            "type": "string",
            "description": "Information about the authorization request id present only in case of successful authorization"
          }
        },
        "required": [
          "rrn",
          "totalAmount",
          "fee",
          "timestampOperation",
          "authorizationCode"
        ]
      },
      "RedirectClosePaymentRequestV2": {
        "required": [
          "fee",
          "idBrokerPSP",
          "idChannel",
          "idPSP",
          "outcome",
          "paymentMethod",
          "paymentTokens",
          "timestampOperation",
          "totalAmount",
          "transactionDetails",
          "transactionId",
          "additionalPaymentInformations"
        ],
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string",
            "description": "Payment method used in this transaction, required only for outcomePaymentGateway OK"
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "description": "required only for outcomePaymentGateway OK",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "idBundle": {
            "type": "string",
            "description": "Bundle id",
            "example": "733a12e7-5bc7-41f8-a5f1-a693bf57011f"
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "additionalPaymentInformations": {
            "$ref": "#/components/schemas/RedirectAdditionalPaymentInformations"
          }
        }
      },
      "CardClosePaymentRequestV2": {
        "required": [
          "fee",
          "idBrokerPSP",
          "idChannel",
          "idPSP",
          "outcome",
          "paymentMethod",
          "paymentTokens",
          "timestampOperation",
          "totalAmount",
          "transactionDetails",
          "transactionId",
          "additionalPaymentInformations"
        ],
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string",
            "description": "Payment method used in this transaction, required only for outcomePaymentGateway OK"
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "description": "required only for outcomePaymentGateway OK",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "idBundle": {
            "type": "string",
            "description": "Bundle id",
            "example": "733a12e7-5bc7-41f8-a5f1-a693bf57011f"
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "additionalPaymentInformations": {
            "$ref": "#/components/schemas/CardAdditionalPaymentInformations"
          }
        }
      },
      "PayPalClosePaymentRequestV2": {
        "required": [
          "fee",
          "idBrokerPSP",
          "idChannel",
          "idPSP",
          "outcome",
          "paymentMethod",
          "paymentTokens",
          "timestampOperation",
          "totalAmount",
          "transactionDetails",
          "transactionId",
          "additionalPaymentInformations"
        ],
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string",
            "description": "Payment method used in this transaction, required only for outcomePaymentGateway OK"
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "description": "required only for outcomePaymentGateway OK",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "idBundle": {
            "type": "string",
            "description": "Bundle id",
            "example": "733a12e7-5bc7-41f8-a5f1-a693bf57011f"
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "additionalPaymentInformations": {
            "$ref": "#/components/schemas/PayPalAdditionalPaymentInformations"
          }
        }
      },
      "BancomatPayClosePaymentRequestV2": {
        "required": [
          "fee",
          "idBrokerPSP",
          "idChannel",
          "idPSP",
          "outcome",
          "paymentMethod",
          "paymentTokens",
          "timestampOperation",
          "totalAmount",
          "transactionDetails",
          "transactionId",
          "additionalPaymentInformations"
        ],
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string",
            "description": "Payment method used in this transaction, required only for outcomePaymentGateway OK"
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "description": "required only for outcomePaymentGateway OK",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "idBundle": {
            "type": "string",
            "description": "Bundle id",
            "example": "733a12e7-5bc7-41f8-a5f1-a693bf57011f"
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "additionalPaymentInformations": {
            "$ref": "#/components/schemas/BancomatPayAdditionalPaymentInformations"
          }
        }
      },
      "MyBankClosePaymentRequestV2": {
        "required": [
          "fee",
          "idBrokerPSP",
          "idChannel",
          "idPSP",
          "outcome",
          "paymentMethod",
          "paymentTokens",
          "timestampOperation",
          "totalAmount",
          "transactionDetails",
          "transactionId",
          "additionalPaymentInformations"
        ],
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string",
            "description": "Payment method used in this transaction, required only for outcomePaymentGateway OK"
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "description": "required only for outcomePaymentGateway OK",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "idBundle": {
            "type": "string",
            "description": "Bundle id",
            "example": "733a12e7-5bc7-41f8-a5f1-a693bf57011f"
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "additionalPaymentInformations": {
            "$ref": "#/components/schemas/MyBankAdditionalPaymentInformations"
          }
        }
      },
      "ApplePayClosePaymentRequestV2": {
        "required": [
          "fee",
          "idBrokerPSP",
          "idChannel",
          "idPSP",
          "outcome",
          "paymentMethod",
          "paymentTokens",
          "timestampOperation",
          "totalAmount",
          "transactionDetails",
          "transactionId",
          "additionalPaymentInformations"
        ],
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string",
            "description": "Payment method used in this transaction, required only for outcomePaymentGateway OK"
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "description": "required only for outcomePaymentGateway OK",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "idBundle": {
            "type": "string",
            "description": "Bundle id",
            "example": "733a12e7-5bc7-41f8-a5f1-a693bf57011f"
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "additionalPaymentInformations": {
            "$ref": "#/components/schemas/ApplePayAdditionalPaymentInformations"
          }
        }
      },
      "SatispayClosePaymentRequestV2": {
        "required": [
          "fee",
          "idBrokerPSP",
          "idChannel",
          "idPSP",
          "outcome",
          "paymentMethod",
          "paymentTokens",
          "timestampOperation",
          "totalAmount",
          "transactionDetails",
          "transactionId",
          "additionalPaymentInformations"
        ],
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string",
            "description": "required only for outcomePaymentGateway OK"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string",
            "description": "Payment method used in this transaction, required only for outcomePaymentGateway OK"
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "required only for outcomePaymentGateway OK",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "description": "required only for outcomePaymentGateway OK",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "idBundle": {
            "type": "string",
            "description": "Bundle id",
            "example": "733a12e7-5bc7-41f8-a5f1-a693bf57011f"
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "additionalPaymentInformations": {
            "$ref": "#/components/schemas/SatispayAdditionalPaymentInformations"
          }
        }
      },
      "ClosePaymentRequestV2": {
        "oneOf": [
          {
            "$ref": "#/components/schemas/CardClosePaymentRequestV2"
          },
          {
            "$ref": "#/components/schemas/RedirectClosePaymentRequestV2"
          },
          {
            "$ref": "#/components/schemas/PayPalClosePaymentRequestV2"
          },
          {
            "$ref": "#/components/schemas/BancomatPayClosePaymentRequestV2"
          },
          {
            "$ref": "#/components/schemas/MyBankClosePaymentRequestV2"
          },
          {
            "$ref": "#/components/schemas/ApplePayClosePaymentRequestV2"
          },
          {
            "$ref": "#/components/schemas/SatispayClosePaymentRequestV2"
          }
        ],
        "discriminator": {
          "propertyName": "paymentMethod",
          "mapping": {
            "CP": "#/components/schemas/CardClosePaymentRequestV2",
            "RBPR": "#/components/schemas/RedirectClosePaymentRequestV2",
            "RBPB": "#/components/schemas/RedirectClosePaymentRequestV2",
            "RBPP": "#/components/schemas/RedirectClosePaymentRequestV2",
            "RPIC": "#/components/schemas/RedirectClosePaymentRequestV2",
            "RBPS": "#/components/schemas/RedirectClosePaymentRequestV2",
            "PPAL": "#/components/schemas/PayPalClosePaymentRequestV2",
            "BPAY": "#/components/schemas/BancomatPayClosePaymentRequestV2",
            "MYBK": "#/components/schemas/MyBankClosePaymentRequestV2",
            "APPL": "#/components/schemas/ApplePayClosePaymentRequestV2",
            "SATY": "#/components/schemas/SatispayClosePaymentRequestV2"
          }
        }
      },
      "TransactionDetails": {
        "required": [
          "info",
          "transaction",
          "user"
        ],
        "type": "object",
        "properties": {
          "transaction": {
            "$ref": "#/components/schemas/Transaction"
          },
          "info": {
            "$ref": "#/components/schemas/Info"
          },
          "user": {
            "$ref": "#/components/schemas/User"
          }
        }
      },
      "Transaction": {
        "required": [
          "creationDate",
          "transactionId",
          "transactionStatus",
          "amount",
          "grandTotal",
          "paymentGateway",
          "timestampOperation"
        ],
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "transactionStatus": {
            "type": "string"
          },
          "creationDate": {
            "type": "string",
            "format": "date-time",
            "example": "2022-02-22T14:41:58.811+01:00"
          },
          "grandTotal": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "example": 20.1
          },
          "amount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "commission amount and  required with outcomePaymentGateway not null",
            "example": 10
          },
          "authorizationCode": {
            "type": "string",
            "description": "only for xpay authorizations"
          },
          "rrn": {
            "type": "string",
            "description": "only for vpos authorizations"
          },
          "psp": {
            "$ref": "#/components/schemas/Psp"
          },
          "errorCode": {
            "type": "string"
          },
          "timestampOperation": {
            "type": "string"
          },
          "paymentGateway": {
            "type": "string"
          }
        }
      },
      "Psp": {
        "required": [
          "brokerName",
          "businessName",
          "idChannel",
          "idPsp",
          "pspOnUs"
        ],
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "businessName": {
            "type": "string"
          },
          "brokerName": {
            "type": "string"
          },
          "pspOnUs": {
            "type": "boolean"
          }
        }
      },
      "Info": {
        "required": [
          "brand",
          "brandLogo",
          "clientId",
          "paymentMethodName",
          "type"
        ],
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "description": "ecommerce payment method"
          },
          "brandLogo": {
            "type": "string"
          },
          "brand": {
            "type": "string"
          },
          "paymentMethodName": {
            "type": "string"
          },
          "clientId": {
            "type": "string"
          },
          "bin": {
            "type": "string"
          },
          "lastFourDigits": {
            "type": "string"
          },
          "maskedEmail": {
            "type": "string"
          }
        }
      },
      "User": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "enum": [
              "GUEST",
              "REGISTERED"
            ]
          },
          "fiscalCode": {
            "type": "string"
          }
        },
        "required": [
          "type"
        ]
      }
    }
  }
}
