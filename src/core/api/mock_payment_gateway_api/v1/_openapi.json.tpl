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