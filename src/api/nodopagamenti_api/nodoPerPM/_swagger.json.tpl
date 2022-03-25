{
  "swagger": "2.0",
  "info": {
    "description": "Specifiche di interfaccia Nodo - Payment Manager",
    "version": "1.0.0",
    "title": "Nodo-PaymentManager",
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
    }
  },
  "definitions": {
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
    }
  }
}