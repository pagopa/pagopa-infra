{
  "openapi": "3.0.1",
  "info": {
    "title": "Nodo-Per-PaymentManager",
    "description": "Specifiche di interfaccia Nodo per Payment Manager",
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
          "error"
        ],
        "type": "object",
        "properties": {
          "error": {
            "type": "string",
            "example": "error message"
          }
        }
      },
      "CardAdditionalPaymentInformations": {
        "type": "object",
        "properties": {
          "paymentMethod": {
            "type": "string",
            "description": "Fixed value \"CP\""
          },
          "additionalPaymentInformations": {
            "type": "object",
            "required": [
              "outcomePaymentGateway",
              "fee",
              "totalAmount",
              "timestampOperation"
            ],
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
              }
            }
          }
        },
        "required": [
          "paymentMethod",
          "additionalPaymentInformations"
        ]
      },
      "RedirectAdditionalPaymentInformations": {
        "type": "object",
        "properties": {
          "paymentMethod": {
            "type": "string",
            "description": "Redirect payment method name"
          },
          "additionalPaymentInformations": {
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
                "format": "date-time",
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
          }
        },
        "required": [
          "paymentMethod",
          "additionalPaymentInformations"
        ]
      },
      "AdditionalPaymentInformations": {
        "oneOf": [
          {
            "$ref": "#/components/schemas/CardAdditionalPaymentInformations"
          },
          {
            "$ref": "#/components/schemas/RedirectAdditionalPaymentInformations"
          }
        ],
        "discriminator": {
          "propertyName": "paymentMethod",
          "mapping": {
            "CP": "#/components/schemas/CardAdditionalPaymentInformations",
            "RBPR": "#/components/schemas/RedirectAdditionalPaymentInformations",
            "RBPB": "#/components/schemas/RedirectAdditionalPaymentInformations",
            "RBPP": "#/components/schemas/RedirectAdditionalPaymentInformations",
            "RPIC": "#/components/schemas/RedirectAdditionalPaymentInformations",
            "RBPS": "#/components/schemas/RedirectAdditionalPaymentInformations"
          }
        }
      },
      "BaseClosePaymentRequestV2": {
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
          "transactionId"
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
            "description": "required only for outcomePaymentGateway OK"
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
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          }
        }
      },
      "ClosePaymentRequestV2": {
        "allOf": [
          {
            "$ref": "#/components/schemas/BaseClosePaymentRequestV2"
          },
          {
            "$ref": "#/components/schemas/AdditionalPaymentInformations"
          }
        ]
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
          "grandTotal"
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
          "idPsp"
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
          }
        }
      },
      "User": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "enum": [
              "GUEST"
            ]
          }
        }
      }
    }
  }
}
