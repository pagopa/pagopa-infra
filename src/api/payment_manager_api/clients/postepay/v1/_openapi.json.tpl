{
  "openapi": "3.0.3",
  "info": {
    "title": "payment-manager API",
    "version": "1.0.0-SNAPSHOT"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/api/v1/payment/create": {
      "post": {
        "tags": [
          "Payment Manager Controller"
        ],
        "summary": "Inzializzazione della transazione di pagamento",
        "description": "",
        "parameters": [
          {
            "in": "header",
            "name": "Authorization",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
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
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/payment/details": {
      "post": {
        "tags": [
          "Payment Manager Controller"
        ],
        "summary": "Recupero dello stato della transazione",
        "description": "",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DetailsPaymentRequest"
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
                    "shopId",
                    "shopTransactionId",
                    "paymentID",
                    "result",
                    "authNumber",
                    "amount",
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
                    "shopId": {
                      "description": "identificativo del negozio",
                      "type": "string"
                    },
                    "shopTransactionId": {
                      "description": "identificativo della transazione lato merchant",
                      "type": "string"
                    },
                    "paymentID": {
                      "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
                      "type": "string"
                    },
                    "result": {
                      "description": "esito",
                      "type": "string"
                    },
                    "authNumber": {
                      "description": "numero autorizzazione se OK",
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
                    "status": {
                      "allOf": [
                        {
                          "$ref": "#/components/schemas/Esito"
                        },
                        {
                          "description": "Esito della transazione"
                        }
                      ]
                    },
                    "refundedAmount": {
                      "description": "importo stornato",
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
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/payment/refund": {
      "post": {
        "tags": [
          "Payment Manager Controller"
        ],
        "summary": "Storno",
        "description": "",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DetailsPaymentRequest"
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
                      "description": "identificativo della transazione lato merchant",
                      "type": "string"
                    },
                    "transactionResult": {
                      "allOf": [
                        {
                          "$ref": "#/components/schemas/EsitoStorno"
                        },
                        {
                          "description": "esito operazione"
                        }
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
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/payment/serverNotify": {
      "post": {
        "tags": [
          "Payment Manager Controller"
        ],
        "summary": "Messaggio di conferma eseguito presso serverNotificationUrl",
        "description": "",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NotifyRequest"
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
                  "type": "object"
                }
              }
            }
          },
          "default": {
            "description": "Errore",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
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
      "Error": {
        "description": "",
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
      "CancelPaymentRequest": {
        "description": "",
        "type": "object",
        "properties": {
          "field": {
            "description": "",
            "type": "string"
          }
        }
      },
      "CancelPaymentResponse": {
        "description": "",
        "type": "object"
      },
      "ConfirmPaymentRequest": {
        "description": "",
        "type": "object",
        "properties": {
          "field": {
            "description": "",
            "type": "string"
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
          "buyerName",
          "buyerEmail",
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
      "CreatePaymentResponse": {
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
      },
      "DetailsPaymentRequest": {
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
            "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
            "type": "string"
          }
        }
      },
      "DetailsPaymentResponse": {
        "description": "",
        "required": [
          "shopId",
          "shopTransactionId",
          "paymentID",
          "result",
          "authNumber",
          "amount",
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
          "shopId": {
            "description": "identificativo del negozio",
            "type": "string"
          },
          "shopTransactionId": {
            "description": "identificativo della transazione lato merchant",
            "type": "string"
          },
          "paymentID": {
            "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
            "type": "string"
          },
          "result": {
            "description": "esito",
            "type": "string"
          },
          "authNumber": {
            "description": "numero autorizzazione se OK",
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
          "status": {
            "allOf": [
              {
                "$ref": "#/components/schemas/Esito"
              },
              {
                "description": "Esito della transazione"
              }
            ]
          },
          "refundedAmount": {
            "description": "importo stornato",
            "type": "string"
          }
        }
      },
      "Esito": {
        "enum": [
          "APPROVED",
          "DECLINED",
          "PENDING",
          "REFUNDED"
        ],
        "type": "string"
      },
      "EsitoStorno": {
        "enum": [
          "OK",
          "KO"
        ],
        "type": "string"
      },
      "NotifyRequest": {
        "description": "",
        "required": [
          "shopId",
          "shopTransactionId",
          "paymentID",
          "result",
          "authNumber",
          "amount",
          "currency",
          "buyerName",
          "buyerEmail",
          "paymentChannel",
          "authType",
          "status"
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
            "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
            "type": "string"
          },
          "result": {
            "description": "esito",
            "type": "string"
          },
          "authNumber": {
            "description": "numero autorizzazione se OK",
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
          "status": {
            "allOf": [
              {
                "$ref": "#/components/schemas/Esito"
              },
              {
                "description": "Esito della transazione"
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
      "PaymentStatusRequest": {
        "description": "",
        "type": "object",
        "properties": {
          "field": {
            "description": "",
            "type": "string"
          }
        }
      },
      "RefundPaymentRequest": {
        "description": "",
        "required": [
          "shopId",
          "shopTransactionId",
          "amount",
          "currency",
          "paymentID",
          "authNumber"
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
            "description": "causale dello storno",
            "type": "string"
          },
          "currency": {
            "description": "valuta in codice ISO (EUR = 978)",
            "type": "string"
          },
          "paymentID": {
            "description": "identificativo della transazione di pagamento assegnato da PosteItaliane",
            "type": "string"
          },
          "authNumber": {
            "description": "numero autorizzazione",
            "type": "string"
          }
        }
      },
      "RefundPaymentResponse": {
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
            "description": "identificativo della transazione lato merchant",
            "type": "string"
          },
          "transactionResult": {
            "allOf": [
              {
                "$ref": "#/components/schemas/EsitoStorno"
              },
              {
                "description": "esito operazione"
              }
            ]
          }
        }
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
    }
  }
}