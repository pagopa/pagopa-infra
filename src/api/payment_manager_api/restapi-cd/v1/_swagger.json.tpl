{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-rest-CD v1",
    "version": "1.0",
    "title": "Payment Manager API - pp-rest-CD v1",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-restapi-CD",
  "tags": [
    {
      "name": "b-pay-controller-cd",
      "description": "B Pay Controller"
    },
    {
      "name": "bancomat-controller-cd",
      "description": "Bancomat Controller"
    },
    {
      "name": "cobadge-controller-cd",
      "description": "Cobadge Controller"
    },
    {
      "name": "payments-controller",
      "description": "Payments Controller"
    },
    {
      "name": "payments-v-2-controller",
      "description": "Payments V 2 Controller"
    },
    {
      "name": "psp-controller",
      "description": "Psp Controller"
    },
    {
      "name": "resource-controller",
      "description": "Resource Controller"
    },
    {
      "name": "satispay-controller",
      "description": "Satispay Controller"
    },
    {
      "name": "transaction-controller",
      "description": "Transaction Controller"
    },
    {
      "name": "users-controller",
      "description": "Users Controller"
    },
    {
      "name": "wallet-controller",
      "description": "Wallet Controller"
    },
    {
      "name": "wallet-v-2-controller",
      "description": "Wallet V 2 Controller"
    },
    {
      "name": "wallet-v-3-controller",
      "description": "Wallet V 3 Controller"
    }
  ],
  "produces": [
    "application/json"
  ],
  "paths": {
    "/bancomat/abi": {
      "get": {
        "tags": [
          "bancomat-controller-cd"
        ],
        "summary": "restituisce la lista paginata degli ABI salvati a DB.size = numero di elementi da visualizzare sulla pagina (max 15).start = posizione dell'elemento da cui partire all'interno della lista.abiQuery = sottostringa a contenuta nei valori di ABI o nome dell'elemento.",
        "operationId": "getAbiListUsingGET",
        "parameters": [
          {
            "name": "size",
            "in": "query",
            "description": "size",
            "required": false,
            "type": "integer",
            "default": 10,
            "format": "int32"
          },
          {
            "name": "start",
            "in": "query",
            "description": "start",
            "required": false,
            "type": "integer",
            "default": 0,
            "format": "int32"
          },
          {
            "name": "abiQuery",
            "in": "query",
            "description": "abiQuery",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/AbiListResponse"
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
    "/bancomat/add-wallets": {
      "post": {
        "tags": [
          "bancomat-controller-cd"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo]",
        "operationId": "addWalletsBancomatCardUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "bancomatCardsRequest",
            "description": "bancomatCardsRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/BancomatCardsRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletV2ListResponse"
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
    "/bancomat/pans": {
      "get": {
        "tags": [
          "bancomat-controller-cd"
        ],
        "summary": "getPans",
        "operationId": "getPansUsingGET",
        "parameters": [
          {
            "name": "abi",
            "in": "query",
            "description": "abi",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/RestPanResponse"
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
          },
          "412": {
            "description": "Too Many Requests"
          }
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/bpay/add-wallets": {
      "post": {
        "tags": [
          "b-pay-controller-cd"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [BPayInfo]",
        "operationId": "addWalletsBPayUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "bPayRequest",
            "description": "bPayRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/BPayRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletV2ListResponse"
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
    "/bpay/list": {
      "get": {
        "tags": [
          "b-pay-controller-cd"
        ],
        "summary": "getBpayList",
        "operationId": "getBpayListUsingGET",
        "parameters": [
          {
            "name": "abi",
            "in": "query",
            "description": "abi",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/RestBPayResponse"
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
    "/cobadge/add-wallets": {
      "post": {
        "tags": [
          "cobadge-controller-cd"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [CardInfo]",
        "operationId": "addWalletsCobadgePaymentInstrumentAsCreditCardUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "request",
            "description": "request",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CobadegPaymentInstrumentsRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletV2ListResponse"
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
    "/cobadge/pans": {
      "get": {
        "tags": [
          "cobadge-controller-cd"
        ],
        "summary": "getCobadges",
        "operationId": "getCobadgesUsingGET",
        "parameters": [
          {
            "name": "abiCode",
            "in": "query",
            "description": "abiCode",
            "required": false,
            "type": "string"
          },
          {
            "name": "PanCode",
            "in": "header",
            "description": "PanCode",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/RestCobadgeResponse"
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
    "/cobadge/search/{searchRequestId}": {
      "get": {
        "tags": [
          "cobadge-controller-cd"
        ],
        "summary": "getCobadgeByRequestId",
        "operationId": "getCobadgeByRequestIdUsingGET",
        "parameters": [
          {
            "name": "searchRequestId",
            "in": "path",
            "description": "searchRequestId",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/RestCobadgeResponse"
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
    "/payments/{id}": {
      "delete": {
        "tags": [
          "payments-controller"
        ],
        "summary": "Cancels given payment with \"CANCELED BY USER\" as KO reason",
        "operationId": "deletePaymentUsingDELETE",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          },
          {
            "name": "showWallet",
            "in": "query",
            "description": "showWallet",
            "required": false,
            "type": "boolean"
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
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
    "/payments/{id}/actions/check": {
      "get": {
        "tags": [
          "payments-controller"
        ],
        "summary": "checkPayment",
        "operationId": "checkPaymentUsingGET",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PaymentResponse"
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
        }
      }
    },
    "/payments/{id}/actions/check-internal": {
      "get": {
        "tags": [
          "payments-controller"
        ],
        "summary": "getPayment",
        "operationId": "getPaymentUsingGET",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PaymentResponse"
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
        }
      }
    },
    "/payments/{id}/actions/delete": {
      "delete": {
        "tags": [
          "payments-controller"
        ],
        "summary": "Cancels given payment with \"SESSION EXPIRED\" as KO reason",
        "operationId": "deleteBySessionCookieExpiredUsingDELETE",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          },
          {
            "name": "showWallet",
            "in": "query",
            "description": "showWallet",
            "required": false,
            "type": "boolean"
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
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
    "/psps": {
      "get": {
        "tags": [
          "psp-controller"
        ],
        "summary": "getPspList",
        "operationId": "getPspListUsingGET",
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PspListResponseCD"
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
    "/psps/all": {
      "get": {
        "tags": [
          "psp-controller"
        ],
        "summary": "getAllPsps",
        "operationId": "getAllPspsUsingGET",
        "parameters": [
          {
            "name": "idWallet",
            "in": "query",
            "description": "idWallet",
            "required": true,
            "type": "string"
          },
          {
            "name": "idPayment",
            "in": "query",
            "description": "idPayment",
            "required": true,
            "type": "string"
          },
          {
            "name": "language",
            "in": "query",
            "description": "language",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PspListResponseCD"
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
    "/psps/selected": {
      "get": {
        "tags": [
          "psp-controller"
        ],
        "summary": "getSelectedPsp",
        "operationId": "getSelectedPspUsingGET",
        "parameters": [
          {
            "name": "idWallet",
            "in": "query",
            "description": "idWallet",
            "required": true,
            "type": "string"
          },
          {
            "name": "idPayment",
            "in": "query",
            "description": "idPayment",
            "required": true,
            "type": "string"
          },
          {
            "name": "language",
            "in": "query",
            "description": "language",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PspListResponseCD"
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
    "/psps/{id}": {
      "get": {
        "tags": [
          "psp-controller"
        ],
        "summary": "getPsp",
        "operationId": "getPspUsingGET",
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
              "$ref": "#/definitions/PspResponse"
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
    "/resources": {
      "get": {
        "tags": [
          "resource-controller"
        ],
        "summary": "getResources",
        "operationId": "getResourcesUsingGET",
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/ResourcesResponse"
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
        }
      }
    },
    "/resources/img/{imgName}": {
      "get": {
        "tags": [
          "resource-controller"
        ],
        "summary": "getImageWithMediaType",
        "operationId": "getImageWithMediaTypeUsingGET",
        "parameters": [
          {
            "name": "imgName",
            "in": "path",
            "description": "imgName",
            "required": true,
            "type": "string"
          }
        ],
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
          "404": {
            "description": "Not Found"
          }
        }
      }
    },
    "/resources/psp/{id}": {
      "get": {
        "tags": [
          "resource-controller"
        ],
        "summary": "getPspLogo",
        "operationId": "getPspLogoUsingGET",
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
            "description": "OK"
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
        }
      }
    },
    "/resources/service/{id}": {
      "get": {
        "tags": [
          "resource-controller"
        ],
        "summary": "getServiceLogo",
        "operationId": "getServiceLogoUsingGET",
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
            "description": "OK"
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
        }
      }
    },
    "/satispay/add-wallet": {
      "post": {
        "tags": [
          "satispay-controller"
        ],
        "summary": "Possibili sottotipi del campo info (PaymentMethodInfo): [SatispayInfo]",
        "operationId": "addWalletSatispayUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "satispayRequest",
            "description": "satispayRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/SatispayRequest"
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
    "/satispay/consumers": {
      "get": {
        "tags": [
          "satispay-controller"
        ],
        "summary": "getConsumer",
        "operationId": "getConsumerUsingGET",
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/RestSatispayResponse"
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
    "/transactions": {
      "get": {
        "tags": [
          "transaction-controller"
        ],
        "summary": "valori authorizationCode: [ 00 - OK ] [ 02 - parametro duplicato ] [ 03 - formato messaggio errato, campo mancante o errato ][ 04 - MAC non corretto ] [ 06 - errore imprevisto durante l’elaborazione ][ 37 - codice di verifica mancante ] [ 40 - errore xml ] [ 41 - errore xml ] [ 98 - errore applicativo ] [ 99 - operazione fallita ]",
        "operationId": "getTransactionsUsingGET",
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/TransactionListResponse"
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
    "/transactions/{id}": {
      "get": {
        "tags": [
          "transaction-controller"
        ],
        "summary": "valori authorizationCode: [ 00 - OK ] [ 02 - parametro duplicato ] [ 03 - formato messaggio errato, campo mancante o errato ][ 04 - MAC non corretto ] [ 06 - errore imprevisto durante l’elaborazione ][ 37 - codice di verifica mancante ] [ 40 - errore xml ] [ 41 - errore xml ] [ 98 - errore applicativo ] [ 99 - operazione fallita ]",
        "operationId": "getTransactionUsingGET",
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
              "$ref": "#/definitions/TransactionResponse"
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
    "/users": {
      "get": {
        "tags": [
          "users-controller"
        ],
        "summary": "getUser",
        "operationId": "getUserUsingGET",
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/UserResponse"
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
    "/users/actions/start-session": {
      "get": {
        "tags": [
          "users-controller"
        ],
        "summary": "startSession",
        "operationId": "startSessionUsingGET",
        "parameters": [
          {
            "name": "token",
            "in": "query",
            "description": "token",
            "required": false,
            "type": "string"
          },
          {
            "name": "Authorization",
            "in": "header",
            "description": "Authorization",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/SessionResponse"
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
        }
      }
    },
    "/users/byTransactionId/{transactionId}": {
      "get": {
        "tags": [
          "users-controller"
        ],
        "summary": "getUserByTransactionId",
        "operationId": "getUserByTransactionIdUsingGET",
        "parameters": [
          {
            "name": "transactionId",
            "in": "path",
            "description": "transactionId",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/UserResponse"
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
    "/users/check-session": {
      "get": {
        "tags": [
          "users-controller"
        ],
        "summary": "checkSession",
        "operationId": "checkSessionUsingGET",
        "parameters": [
          {
            "name": "sessionToken",
            "in": "query",
            "description": "sessionToken",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/SessionResponse"
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
          "wallet-controller"
        ],
        "summary": "getWallets",
        "operationId": "getWalletsUsingGET",
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
      "post": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "addWallet",
        "operationId": "addWalletUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "walletRequest",
            "description": "walletRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/WalletRequest"
            }
          },
          {
            "name": "language",
            "in": "query",
            "description": "language",
            "required": true,
            "type": "string"
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
    "/wallet/actions/check-card-bin": {
      "post": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "checkCardBin",
        "operationId": "checkCardBinUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "checkCardBinRequest",
            "description": "checkCardBinRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CheckCardBinRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/CheckCardBinResponse"
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
    "/wallet/byTransactionId/{transactionId}": {
      "get": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "getWalletByTransactionId",
        "operationId": "getWalletByTransactionIdUsingGET",
        "parameters": [
          {
            "name": "transactionId",
            "in": "path",
            "description": "transactionId",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/WalletResponse"
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
    "/wallet/cc": {
      "post": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "addWalletCreditCard",
        "operationId": "addWalletCreditCardUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
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
    "/wallet/delete-contract": {
      "delete": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "prepareDeleteContract",
        "operationId": "prepareDeleteContractUsingDELETE",
        "parameters": [
          {
            "in": "body",
            "name": "idWallet",
            "description": "idWallet",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
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
      "get": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "getWallet",
        "operationId": "getWalletUsingGET",
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
              "$ref": "#/definitions/WalletResponse"
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
          "wallet-controller"
        ],
        "summary": "updateWallet",
        "operationId": "updateWalletUsingPUT",
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
      },
      "delete": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "deleteWallet",
        "operationId": "deleteWalletUsingDELETE",
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
            "description": "OK"
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
    "/wallet/{id}/actions/confirm": {
      "post": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "confirmWallet",
        "operationId": "confirmWalletUsingPOST",
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
    "/wallet/{id}/actions/favourite": {
      "post": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "favouriteWallet",
        "operationId": "favouriteWalletUsingPOST",
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
    "/wallet/{id}/{pspId}": {
      "delete": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "deleteWallet",
        "operationId": "deleteWalletUsingDELETE_1",
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
            "name": "pspId",
            "in": "path",
            "description": "pspId",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
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
    "Abi": {
      "type": "object",
      "properties": {
        "abi": {
          "type": "string"
        },
        "logoUrl": {
          "type": "string"
        },
        "name": {
          "type": "string"
        }
      },
      "title": "Abi"
    },
    "AbiListResponse": {
      "type": "object",
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Abi"
          }
        },
        "size": {
          "type": "integer",
          "format": "int32"
        },
        "start": {
          "type": "integer",
          "format": "int32"
        },
        "total": {
          "type": "integer",
          "format": "int32"
        }
      },
      "title": "AbiListResponse"
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
    "BPayInfo": {
      "type": "object",
      "properties": {
        "bankName": {
          "type": "string"
        },
        "brandLogo": {
          "type": "string"
        },
        "instituteCode": {
          "type": "string"
        },
        "numberObfuscated": {
          "type": "string"
        },
        "paymentInstruments": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/BPayPaymentInstrumentWallet"
          }
        },
        "uidHash": {
          "type": "string"
        }
      },
      "title": "BPayInfo"
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
    "BPayPaymentInstrumentWallet": {
      "type": "object",
      "properties": {
        "defaultReceive": {
          "type": "boolean"
        },
        "defaultSend": {
          "type": "boolean"
        }
      },
      "title": "BPayPaymentInstrumentWallet"
    },
    "BPayRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/BPay"
          }
        }
      },
      "title": "BPayRequest"
    },
    "BancomatCardsRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/PanResponse"
        }
      },
      "title": "BancomatCardsRequest"
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
    "CardInfo": {
      "type": "object",
      "properties": {
        "blurredNumber": {
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
        "hashPan": {
          "type": "string"
        },
        "holder": {
          "type": "string"
        },
        "htokenList": {
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "issuerAbiCode": {
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
      "title": "CardInfo"
    },
    "CheckCardBin": {
      "type": "object",
      "properties": {
        "cardBin": {
          "type": "string"
        },
        "urlLogo": {
          "type": "string"
        }
      },
      "title": "CheckCardBin"
    },
    "CheckCardBinRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/CheckCardBin"
        }
      },
      "title": "CheckCardBinRequest"
    },
    "CheckCardBinResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/CheckCardBin"
        }
      },
      "title": "CheckCardBinResponse"
    },
    "CobadegPaymentInstrumentsRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/CobadgeResponse"
        }
      },
      "title": "CobadegPaymentInstrumentsRequest"
    },
    "CobadgeResponse": {
      "type": "object",
      "properties": {
        "errors": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/ErrorModel"
          }
        },
        "payload": {
          "$ref": "#/definitions/Payload"
        },
        "status": {
          "type": "string"
        }
      },
      "title": "CobadgeResponse"
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
    "PayPalInfo": {
      "type": "object",
      "properties": {
        "pspInfo": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/PayPalPspInfo"
          }
        }
      },
      "title": "PayPalInfo"
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
          "format": "double",
        },
        "codiceAbi": {
          "type": "string",
        },
        "idPsp": {
          "type": "string",
        },
        "maxFee": {
          "type": "integer",
        },
        "onboard": {
          "type": "boolean",
          "example": false,
        },
        "privacyUrl": {
          "type": "string",
        },
        "ragioneSociale": {
          "type": "string",
        }
      },
      "title": "PayPalPsp"
    },
    "PayPalPspInfo": {
      "type": "object",
      "properties": {
        "abi": {
          "type": "string"
        },
        "dataAssociazione": {
          "type": "string",
          "format": "date-time"
        },
        "default": {
          "type": "boolean"
        },
        "email": {
          "type": "string"
        },
        "ragioneSociale": {
          "type": "string"
        }
      },
      "title": "PayPalPspInfo"
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
    "PaymentResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Payment"
        }
      },
      "title": "PaymentResponse"
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
          "type": "string",
        },
        "defaultPsp": {
          "type": "boolean",
          "example": false,
        },
        "fee": {
          "type": "integer",
        },
        "idPsp": {
          "type": "string",
        },
        "onboard": {
          "type": "boolean",
          "example": false,
        },
        "privacyUrl": {
          "type": "string",
        },
        "ragioneSociale": {
          "type": "string",
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
    "PspInfo": {
      "type": "object",
      "properties": {
        "codiceAbi": {
          "type": "string"
        },
        "idPsp": {
          "type": "string"
        },
        "ragioneSociale": {
          "type": "string"
        }
      },
      "title": "PspInfo"
    },
    "PspListResponseCD": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Psp"
          }
        }
      },
      "title": "PspListResponseCD"
    },
    "PspResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Psp"
        }
      },
      "title": "PspResponse"
    },
    "ResourcesResponse": {
      "type": "object",
      "title": "ResourcesResponse"
    },
    "RestBPayResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/BPay"
          }
        }
      },
      "title": "RestBPayResponse"
    },
    "RestCobadgeResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/CobadgeResponse"
        }
      },
      "title": "RestCobadgeResponse"
    },
    "RestPanResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/PanResponse"
        }
      },
      "title": "RestPanResponse"
    },
    "RestSatispayResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Satispay"
        }
      },
      "title": "RestSatispayResponse"
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
    "SatispayInfo": {
      "type": "object",
      "properties": {
        "brandLogo": {
          "type": "string"
        },
        "uuid": {
          "type": "string"
        }
      },
      "title": "SatispayInfo"
    },
    "SatispayRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Satispay"
        }
      },
      "title": "SatispayRequest"
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
    "Session": {
      "type": "object",
      "properties": {
        "idPayment": {
          "type": "string"
        },
        "sessionToken": {
          "type": "string"
        },
        "user": {
          "$ref": "#/definitions/User"
        }
      },
      "title": "Session"
    },
    "SessionResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Session"
        }
      },
      "title": "SessionResponse"
    },
    "Transaction": {
      "type": "object",
      "properties": {
        "accountingStatus": {
          "type": "integer",
          "format": "int64"
        },
        "amount": {
          "$ref": "#/definitions/Amount"
        },
        "authorizationCode": {
          "type": "string"
        },
        "created": {
          "type": "string",
          "format": "date-time"
        },
        "description": {
          "type": "string"
        },
        "detailsList": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Dettaglio"
          }
        },
        "directAcquirer": {
          "type": "boolean"
        },
        "error": {
          "type": "boolean"
        },
        "fee": {
          "$ref": "#/definitions/Amount"
        },
        "grandTotal": {
          "$ref": "#/definitions/Amount"
        },
        "id": {
          "type": "integer",
          "format": "int64"
        },
        "idPayment": {
          "type": "integer",
          "format": "int64"
        },
        "idStatus": {
          "type": "integer",
          "format": "int64"
        },
        "idWallet": {
          "type": "integer",
          "format": "int64"
        },
        "merchant": {
          "type": "string"
        },
        "nodoIdPayment": {
          "type": "string"
        },
        "numAut": {
          "type": "string"
        },
        "orderNumber": {
          "type": "integer",
          "format": "int64"
        },
        "paymentCancelled": {
          "type": "boolean"
        },
        "paymentModel": {
          "type": "integer",
          "format": "int64"
        },
        "pspId": {
          "type": "integer",
          "format": "int64"
        },
        "pspInfo": {
          "$ref": "#/definitions/PspInfo"
        },
        "rrn": {
          "type": "string"
        },
        "spcNodeDescription": {
          "type": "string"
        },
        "spcNodeStatus": {
          "type": "integer",
          "format": "int64"
        },
        "statusMessage": {
          "type": "string"
        },
        "success": {
          "type": "boolean"
        },
        "token": {
          "type": "string"
        },
        "updated": {
          "type": "string",
          "format": "date-time"
        },
        "urlCheckout3ds": {
          "type": "string"
        },
        "urlRedirectPSP": {
          "type": "string"
        }
      },
      "title": "Transaction"
    },
    "TransactionListResponse": {
      "type": "object",
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Transaction"
          }
        },
        "size": {
          "type": "integer",
          "format": "int32"
        },
        "start": {
          "type": "integer",
          "format": "int32"
        },
        "total": {
          "type": "integer",
          "format": "int32"
        }
      },
      "title": "TransactionListResponse"
    },
    "TransactionResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Transaction"
        }
      },
      "title": "TransactionResponse"
    },
    "User": {
      "type": "object",
      "properties": {
        "acceptTerms": {
          "type": "boolean"
        },
        "activationDate": {
          "type": "string",
          "format": "date-time"
        },
        "cellphone": {
          "type": "string"
        },
        "email": {
          "type": "string"
        },
        "fiscalCode": {
          "type": "string"
        },
        "idPayment": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "notificationEmail": {
          "type": "string"
        },
        "registered": {
          "type": "boolean"
        },
        "registeredDate": {
          "type": "string",
          "format": "date-time"
        },
        "spidSessionId": {
          "type": "integer",
          "format": "int64"
        },
        "status": {
          "type": "string",
          "enum": [
            "ANONYMOUS",
            "DELETED",
            "REGISTERED_SPID",
            "REGISTERED_CIE"
          ]
        },
        "surname": {
          "type": "string"
        },
        "userId": {
          "type": "integer",
          "format": "int64"
        },
        "username": {
          "type": "string"
        }
      },
      "title": "User"
    },
    "UserResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/User"
        }
      },
      "title": "UserResponse"
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
