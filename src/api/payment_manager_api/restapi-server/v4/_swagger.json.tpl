{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-restspi-servet",
    "version": "4.0",
    "title": "Payment Manager API - pp-restspi-servet v4",
    "x-version": "36.1.3"
  },
  "basePath": "/pp-restapi-server/v4",
  "host": "${host}",
  "produces": [
    "application/json"
  ],
  "paths": {
    "/be/checkStatus": {
      "get": {
        "summary": "getCheckStatus",
        "operationId": "getCheckStatusUsingGET",
        "parameters": [
          {
            "name": "minuteRange",
            "in": "header",
            "description": "minute",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/CheckStatus"
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "500": {
            "description": "Internal server error"
          }
        }
      },
      "post": {
        "summary": "postCheckStatus",
        "operationId": "postCheckStatusUsingPOST",
        "responses": {
          "200": {
            "description": "OK"
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "500": {
            "description": "Internal server error"
          }
        }
      }
    },
    "/be/creditCard": {
      "get": {
        "summary": "getCreditCard",
        "operationId": "getCreditCardGET",
        "parameters": [
          {
            "name": "IdUSer",
            "in": "header",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletListResponse"
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "500": {
            "description": "Internal server error"
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    }
  },
  "securityDefinitions": {
    "Bearer": {
      "type": "apiKey",
      "name": "Authorization",
      "in": "header"
    }
  },
  "definitions": {
    "CheckStatus": {
      "type": "object",
      "required": [
        "dbConnection",
        "nodeConnection",
        "retryNumberPayment"
      ],
      "properties": {
        "dbConnection": {
          "type": "boolean"
        },
        "nodeConnection": {
          "type": "boolean"
        },
        "retryNumberPayment": {
          "type": "integer",
          "format": "int32"
        }
      }
    },
    "Wallet": {
      "type": "object",
      "properties": {
        "bancomatCard": {
          "$ref": "#/definitions/Card"
        },
        "bpay": {
          "$ref": "#/definitions/BPay"
        },
        "buyerBankName": {
          "type": "string"
        },
        "creditCard": {
          "$ref": "#/definitions/CreditCard"
        },
        "favourite": {
          "type": "boolean"
        },
        "idBuyerBank": {
          "type": "integer",
          "format": "int64"
        },
        "idPagamentoFromEC": {
          "type": "string"
        },
        "idPsp": {
          "type": "integer",
          "format": "int64"
        },
        "idWallet": {
          "type": "integer",
          "format": "int64"
        },
        "isMatchedPsp": {
          "type": "boolean"
        },
        "isPspToIgnore": {
          "type": "boolean"
        },
        "jiffyCellphoneNumber": {
          "type": "string"
        },
        "lastUsage": {
          "type": "string",
          "format": "date-time"
        },
        "onboardingChannel": {
          "type": "string"
        },
        "pagoPa": {
          "type": "boolean"
        },
        "payPals": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/PayPal"
          }
        },
        "psp": {
          "$ref": "#/definitions/Psp"
        },
        "pspEditable": {
          "type": "boolean"
        },
        "pspListNotOnUs": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Psp"
          }
        },
        "registeredNexi": {
          "type": "boolean"
        },
        "satispay": {
          "$ref": "#/definitions/Satispay"
        },
        "saved": {
          "type": "boolean"
        },
        "services": {
          "type": "array",
          "items": {
            "type": "string",
            "enum": [
              "pagoPA",
              "BPD",
              "FA"
            ]
          }
        },
        "type": {
          "type": "string",
          "enum": [
            "CREDIT_CARD",
            "BANK_ACCOUNT",
            "EXTERNAL_PS",
            "PAYPAL"
          ]
        }
      },
      "title": "Wallet"
    },
    "WalletListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Wallet"
          }
        }
      },
      "title": "WalletListResponse"
    },
    "Card": {
      "type": "object",
      "properties": {
        "abi": {
          "type": "string"
        },
        "cardNumber": {
          "type": "string"
        },
        "cardPartialNumber": {
          "type": "string"
        },
        "expiringDate": {
          "type": "string",
          "format": "date-time"
        },
        "hpan": {
          "type": "string"
        },
        "productType": {
          "type": "string",
          "enum": [
            "PP",
            "DEB",
            "CRD",
            "PRV"
          ]
        },
        "tokens": {
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "validityState": {
          "type": "string",
          "enum": [
            "V",
            "BR"
          ]
        }
      },
      "title": "Card"
    },
    "BPay": {
      "type": "object",
      "properties": {
        "bankName": {
          "type": "string"
        },
        "groupCode": {
          "type": "string"
        },
        "instituteCode": {
          "type": "string"
        },
        "nameObfuscated": {
          "type": "string"
        },
        "numberEncrypted": {
          "type": "string"
        },
        "numberObfuscated": {
          "type": "string"
        },
        "paymentInstruments": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/BPayPaymentInstrument"
          }
        },
        "serviceState": {
          "type": "string"
        },
        "surnameObfuscated": {
          "type": "string"
        },
        "token": {
          "type": "string"
        },
        "uid": {
          "type": "string"
        },
        "uidHash": {
          "type": "string"
        }
      },
      "title": "BPay"
    },
    "BPayPaymentInstrument": {
      "type": "object",
      "properties": {
        "defaultReceive": {
          "type": "boolean"
        },
        "defaultSend": {
          "type": "boolean"
        },
        "ibanObfuscated": {
          "type": "string"
        }
      },
      "title": "BPayPaymentInstrument"
    },
    "CreditCard": {
      "type": "object",
      "properties": {
        "abiCode": {
          "type": "string"
        },
        "brand": {
          "type": "string"
        },
        "brandLogo": {
          "type": "string"
        },
        "expireMonth": {
          "type": "string"
        },
        "expireYear": {
          "type": "string"
        },
        "flag3dsVerified": {
          "type": "boolean"
        },
        "flagForwardCreateToTkm": {
          "type": "boolean"
        },
        "flagForwardDeleteToTkm": {
          "type": "boolean"
        },
        "hasAlreadyPaid": {
          "type": "boolean"
        },
        "holder": {
          "type": "string"
        },
        "hpan": {
          "type": "string"
        },
        "id": {
          "type": "integer",
          "format": "int64"
        },
        "isOnUs": {
          "type": "boolean"
        },
        "onlyOnUs": {
          "type": "boolean"
        },
        "pan": {
          "type": "string"
        },
        "securityCode": {
          "type": "string"
        },
        "type": {
          "type": "string",
          "enum": [
            "PP",
            "DEB",
            "CRD",
            "PRV"
          ]
        }
      },
      "title": "CreditCard"
    },
    "PayPal": {
      "type": "object",
      "properties": {
        "canceled": {
          "type": "boolean"
        },
        "creationDate": {
          "type": "string",
          "format": "date-time"
        },
        "default": {
          "type": "boolean"
        },
        "emailPp": {
          "type": "string"
        },
        "idPp": {
          "type": "string"
        },
        "psp": {
          "$ref": "#/definitions/PayPalPsp"
        }
      },
      "title": "PayPal"
    },
    "PayPalPsp": {
      "type": "object",
      "required": [
        "avgFee",
        "codiceAbi",
        "idPsp",
        "maxFee",
        "onboard",
        "privacyUrl",
        "ragioneSociale"
      ],
      "properties": {
        "avgFee": {
          "type": "number",
          "format": "double"
        },
        "codiceAbi": {
          "type": "string"
        },
        "idPsp": {
          "type": "string"
        },
        "maxFee": {
          "type": "integer"
        },
        "onboard": {
          "type": "boolean",
          "example": false
        },
        "privacyUrl": {
          "type": "string"
        },
        "ragioneSociale": {
          "type": "string"
        }
      },
      "title": "PayPalPsp"
    },
    "Psp": {
      "type": "object",
      "properties": {
        "appChannel": {
          "type": "boolean"
        },
        "businessName": {
          "type": "string"
        },
        "codiceAbi": {
          "type": "string"
        },
        "codiceConvenzione": {
          "type": "string"
        },
        "directAcquirer": {
          "type": "boolean"
        },
        "favoriteSellerCharge": {
          "type": "integer",
          "format": "int64"
        },
        "fixedCost": {
          "$ref": "#/definitions/Amount"
        },
        "flagStamp": {
          "type": "boolean"
        },
        "id": {
          "type": "integer",
          "format": "int64"
        },
        "idCard": {
          "type": "integer",
          "format": "int64"
        },
        "idChannel": {
          "type": "string"
        },
        "idIntermediary": {
          "type": "string"
        },
        "idPsp": {
          "type": "string"
        },
        "isCancelled": {
          "type": "boolean"
        },
        "isPspOnus": {
          "type": "boolean"
        },
        "jiffyInfoPsp": {
          "$ref": "#/definitions/JiffyInfoPsp"
        },
        "lingua": {
          "type": "string",
          "enum": [
            "IT",
            "EN",
            "FR",
            "DE",
            "SL"
          ]
        },
        "logoPSP": {
          "type": "string"
        },
        "participant": {
          "type": "string"
        },
        "paymentModel": {
          "type": "integer",
          "format": "int64"
        },
        "paymentType": {
          "type": "string"
        },
        "serviceAvailability": {
          "type": "string"
        },
        "serviceDescription": {
          "type": "string"
        },
        "serviceLogo": {
          "type": "string"
        },
        "serviceName": {
          "type": "string"
        },
        "solvedByPan": {
          "type": "boolean"
        },
        "tags": {
          "type": "array",
          "items": {
            "type": "string",
            "enum": [
              "VISA",
              "MASTERCARD",
              "MAESTRO",
              "VISA_ELECTRON",
              "AMEX",
              "OTHER",
              "VPAY",
              "DINERS"
            ]
          }
        },
        "urlInfoChannel": {
          "type": "string"
        }
      },
      "title": "Psp"
    },
    "JiffyInfoPsp": {
      "type": "object",
      "properties": {
        "codiceEsito": {
          "type": "string"
        },
        "numeroTelefonicoCriptato": {
          "type": "string"
        },
        "numeroTelefonicoOffuscato": {
          "type": "string"
        },
        "primitiva": {
          "type": "string"
        }
      },
      "title": "JiffyInfoPsp"
    },
    "Amount": {
      "type": "object",
      "properties": {
        "amount": {
          "type": "integer"
        },
        "currency": {
          "type": "string"
        },
        "currencyNumber": {
          "type": "string"
        },
        "decimalDigits": {
          "type": "integer",
          "format": "int32"
        }
      },
      "title": "Amount"
    },
    "Satispay": {
      "type": "object",
      "properties": {
        "hasMore": {
          "type": "boolean"
        },
        "token": {
          "type": "string"
        },
        "uidSatispay": {
          "type": "string"
        },
        "uidSatispayHash": {
          "type": "string"
        }
      },
      "title": "Satispay"
    }
  }
}
