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
  "produces": [
    "application/json"
  ],
  "paths": {
   "/payments/send-payment-result": {
      "post": {
        "summary": "sendPaymentResult",
        "description": "Call from Nodo (receipt generated)",
        "operationId": "sendPaymentResult",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/SendPaymentRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/SendPaymentResponse"
            }
          },
          "400": {
            "description": "Bad Request"
          },
          "404": {
            "description": "Not found"
          },
          "408": {
            "description": "Request Timeout"
          },
          "422": {
            "description": "Unprocessable entity"
          }
        }
      }
    },
     "/inoltraInformative": {
      "post": {
        "tags": [
          "PaymentManager"
        ],
        "summary": "paymentManagerInoltraInformative",
        "description": "La primitiva si prefigge lo scopo di consentire al Nodo dei Pagamenti di inoltrare al Payment Manager le informative contenenti i dati relativi agli strumenti di pagamento dei PSP.",
        "operationId": "paymentManagerInoltraInformative",
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
            "description": "informative",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Informative"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/SimpleSuccess"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "408": {
            "description": "Request Timeout",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "422": {
            "description": "Unprocessable entry",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          }
        }
      }
    },
     "/notificaPush": {
      "post": {
        "tags": [
          "PaymentManager"
        ],
        "summary": "paymentManagerNotificaPush",
        "description": "La primitiva si prefigge lo scopo di consentire al Nodo dei Pagamenti, nella sua componente WFESP, di inoltrare al Payment Manager l’informazione di notifica push, atta a risvegliare, sul dispositivo dell’utente, l’APP dell’EC da cui l’utente ha dato avvio al processo di pagamento.",
        "operationId": "paymentManagerNotificaPush",
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
            "description": "notificaPush",
            "required": true,
            "schema": {
              "$ref": "#/definitions/NotificaPush"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/SimpleSuccess"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "404": {
            "description": "Not found",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "408": {
            "description": "Request Timeout",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "422": {
            "description": "Unprocessable entry",
            "schema": {
              "$ref": "#/definitions/Error"
            }
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
    "SendPaymentRequest": {
      "type": "object",
      "required": [
        "paymentTokens",
        "outcome",
        "pspTransactionId"
      ],
      "properties": {
        "paymentTokens": {
          "description": "Array composto da un solo elemento, contenente il token di pagamento staccato dal Nodo a seguito della activatePaymentNotice",
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "outcome": {
          "description": "Esito del pagamento",
          "type": "string",
          "enum": [
            "OK",
            "KO"
          ]
        },
        "pspTransactionId": {
          "description": "Identificativo lato PSP della transazione",
          "type": "string"
        }
      }
    },
    "SendPaymentResponse": {
      "type": "object",
      "required": [
        "esito"
      ],
      "properties": {
        "esito": {
          "type": "string",
          "enum": [
            "OK",
            "KO"
          ]
        }
      }
    },
    "Error": {
      "type": "object",
      "required": [
        "error"
      ],
      "properties": {
        "error": {
          "type": "string",
          "example": "error message"
        }
      }
    },
    "SimpleSuccess": {
      "type": "object",
      "required": [
        "esito"
      ],
      "properties": {
        "esito": {
          "type": "string",
          "example": "OK"
        },
        "descrizione": {
          "type": "string",
          "description": "In caso di esito KO, motivo del KO"
        }
      }
    },
    "NotificaPush": {
      "type": "object",
      "required": [
        "mobileToken",
        "idPagamento",
        "esitoOperazione"
      ],
      "properties": {
        "mobileToken": {
          "$ref": "#/definitions/MobileToken"
        },
        "idPagamento": {
          "$ref": "#/definitions/IdPagamento"
        },
        "esitoOperazione": {
          "type": "string",
          "description": "Esito dell’operazione di pagamento, da scegliersi tra OK ed ERROR ",
          "enum": [
            "ok",
            "error"
          ]
        }
      }
    },
     "Informative": {
      "title": "inoltraInformative",
      "type": "object",
      "required": [
        "totalRows"
      ],
      "properties": {
        "totalRows": {
          "type": "integer",
          "format": "int32",
          "minimum": 0,
          "example": "35"
        },
        "data": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Informativa"
          }
        }
      }
    },
    "Informativa": {
      "type": "object",
      "required": [
        "idCard",
        "identificativoPsp",
        "ragioneSocialePsp",
        "tipoVersamento",
        "modelloPagamento",
        "identificativoIntermediario",
        "identificativoCanale",
        "logoPSP",
        "logoServizio",
        "nomeServizio",
        "costoFisso",
        "canaleApp",
        "bollo",
        "tags",
        "descrizioneServizio",
        "disponibilitàServizio",
        "urlInformazioniCanale",
        "lingua",
        "codiceABI"
      ],
      "properties": {
        "idCard": {
          "type": "integer",
          "format": "int32",
          "description": "Identificativo univoco di una selezione",
          "example": "123"
        },
        "identificativoPsp": {
          "$ref": "#/definitions/IdentificativoPsp"
        },
        "ragioneSocialePsp": {
          "type": "string",
          "description": "Ragione sociale del PSP",
          "example": "ICBPI"
        },
        "tipoVersamento": {
          "$ref": "#/definitions/TipoVersamento"
        },
        "modelloPagamento": {
          "$ref": "#/definitions/ModelloPagamento"
        },
        "identificativoIntermediario": {
          "$ref": "#/definitions/IdentificativoIntermediario"
        },
        "identificativoCanale": {
          "$ref": "#/definitions/IdentificativoCanale"
        },
        "logoPSP": {
          "type": "string",
          "description": "Logo del PSP in base64",
          "format": "byte"
        },
        "logoServizio": {
          "type": "string",
          "description": "Logo del PSP in base64",
          "format": "byte"
        },
        "nomeServizio": {
          "type": "string",
          "description": "Nome del servizio",
          "example": "Pago Semplice"
        },
        "descrizioneServizio": {
          "type": "string",
          "description": "Descrizione del servizio",
          "example": " E' la piattaforma di pagamento dell'isituto ..."
        },
        "costoFisso": {
          "type": "number",
          "description": "Valore della commissione",
          "minimum": 0,
          "example": "12.35"
        },
        "canaleApp": {
          "type": "boolean",
          "description": "Flag canale app SI/NO",
          "example": false
        },
        "bollo": {
          "type": "boolean",
          "description": "Flag gestione bollo telematico SI/NO",
          "example": false
        },
        "tags": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Tag"
          },
          "description": "array di parole chiave"
        },
        "disponibilitàServizio": {
          "type": "string",
          "description": "Informazioni di disponibilità del servizio"
        },
        "urlInformazioniCanale": {
          "type": "string",
          "description": "Url con informazioni di dettaglio",
          "format": "uri"
        },
        "lingua": {
          "$ref": "#/definitions/Lingua"
        },
        "codiceABI": {
          "$ref": "#/definitions/CodiceABI"
        }
      }
    }
  }
}
