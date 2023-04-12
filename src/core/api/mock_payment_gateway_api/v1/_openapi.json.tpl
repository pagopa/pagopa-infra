{
  "openapi": "3.0.1",
  "info": {
    "title": "Pagopa PM Mock",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "tags": [
    {
      "name": "paypalmock",
      "description": "todo"
    }
  ],
  "paths": {
    "/paypalpsp/api/pp_onboarding_back": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to start onboarding",
        "responses": {
          "200": {
            "description": "Response",
            "content": {
              "application/json": {
                "schema": {
                  "oneOf": [
                    {
                      "$ref": "#/components/schemas/StartOnboardingResponseSuccess"
                    },
                    {
                      "$ref": "#/components/schemas/StartOnboardingResponseError"
                    }
                  ]
                }
              }
            }
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalpsp/api/pp_pay_direct": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to pay",
        "responses": {
          "200": {
            "description": "Response"
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalpsp/api/pp_refund_direct": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to refund payment",
        "responses": {
          "200": {
            "description": "Response"
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalpsp/api/pp_bilagr_del": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to delete contract",
        "responses": {
          "200": {
            "description": "Response"
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalweb/*": {
      "get": {
        "operationId": "WebView GET",
        "description": "TEST WebView paypal",
        "tags": [
          "paypalmock"
        ],
        "responses": {
          "200": {
            "description": "html with redirect"
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
        "operationId": "WebView POST",
        "description": "TEST WebView paypal",
        "tags": [
          "paypalmock"
        ],
        "responses": {
          "200": {
            "description": "html with redirect"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    },
    "/static/*": {
      "get": {
        "operationId": "staticResourcesGET",
        "description": "static resources GET",
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
    },
    "/bpay": {
      "post": {
        "operationId": "bpayRequestAuthPOST",
        "description": "Payment authorization request to BPAY",
        "responses": {
          "200": {
            "description": "Authorization response"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    },
    "/postepay/api/v1/payment/create": {
      "post": {
        "operationId": "createPayment",
        "tags": [
          "Payment Manager Controller"
        ],
        "summary": "Inzializzazione della transazione di pagamento",
        "description": "",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreatePaymentRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "description": "",
                  "required": [
                    "paymentID",
                    "userRedirectURL"
                  ],
                  "type": "object",
                  "properties": {
                    "paymentID": {
                      "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
                      "type": "string"
                    },
                    "userRedirectURL": {
                      "description": "URL verso cui redirigere l'utente per portare a compimento la transazione",
                      "type": "string"
                    }
                  }
                }
              }
            }
          },
          "default": {
            "description": "Errore",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayError"
                }
              }
            }
          }
        }
      }
    },
    "/postepay/api/v1/user/onboarding": {
      "post": {
        "operationId": "userPostepayOnboarding",
        "summary": "Postepay user onboarding",
        "description": "",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/OnboardingPostepayRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "description": "",
                  "required": [
                    "onboardingID",
                    "userRedirectURL"
                  ],
                  "type": "object",
                  "properties": {
                    "onboardingID": {
                      "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
                      "type": "string"
                    },
                    "userRedirectURL": {
                      "description": "URL verso cui redirigere l'utente per portare a compimento la transazione",
                      "type": "string"
                    }
                  }
                }
              }
            }
          },
          "default": {
            "description": "Errore",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayError"
                }
              }
            }
          }
        }
      }
    },
    "/postepayweb/change/outcome": {
      "post": {
        "operationId": "changeOutcomePostePay",
        "tags": [
          "Payment Manager Controller"
        ],
        "parameters": [
          {
            "in": "query",
            "name": "paymentOutcome",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "timeoutMs",
            "schema": {
              "type": "integer"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/postepay/api/v1/payment/details": {
      "post": {
        "operationId": "paymentDetail",
        "summary": "Dettagli di una transazione di pagamento",
        "description": "",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DeatilsPaymentRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "description": "",
                  "required": [
                    "paymentID",
                    "userRedirectURL",
                    "shopId;",
                    "shopTransactionId",
                    "result",
                    "authNumber",
                    "amount",
                    "description",
                    "currency",
                    "buyerName",
                    "buyerEmail",
                    "paymentChannel",
                    "authType",
                    "status",
                    "refundedAmount"
                  ],
                  "type": "object",
                  "properties": {
                    "paymentID": {
                      "type": "string"
                    },
                    "userRedirectURL": {
                      "type": "string"
                    },
                    "shopId": {
                      "type": "string"
                    },
                    "shopTransactionId": {
                      "type": "string"
                    },
                    "result": {
                      "type": "string"
                    },
                    "authNumber": {
                      "type": "string"
                    },
                    "amount": {
                      "type": "string"
                    },
                    "description": {
                      "type": "string"
                    },
                    "currency": {
                      "type": "string"
                    },
                    "buyerName": {
                      "type": "string"
                    },
                    "buyerEmail": {
                      "type": "string"
                    },
                    "paymentChannel": {
                      "type": "string"
                    },
                    "authType": {
                      "type": "string"
                    },
                    "status": {
                      "type": "string"
                    },
                    "refundedAmount": {
                      "type": "string"
                    }
                  }
                }
              }
            }
          },
          "default": {
            "description": "Errore",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayError"
                }
              }
            }
          }
        }
      }
    },
    "/postepay/api/v1/payment/refund": {
      "post": {
        "operationId": "refundPostepayPayment",
        "tags": [
          "Payment Manager Controller"
        ],
        "summary": "refund transazione di pagamento",
        "description": "",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RefundPaymentRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "description": "",
                  "required": [
                    "paymentID",
                    "shopTransactionId",
                    "transactionResult"
                  ],
                  "type": "object",
                  "properties": {
                    "paymentID": {
                      "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
                      "type": "string"
                    },
                    "shopTransactionId": {
                      "type": "string"
                    },
                    "transactionResult": {
                      "type": "string",
                      "enum": [
                        "OK",
                        "KO"
                      ]
                    }
                  }
                }
              }
            }
          },
          "default": {
            "description": "Errore",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayError"
                }
              }
            }
          }
        }
      }
    },
    "/xpay/ecomm/api/paga/autenticazione3DS": {
      "post": {
        "tags": [
          "XPay Controller"
        ],
        "operationId": "paymentAuthorization",
        "summary": "esegue l'autenticazione3DS",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/XPayAuthRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayAuthResponseSuccess"
                }
              }
            }
          },
          "default": {
            "description": "Errore",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayAuthResponseError"
                }
              }
            }
          }
        }
      }
    },
    "/xpay/ecomm/api/paga/paga3DS": {
      "post": {
        "tags": [
          "XPay Payment Controller"
        ],
        "operationId": "xPayPayment",
        "summary": "esegue la paga3DS",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/XPayPaymentRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayPaymentResponseSuccess"
                }
              }
            }
          },
          "default": {
            "description": "Errore",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayPaymentResponseError"
                }
              }
            }
          }
        }
      }
    },
    "/xpay/ecomm/api/bo/storna": {
      "post": {
        "tags": [
          "XPay Refund Controller"
        ],
        "operationId": "xPayRefund",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/XPayRefundRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/XPayRefundResponse"
                }
              }
            }
          }
        }
      }
    },
    "/xpay/ecomm/api/bo/situazioneOrdine": {
      "post": {
        "tags": [
          "XPay OrderStatus Controller"
        ],
        "operationId": "xPayOrderStatus",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/XPayOrderRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/XPayOrderResponse"
                }
              }
            }
          }
        }
      }
    },
    "/cc/": {
      "get": {
        "tags": [
          "Credit Card Controller"
        ],
        "operationId": "creditCard WebView",
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/cc/generateCard": {
      "get": {
        "tags": [
          "Credit Card Controller"
        ],
        "operationId": "generateCard",
        "parameters": [
          {
            "name": "type",
            "in": "query",
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
              "*/*": {
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "/issuer/3ds20/method": {
      "get": {
        "tags": [
          "Issuer Controller"
        ],
        "operationId": "methodUrl WebView",
        "parameters": [
          {
            "name": "threeDSMethodData",
            "in": "query",
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
              "*/*": {
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "/issuer/3ds20/challenge": {
      "get": {
        "tags": [
          "Issuer Controller"
        ],
        "operationId": "challengeUrl WebView",
        "parameters": [
          {
            "name": "creq",
            "in": "query",
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
              "*/*": {
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "/vpos/authorize3dsV2": {
      "post": {
        "tags": [
          "VPOS Controller"
        ],
        "operationId": "vposAuthorize",
        "requestBody": {
          "content": {
            "application/x-www-form-urlencoded": {
              "schema": {
                "type": "string"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/xml;charset=ISO-8859-1": {
                "schema": {
                  "$ref": "#/components/schemas/BPWXmlResponse"
                }
              }
            }
          }
        }
      }
    },
    "/transactions/{transactionId}/auth-requests": {
      "patch": {
        "tags": [
          "UpdateTransactionAuthorizationController"
        ],
        "operationId": "updateTransactionAuthorization",
        "summary": "Update authorization",
        "description": "Callback endpoint used for notify authorization outcome",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Base64 of bytes related to TransactionId"
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/UpdateAuthorizationRequest"
        },
        "responses": {
          "200": {
            "description": "Transaction authorization request successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TransactionInfo"
                }
              }
            }
          },
          "400": {
            "description": "Invalid transaction id",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Transaction not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "Bad gateway",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "504": {
            "description": "Gateway timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "StartOnboardingResponseSuccess": {
        "required": [
          "esito",
          "url_to_call"
        ],
        "type": "object",
        "properties": {
          "esito": {
            "type": "string",
            "enum": [
              "1"
            ],
            "description": "URL used to return the result"
          },
          "url_to_call": {
            "type": "string",
            "description": "url to call to proceed with onboarding"
          }
        }
      },
      "StartOnboardingResponseError": {
        "required": [
          "esito",
          "err_code",
          "err_desc"
        ],
        "type": "object",
        "properties": {
          "esito": {
            "type": "string",
            "enum": [
              "3",
              "9"
            ],
            "description": "Api result"
          },
          "err_code": {
            "type": "string",
            "enum": [
              "9",
              "11",
              "13",
              "15",
              "19",
              "67"
            ]
          },
          "err_desc": {
            "type": "string"
          }
        }
      },
      "PostePayError": {
        "type": "object",
        "properties": {
          "errorCode": {
            "description": "Codice di errore",
            "type": "string"
          },
          "description": {
            "description": "Descrizione tecnica dell'errore",
            "type": "string"
          },
          "message": {
            "description": "Messaggio utente",
            "type": "string"
          }
        }
      },
      "AuthorizationType": {
        "enum": [
          "IMMEDIATA",
          "DIFFERITA"
        ],
        "type": "string"
      },
      "RefundPaymentRequest": {
        "description": "",
        "required": [
          "shopId",
          "shopTransactionId",
          "merchantId",
          "paymentID",
          "authNumber",
          "currency"
        ],
        "type": "object",
        "properties": {
          "shopId": {
            "description": "identificativo del negozio",
            "type": "string"
          },
          "shopTransactionId": {
            "description": "identificativo della transazione lato merchant",
            "type": "string"
          },
          "amount": {
            "description": "importo",
            "type": "string"
          },
          "reason": {
            "description": "descrizione della transazione presentata al cliente",
            "type": "string"
          },
          "currency": {
            "description": "valuta in codice ISO (EUR = 978)",
            "type": "string"
          },
          "merchantId": {
            "type": "string"
          },
          "paymentID": {
            "type": "string"
          },
          "authNumber": {
            "type": "string"
          }
        }
      },
      "DeatilsPaymentRequest": {
        "description": "",
        "required": [
          "shopId",
          "shopTransactionId",
          "paymentID"
        ],
        "type": "object",
        "properties": {
          "shopId": {
            "description": "identificativo del negozio",
            "type": "string"
          },
          "shopTransactionId": {
            "description": "identificativo della transazione lato merchant",
            "type": "string"
          },
          "paymentID": {
            "description": "paymentID",
            "type": "string"
          }
        }
      },
      "OnboardingPostepayRequest": {
        "description": "",
        "required": [
          "shopId",
          "merchantId",
          "onboardingTransactionId",
          "paymentChannel",
          "responseURLs"
        ],
        "type": "object",
        "properties": {
          "shopId": {
            "description": "identificativo del negozio",
            "type": "string"
          },
          "merchantId": {
            "description": "identificativo del merchant",
            "type": "string"
          },
          "onboardingTransactionId": {
            "description": "id onboarding transaction Id",
            "type": "string"
          },
          "paymentChannel": {
            "allOf": [
              {
                "$ref": "#/components/schemas/PaymentChannel"
              },
              {
                "description": "canale di pagamento, puo essere valorizzato con APP/WEB"
              }
            ]
          },
          "responseURLs": {
            "allOf": [
              {
                "$ref": "#/components/schemas/ResponseURLs"
              },
              {
                "description": "URL di ritorno"
              }
            ]
          }
        }
      },
      "CreatePaymentRequest": {
        "description": "",
        "required": [
          "shopId",
          "shopTransactionId",
          "amount",
          "currency",
          "paymentChannel",
          "authType",
          "responseURLs"
        ],
        "type": "object",
        "properties": {
          "shopId": {
            "description": "identificativo del negozio",
            "type": "string"
          },
          "shopTransactionId": {
            "description": "identificativo della transazione lato merchant",
            "type": "string"
          },
          "amount": {
            "description": "importo",
            "type": "string"
          },
          "description": {
            "description": "descrizione della transazione presentata al cliente",
            "type": "string"
          },
          "currency": {
            "description": "valuta in codice ISO (EUR = 978)",
            "type": "string"
          },
          "buyerName": {
            "description": "nome del cliente",
            "type": "string"
          },
          "buyerEmail": {
            "description": "indirizzo email del cliente",
            "type": "string"
          },
          "paymentChannel": {
            "allOf": [
              {
                "$ref": "#/components/schemas/PaymentChannel"
              },
              {
                "description": "canale di pagamento, puo essere valorizzato con APP/WEB"
              }
            ]
          },
          "authType": {
            "allOf": [
              {
                "$ref": "#/components/schemas/AuthorizationType"
              },
              {
                "description": "tipo di autorizzazione, puo essere valorizzato con IMMEDIATA/DIFFERITA"
              }
            ]
          },
          "responseURLs": {
            "allOf": [
              {
                "$ref": "#/components/schemas/ResponseURLs"
              },
              {
                "description": "URL di ritorno"
              }
            ]
          }
        }
      },
      "PaymentChannel": {
        "enum": [
          "WEB",
          "APP"
        ],
        "type": "string"
      },
      "ResponseURLs": {
        "description": "",
        "required": [
          "responseUrlOk",
          "responseUrlKo",
          "serverNotificationUrl"
        ],
        "type": "object",
        "properties": {
          "responseUrlOk": {
            "description": "URL di redirect dell'utente per transazione OK completa di eventuali parametri da passare",
            "type": "string"
          },
          "responseUrlKo": {
            "description": "URL di redirect dell'utente per transazione KO completa di eventuali parametri da passare",
            "type": "string"
          },
          "serverNotificationUrl": {
            "description": "URL presso la quale sarà eseguita la chiamata di conferma del pagamento solo per i casi OK",
            "type": "string"
          }
        }
      },
      "XPayAuthRequest": {
        "description": "",
        "required": [
          "apiKey",
          "urlRisposta",
          "codiceTransazione",
          "importo",
          "divisa",
          "pan",
          "scadenza",
          "cvv",
          "timeStamp",
          "mac"
        ],
        "type": "object",
        "properties": {
          "apiKey": {
            "type": "string"
          },
          "urlRisposta": {
            "type": "string"
          },
          "codiceTransazione": {
            "type": "string"
          },
          "importo": {
            "type": "number",
            "format": "BigInteger"
          },
          "divisa": {
            "description": "valuta in codice ISO (EUR = 978)",
            "type": "number",
            "format": "long"
          },
          "pan": {
            "type": "string"
          },
          "scadenza": {
            "type": "string"
          },
          "cvv": {
            "type": "string"
          },
          "timeStamp": {
            "type": "string"
          },
          "mac": {
            "type": "string"
          }
        }
      },
      "XPayAuthResponseSuccess": {
        "description": "",
        "required": [
          "esito",
          "idOperazione",
          "timeStamp",
          "mac"
        ],
        "type": "object",
        "properties": {
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
          "timeStamp": {
            "type": "number",
            "format": "long"
          },
          "html": {
            "type": "string"
          },
          "mac": {
            "type": "string"
          }
        }
      },
      "XPayAuthResponseError": {
        "description": "",
        "required": [
          "esito",
          "idOperazione",
          "timeStamp",
          "mac"
        ],
        "type": "object",
        "properties": {
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
          "timeStamp": {
            "type": "number",
            "format": "long"
          },
          "errore": {
            "$ref": "#/components/schemas/XPayError"
          },
          "mac": {
            "type": "string"
          }
        }
      },
      "XPayError": {
        "required": [
          "codice",
          "messaggio"
        ],
        "properties": {
          "codice": {
            "type": "number",
            "format": "long"
          },
          "messaggio": {
            "type": "string"
          }
        }
      },
      "XPayPaymentRequest": {
        "description": "",
        "required": [
          "apiKey",
          "codiceTransazione",
          "importo",
          "divisa",
          "xpayNonce",
          "timeStamp",
          "mac"
        ],
        "type": "object",
        "properties": {
          "apiKey": {
            "type": "string"
          },
          "codiceTransazione": {
            "type": "string"
          },
          "importo": {
            "type": "number",
            "format": "BigInteger"
          },
          "divisa": {
            "description": "valuta in codice ISO (EUR = 978)",
            "type": "number",
            "format": "long"
          },
          "xpayNonce": {
            "type": "string"
          },
          "timeStamp": {
            "type": "string"
          },
          "mac": {
            "type": "string"
          },
          "parametriAggiuntivi": {
            "$ref": "#/components/schemas/XPayAdditionalParameters"
          }
        }
      },
      "XPayAdditionalParameters": {
        "properties": {
          "mail": {
            "type": "string"
          },
          "nome": {
            "type": "string"
          },
          "cognome": {
            "type": "string"
          },
          "descrizione": {
            "type": "string"
          },
          "note1": {
            "type": "string"
          },
          "XPayTconTabEnum": {
            "type": "string",
            "enum": [
              "C",
              "D"
            ]
          }
        }
      },
      "XPayPaymentResponseSuccess": {
        "description": "",
        "required": [
          "esito",
          "idOperazione",
          "timeStamp",
          "mac",
          "codiceAutorizzazione",
          "codiceConvenzione",
          "data",
          "nazione",
          "regione",
          "brand",
          "tipoProdotto",
          "tipoTransazione"
        ],
        "type": "object",
        "properties": {
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
          "timeStamp": {
            "type": "number",
            "format": "long"
          },
          "mac": {
            "type": "string"
          },
          "codiceAutorizzazione": {
            "type": "string"
          },
          "codiceConvenzione": {
            "type": "string"
          },
          "data": {
            "type": "string"
          },
          "nazione": {
            "type": "string"
          },
          "regione": {
            "type": "string"
          },
          "brand": {
            "type": "string"
          },
          "tipoProdotto": {
            "type": "string"
          },
          "tipoTransazione": {
            "type": "string"
          },
          "ppo": {
            "type": "string"
          },
          "parametriAggiuntivi": {
            "$ref": "#/components/schemas/XPayAdditionalParameters"
          }
        }
      },
      "XPayPaymentResponseError": {
        "description": "",
        "required": [
          "esito",
          "idOperazione",
          "timeStamp"
        ],
        "type": "object",
        "properties": {
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
          "timeStamp": {
            "type": "number",
            "format": "long"
          },
          "errore": {
            "$ref": "#/components/schemas/XPayError"
          },
          "mac": {
            "type": "string"
          }
        }
      },
      "XPayRefundRequest": {
        "required": [
          "apiKey",
          "codiceTransazione",
          "divisa",
          "importo",
          "mac",
          "timeStamp"
        ],
        "type": "object",
        "properties": {
          "apiKey": {
            "type": "string"
          },
          "codiceTransazione": {
            "type": "string"
          },
          "importo": {
            "type": "integer"
          },
          "divisa": {
            "type": "integer",
            "format": "int64"
          },
          "timeStamp": {
            "type": "string"
          },
          "mac": {
            "type": "string"
          },
          "idContabParzialePayPal": {
            "type": "string"
          }
        }
      },
      "XPayInfoApm": {
        "type": "object",
        "properties": {
          "apm": {
            "type": "string"
          },
          "info": {
            "type": "string"
          }
        }
      },
      "XPayRefundResponse": {
        "type": "object",
        "properties": {
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
          "timeStamp": {
            "type": "integer",
            "format": "int64"
          },
          "mac": {
            "type": "string"
          },
          "infoAPM": {
            "$ref": "#/components/schemas/XPayInfoApm"
          },
          "errore": {
            "$ref": "#/components/schemas/XPayError"
          }
        }
      },
      "XPayOrderRequest": {
        "required": [
          "apiKey",
          "codiceTransazione",
          "mac",
          "timeStamp"
        ],
        "type": "object",
        "properties": {
          "apiKey": {
            "type": "string"
          },
          "codiceTransazione": {
            "type": "string"
          },
          "timeStamp": {
            "type": "string"
          },
          "mac": {
            "type": "string"
          }
        }
      },
      "XPayOrderResponse": {
        "type": "object",
        "properties": {
          "timeStamp": {
            "type": "integer",
            "format": "int64"
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
          "scadenza": {
            "type": "string"
          },
          "mac": {
            "type": "string"
          },
          "errore": {
            "$ref": "#/components/schemas/XPayError"
          },
          "report": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/XPayReport"
            }
          }
        }
      },
      "XPayReport": {
        "type": "object",
        "properties": {
          "numeroMerchant": {
            "type": "string"
          },
          "codiceTransazione": {
            "type": "string"
          },
          "importo": {
            "type": "integer"
          },
          "divisa": {
            "type": "string"
          },
          "codiceAutorizzazione": {
            "type": "string"
          },
          "brand": {
            "type": "string"
          },
          "tipoPagamento": {
            "type": "string"
          },
          "tipoTransazione": {
            "type": "string"
          },
          "nazione": {
            "type": "string"
          },
          "tipoProdotto": {
            "type": "string"
          },
          "pan": {
            "type": "string"
          },
          "parametri": {
            "type": "string"
          },
          "stato": {
            "type": "string"
          },
          "dataTransazione": {
            "type": "string"
          },
          "mail": {
            "type": "string"
          },
          "dettaglio": {
            "$ref": "#/components/schemas/XPayReportDetail"
          }
        }
      },
      "XPayReportDetail": {
        "type": "object",
        "properties": {
          "nome": {
            "type": "string"
          },
          "cognome": {
            "type": "string"
          },
          "mail": {
            "type": "string"
          },
          "importo": {
            "type": "integer"
          },
          "importoRifiutato": {
            "type": "integer"
          },
          "divisa": {
            "type": "string"
          },
          "stato": {
            "type": "string"
          },
          "codiceTransazione": {
            "type": "string"
          },
          "parametriAggiuntivi": {
            "type": "string"
          },
          "controvaloreValuta": {
            "type": "integer"
          },
          "decimaliValuta": {
            "type": "integer",
            "format": "int32"
          },
          "tassoCambio": {
            "type": "integer"
          },
          "codiceValuta": {
            "type": "integer",
            "format": "int32"
          },
          "flagValuta": {
            "type": "boolean"
          },
          "operazioni": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/XPayReportOperations"
            }
          }
        }
      },
      "XPayReportOperations": {
        "type": "object",
        "properties": {
          "tipoOperazione": {
            "type": "string"
          },
          "importo": {
            "type": "integer"
          },
          "divisa": {
            "type": "string"
          },
          "stato": {
            "type": "string"
          },
          "dataOperazione": {
            "type": "string"
          },
          "utente": {
            "type": "string"
          },
          "idContabParzialePayPal": {
            "type": "string"
          }
        }
      },
      "BPWXmlResponse": {
        "type": "object",
        "properties": {
          "timestamp": {
            "type": "string",
            "xml": {
              "name": "Timestamp"
            }
          },
          "result": {
            "type": "string",
            "xml": {
              "name": "Result"
            }
          },
          "mac": {
            "type": "string",
            "xml": {
              "name": "MAC"
            }
          },
          "data": {
            "$ref": "#/components/schemas/XmlData"
          }
        },
        "xml": {
          "name": "BPWXmlResponse"
        }
      },
      "OrderStatus": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/OrderStatusHeader"
          },
          "orderId": {
            "type": "string",
            "xml": {
              "name": "OrderID"
            }
          }
        }
      },
      "OrderStatusHeader": {
        "type": "object",
        "properties": {
          "shopId": {
            "type": "string",
            "xml": {
              "name": "ShopID"
            }
          },
          "operatorId": {
            "type": "string",
            "xml": {
              "name": "OperatorID"
            }
          },
          "reqRefNum": {
            "type": "string",
            "xml": {
              "name": "ReqRefNum"
            }
          }
        }
      },
      "PanAliasData": {
        "type": "object",
        "properties": {
          "panAlias": {
            "type": "string",
            "xml": {
              "name": "PanAlias"
            }
          },
          "panAliasExpDate": {
            "type": "string",
            "xml": {
              "name": "PanAliasExpDate"
            }
          },
          "panAliasTail": {
            "type": "string",
            "xml": {
              "name": "PanAliasTail"
            }
          },
          "mac": {
            "type": "string",
            "xml": {
              "name": "MAC"
            }
          }
        }
      },
      "ThreeDSAuthorization": {
        "type": "object",
        "properties": {
          "paymentType": {
            "type": "string",
            "xml": {
              "name": "PaymentType"
            }
          },
          "authorizationType": {
            "type": "string",
            "xml": {
              "name": "AuthorizationType"
            }
          },
          "transactionID": {
            "type": "string",
            "xml": {
              "name": "TransactionID"
            }
          },
          "network": {
            "type": "string",
            "xml": {
              "name": "Network"
            }
          },
          "orderID": {
            "type": "string",
            "xml": {
              "name": "OrderID"
            }
          },
          "transactionAmount": {
            "type": "string",
            "xml": {
              "name": "TransactionAmount"
            }
          },
          "authorizedAmount": {
            "type": "string",
            "xml": {
              "name": "AuthorizedAmount"
            }
          },
          "currency": {
            "type": "string",
            "xml": {
              "name": "Currency"
            }
          },
          "exponent": {
            "type": "string",
            "xml": {
              "name": "Exponent"
            }
          },
          "accountedAmount": {
            "type": "string",
            "xml": {
              "name": "AccountedAmount"
            }
          },
          "refundedAmount": {
            "type": "string",
            "xml": {
              "name": "RefundedAmount"
            }
          },
          "transactionResult": {
            "type": "string",
            "xml": {
              "name": "TransactionResult"
            }
          },
          "timestamp": {
            "type": "string",
            "xml": {
              "name": "Timestamp"
            }
          },
          "authorizationNumber": {
            "type": "string",
            "xml": {
              "name": "AuthorizationNumber"
            }
          },
          "acquirerBIN": {
            "type": "string",
            "xml": {
              "name": "AcquirerBIN"
            }
          },
          "merchantID": {
            "type": "string",
            "xml": {
              "name": "MerchantID"
            }
          },
          "transactionStatus": {
            "type": "string",
            "xml": {
              "name": "TransactionStatus"
            }
          },
          "responseCodeISO": {
            "type": "string",
            "xml": {
              "name": "ResponseCodeISO"
            }
          },
          "rrn": {
            "type": "string",
            "xml": {
              "name": "RRN"
            }
          },
          "mac": {
            "type": "string",
            "xml": {
              "name": "MAC"
            }
          }
        }
      },
      "ThreeDSAuthorizationRequest0": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/VposHeader"
          },
          "orderID": {
            "type": "string",
            "xml": {
              "name": "OrderID"
            }
          },
          "pan": {
            "type": "string",
            "xml": {
              "name": "Pan"
            }
          },
          "cvv2": {
            "type": "string",
            "xml": {
              "name": "CVV2"
            }
          },
          "createPanAlias": {
            "type": "string",
            "xml": {
              "name": "CreatePanAlias"
            }
          },
          "expDate": {
            "type": "string",
            "xml": {
              "name": "ExpDate"
            }
          },
          "amount": {
            "type": "string",
            "xml": {
              "name": "Amount"
            }
          },
          "currency": {
            "type": "string",
            "xml": {
              "name": "Currency"
            }
          },
          "exponent": {
            "type": "string",
            "xml": {
              "name": "Exponent"
            }
          },
          "accountingMode": {
            "type": "string",
            "xml": {
              "name": "AccountingMode"
            }
          },
          "network": {
            "type": "string",
            "xml": {
              "name": "Network"
            }
          },
          "userid": {
            "type": "string",
            "xml": {
              "name": "Userid"
            }
          },
          "opDescr": {
            "type": "string",
            "xml": {
              "name": "OpDescr"
            }
          },
          "productRef": {
            "type": "string",
            "xml": {
              "name": "ProductRef"
            }
          },
          "name": {
            "type": "string",
            "xml": {
              "name": "Name"
            }
          },
          "surname": {
            "type": "string",
            "xml": {
              "name": "Surname"
            }
          },
          "taxID": {
            "type": "string",
            "xml": {
              "name": "TaxID"
            }
          },
          "threeDSData": {
            "type": "string",
            "xml": {
              "name": "ThreeDSData"
            }
          },
          "notifUrl": {
            "type": "string",
            "xml": {
              "name": "NotifUrl"
            }
          },
          "emailCH": {
            "type": "string",
            "xml": {
              "name": "EmailCH"
            }
          },
          "nameCH": {
            "type": "string",
            "xml": {
              "name": "NameCH"
            }
          },
          "acquirer": {
            "type": "string",
            "xml": {
              "name": "Acquirer"
            }
          },
          "ipAddress": {
            "type": "string",
            "xml": {
              "name": "IpAddress"
            }
          },
          "usrAuthFlag": {
            "type": "string",
            "xml": {
              "name": "UsrAuthFlag"
            }
          },
          "options": {
            "type": "string",
            "xml": {
              "name": "Options"
            }
          },
          "antiFraud": {
            "type": "string",
            "xml": {
              "name": "AntiFraud"
            }
          },
          "installmentsNumber": {
            "type": "string",
            "xml": {
              "name": "InstallmentsNumber"
            }
          },
          "threeDSMtdNotifUrl": {
            "type": "string",
            "xml": {
              "name": "ThreeDSMtdNotifUrl"
            }
          },
          "challengeWinSize": {
            "type": "string",
            "xml": {
              "name": "ChallengeWinSize"
            }
          },
          "trecurr": {
            "type": "string"
          },
          "cprof": {
            "type": "string"
          },
          "crecurr": {
            "type": "string"
          }
        }
      },
      "ThreeDSAuthorizationRequest1": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/VposHeader"
          },
          "threeDSTransId": {
            "type": "string",
            "xml": {
              "name": "ThreeDSTransID"
            }
          },
          "threeDSMtdComplInd": {
            "type": "string",
            "xml": {
              "name": "ThreeDSMtdComplInd"
            }
          }
        }
      },
      "ThreeDSAuthorizationRequest2": {
        "type": "object",
        "properties": {
          "header": {
            "$ref": "#/components/schemas/VposHeader"
          },
          "threeDSTransId": {
            "type": "string",
            "xml": {
              "name": "ThreeDSTransID"
            }
          }
        }
      },
      "ThreeDSChallenge": {
        "type": "object",
        "properties": {
          "threeDSTransId": {
            "type": "string",
            "xml": {
              "name": "ThreeDSTransId"
            }
          },
          "acsUrl": {
            "type": "string",
            "xml": {
              "name": "ACSUrl"
            }
          },
          "mac": {
            "type": "string",
            "xml": {
              "name": "MAC"
            }
          },
          "creq": {
            "type": "string"
          }
        }
      },
      "ThreeDSMethod": {
        "type": "object",
        "properties": {
          "threeDSTransId": {
            "type": "string",
            "xml": {
              "name": "ThreeDSTransId"
            }
          },
          "threeDSMethodData": {
            "type": "string",
            "xml": {
              "name": "ThreeDSMethodData"
            }
          },
          "threeDSMethodUrl": {
            "type": "string",
            "xml": {
              "name": "ThreeDSMethodUrl"
            }
          },
          "mac": {
            "type": "string",
            "xml": {
              "name": "MAC"
            }
          }
        }
      },
      "VposHeader": {
        "type": "object",
        "properties": {
          "shopID": {
            "type": "string",
            "xml": {
              "name": "ShopID"
            }
          },
          "operatorID": {
            "type": "string",
            "xml": {
              "name": "OperatorID"
            }
          },
          "reqRefNum": {
            "type": "string",
            "xml": {
              "name": "ReqRefNum"
            }
          }
        }
      },
      "XmlData": {
        "type": "object",
        "properties": {
          "orderStatus": {
            "$ref": "#/components/schemas/OrderStatus"
          },
          "productRef": {
            "type": "string",
            "xml": {
              "name": "ProductRef"
            }
          },
          "numberOfItems": {
            "type": "integer",
            "format": "int32",
            "xml": {
              "name": "NumberOfItems"
            }
          },
          "authorization": {
            "$ref": "#/components/schemas/ThreeDSAuthorization"
          },
          "panAliasData": {
            "$ref": "#/components/schemas/PanAliasData"
          },
          "header": {
            "$ref": "#/components/schemas/OrderStatusHeader"
          },
          "orderId": {
            "type": "string",
            "xml": {
              "name": "OrderID"
            }
          },
          "threeDSAuthorizationRequest0": {
            "$ref": "#/components/schemas/ThreeDSAuthorizationRequest0"
          },
          "threeDSAuthorizationRequest1": {
            "$ref": "#/components/schemas/ThreeDSAuthorizationRequest1"
          },
          "threeDSAuthorizationRequest2": {
            "$ref": "#/components/schemas/ThreeDSAuthorizationRequest2"
          },
          "threeDSMethod": {
            "$ref": "#/components/schemas/ThreeDSMethod"
          },
          "threeDSChallenge": {
            "$ref": "#/components/schemas/ThreeDSChallenge"
          },
          "threeDSAuthorization": {
            "$ref": "#/components/schemas/ThreeDSAuthorization"
          }
        }
      },
      "RptId": {
        "description": "Digital payment receipt identifier",
        "type": "string",
        "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
      },
      "PaymentInfo": {
        "description": "Informations about transaction payments",
        "type": "object",
        "properties": {
          "paymentToken": {
            "type": "string"
          },
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "reason": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "rptId",
          "amount"
        ],
        "example": {
          "rptId": "77777777777302012387654312384",
          "paymentToken": "paymentToken1",
          "reason": "reason1",
          "amount": 100
        }
      },
      "NewTransactionResponse": {
        "type": "object",
        "description": "Transaction data returned when creating a new transaction",
        "properties": {
          "transactionId": {
            "description": "the transaction unique identifier",
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
          },
          "payments": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentInfo"
            },
            "minItems": 1,
            "maxItems": 5,
            "example": [
              {
                "rptId": "77777777777302012387654312384",
                "paymentToken": "paymentToken1",
                "reason": "reason1",
                "amount": 100
              },
              {
                "rptId": "77777777777302012387654312385",
                "paymentToken": "paymentToken2",
                "reason": "reason2",
                "amount": 100
              }
            ]
          },
          "clientId": {
            "description": "transaction client id",
            "enum": [
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART"
            ]
          },
          "authToken": {
            "description": "authorization token",
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "amountTotal",
          "status",
          "payments",
          "clientId"
        ]
      },
      "UpdateAuthorizationRequest": {
        "type": "object",
        "description": "Request body for updating an authorization for a transaction",
        "properties": {
          "authorizationResult": {
            "$ref": "#/components/schemas/AuthorizationResult"
          },
          "timestampOperation": {
            "type": "string",
            "format": "date-time",
            "description": "Payment timestamp"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Payment gateway-specific authorization code related to the transaction"
          }
        },
        "required": [
          "authorizationResult",
          "timestampOperation",
          "authorizationCode"
        ],
        "example": {
          "authorizationResult": "OK",
          "timestampOperation": "2022-02-11T12:00:00.000Z",
          "authorizationCode": "auth-code"
        }
      },
      "TransactionInfo": {
        "description": "Transaction data returned when querying for an existing transaction",
        "allOf": [
          {
            "$ref": "#/components/schemas/NewTransactionResponse"
          },
          {
            "type": "object",
            "properties": {
              "feeTotal": {
                "$ref": "#/components/schemas/AmountEuroCents"
              }
            },
            "required": [
              "status"
            ]
          }
        ]
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "AuthorizationResult": {
        "description": "Authorization result",
        "type": "string",
        "enum": [
          "OK",
          "KO"
        ]
      },
      "TransactionStatus": {
        "type": "string",
        "description": "Possible statuses a transaction can be in",
        "enum": [
          "ACTIVATED",
          "AUTHORIZATION_REQUESTED",
          "AUTHORIZATION_COMPLETED",
          "CLOSED",
          "CLOSURE_ERROR",
          "NOTIFIED_OK",
          "NOTIFIED_KO",
          "NOTIFICATION_ERROR",
          "NOTIFICATION_REQUESTED",
          "EXPIRED",
          "REFUNDED",
          "CANCELED",
          "EXPIRED_NOT_AUTHORIZED",
          "UNAUTHORIZED",
          "REFUND_ERROR",
          "REFUND_REQUESTED",
          "CANCELLATION_REQUESTED",
          "CANCELLATION_EXPIRED"
        ]
      },
      "ProblemJson": {
        "description": "Body definition for error responses containing failure details",
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
            "default": "about:blank",
            "example": "https://example.com/problem/constraint-violation"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "status": {
            "$ref": "#/components/schemas/HttpStatusCode"
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the\nproblem.",
            "example": "There was an error processing the request"
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 200
      }
    },
    "requestBodies": {
      "UpdateAuthorizationRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/UpdateAuthorizationRequest"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "string"
      }
    }
  }
}