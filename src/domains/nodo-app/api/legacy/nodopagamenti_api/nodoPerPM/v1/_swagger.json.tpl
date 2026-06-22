{
  "swagger": "2.0",
  "info": {
    "description": "Specifiche di interfaccia Nodo - Payment Manager",
    "version": "1.0.0",
    "title": "Nodo-PaymentManager ${service}",
    "license": {
      "name": "Apache 2.0",
      "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
    }
  },
  "host": "${host}",
  "tags": [
    {
      "name": "PaymentManager",
      "description": "Servizi esposti da Payment Manager"
    },
    {
      "name": "Nodo",
      "description": "Servizi esposti da Nodo dei Pagamenti"
    }
  ],
  "schemes": [
    "http"
  ],
  "paths": {
    "/informazioniPagamento": {
      "get": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoChiediInformazioniPagamento",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di recuperare dal Nodo dei Pagamenti le informazioni relative ad un pagamento",
        "operationId": "nodoChiediInformazioniPagamento",
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "idPagamento",
            "in": "query",
            "description": "Stringa alfanumerica di 36 caratteri",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/InformazioniPagamento"
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
    },
    "/avanzamentoPagamento": {
      "get": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoChiediAvanzamentoPagamento",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di recuperare dal Nodo lo stato del pagamenti",
        "operationId": "nodoChiediAvanzamentoPagamento",
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "idPagamento",
            "in": "query",
            "description": "Stringa alfanumerica di 36 caratteri",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/AvanzamentoPagamento"
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
    },
    "/listaPSP": {
      "get": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoChiediListaPSP",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di recuperare dal Nodo dei Pagamenti i dati relativi ai PSP, compatibili con l’operazione di pagamento in corso",
        "operationId": "nodoChiediListaPSP",
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "idPagamento",
            "in": "query",
            "description": "Stringa alfanumerica di 36 caratteri",
            "required": true,
            "type": "string"
          },
          {
            "name": "percorsoPagamento",
            "in": "query",
            "description": "Stringa enumerata - valori possibili: carte,cc,altro",
            "required": true,
            "type": "string",
            "enum": [
              "carte",
              "cc",
              "altro"
            ]
          },
          {
            "name": "lingua",
            "in": "query",
            "description": "Stringa enumerata - valori possibili: IT,EN,FR,DE,SL",
            "required": false,
            "type": "string",
            "enum": [
              "IT",
              "EN",
              "FR",
              "DE",
              "SL"
            ]
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/ListaPSP"
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
    },
    "/inoltroEsito/carta": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoInoltraEsitoPagamentoCarta",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di trasmettere al Nodo dei Pagamenti l’esito dell’operazione di pagamento, mediante carta.",
        "operationId": "nodoInoltraEsitoPagamentoCarta",
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
            "description": "esitoPagamentoCarta",
            "required": true,
            "schema": {
              "$ref": "#/definitions/EsitoPagamentoCarta"
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
          "412": {
            "description": "Precondition failed",
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
    "/inoltroEsito/mod1": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoInoltraPagamentoMod1",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di sbloccare sul Nodo dei Pagamenti l’operazione di pagamento, secondo uno strumento diverso dalle carte ma attraverso un canale che implementa il modello di pagamento 1.",
        "operationId": "nodoInoltraPagamentoMod1",
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
            "description": "modello 1",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Modello1"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/SuccessMod1"
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
          "412": {
            "description": "Precondition failed",
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
    "/inoltroEsito/mod2": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoInoltraPagamentoMod2",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di sbloccare sul Nodo dei Pagamenti l’operazione di pagamento, attraverso un canale che implementa il modello di pagamento 2.",
        "operationId": "nodoInoltraPagamentoMod2",
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
            "description": "modello 1",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Modello2"
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
          "412": {
            "description": "Precondition failed",
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
    "/inoltroEsito/paypal": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoInoltraEsitoPagamentoPayPal",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di trasmettere al Nodo dei Pagamenti l’esito dell’operazione di pagamento, mediante PayPal.",
        "operationId": "nodoInoltraEsitoPagamentoPayPal",
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
            "description": "esitoPagamentoPayPal",
            "required": true,
            "schema": {
              "$ref": "#/definitions/EsitoPagamentoPayPal"
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
          "412": {
            "description": "Precondition failed",
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
    "/notificaAnnullamento": {
      "get": {
        "tags": [
          "Nodo"
        ],
        "summary": "nodoNotificaAnnullamento",
        "description": "•  La primitiva si prefigge lo scopo di consentire al Payment Manager di notificare al Nodo dei Pagamenti l’annullamento di una scelta/pagamento",
        "operationId": "nodoNotificaAnnullamento",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "idPagamento",
            "in": "query",
            "description": "Stringa alfanumerica di 36 caratteri",
            "required": true,
            "type": "string"
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
    },
    "/health": {
      "get": {
        "tags": [
          "Nodo"
        ],
        "summary": "health",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di verificare la connettività con il Nodo Dei Pagamenti.",
        "operationId": "health",
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "successful operation"
          }
        }
      }
    },
    "/closepayment": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "closePayment",
        "description": "TBD",
        "operationId": "closePayment",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/ClosePaymentRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/ClosePaymentResponse"
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
    },
    "/checkPosition": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "checkPosition",
        "description": "Ha lo scopo di consentire al Payment Manager di fare il check di positions",
        "operationId": "checkPosition",
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CheckPosition"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/CheckPositionResponse"
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
    },"/parkedList": {
      "get": {
        "tags": [
          "Nodo"
        ],
        "summary": "parkedList",
        "description": "La primitiva si prefigge lo scopo di consentire al Payment Manager di recuperare dal Nodo dei Pagamenti i dati relativi alle RPT pargheggiate",
        "operationId": "parkedList",
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "maxOccurrences",
            "in": "query",
            "description": "Numero di righe da restituire",
            "type": "number"
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/ListaIdSessione"
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
  "definitions": {
    "CheckPosition" : {
      "type": "object",
      "required": ["positionslist"],
      "properties": {
        "positionslist": {
          "type": "array",
          "items": { "$ref": "#/definitions/listelement" },
          "minItems": 1,
          "maxItems": 5
        }
      },
    },
    "listelement": {
      "type": "object",
      "required": [ "fiscalCode", "noticeNumber" ],
      "properties": {
        "fiscalCode": {
          "type": "string",
          "pattern": "^[0-9]{11}$"
        },
        "noticeNumber": {
          "type": "string",
          "pattern": "^[0-9]{18}$"
        }
      }
    },
    "InformazioniPagamento": {
      "type": "object",
      "required": [
        "importoTotale",
        "ragioneSociale",
        "oggettoPagamento",
        "bolloDigitale",
        "urlRedirectEC",
        "dettagli"
      ],
      "properties": {
        "importoTotale": {
          "type": "number",
          "description": "Importo totale del pagamento",
          "minimum": 0,
          "example": "15.00"
        },
        "email": {
          "type": "string",
          "description": "Indirizzo email del pagatore",
          "format": "email",
          "example": "user@example.com"
        },
        "ragioneSociale": {
          "type": "string",
          "description": "Ragione Sociale dell'ente creditore beneficiario",
          "example": "Comune di Milano"
        },
        "oggettoPagamento": {
          "type": "string",
          "description": "Oggetto del pagamento",
          "example": "TARI"
        },
        "urlRedirectEC": {
          "type": "string",
          "description": "Url di redirezione verso l'ente creditore da utilizzare al termine della scelta-pagamento",
          "format": "uri",
          "example": "https://www.sitopa.it/esito"
        },
        "bolloDigitale": {
          "type": "boolean",
          "description": "Flag bollo digitale SI/NO",
          "example": false
        },
        "codiceFiscale": {
          "type": "string",
          "description": "Codice Fiscale del soggetto pagatore",
          "example": "AAABBB99C99D999E"
        },
        "idCarrello": {
          "type": "string",
          "description": "Identificativo del carrello",
          "example": "006e275e722441dfa2b5a86f84e8722a"
        },
        "dettagli": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/Dettaglio"
          }
        }
      }
    },
    "Dettaglio": {
      "type": "object",
      "required": [
        "IUV",
        "CCP",
        "idDominio",
        "enteBeneficiario"
      ],
      "properties": {
        "IUV": {
          "type": "string",
          "example": "15190924706067024"
        },
        "CCP": {
          "type": "string",
          "example": "1c2168b748bc4b7db1239d725e5c9193"
        },
        "idDominio": {
          "type": "string",
          "example": "12345678901"
        },
        "enteBeneficiario": {
          "type": "string",
          "example": "Comune di test"
        }
      }
    },
    "AvanzamentoPagamento": {
      "type": "object",
      "required": [
        "esito"
      ],
      "properties": {
        "esito": {
          "type": "string",
          "description": "esito del pagamento",
          "example": "ACK_UNKNOWN",
          "enum": [
            "OK",
            "KO",
            "ACK_UNKNOWN"
          ]
        }
      }
    },
    "ListaPSP": {
      "type": "object",
      "required": [
        "totalRows"
      ],
      "properties": {
        "totalRows": {
          "type": "integer",
          "format": "int32",
          "description": "Numero di selezioni totali",
          "minimum": 0,
          "example": "3"
        },
        "data": {
          "type": "array",
          "description": "Array di identificativi univoci di selezione",
          "items": {
            "type": "integer",
            "format": "int32"
          },
          "example": "[15,39,41]"
        }
      }
    },
    "ListaIdSessione": {
      "type": "object",
      "required": [
        "totalNumber",
        "idPaymentList"
      ],
      "properties": {
        "totalNumber": {
          "type": "integer",
          "format": "int32",
          "description": "Numero di idSessione totali",
          "minimum": 0,
          "example": "3"
        },
        "idPaymentList": {
          "type": "array",
          "description": "Array di idSessione univoci di Rpt",
          "items": {
            "type": "string"
          },
          "example": "[\"idsession1\",\"idsession2\",\"idsession3\"]"
        }
      }
    },
    "EsitoPagamentoCarta": {
      "type": "object",
      "required": [
        "idPagamento",
        "RRN",
        "identificativoPsp",
        "tipoVersamento",
        "identificativoIntermediario",
        "identificativoCanale",
        "importoTotalePagato",
        "timestampOperazione",
        "codiceAutorizzativo",
        "esitoTransazioneCarta"
      ],
      "properties": {
        "idPagamento": {
          "$ref": "#/definitions/IdPagamento"
        },
        "RRN": {
          "type": "number",
          "description": "Return Reference Number"
        },
        "identificativoPsp": {
          "$ref": "#/definitions/IdentificativoPsp"
        },
        "tipoVersamento": {
          "$ref": "#/definitions/TipoVersamento"
        },
        "identificativoIntermediario": {
          "$ref": "#/definitions/IdentificativoIntermediario"
        },
        "identificativoCanale": {
          "$ref": "#/definitions/IdentificativoCanale"
        },
        "importoTotalePagato": {
          "type": "number",
          "description": "Importo Totale Pagato",
          "minimum": 0,
          "example": "20.10"
        },
        "timestampOperazione": {
          "type": "string",
          "format": "date-time",
          "example": "2012-04-23T18:25:43Z"
        },
        "codiceAutorizzativo": {
          "type": "string",
          "example": "123456",
          "minLength": 1,
          "maxLength": 6
        },
        "esitoTransazioneCarta": {
          "type": "string"
        }
      }
    },
    "EsitoPagamentoPayPal": {
      "type": "object",
      "required": [
        "idPagamento",
        "idTransazione",
        "idTransazionePsp",
        "identificativoPsp",
        "identificativoIntermediario",
        "identificativoCanale",
        "importoTotalePagato",
        "timestampOperazione"
      ],
      "properties": {
        "idPagamento": {
          "$ref": "#/definitions/IdPagamento"
        },
        "idTransazione": {
          "type": "number",
          "description": "Identificativo univoco di una transazione"
        },
        "idTransazionePsp": {
          "$ref": "#/definitions/IdTransazionePsp"
        },
        "identificativoPsp": {
          "$ref": "#/definitions/IdentificativoPsp"
        },
        "identificativoIntermediario": {
          "$ref": "#/definitions/IdentificativoIntermediario"
        },
        "identificativoCanale": {
          "$ref": "#/definitions/IdentificativoCanale"
        },
        "importoTotalePagato": {
          "type": "number",
          "description": "Importo Totale Pagato",
          "minimum": 0,
          "example": "20.10"
        },
        "timestampOperazione": {
          "type": "string",
          "format": "date-time",
          "example": "2012-04-23T18:25:43Z"
        }
      }
    },
    "Modello1": {
      "type": "object",
      "required": [
        "idPagamento",
        "identificativoPsp",
        "tipoVersamento",
        "identificativoIntermediario",
        "identificativoCanale",
        "tipoOperazione"
      ],
      "properties": {
        "idPagamento": {
          "$ref": "#/definitions/IdPagamento"
        },
        "identificativoPsp": {
          "$ref": "#/definitions/IdentificativoPsp"
        },
        "tipoVersamento": {
          "$ref": "#/definitions/TipoVersamento"
        },
        "identificativoIntermediario": {
          "$ref": "#/definitions/IdentificativoIntermediario"
        },
        "identificativoCanale": {
          "$ref": "#/definitions/IdentificativoCanale"
        },
        "tipoOperazione": {
          "type": "string",
          "description": "Identificativo del canale",
          "enum": [
            "mobile",
            "web"
          ]
        },
        "mobileToken": {
          "$ref": "#/definitions/MobileToken"
        }
      }
    },
    "Modello2": {
      "type": "object",
      "required": [
        "idPagamento",
        "identificativoPsp",
        "tipoVersamento",
        "identificativoIntermediario",
        "identificativoCanale"
      ],
      "properties": {
        "idPagamento": {
          "$ref": "#/definitions/IdPagamento"
        },
        "identificativoPsp": {
          "$ref": "#/definitions/IdentificativoPsp"
        },
        "tipoVersamento": {
          "$ref": "#/definitions/TipoVersamento"
        },
        "identificativoIntermediario": {
          "$ref": "#/definitions/IdentificativoIntermediario"
        },
        "identificativoCanale": {
          "$ref": "#/definitions/IdentificativoCanale"
        }
      }
    },
    "IdPagamento": {
      "type": "string",
      "description": "Identificativo univoco di un pagamento",
      "example": "24e1aaf4-9f44-497c-ab97-4669e4efa20"
    },
    "IdTransazionePsp": {
      "type": "string",
      "description": "Identificativo univoco di una transazione lato PSP",
      "example": "123abc567"
    },
    "IdentificativoPsp": {
      "type": "string",
      "description": "BIC del PSP",
      "example": "CIPBITMM"
    },
    "IdentificativoIntermediario": {
      "type": "string",
      "description": "Identificativo intermediario del PSP",
      "example": "123456789"
    },
    "IdentificativoCanale": {
      "type": "string",
      "description": "Identificativo del canale",
      "example": "123456789_01"
    },
    "MobileToken": {
      "type": "string",
      "description": "Token per il servzio di callback",
      "example": "ABC-123-XYZ"
    },
    "TipoVersamento": {
      "type": "string",
      "description": "Tipo versamento gestito dal canale",
      "enum": [
        "BBT",
        "BP",
        "AD",
        "CP",
        "PO",
        "OBEP",
        "JIF"
      ],
      "example": "CP"
    },
    "ModelloPagamento": {
      "type": "integer",
      "format": "int32",
      "description": "Modello di pagamento Gestito dal Canale",
      "enum": [
        "0",
        "1",
        "2"
      ],
      "example": "0"
    },
    "Tag": {
      "type": "string",
      "description": "Valore di tipo enumerato - secondo SANP",
      "enum": [
        "American Express",
        "Diners",
        "Maestro",
        "Mastercard",
        "MyBank",
        "PagoBancomat",
        "PayPal",
        "Visa",
        "Visa Electron",
        "V-Pay",
        "Wallet"
      ],
      "example": "Visa"
    },
    "Lingua": {
      "type": "string",
      "description": "Lingua Valore di tipo enumerato",
      "enum": [
        "IT",
        "EN",
        "FR",
        "DE",
        "SL"
      ],
      "example": "IT"
    },
    "CodiceABI": {
      "type": "string",
      "description": "ABI del PSP",
      "example": "06055"
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
    "SuccessMod1": {
      "type": "object",
      "required": [
        "esito",
        "urlRedirectPSP"
      ],
      "properties": {
        "esito": {
          "type": "string",
          "example": "OK"
        },
        "urlRedirectPSP": {
          "type": "string",
          "example": "http:\\www.psp.com",
          "description": "Url di redirezione verso il PSP",
          "format": "uri"
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
    "ClosePaymentRequest": {
      "type": "object",
      "required": [
        "paymentTokens",
        "outcome"
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
        "identificativoPsp": {
          "description": "Codice identificativo del PSP scelto per il riversamento",
          "type": "string"
        },
        "tipoVersamento": {
          "description": "Tipologia di versamento",
          "type": "string",
          "enum": [
            "BP",
            "BPAY",
            "AD",
            "PPAL",
            "PO",
            "CP",
            "JIF",
            "BBT",
            "MYBK",
            "OBEP"
          ]
        },
        "identificativoIntermediario": {
          "description": "Codice identificativo dell’intermediario del PSP",
          "type": "string"
        },
        "identificativoCanale": {
          "description": "Codice identificativo del canale del PSP usato per il pagamento",
          "type": "string"
        },
        "pspTransactionId": {
          "description": "Identificativo lato PSP della transazione",
          "type": "string"
        },
        "totalAmount": {
          "description": "Somma algebrica di importo e commissione",
          "type": "number"
        },
        "fee": {
          "description": "Ammonto della commissione",
          "type": "number"
        },
        "timestampOperation": {
          "description": "Timestamp del pagamento",
          "type": "string",
          "format": "date-time"
        },
        "additionalPaymentInformations": {
          "$ref": "#/definitions/AdditionalPaymentInformations"
        }
      }
    },
    "AdditionalPaymentInformations": {
      "type": "object",
      "required": [
        "transactionId",
        "outcomePaymentGateway",
        "authorizationCode"
      ],
      "properties": {
        "transactionId": {
          "description": "Identificativo della transazione lato PM",
          "type": "string"
        },
        "outcomePaymentGateway": {
          "description": "Codice di esito ricevuto dal payment gateway a fronte di un’autorizzazione",
          "type": "string"
        },
        "authorizationCode": {
          "description": "Codice autorizzativo ricevuto dal payment gateway",
          "type": "string"
        }
      }
    },
    "ClosePaymentResponse": {
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
    "CheckPositionResponse": {
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
    }
  }
}
