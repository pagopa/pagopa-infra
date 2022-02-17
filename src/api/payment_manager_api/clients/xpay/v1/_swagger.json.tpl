{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager - API to support xpay payments",
    "version": "1.0.0",
    "title": "Payment Manager xpay API"
  },
  "host": "${host}",
  "basePath": "/ecomm/api",
  "schemes": [
    "https",
    "http"
  ],
  "paths": {
    "/paga/autenticazione3DS": {
      "post": {
        "description": "Autenticazione 3D-Secure",
        "operationId": "autenticazione3DS",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayAuthRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayAuthResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/paga/paga3DS": {
      "post": {
        "description": "Pagamento 3D-Secure",
        "operationId": "pagamento3DS",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayPaymentRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayPaymentResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/bo/storna": {
      "post": {
        "description": "Storno 3D-Secure",
        "operationId": "StornoXpay",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayRevertRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayRevertResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/bo/situazioneOrdine": {
      "post": {
        "description": "Situazione ordine 3D-Secure",
        "operationId": "SituazioneOrdineXpay",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayOrderStatusRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayOrderStatusResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/recurring/creaNoncePrimo3DS": {
      "post": {
        "description": "Autenticazione Nonce 3D-Secure",
        "operationId": "autenticazioneNonce3DS",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayAuthRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayAuthResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/recurring/primoPagamento3DS": {
      "post": {
        "description": "Primo Pagamento 3D-Secure",
        "operationId": "primoPagamento3DS",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayPaymentRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayPaymentResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/recurring/pagamentoRicorrente3DS": {
      "post": {
        "description": "Pagamento Ricorrente 3D-Secure",
        "operationId": "pagamentoRicorrente3DS",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayPaymentRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayPaymentResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/contratti/cancellaContratto": {
      "post": {
        "description": "Cancella contratto",
        "operationId": "cancellaContratto",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayCancelContractRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayCancelContractResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/ecomm/api/recurring/creaNonceVerificaCarta": {
      "post": {
        "description": "Verifica Carta",
        "operationId": "verificaCarta",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayAuthRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayAuthResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "/ecomm/api/recurring/verificaCarta3DS": {
      "post": {
        "description": "Verifica Carta 3ds",
        "operationId": "verificaCarta3ds",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/XpayAuthRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/XpayAuthResponse"
            }
          },
          "400": {
            "description": "invalid input"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "internal server error"
          }
        }
      }
    },
    "paths": {
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
    }
  },
  "definitions": {
    "XpayAuthRequest": {
      "type": "object",
      "required": [
        "apiKey",
        "pan",
        "scadenza",
        "cvv",
        "importo",
        "divisa",
        "codiceTransazione",
        "urlRisposta",
        "timeStamp",
        "mac"
      ],
      "properties": {
        "apiKey": {
          "type": "string"
        },
        "pan": {
          "type": "integer",
          "format": "int64"
        },
        "scadenza": {
          "type": "string"
        },
        "cvv": {
          "type": "integer",
          "format": "int64"
        },
        "importo": {
          "type": "integer",
          "format": "int64"
        },
        "divisa": {
          "type": "string"
        },
        "codiceTransazione": {
          "type": "string"
        },
        "urlRisposta": {
          "type": "string"
        },
        "timeStamp": {
          "type": "integer",
          "format": "int64"
        },
        "mac": {
          "type": "string"
        }
      }
    },
    "XpayAuthResponse": {
      "type": "object",
      "required": [
        "esito",
        "idOperazione",
        "timeStamp",
        "html",
        "errore",
        "mac",
        "xpayNonce"
      ],
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
        "html": {
          "type": "string"
        },
        "errore": {
          "$ref": "#/definitions/XpayError"
        },
        "mac": {
          "type": "string"
        },
        "xpayNonce": {
          "type": "string"
        }
      }
    },
    "XpayError": {
      "type": "object",
      "required": [
        "codice",
        "messaggio"
      ],
      "properties": {
        "codice": {
          "type": "integer",
          "format": "int64"
        },
        "messaggio": {
          "type": "string"
        }
      }
    },
    "XpayCancelContractRequest": {
      "type": "object",
      "required": [
        "apiKey",
        "numeroContratto",
        "mac",
        "timestamp"
      ],
      "properties": {
        "apiKey": {
          "type": "string"
        },
        "numeroContratto": {
          "type": "string"
        },
        "mac": {
          "type": "string"
        },
        "timestamp": {
          "type": "string"
        }
      }
    },
    "XpayCancelContractResponse": {
      "type": "object",
      "required": [
        "esito",
        "idOperazione",
        "timeStamp",
        "errore",
        "mac"
      ],
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
        "errore": {
          "$ref": "#/definitions/XpayError"
        },
        "mac": {
          "type": "string"
        }
      }
    },
    "XpayRevertRequest": {
      "type": "object",
      "required": [
        "apiKey",
        "importo",
        "divisa",
        "codiceTransazione",
        "timeStamp"
      ],
      "properties": {
        "apiKey": {
          "type": "string"
        },
        "importo": {
          "type": "integer",
          "format": "int64"
        },
        "divisa": {
          "type": "string"
        },
        "codiceTransazione": {
          "type": "string"
        },
        "timeStamp": {
          "type": "integer",
          "format": "int64"
        }
      }
    },
    "XpayRevertResponse": {
      "type": "object",
      "required": [
        "esito",
        "idOperazione",
        "timeStamp",
        "errore",
        "mac"
      ],
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
        "errore": {
          "$ref": "#/definitions/XpayError"
        },
        "mac": {
          "type": "string"
        }
      }
    },
    "XpayOrderStatusRequest": {
      "type": "object",
      "required": [
        "apiKey",
        "mac",
        "codiceTransazione",
        "timeStamp"
      ],
      "properties": {
        "apiKey": {
          "type": "string"
        },
        "mac": {
          "type": "string"
        },
        "codiceTransazione": {
          "type": "string"
        },
        "timeStamp": {
          "type": "integer",
          "format": "int64"
        }
      }
    },
    "XpayOrderStatusResponse": {
      "type": "object",
      "required": [
        "esito",
        "idOperazione",
        "timeStamp",
        "errore",
        "mac",
        "report"
      ],
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
        "errore": {
          "$ref": "#/definitions/XpayError"
        },
        "mac": {
          "type": "string"
        },
        "report": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Report"
          }
        }
      }
    },
    "Report": {
      "type": "object",
      "properties": {
        "codiceAutorizzazione": {
          "type": "string"
        },
        "codiceTransazione": {
          "type": "string"
        },
        "dataTransazione": {
          "type": "string"
        },
        "mail": {
          "type": "string"
        },
        "divisa": {
          "type": "string"
        },
        "scadenza": {
          "type": "string"
        },
        "importo": {
          "type": "string"
        },
        "numeroMerchant": {
          "type": "string"
        },
        "tipoTransazione": {
          "type": "string"
        },
        "parametri": {
          "type": "string"
        },
        "stato": {
          "type": "string"
        },
        "tipoProdotto": {
          "type": "string"
        },
        "nazione": {
          "type": "string"
        },
        "numOrdinePm": {
          "type": "string"
        },
        "tipoPagamento": {
          "type": "string"
        },
        "pan": {
          "type": "string"
        },
        "brand": {
          "type": "string"
        },
        "dettaglio": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Dettaglio"
          }
        }
      }
    },
    "Dettaglio": {
      "type": "object",
      "properties": {
        "codiceTransazione": {
          "type": "string"
        },
        "mail": {
          "type": "string"
        },
        "cognome": {
          "type": "string"
        },
        "divisa": {
          "type": "string"
        },
        "decimaliValuta": {
          "type": "integer",
          "format": "int64"
        },
        "codiceValuta": {
          "type": "string"
        },
        "importo": {
          "type": "string"
        },
        "motivoEsito": {
          "type": "string"
        },
        "controvaloreValuta": {
          "type": "string"
        },
        "nome": {
          "type": "string"
        },
        "parametriAggiuntivi": {
          "type": "string"
        },
        "flagValuta": {
          "type": "string"
        },
        "stato": {
          "type": "string"
        },
        "tassoCambio": {
          "type": "string"
        },
        "importoRifiutato": {
          "type": "string"
        },
        "operazioni": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Operazione"
          }
        }
      }
    },
    "Operazione": {
      "type": "object",
      "properties": {
        "tipoOperazione": {
          "type": "string"
        },
        "importo": {
          "type": "integer",
          "format": "int64"
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
    "XpayPaymentRequest": {
      "type": "object",
      "required": [
        "apiKey",
        "mac",
        "codiceTransazione",
        "timeStamp",
        "importo",
        "divisa",
        "xpayNonce",
        "numeroContratto"
      ],
      "properties": {
        "apiKey": {
          "type": "string"
        },
        "mac": {
          "type": "string"
        },
        "codiceTransazione": {
          "type": "string"
        },
        "timeStamp": {
          "type": "integer",
          "format": "int64"
        },
        "importo": {
          "type": "integer",
          "format": "int64"
        },
        "divisa": {
          "type": "integer",
          "format": "int64"
        },
        "xpayNonce": {
          "type": "string"
        },
        "numeroContratto": {
          "type": "string"
        }
      }
    },
    "XpayPaymentResponse": {
      "type": "object",
      "required": [
        "esito",
        "idOperazione",
        "timeStamp",
        "mac"
      ],
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
        "errore": {
          "$ref": "#/definitions/XpayError"
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
        "tipoProdotto": {
          "type": "string"
        },
        "tipoTransazione": {
          "type": "string"
        },
        "ora": {
          "type": "string"
        }
      }
    }
  }
}
