{
  "openapi": "3.0.1",
  "info": {
    "title": "Pagopa webview PM Mock",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "tags": [
    {
      "name": "paypalmanagement",
      "description": "todo"
    }
  ],
  "paths": {
    "/paypalpsp/management/response": {
      "get": {
        "operationId": "getmanagementresponse",
        "description": "get management",
        "tags": [
          "paypalmanagement"
        ],
        "responses": {
          "200": {
            "description": "json response"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "patch": {
        "tags": [
          "paypalmanagement"
        ],
        "operationId": "patchmanagement",
        "description": "patch management",
        "responses": {
          "200": {
            "description": "json response"
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
    "/paypalpsp/management/response/{idappio}/{apiid}": {
      "get": {
        "tags": [
          "paypalmanagement"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "idappio",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "path",
            "name": "apiid",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "operationId": "getmanagementwithapiid",
        "description": "GET management with api Id",
        "responses": {
          "200": {
            "description": "json response"
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
    "/paypalpsp/management/response/{idappio}": {
      "get": {
        "tags": [
          "paypalmanagement"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "idappio",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "operationId": "getmanagement",
        "description": "GET management",
        "responses": {
          "200": {
            "description": "json response"
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
    "/info": {
      "get": {
        "operationId": "getappinfo",
        "description": "GET Application info",
        "responses": {
          "200": {
            "description": "json response"
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
    "/bpayweb/change/client": {
      "post": {
        "operationId": "bpayChangeClientPOST",
        "description": "Change client for BPAY",
        "requestBody": {
          "description": "bpayChangeClientRequest",
          "required": true,
          "content": {
            "text/plain": {
              "schema": {
                "type": "string"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Client changed"
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
    "/bpayweb/change/outcome": {
      "post": {
        "operationId": "bpayChangeOutcomePOST",
        "description": "Change Outcome for BPAY",
        "parameters": [
          {
            "in": "query",
            "name": "code",
            "description": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "timeoutMs",
            "description": "timeout Ms",
            "required": false,
            "schema": {
              "type": "integer"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Outcome changed"
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
    "/xpay/change/autenticazione3DS/outcome": {
      "post": {
        "tags": [
          "XPay Controller"
        ],
        "operationId": "xpayChangeAuthenticationOutcome",
        "summary": "permette di cambiare l'outcome dell'autenticazione3DS",
        "parameters": [
          {
            "in": "query",
            "name": "outcome",
            "example": "OK",
            "schema": {
              "type": "string",
              "enum": [
                "OK",
                "KO"
              ]
            }
          },
          {
            "in": "query",
            "name": "errorCode",
            "example": "97L",
            "schema": {
              "type": "number"
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
    "/xpay/change/paga3DS/outcome": {
      "post": {
        "tags": [
          "XPay Controller"
        ],
        "operationId": "xpayChangePaymentOutcome",
        "summary": "permette di cambiare l'outcome della paga3DS",
        "parameters": [
          {
            "in": "query",
            "name": "outcome",
            "example": "OK",
            "schema": {
              "type": "string",
              "enum": [
                "OK",
                "KO"
              ]
            }
          },
          {
            "in": "query",
            "name": "errorCode",
            "example": "97L",
            "schema": {
              "type": "number"
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
    "/xpay/change/storna/outcome": {
      "post": {
        "tags": [
          "XPay Controller"
        ],
        "operationId": "xPayRefundChangeOutcome",
        "parameters": [
          {
            "name": "outcome",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string",
              "enum": [
                "OK",
                "KO"
              ]
            }
          },
          {
            "name": "errorCode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
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
    "/xpay/change/situazioneOrdine/outcome": {
      "post": {
        "tags": [
          "XPay Controller"
        ],
        "operationId": "xPayOrderStatusChangeOutcome",
        "parameters": [
          {
            "name": "outcome",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string",
              "enum": [
                "OK",
                "KO"
              ]
            }
          },
          {
            "name": "errorCode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
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
    "/xpay/mac": {
      "get": {
        "tags": [
          "XPay Controller"
        ],
        "operationId": "generateMac",
        "parameters": [
          {
            "name": "codiceTransazione",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "timeStamp",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "divisa",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          },
          {
            "name": "importo",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer"
            }
          }
        ],
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
    "/vpos/change/outcome": {
      "post": {
        "tags": [
          "VPOS Settings"
        ],
        "operationId": "changeVposOutcome",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ChangeVposOutcome"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
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
      "ChangeVposOutcome": {
        "required": [
          "httpOutcome",
          "method3dsOutcome",
          "orderStatusOutcome",
          "step0Outcome",
          "step1Outcome",
          "step2Outcome",
          "transactionStatusOutcome"
        ],
        "type": "object",
        "properties": {
          "method3dsOutcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "step0Outcome": {
            "type": "string",
            "enum": [
              "SUCCESS",
              "REQREFNUM_DUPLICATED_OR_INCORRECT",
              "INCORRECT_MESSAGE_FORMAT_MISSING_OR_INCORRECT_FIELD",
              "INCORRECT_API_AUTHENTICATION_INCORRECT_MAC",
              "UNFORESEEN_ERROR_DURING_PROCESSING_OF_REQUEST",
              "THE_CARD_IS_VBV_ENABLED",
              "METHOD",
              "A_CHALLENGE_FLOW",
              "EMPTY_XML_OR_MISSING_DATA_PARAMETER",
              "XML_NOT_PARSABLE",
              "INSTALLMENTS_NOT_AVAILABLE",
              "INSTALLMENT_NUMBER_OUT_OF_BOUNDS_CLIENT_SIDE",
              "TRANSACTION_FAILED_SEE_SPECIFIC_OUTCOME"
            ]
          },
          "step1Outcome": {
            "type": "string",
            "enum": [
              "SUCCESS",
              "REQREFNUM_DUPLICATED_OR_INCORRECT",
              "INCORRECT_MESSAGE_FORMAT_MISSING_OR_INCORRECT_FIELD",
              "INCORRECT_API_AUTHENTICATION_INCORRECT_MAC",
              "UNFORESEEN_ERROR_DURING_PROCESSING_OF_REQUEST",
              "THREEDSTRANSID_NOT_FOUND",
              "MAXIMUM_TIME_LIMIT_FOR_FORWARDING_THE_VBV",
              "A_CHALLENGE_FLOW",
              "EMPTY_XML_OR_MISSING_DATA_PARAMETER",
              "XML_NOT_PARSABLE",
              "TRANSACTION_FAILED_SEE_SPECIFIC_OUTCOME"
            ]
          },
          "step2Outcome": {
            "type": "string",
            "enum": [
              "SUCCESS",
              "REQREFNUM_DUPLICATED_OR_INCORRECT",
              "INCORRECT_MESSAGE_FORMAT_MISSING_OR_INCORRECT_FIELD",
              "INCORRECT_API_AUTHENTICATION_INCORRECT_MAC",
              "UNFORESEEN_ERROR_DURING_PROCESSING_OF_REQUEST",
              "THREEDSTRANSID_NOT_FOUND",
              "MAXIMUM_TIME_LIMIT_FOR_FORWARDING_THE_VBV",
              "EMPTY_XML_OR_MISSING_DATA_PARAMETER",
              "XML_NOT_PARSABLE",
              "TRANSACTION_FAILED_SEE_SPECIFIC_OUTCOME"
            ]
          },
          "orderStatusOutcome": {
            "type": "string",
            "enum": [
              "SUCCESS",
              "ORDER_OR_REQREFNUM_NOT_FOUND",
              "REQREFNUM_DUPLICATED_OR_INCORRECT",
              "INCORRECT_MESSAGE_FORMAT_MISSING_OR_INCORRECT_FIELD",
              "INCORRECT_API_AUTHENTICATION_INCORRECT_MAC",
              "UNFORESEEN_ERROR_DURING_PROCESSING_OF_REQUEST",
              "THREEDSTRANSID_NOT_FOUND",
              "EMPTY_XML_OR_MISSING_DATA_PARAMETER",
              "XML_NOT_PARSABLE",
              "TRANSACTION_FAILED_SEE_SPECIFIC_OUTCOME"
            ]
          },
          "transactionStatusOutcome": {
            "type": "string",
            "enum": [
              "AUTH_GRANTED_BOOKABLE",
              "AUTH_DENIED",
              "AUTH_BOOKED_TO_BE_PROCESSED_BY_CLEARING",
              "AUTH_BOOKED_PROCESSED_BY_CLEARING",
              "AUTH_REVERSED",
              "AUTH_TO_BE_REVERSED_DUE_TO_ERROR",
              "AUTH_UNDERWAY"
            ]
          },
          "httpOutcome": {
            "type": "string",
            "enum": [
              "OK",
              "NOT_FOUND",
              "SERVICE_UNAVAILABLE"
            ]
          }
        }
      }
    }
  }
}