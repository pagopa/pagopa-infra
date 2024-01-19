{
  "openapi": "3.0.1",
  "info": {
    "title": "Rest-Api Server API-SPEC",
    "description": "RESTful API provided by the \\\"Payment Manager\\\" system",
    "version": "3.0.0"
  },
  "servers": [
    {
      "url": "${host}"
    }
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
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CheckStatus"
                }
              }
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
    "/be/payment-events/{idPayment}": {
      "get": {
        "tags": [
          "pp-restapi-server"
        ],
        "summary": "Retrieves payment events for a specific payment",
        "parameters": [
          {
            "in": "path",
            "name": "idPayment",
            "description": "payment's id",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "method",
            "description": "payment's type",
            "required": false,
            "schema": {
              "type": "string",
              "enum": [
                "BPAY",
                "PPAL"
              ]
            }
          }
        ],
        "responses": {
          "200": {
            "description": "List of payment events",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/PaymentEvent"
                  }
                }
              }
            }
          },
          "401": {
            "description": "Not Authorized",
            "content": {}
          },
          "404": {
            "description": "PaymentId Not Found",
            "content": {}
          },
          "500": {
            "description": "Generic Error",
            "content": {}
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/be/creditCard": {
      "get": {
        "tags": [
          "pp-restapi-server"
        ],
        "summary": "getWallets for WISP",
        "parameters": [
          {
            "in": "header",
            "name": "IdUSer",
            "description": "user's id",
            "required": true,
            "schema": {
              "type": "number"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "List of wallets",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletListResponse"
                }
              }
            }
          },
          "401": {
            "description": "Not Authorized",
            "content": {}
          },
          "422": {
            "description": "Unprocessable entity",
            "content": {}
          },
          "500": {
            "description": "Generic Error",
            "content": {}
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/be/creditCard/io": {
      "get": {
        "tags": [
          "pp-restapi-server"
        ],
        "summary": "getWallets for IO",
        "parameters": [
          {
            "in": "header",
            "name": "IdUSer",
            "description": "user's id",
            "required": true,
            "schema": {
              "type": "number"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "List of wallets",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletV2ListResponse"
                }
              }
            }
          },
          "401": {
            "description": "Not Authorized",
            "content": {}
          },
          "422": {
            "description": "Unprocessable entity",
            "content": {}
          },
          "500": {
            "description": "Generic Error",
            "content": {}
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/be/notification": {
      "post": {
        "tags": [
          "pp-restapi-server"
        ],
        "summary": "post notification",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NotificaPush"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Outcome",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SimpleSuccessResponse"
                }
              }
            }
          },
          "401": {
            "description": "Not Authorized",
            "content": {}
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/be/psps": {
      "post": {
        "tags": [
          "pp-restapi-server"
        ],
        "summary": "inoltra informative",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/Informative"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Outcome",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SimpleSuccessResponse"
                }
              }
            }
          },
          "401": {
            "description": "Not Authorized",
            "content": {}
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      },
      "get": {
        "tags": [
          "pp-restapi-server"
        ],
        "summary": "get informative (TO BE DISMANTLED)",
        "responses": {
          "200": {
            "description": "Informative",
            "content": {}
          },
          "401": {
            "description": "Not Authorized",
            "content": {}
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/be/spid": {
      "post": {
        "tags": [
          "pp-restapi-server"
        ],
        "summary": "create session",
        "parameters": [
          {
            "in": "header",
            "required": true,
            "name": "email",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "header",
            "required": true,
            "name": "spidToken",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {}
          },
          "401": {
            "description": "Not Authorized",
            "content": {}
          },
          "500": {
            "description": "Error",
            "content": {}
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
  "components": {
    "securitySchemes": {
      "Bearer": {
        "type": "apiKey",
        "name": "Authorization",
        "in": "header"
      }
    },
    "schemas": {
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
      "PaymentEvent": {
        "type": "object",
        "properties": {
          "transaction": {
            "$ref": "#/components/schemas/TransactionEvent"
          },
          "wallet": {
            "$ref": "#/components/schemas/WalletEvent"
          },
          "user": {
            "$ref": "#/components/schemas/UserEvent"
          }
        }
      },
      "TransactionEvent": {
        "type": "object",
        "properties": {
          "idTransaction": {
            "type": "number"
          },
          "grandTotal": {
            "type": "number"
          },
          "amount": {
            "type": "number"
          },
          "fee": {
            "type": "number"
          },
          "transactionStatus": {
            "type": "string"
          },
          "accountingStatus": {
            "type": "string"
          },
          "origin": {
            "type": "string",
            "enum": [
              "IO",
              "CHECKOUT",
              "WISP"
            ]
          },
          "rrn": {
            "type": "string"
          },
          "authorizationCode": {
            "type": "string"
          },
          "creationDate": {
            "type": "string",
            "format": "date-time"
          },
          "numaut": {
            "type": "string"
          },
          "accountCode": {
            "type": "string"
          },
          "psp": {
            "$ref": "#/components/schemas/PspEvent"
          }
        }
      },
      "PspEvent": {
        "type": "object",
        "properties": {
          "idChannel": {
            "type": "string"
          },
          "businessName": {
            "type": "string"
          },
          "serviceName": {
            "type": "string"
          }
        }
      },
      "WalletEvent": {
        "type": "object",
        "properties": {
          "idWallet": {
            "type": "number"
          },
          "walletType": {
            "type": "string"
          },
          "enableableFunctions": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "pagoPa": {
            "type": "boolean"
          },
          "onboardingChannel": {
            "type": "string"
          },
          "favourite": {
            "type": "boolean"
          },
          "createDate": {
            "type": "string",
            "format": "date-time"
          },
          "info": {
            "type": "object"
          }
        }
      },
      "UserEvent": {
        "type": "object",
        "properties": {
          "idUser": {
            "type": "number"
          },
          "userStatus": {
            "type": "number"
          },
          "name": {
            "type": "string"
          },
          "surname": {
            "type": "string"
          },
          "fiscalCode": {
            "type": "string"
          },
          "userStatusDescription": {
            "type": "string"
          }
        }
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
              "$ref": "#/components/schemas/BPayPaymentInstrument"
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
            "$ref": "#/components/schemas/PayPalPsp"
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
            "$ref": "#/components/schemas/Amount"
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
            "$ref": "#/components/schemas/JiffyInfoPsp"
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
      },
      "SimpleSuccessResponse": {
        "type": "object",
        "required": [
          "data"
        ],
        "properties": {
          "data": {
            "$ref": "#/components/schemas/SimpleSuccess"
          }
        },
        "title": "SimpleSuccessResponse"
      },
      "SimpleSuccess": {
        "type": "object",
        "properties": {
          "esito": {
            "type": "string"
          },
          "descrizione": {
            "type": "string"
          }
        },
        "title": "SimpleSuccess"
      },
      "NotificaPush": {
        "type": "object",
        "properties": {
          "mobileToken": {
            "type": "string"
          },
          "idPagamento": {
            "type": "string"
          },
          "esitoOperazione": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          }
        },
        "title": "NotificaPush"
      },
      "Informative": {
        "type": "object",
        "properties": {
          "totalRows": {
            "type": "number"
          },
          "data": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Informativa"
            }
          }
        },
        "title": "Informative"
      },
      "Informativa": {
        "type": "object",
        "properties": {
          "idCard": {
            "type": "number"
          },
          "identificativoPsp": {
            "type": "string"
          },
          "descrizioneServizio": {
            "type": "string"
          },
          "disponibilitaServizio": {
            "type": "string"
          },
          "identificativoCanale": {
            "type": "string"
          },
          "identificativoIntermediario": {
            "type": "string"
          },
          "nomeServizio": {
            "type": "string"
          },
          "ragioneSocialePsp": {
            "type": "string"
          },
          "urlInformazioniCanale": {
            "type": "string"
          },
          "bollo": {
            "type": "boolean"
          },
          "canaleApp": {
            "type": "boolean"
          },
          "costoFisso": {
            "type": "number",
            "format": "double"
          },
          "logoPSP": {
            "type": "string"
          },
          "logoServizio": {
            "type": "string"
          },
          "lingua": {
            "type": "string",
            "enum": [
              "IT",
              "EN",
              "DE",
              "FR",
              "SL"
            ]
          },
          "modelloPagamento": {
            "type": "number",
            "enum": [
              0,
              1,
              2,
              3,
              4
            ]
          },
          "tipoVersamento": {
            "type": "string",
            "enum": [
              "BBT",
              "BP",
              "AD",
              "CP",
              "PO",
              "OBEP"
            ]
          },
          "tags": {
            "type": "array",
            "items": {
              "type": "string",
              "enum": [
                "American Express",
                "Diners",
                "Maestro",
                "Mastercard",
                "MyBank",
                "PagoBancomat",
                "PayPal",
                "Visa",
                "Visa Electron",
                "V-Pay",
                "Wallet"
              ]
            }
          }
        },
        "title": "Informativa"
      },
      "Wallet": {
        "type": "object",
        "properties": {
          "bancomatCard": {
            "$ref": "#/components/schemas/Card"
          },
          "bpay": {
            "$ref": "#/components/schemas/BPay"
          },
          "buyerBankName": {
            "type": "string"
          },
          "creditCard": {
            "$ref": "#/components/schemas/CreditCard"
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
              "$ref": "#/components/schemas/PayPal"
            }
          },
          "psp": {
            "$ref": "#/components/schemas/Psp"
          },
          "pspEditable": {
            "type": "boolean"
          },
          "pspListNotOnUs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Psp"
            }
          },
          "registeredNexi": {
            "type": "boolean"
          },
          "satispay": {
            "$ref": "#/components/schemas/Satispay"
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
              "$ref": "#/components/schemas/Wallet"
            }
          }
        },
        "title": "WalletListResponse"
      },
      "WalletV2ListResponse": {
        "type": "object",
        "required": [
          "data"
        ],
        "properties": {
          "data": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/WalletV2"
            }
          }
        },
        "title": "WalletV2ListResponse"
      },
      "WalletV2": {
        "type": "object",
        "properties": {
          "createDate": {
            "type": "string",
            "format": "date-time"
          },
          "enableableFunctions": {
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
          "favourite": {
            "type": "boolean"
          },
          "idWallet": {
            "type": "integer",
            "format": "int64"
          },
          "info": {
            "$ref": "#/components/schemas/PaymentMethodInfo"
          },
          "onboardingChannel": {
            "type": "string"
          },
          "pagoPA": {
            "type": "boolean"
          },
          "updateDate": {
            "type": "string",
            "format": "date-time"
          },
          "walletType": {
            "type": "string",
            "enum": [
              "Card",
              "Bancomat",
              "Satispay",
              "BPay",
              "Generic",
              "PayPal"
            ]
          }
        },
        "title": "WalletV2"
      },
      "PaymentMethodInfo": {
        "type": "object",
        "title": "PaymentMethodInfo"
      }
    }
  }
}