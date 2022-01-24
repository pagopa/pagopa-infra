{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-rest-CD v2",
    "version": "2.0",
    "title": "Payment Manager API - pp-rest-CD v2",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-restapi-CD",
  "tags": [
    {
      "name": "payments-v-2-controller",
      "description": "Payments V 2 Controller"
    },
    {
      "name": "wallet-v-2-controller",
      "description": "Wallet V 2 Controller"
    }
  ],
  "produces": [
    "application/json"
  ],
  "paths": {
    "/payments/{id}/psps": {
      "get": {
        "tags": [
          "payments-v-2-controller"
        ],
        "summary": "getPspListV2",
        "operationId": "getPspListV2UsingGET",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          },
          {
            "name": "idWallet",
            "in": "query",
            "description": "idWallet",
            "required": true,
            "type": "string"
          },
          {
            "name": "cellphoneNumber",
            "in": "query",
            "description": "cellphoneNumber",
            "required": false,
            "type": "string"
          },
          {
            "name": "externalPsId",
            "in": "query",
            "description": "externalPsId",
            "required": false,
            "type": "string"
          },
          {
            "name": "language",
            "in": "query",
            "description": "language",
            "required": false,
            "type": "string"
          },
          {
            "name": "isList",
            "in": "query",
            "description": "isList",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PspDataListResponse"
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/wallet": {
      "get": {
        "tags": [
          "wallet-v-2-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay)]",
        "operationId": "getWalletsV2UsingGET",
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletV2ListResponse"
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/wallet/delete-wallets": {
      "delete": {
        "tags": [
          "wallet-v-2-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay)]",
        "operationId": "deleteWalletsByServiceUsingDELETE",
        "parameters": [
          {
            "name": "service",
            "in": "query",
            "description": "service",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/DeletedWalletsResponse"
            }
          },
          "204": {
            "description": "No Content"
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/wallet/{id}": {
      "put": {
        "tags": [
          "wallet-v-2-controller"
        ],
        "summary": "updateWallet",
        "operationId": "updateWalletUsingPUT_1",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "integer",
            "format": "int64"
          },
          {
            "in": "body",
            "name": "walletRequest",
            "description": "walletRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/WalletRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletResponse"
            }
          },
          "201": {
            "description": "Created"
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/wallet/{id}/payment-status": {
      "get": {
        "tags": [
          "wallet-v-2-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay)]",
        "operationId": "getWalletPaymentStatusUsingGET",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "integer",
            "format": "int64"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletPaymentStatusResponse"
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      },
      "put": {
        "tags": [
          "wallet-v-2-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay)]",
        "operationId": "changeWalletPaymentStatusUsingPUT",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "integer",
            "format": "int64"
          },
          {
            "in": "body",
            "name": "walletPaymentStatusRequest",
            "description": "walletPaymentStatusRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/WalletPaymentStatusRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletV2Response"
            }
          },
          "201": {
            "description": "Created"
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
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
    "DeletedWallets": {
      "type": "object",
      "properties": {
        "deletedWallets": {
          "type": "integer",
          "format": "int32"
        },
        "notDeletedWallets": {
          "type": "integer",
          "format": "int32"
        },
        "remainingWallets": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/WalletV2"
          }
        }
      },
      "title": "DeletedWallets"
    },
    "DeletedWalletsResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/DeletedWallets"
        }
      },
      "title": "DeletedWalletsResponse"
    },
    "Dettaglio": {
      "type": "object",
      "properties": {
        "CCP": {
          "type": "string"
        },
        "IUV": {
          "type": "string"
        },
        "codicePagatore": {
          "type": "string"
        },
        "enteBeneficiario": {
          "type": "string"
        },
        "idDominio": {
          "type": "string"
        },
        "idPayment": {
          "type": "string"
        },
        "importo": {
          "type": "number"
        },
        "nomePagatore": {
          "type": "string"
        },
        "tipoPagatore": {
          "type": "string"
        }
      },
      "title": "Dettaglio"
    },
    "ErrorModel": {
      "type": "object",
      "properties": {
        "code": {
          "type": "string"
        },
        "description": {
          "type": "string"
        },
        "params": {
          "type": "string"
        }
      },
      "title": "ErrorModel"
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
    "Message": {
      "type": "object",
      "properties": {
        "caName": {
          "type": "string",
          "enum": [
            "ICCREA",
            "NEXI",
            "SIA"
          ]
        },
        "cardsNumber": {
          "type": "integer",
          "format": "int32"
        },
        "code": {
          "type": "string",
          "enum": [
            "0",
            "1",
            "11",
            "21",
            "23",
            "31",
            "32"
          ]
        }
      },
      "title": "Message"
    },
    "PanResponse": {
      "type": "object",
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Card"
          }
        },
        "messages": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Message"
          }
        },
        "requestId": {
          "type": "string"
        }
      },
      "title": "PanResponse"
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
    "Payload": {
      "type": "object",
      "properties": {
        "paymentInstruments": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/PaymentInstrument"
          }
        },
        "searchRequestId": {
          "type": "string"
        },
        "searchRequestMetadata": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/SearchRequestMetadata"
          }
        }
      },
      "title": "Payload"
    },
    "Payment": {
      "type": "object",
      "properties": {
        "amount": {
          "$ref": "#/definitions/Amount"
        },
        "bolloDigitale": {
          "type": "boolean"
        },
        "creditCardVerification": {
          "type": "boolean"
        },
        "detailsList": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Dettaglio"
          }
        },
        "email": {
          "type": "string"
        },
        "fiscalCode": {
          "type": "string"
        },
        "iban": {
          "type": "string"
        },
        "id": {
          "type": "integer",
          "format": "int64"
        },
        "idCarrello": {
          "type": "string"
        },
        "idPayment": {
          "type": "string"
        },
        "isCancelled": {
          "type": "boolean"
        },
        "origin": {
          "type": "string"
        },
        "receiver": {
          "type": "string"
        },
        "subject": {
          "type": "string"
        },
        "urlRedirectEc": {
          "type": "string"
        }
      },
      "title": "Payment"
    },
    "PaymentInstrument": {
      "type": "object",
      "properties": {
        "abiCode": {
          "type": "string"
        },
        "expiringDate": {
          "type": "string"
        },
        "hpan": {
          "type": "string"
        },
        "panCode": {
          "type": "string"
        },
        "panPartialNumber": {
          "type": "string"
        },
        "paymentNetwork": {
          "type": "string",
          "enum": [
            "MAESTRO",
            "MASTERCARD",
            "VISA_ELECTRON",
            "VISA_CLASSIC",
            "VPAY"
          ]
        },
        "productType": {
          "type": "string",
          "enum": [
            "CREDIT",
            "PREPAID",
            "DEBIT",
            "PRIVATIVE"
          ]
        },
        "tokenMac": {
          "type": "string"
        },
        "validityStatus": {
          "type": "string",
          "enum": [
            "VALID",
            "BLOCK_REVERSIBLE"
          ]
        }
      },
      "title": "PaymentInstrument"
    },
    "PaymentMethodInfo": {
      "type": "object",
      "title": "PaymentMethodInfo"
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
    "PspData": {
      "type": "object",
      "required": [
        "codiceAbi",
        "defaultPsp",
        "fee",
        "idPsp",
        "onboard",
        "privacyUrl",
        "ragioneSociale"
      ],
      "properties": {
        "codiceAbi": {
          "type": "string"
        },
        "defaultPsp": {
          "type": "boolean",
          "example": false
        },
        "fee": {
          "type": "integer"
        },
        "idPsp": {
          "type": "string"
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
      "title": "PspData"
    },
    "PspDataListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/PspData"
          }
        }
      },
      "title": "PspDataListResponse"
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
    "SearchRequestMetadata": {
      "type": "object",
      "properties": {
        "executionStatus": {
          "type": "string"
        },
        "retrievedInstrumentsCount": {
          "type": "integer",
          "format": "int32"
        },
        "serviceProviderName": {
          "type": "string"
        }
      },
      "title": "SearchRequestMetadata"
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
    "WalletPaymentStatus": {
      "type": "object",
      "properties": {
        "pagoPA": {
          "type": "boolean"
        }
      },
      "title": "WalletPaymentStatus"
    },
    "WalletPaymentStatusRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/WalletPaymentStatus"
        }
      },
      "title": "WalletPaymentStatusRequest"
    },
    "WalletPaymentStatusResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/WalletPaymentStatus"
        }
      },
      "title": "WalletPaymentStatusResponse"
    },
    "WalletRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Wallet"
        }
      },
      "title": "WalletRequest"
    },
    "WalletResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Wallet"
        }
      },
      "title": "WalletResponse"
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
          "$ref": "#/definitions/PaymentMethodInfo"
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
    "WalletV2ListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/WalletV2"
          }
        }
      },
      "title": "WalletV2ListResponse"
    },
    "WalletV2Response": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/WalletV2"
        }
      },
      "title": "WalletV2Response"
    }
  }
}
