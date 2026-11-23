{
  "openapi": "3.0.1",
  "info": {
    "title": "_NodoDeiPagamenti ${service}",
    "description": "Api and Models",
    "version": "1.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/*": {
      "get": {
        "summary": "get",
        "operationId": "get",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "post": {
        "summary": "post",
        "operationId": "post",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "put": {
        "summary": "put",
        "operationId": "put",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "delete": {
        "summary": "del",
        "operationId": "del",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "head": {
        "summary": "head",
        "operationId": "head",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "options": {
        "summary": "opt",
        "operationId": "opt",
        "responses": {
          "200": {
            "description": ""
          }
        }
      }
    },
    "/cache/version": {
      "get": {
        "operationId": "cache-version",
        "responses": {
          "200": {
            "description": ""
          }
        },
        "summary": "cache/version"
      }
    },
    "/paymentstatus" : {
      "get" : {
        "tags" : [ "PaymentStatus" ],
        "summary" : "Get payment status by token",
        "operationId" : "paymentStatus",
        "parameters" : [ {
          "name" : "paymenttoken",
          "in" : "query",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "caller",
          "in" : "query",
          "required" : true,
          "schema" : {
            "type" : "string",
            "maxLength" : 35
          }
        }, {
          "name" : "daysToGoBack",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "maximum" : 89
          }
        } ],
        "responses" : {
          "403" : {
            "description" : "Forbidden"
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentDataResponse"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests - Limite di 1000 richieste per minuto per API Key superato. Riprova dopo il tempo indicato nell'header Retry-After.",
            "headers" : {
              "Retry-After" : {
                "description" : "Numero di secondi da attendere prima di riprovare",
                "schema" : {
                  "type" : "integer",
                  "example" : 60
                }
              },
              "X-RateLimit-Limit" : {
                "description" : "Numero massimo di richieste consentite per minuto",
                "schema" : {
                  "type" : "integer",
                  "example" : 1000
                }
              },
              "X-RateLimit-Remaining" : {
                "description" : "Numero di richieste ancora disponibili nel minuto corrente",
                "schema" : {
                  "type" : "integer",
                  "example" : 0
                }
              },
              "X-RateLimit-Reset" : {
                "description" : "Timestamp Unix di quando il limite si azzera",
                "schema" : {
                  "type" : "integer",
                  "example" : 1694425260
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "500" : {
            "description" : "Service unavailable",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [
          {
            "ApiKey" : [ ]
          }
        ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          }
        }
      },
      "PaymentStatusData" : {
        "required" : [ "id", "pa_fiscal_code", "notice_id", "creditor_reference_id", "payment_token", "status", "inserted_timestamp", "updated_timestamp", "fk_position_payment", "inserted_by", "updated_by" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "integer",
            "format" : "int64",
            "description" : "Identificativo univoco del pagamento nel sistema"
          },
          "pa_fiscal_code" : {
            "type" : "string",
            "description" : "Codice fiscale dell'ente creditore (PA) che ha ricevuto il pagamento"
          },
          "notice_id" : {
            "type" : "string",
            "description" : "Numero dell'avviso di pagamento (IUV) formato esteso 18 caratteri"
          },
          "creditor_reference_id" : {
            "type" : "string",
            "description" : "Identificativo del creditore dal sistema del PSP"
          },
          "payment_token" : {
            "type" : "string",
            "description" : "Token univoco a 32 caratteri che identifica il pagamento nel sistema nodo4"
          },
          "status": {
            "type": "string",
            "description": "Payment Status - Enum Stati: PAYING (IN CORSO), PAYING_RPT (IN CORSO), PAID_NORPT (OK), PAID (OK), FAILED_NORPT (KO), FAILED (KO), CANCELLED (KO), CANCELLED_NORPT (KO), NOTICE_GENERATED (OK), NOTICE_STORED (OK), NOTICE_SENT (OK), NOTIFIED (OK), PAYMENT_SENT (IN CORSO), PAYMENT_REFUSED (KO), PAYMENT_SEND_ERROR (KO), PAYMENT_ACCEPTED (OK), PAYMENT_UNKNOWN (IN CORSO), PAYMENT_RESERVED (IN CORSO).",
            "enum": [
              "PAYING",
              "PAYING_RPT",
              "PAID_NORPT",
              "PAID",
              "FAILED_NORPT",
              "FAILED",
              "CANCELLED",
              "CANCELLED_NORPT",
              "NOTICE_GENERATED",
              "NOTICE_STORED",
              "NOTICE_SENT",
              "NOTIFIED",
              "PAYMENT_SENT",
              "PAYMENT_REFUSED",
              "PAYMENT_SEND_ERROR",
              "PAYMENT_ACCEPTED",
              "PAYMENT_UNKNOWN",
              "PAYMENT_RESERVED"
            ]
          }
        ,
          "inserted_timestamp" : {
            "type" : "string",
            "format" : "date-time",
            "description" : "Data e ora di creazione del pagamento nel formato ISO 8601 con fuso orario"
          },
          "updated_timestamp" : {
            "type" : "string",
            "format" : "date-time",
            "description" : "Data e ora dell'ultimo aggiornamento dello stato nel formato ISO 8601 con fuso orario"
          },
          "fk_position_payment" : {
            "type" : "integer",
            "format" : "int64",
            "description" : "Identificativo esterno della posizione di pagamento nel sistema dell'ente"
          },
          "inserted_by" : {
            "type" : "string",
            "description" : "Primitiva o attore che ha creato il pagamento (es. activatePaymentNoticeV2, closePayment-V2)"
          },
          "updated_by" : {
            "type" : "string",
            "description" : "Primitiva o attore che ha aggiornato per ultimo lo stato del pagamento (es. nodoInviaRT, closePayment)"
          }
        }
      },
      "PaymentDataResponse" : {
        "required" : [ "payment_status" ],
        "type" : "object",
        "description" : "Response contenente lo stato di un pagamento",
        "properties" : {
          "payment_status" : {
            "$ref" : "#/components/schemas/PaymentStatusData",
            "description" : "Oggetto contenente i dettagli dello stato del pagamento"
          }
        }
      }
    }
  }
}