{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-rest-CD v3",
    "version": "3.0",
    "title": "Payment Manager API - pp-rest-CD v3",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-restapi-CD",
  "tags": [
    {
      "name": "wallet-v-3-controller",
      "description": "Wallet V 3 Controller"
    }
  ],
  "produces": [
    "application/json"
  ],
  "paths": {
    "/paypal/psps": {
      "get": {
        "tags": [
          "pay-pal-controller"
        ],
        "summary": "getPaypalPsps",
        "operationId": "getPaypalPspsUsingGET",
        "parameters": [
          {
            "name": "language",
            "in": "query",
            "description": "language",
            "required": false,
            "type": "string",
            "default": "it"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PaypalPspListResponse"
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
    "/postepay/searchPSP": {
      "get": {
        "tags": [
          "poste-pay-controller"
        ],
        "summary": "getPostePayPsps",
        "operationId": "getPostePayPspsUsingGET",
        "parameters": [
          {
            "name": "language",
            "in": "query",
            "description": "language",
            "required": false,
            "type": "string",
            "default": "it"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PostePayPspListResponse"
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
          "wallet-v-3-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay), GenericInstrumentInfo (walletType Generic), PayPalInfo (walletType PayPal)]",
        "operationId": "getWalletsV3UsingGET",
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
          "wallet-v-3-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay), GenericInstrumentInfo (walletType Generic), PayPalInfo (walletType PayPal)]",
        "operationId": "deleteWalletsByServiceUsingDELETE_1",
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
    "/wallet/{id}/payment-status": {
      "get": {
        "tags": [
          "wallet-v-3-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay), GenericInstrumentInfo (walletType Generic), PayPalInfo (walletType PayPal)]",
        "operationId": "getWalletPaymentStatusUsingGET_1",
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
          "wallet-v-3-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo (walletType Card o Bancomat), SatispayInfo (walletType Satispay), BPayInfo (walletType BPay), GenericInstrumentInfo (walletType Generic), PayPalInfo (walletType PayPal)]",
        "operationId": "changeWalletPaymentStatusUsingPUT_1",
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
    },
    "/webview/*": {
      "get": {
        "operationId": "staticResourcesWebviewGet",
        "description": "static resources of Webview - GET",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "post": {
        "operationId": "staticResourcesWebviewPost",
        "description": "static resources of Webview - POST",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "options": {
        "operationId": "staticResourcesWebviewOptions",
        "description": "static resources of Webview - Options",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "head": {
        "operationId": "staticResourcesWebviewHead",
        "description": "static resources of Webview - Head",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
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
    "PaymentMethodInfo": {
      "type": "object",
      "title": "PaymentMethodInfo"
    },
    "PaypalPspListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/PayPalPsp"
          }
        }
      },
      "title": "PaypalPspListResponse"
    },
    "PostePayPsp": {
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
      "title": "PostePayPsp"
    },
    "PostePayPspListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/PostePayPsp"
          }
        }
      },
      "title": "PostePayPspListResponse"
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
