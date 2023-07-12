{
  "swagger": "2.0",
  "info": {
    "description": "Specifiche di interfaccia Nodo per Payment Manager",
    "version": "2.0.0",
    "title": "Nodo-Per-PaymentManager"
  },
  "schemes": [
    "http"
  ],
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ],
  "host": "${host}",
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
            "in": "query",
            "name": "clientId",
            "description": "The client who made the request",
            "required": false,
            "type": "string"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/ClosePaymentRequestV2"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/ClosePaymentResponse"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "404": {
            "description": "Not found",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "408": {
            "description": "Request Timeout",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "422": {
            "description": "Unprocessable entry",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          }
        }
      }
    }
  },
  "definitions": {
    "ClosePaymentResponse": {
      "type": "object",
      "required": [
        "outcome"
      ],
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
      "type": "object",
      "required": [
        "error"
      ],
      "properties": {
        "error": {
          "type": "string",
          "example": "error message"
        }
      }
    },
    "ClosePaymentRequestV2": {
      "type": "object",
      "required": [
        "paymentTokens",
        "outcome",
        "transactionId",
        "transactionDetails"
      ],
      "properties": {
        "paymentTokens": {
          "type": "array",
          "minItems": 1,
          "items": {
            "type": "string",
            "minLength": 1,
            "maxLength": 36
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
          "description": "required only for outcomePaymentGateway OK",
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "idBrokerPSP": {
          "description": "required only for outcomePaymentGateway OK",
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "idChannel": {
          "description": "required only for outcomePaymentGateway OK",
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "paymentMethod": {
          "description": "required only for outcomePaymentGateway OK",
          "type": "string",
          "minLength": 1
        },
        "transactionId": {
          "type": "string",
          "minLength": 1,
          "maxLength": 255
        },
        "totalAmount": {
          "description": "required only for outcomePaymentGateway OK",
          "type": "number",
          "minimum": 0,
          "maximum": 1000000000,
          "example": "20.10"
        },
        "fee": {
          "type": "number",
          "description": "required only for outcomePaymentGateway OK",
          "minimum": 0,
          "maximum": 1000000000,
          "example": "10.00"
        },
        "timestampOperation": {
          "description": "required only for outcomePaymentGateway OK",
          "type": "string",
          "format": "date-time",
          "example": "2022-02-22T14:41:58.811+01:00"
        },
        "additionalPaymentInformations": {
          "$ref": "#/definitions/AdditionalPaymentInformations"
        },
        "transactionDetails": {
          "$ref": "#/definitions/TransactionDetails"
        }
      }
    },
    "AdditionalPaymentInformations": {
      "description": "required with outcomePaymentGateway OK",
      "type": "object",
      "required": [
        "outcomePaymentGateway",
        "totalAmount",
        "fee",
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
        "rrn": {
          "description": "only for vpos authorizations",
          "type": "string"
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
          "description": "timestampOperation of payment gateway converted in string with this format 'yyyy-MM-ddThh:mm:ss'",
          "type": "string",
          "format": "yyyy-MM-ddThh:mm:ss",
          "example": "2022-02-22T14:41:58"
        },
        "authorizationCode": {
          "description": "only for xpay authorizations",
          "type": "string"
        }
      }
    },
    "TransactionDetails": {
      "type": "object",
      "required": [
        "transaction",
        "info",
        "user"
      ],
      "properties": {
        "transaction": {
          "$ref": "#/definitions/Transaction"
        },
        "info": {
          "$ref": "#/definitions/Info"
        },
        "user": {
          "$ref": "#/definitions/User"
        }
      }
    },
    "Transaction": {
      "type": "object",
      "required": [
        "transactionId",
        "transactionStatus",
        "creationDate"
      ],
      "properties": {
        "transactionId": {
          "type": "string"
        },
        "grandTotal": {
          "type": "number",
          "minimum": 0,
          "maximum": 1000000000,
          "example": "20.10"
        },
        "amount": {
          "type": "number",
          "minimum": 0,
          "maximum": 1000000000,
          "example": "20.10"
        },
        "fee": {
          "type": "number",
          "description": "commission amount and  required with outcomePaymentGateway not null",
          "minimum": 0,
          "maximum": 1000000000,
          "example": "10.00"
        },
        "transactionStatus": {
          "type": "string"
        },
        "authorizationCode": {
          "description": "only for xpay authorizations",
          "type": "string"
        },
        "rrn": {
          "description": "only for vpos authorizations",
          "type": "string"
        },
        "creationDate": {
          "type": "string",
          "format": "date-time",
          "example": "2022-02-22T14:41:58.811+01:00"
        },
        "psp": {
          "$ref": "#/definitions/Psp"
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
      "type": "object",
      "required": [
        "idPsp",
        "idChannel",
        "businessName",
        "brokerName"
      ],
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
      "type": "object",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "description": "ecommerce payment method",
          "type": "string"
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
      "required": [
        "userStatusDescription"
      ],
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
