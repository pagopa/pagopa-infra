{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-rest",
    "version": "1.0",
    "title": "Payment Manager API",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-restapi",
  "tags": [
    {
      "name": "payments-controller",
      "description": "Payments Controller"
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
      "name": "spid-registry-controller",
      "description": "SPID Registry Controller"
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
    }
  ],
  "produces": [
    "application/json"
  ],
  "paths": {
    "/v4/payments/{id}/actions/check": {
      "get": {
        "tags": [
          "payments-controller"
        ],
        "summary": "checkPayment",
        "operationId": "checkPaymentUsingGET",
        "parameters": [
          {
            "name": "origin",
            "in": "header",
            "description": "origin",
            "required": false,
            "type": "string"
          },
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
    "/v4/payments/{id}/actions/check-internal": {
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
    "/v4/payments/{id}/actions/delete": {
      "delete": {
        "tags": [
          "payments-controller"
        ],
        "summary": "deleteBySessionCookieExpired",
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
            "name": "koReason",
            "in": "query",
            "description": "koReason",
            "required": false,
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
    "/v4/payments/{id}/actions/pay": {
      "post": {
        "tags": [
          "payments-controller"
        ],
        "summary": "valori authorizationCode: [ 00 - OK ] [ 02 - parametro duplicato ] [ 03 - formato messaggio errato, campo mancante o errato ][ 04 - MAC non corretto ] [ 06 - errore imprevisto durante l’elaborazione ][ 37 - codice di verifica mancante ] [ 40 - errore xml ] [ 41 - errore xml ] [ 98 - errore applicativo ] [ 99 - operazione fallita ]",
        "operationId": "payUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          },
          {
            "in": "body",
            "name": "payRequest",
            "description": "payRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/PayRequest"
            }
          },
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
              "$ref": "#/definitions/TransactionResponse"
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
    "/v4/payments/{id}/actions/pay3ds2": {
      "post": {
        "tags": [
          "payments-controller"
        ],
        "summary": "valori authorizationCode: [ 00 - OK ] [ 02 - parametro duplicato ] [ 03 - formato messaggio errato, campo mancante o errato ][ 04 - MAC non corretto ] [ 06 - errore imprevisto durante l’elaborazione ][ 37 - codice di verifica mancante ] [ 40 - errore xml ] [ 41 - errore xml ] [ 98 - errore applicativo ] [ 99 - operazione fallita ]",
        "operationId": "pay3ds2UsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "origin",
            "in": "header",
            "description": "origin",
            "required": false,
            "type": "string"
          },
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          },
          {
            "in": "body",
            "name": "payRequest",
            "description": "payRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/PayRequest"
            }
          },
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
              "$ref": "#/definitions/TransactionResponse"
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
    "/v4/psps": {
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
              "$ref": "#/definitions/PspListResponse"
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
    "/v4/psps/actions/get-buyer-bank/{idBuyer}": {
      "get": {
        "tags": [
          "psp-controller"
        ],
        "summary": "getBuyerBank",
        "operationId": "getBuyerBankUsingGET",
        "parameters": [
          {
            "name": "idBuyer",
            "in": "path",
            "description": "idBuyer",
            "required": true,
            "type": "integer",
            "format": "int64"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/BuyerBankResponse"
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
    "/v4/psps/actions/get-seller-bank/{idBuyer}": {
      "post": {
        "tags": [
          "psp-controller"
        ],
        "summary": "retrieveSellerBank",
        "operationId": "retrieveSellerBankUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "idBuyer",
            "in": "path",
            "description": "idBuyer",
            "required": true,
            "type": "integer",
            "format": "int64"
          },
          {
            "in": "body",
            "name": "sellerBanksRequest",
            "description": "sellerBanksRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/SellerBanksRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/PspResponse"
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
    "/v4/psps/buyer-banks": {
      "get": {
        "tags": [
          "psp-controller"
        ],
        "summary": "getBuyerBankList",
        "operationId": "getBuyerBankListUsingGET",
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
              "$ref": "#/definitions/BuyerBankListResponse"
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
    "/v4/psps/seller/list": {
      "get": {
        "tags": [
          "psp-controller"
        ],
        "summary": "getPspsByIds",
        "operationId": "getPspsByIdsUsingGET",
        "parameters": [
          {
            "name": "id",
            "in": "query",
            "description": "id",
            "required": true,
            "type": "array",
            "items": {
              "type": "integer",
              "format": "int64"
            },
            "collectionFormat": "multi"
          },
          {
            "name": "buyerBankId",
            "in": "query",
            "description": "buyerBankId",
            "required": true,
            "type": "integer",
            "format": "int64"
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
              "$ref": "#/definitions/SelectedPspListResponse"
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
    "/v4/psps/{id}": {
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
    "/v4/resources": {
      "get": {
        "tags": [
          "resource-controller"
        ],
        "summary": "getResources",
        "operationId": "getResourcesUsingGET",
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
    "/v4/resources/psp/{id}": {
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
    "/v4/resources/service/img/pa-logo/{idLogo}": {
      "get": {
        "tags": [
          "resource-controller"
        ],
        "summary": "getLogoWithMediaType",
        "operationId": "getLogoWithMediaTypeUsingGET",
        "parameters": [
          {
            "name": "idLogo",
            "in": "path",
            "description": "idLogo",
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
    "/v4/resources/service/img/{imgName}": {
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
    "/v4/resources/service/{id}": {
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
    "/v4/spid-authentication-record": {
      "post": {
        "tags": [
          "spid-registry-controller"
        ],
        "summary": "writeRecord",
        "operationId": "writeRecordUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "samlAuthenticationRequest",
            "description": "samlAuthenticationRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/SAMLAuthenticationRecordRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/SAMLAuthenticationRecordResponse"
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
    "/v4/transactions": {
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
              "$ref": "#/definitions/TransactionListRestApiResponse"
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
    "/v4/transactions/{id}": {
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
    "/v4/transactions/{id}/actions/check": {
      "get": {
        "tags": [
          "transaction-controller"
        ],
        "summary": "checkStatus",
        "operationId": "checkStatusUsingGET",
        "parameters": [
          {
            "name": "origin",
            "in": "header",
            "description": "origin",
            "required": false,
            "type": "string"
          },
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
              "$ref": "#/definitions/TransactionStatusResponse"
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
    "/v4/transactions/{id}/actions/resume": {
      "post": {
        "tags": [
          "transaction-controller"
        ],
        "summary": "resume",
        "operationId": "resumeUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "origin",
            "in": "header",
            "description": "origin",
            "required": false,
            "type": "string"
          },
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          },
          {
            "in": "body",
            "name": "resumeRequest",
            "description": "resumeRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/ResumeRequest"
            }
          },
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
            "description": "OK"
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
    "/v4/transactions/{id}/actions/resume3ds2": {
      "post": {
        "tags": [
          "transaction-controller"
        ],
        "summary": "resume3ds2",
        "operationId": "resume3ds2UsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "origin",
            "in": "header",
            "description": "origin",
            "required": false,
            "type": "string"
          },
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "string"
          },
          {
            "in": "body",
            "name": "resumeRequest",
            "description": "resumeRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/ResumeRequest"
            }
          },
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
            "description": "OK"
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
    "/v4/users": {
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
      },
      "put": {
        "tags": [
          "users-controller"
        ],
        "summary": "updateUser",
        "operationId": "updateUserUsingPUT",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "userRequest",
            "description": "userRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/UserRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/UserResponse"
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
    "/v4/users/actions/approve-terms": {
      "post": {
        "tags": [
          "users-controller"
        ],
        "summary": "approveTerms",
        "operationId": "approveTermsUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "approveTermsRequest",
            "description": "approveTermsRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/ApproveTermsRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/UserResponse"
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
    "/v4/users/actions/check-session": {
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
    "/v4/users/actions/logout": {
      "post": {
        "tags": [
          "users-controller"
        ],
        "summary": "logout",
        "operationId": "logoutUsingPOST",
        "consumes": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "OK"
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
    "/v4/users/actions/spid/success": {
      "post": {
        "tags": [
          "users-controller"
        ],
        "summary": "successSpidLogin",
        "operationId": "successSpidLoginUsingPOST",
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
              "$ref": "#/definitions/StartSpidSessionRequest"
            }
          },
          {
            "name": "Api-Key",
            "in": "header",
            "description": "Api-Key",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/Session"
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
    "/v4/users/actions/start-session": {
      "post": {
        "tags": [
          "users-controller"
        ],
        "summary": "startSession",
        "operationId": "startSessionUsingPOST",
        "consumes": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "startSessionRequest",
            "description": "startSessionRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/StartSessionRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/Session"
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
        }
      }
    },
    "/v4/users/actions/start-session-spid": {
      "post": {
        "tags": [
          "users-controller"
        ],
        "summary": "startSessionSpid",
        "operationId": "startSessionSpidUsingPOST",
        "consumes": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/SpidSessionResponse"
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
        }
      }
    },
    "/v4/users/byTransactionId/{transactionId}": {
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
    "/v4/wallet": {
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
            "name": "origin",
            "in": "header",
            "description": "origin",
            "required": false,
            "type": "string"
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
    "/v4/wallet/actions/check-card-bin": {
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
    "/v4/wallet/byTransactionId/{transactionId}": {
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
    "/v4/wallet/delete-contract": {
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
    "/v4/wallet/set-favorite": {
      "post": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "setWalletFavorite",
        "operationId": "setWalletFavoriteUsingPOST",
        "consumes": [
          "application/json"
        ],
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
    "/v4/wallet/set-visible": {
      "post": {
        "tags": [
          "wallet-controller"
        ],
        "summary": "setWalletVisible",
        "operationId": "setWalletVisibleUsingPOST",
        "consumes": [
          "application/json"
        ],
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
    "/v4/wallet/{id}": {
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
    "/v4/wallet/{id}/actions/confirm": {
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
    "/v4/wallet/{id}/actions/favourite": {
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
    "AppTransaction": {
      "type": "object",
      "properties": {
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
        },
        "transactionsList": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Transaction"
          }
        }
      },
      "title": "AppTransaction"
    },
    "ApproveTerms": {
      "type": "object",
      "properties": {
        "privacy": {
          "type": "boolean"
        },
        "terms": {
          "type": "boolean"
        }
      },
      "title": "ApproveTerms"
    },
    "ApproveTermsRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/ApproveTerms"
        }
      },
      "title": "ApproveTermsRequest"
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
    "BuyerBank": {
      "type": "object",
      "properties": {
        "alias": {
          "type": "string"
        },
        "id": {
          "type": "integer",
          "format": "int64"
        },
        "participant": {
          "type": "string"
        }
      },
      "title": "BuyerBank"
    },
    "BuyerBankListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/BuyerBanks"
        }
      },
      "title": "BuyerBankListResponse"
    },
    "BuyerBankResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/BuyerBank"
        }
      },
      "title": "BuyerBankResponse"
    },
    "BuyerBanks": {
      "type": "object",
      "properties": {
        "buyerBanks": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/BuyerBank"
          }
        },
        "language": {
          "type": "string"
        }
      },
      "title": "BuyerBanks"
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
    "Device": {
      "type": "object",
      "properties": {
        "idDevice": {
          "type": "integer",
          "format": "int64"
        },
        "idNotificationConfig": {
          "type": "string"
        },
        "idUser": {
          "type": "integer",
          "format": "int64"
        },
        "os": {
          "type": "string",
          "enum": [
            "ANDROID",
            "IOS"
          ]
        },
        "scale": {
          "type": "integer",
          "format": "int64"
        },
        "status": {
          "type": "string",
          "enum": [
            "ACTIVE",
            "DISABLED"
          ]
        },
        "token": {
          "type": "string"
        },
        "userAgent": {
          "type": "string"
        }
      },
      "title": "Device"
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
    "Pay": {
      "type": "object",
      "properties": {
        "cvv": {
          "type": "string"
        },
        "idWallet": {
          "type": "integer",
          "format": "int64"
        },
        "mobileToken": {
          "type": "string"
        },
        "threeDSData": {
          "type": "string"
        },
        "tipo": {
          "type": "string"
        }
      },
      "title": "Pay"
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
    "PayRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Pay"
        }
      },
      "title": "PayRequest"
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
    "PspListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/PspListResponseData"
        }
      },
      "title": "PspListResponse"
    },
    "PspListResponseData": {
      "type": "object",
      "properties": {
        "myBankSellerBankList": {
          "type": "array",
          "items": {
            "type": "integer",
            "format": "int64"
          }
        },
        "pspList": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Psp"
          }
        }
      },
      "title": "PspListResponseData"
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
    "Resume": {
      "type": "object",
      "properties": {
        "esito": {
          "type": "string"
        },
        "methodCompleted": {
          "type": "string"
        },
        "xpay3DSResponse": {
          "$ref": "#/definitions/Xpay3DSResponse"
        }
      },
      "title": "Resume"
    },
    "ResumeRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/Resume"
        }
      },
      "title": "ResumeRequest"
    },
    "SAMLAuthenticationRecordRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/SPIDAuthenticationRecord"
        }
      },
      "title": "SAMLAuthenticationRecordRequest"
    },
    "SAMLAuthenticationRecordResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/SPIDAuthenticationRecord"
        }
      },
      "title": "SAMLAuthenticationRecordResponse"
    },
    "SPIDAuthenticationRecord": {
      "type": "object",
      "properties": {
        "createDate": {
          "type": "string",
          "format": "date-time"
        },
        "destination": {
          "type": "string"
        },
        "inResponseToSPIDId": {
          "type": "string"
        },
        "issuer": {
          "type": "string"
        },
        "operation": {
          "type": "string"
        },
        "rawMessage": {
          "type": "string"
        },
        "result": {
          "type": "string"
        },
        "spidId": {
          "type": "string"
        }
      },
      "title": "SPIDAuthenticationRecord"
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
    "SelectedPspListResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/SelectedPspListResponseBody"
        }
      },
      "title": "SelectedPspListResponse"
    },
    "SelectedPspListResponseBody": {
      "type": "object",
      "properties": {
        "pspList": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Psp"
          }
        }
      },
      "title": "SelectedPspListResponseBody"
    },
    "SellerBanksParams": {
      "type": "object",
      "properties": {
        "iban": {
          "type": "string"
        },
        "idSellerChosen": {
          "type": "integer",
          "format": "int64"
        },
        "language": {
          "type": "string"
        },
        "sellerBanksList": {
          "type": "array",
          "items": {
            "type": "integer",
            "format": "int64"
          }
        }
      },
      "title": "SellerBanksParams"
    },
    "SellerBanksRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/SellerBanksParams"
        }
      },
      "title": "SellerBanksRequest"
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
    "SpidSession": {
      "type": "object",
      "properties": {
        "email": {
          "type": "string"
        },
        "fiscalCode": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "surname": {
          "type": "string"
        },
        "token": {
          "type": "string"
        },
        "verified": {
          "type": "boolean"
        }
      },
      "title": "SpidSession"
    },
    "SpidSessionResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/SpidSession"
        }
      },
      "title": "SpidSessionResponse"
    },
    "StartSession": {
      "type": "object",
      "properties": {
        "device": {
          "$ref": "#/definitions/Device"
        },
        "email": {
          "type": "string"
        },
        "fiscalCode": {
          "type": "string"
        },
        "idPayment": {
          "type": "string"
        }
      },
      "title": "StartSession"
    },
    "StartSessionRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/StartSession"
        }
      },
      "title": "StartSessionRequest"
    },
    "StartSpidSession": {
      "type": "object",
      "properties": {
        "spidSession": {
          "$ref": "#/definitions/SpidSession"
        }
      },
      "title": "StartSpidSession"
    },
    "StartSpidSessionRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/StartSpidSession"
        }
      },
      "title": "StartSpidSessionRequest"
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
    "TransactionListRestApiResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/AppTransaction"
        }
      },
      "title": "TransactionListRestApiResponse"
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
    "TransactionStatus": {
      "type": "object",
      "properties": {
        "acsUrl": {
          "type": "string"
        },
        "authorizationCode": {
          "type": "string"
        },
        "expired": {
          "type": "boolean"
        },
        "finalStatus": {
          "type": "boolean"
        },
        "idPayment": {
          "type": "string"
        },
        "idStatus": {
          "type": "integer",
          "format": "int64"
        },
        "idTransaction": {
          "type": "integer",
          "format": "int64"
        },
        "methodUrl": {
          "type": "string"
        },
        "paymentOrigin": {
          "type": "string"
        },
        "result": {
          "type": "string"
        },
        "statusMessage": {
          "type": "string"
        },
        "threeDSMethodData": {
          "type": "string"
        },
        "xpayHtml": {
          "type": "string"
        }
      },
      "title": "TransactionStatus"
    },
    "TransactionStatusResponse": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/TransactionStatus"
        }
      },
      "title": "TransactionStatusResponse"
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
    "UserRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/User"
        }
      },
      "title": "UserRequest"
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
    "Xpay3DSResponse": {
      "type": "object",
      "properties": {
        "codice": {
          "type": "string"
        },
        "esito": {
          "type": "string",
          "enum": [
            "OK",
            "KO"
          ]
        },
        "idOperazione": {
          "type": "string"
        },
        "mac": {
          "type": "string"
        },
        "messaggio": {
          "type": "string"
        },
        "resumeType": {
          "type": "string"
        },
        "timestamp": {
          "type": "string"
        },
        "xpayNonce": {
          "type": "string"
        }
      },
      "title": "Xpay3DSResponse"
    }
  }
}
