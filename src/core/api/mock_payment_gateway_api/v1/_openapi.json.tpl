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