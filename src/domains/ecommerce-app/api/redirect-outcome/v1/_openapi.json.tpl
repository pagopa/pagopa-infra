{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa Redirect",
    "description": "Collection of all api used for perform a transaction using redirect payment instrument. Specifically this openapi contains api used to receive redirect transaction authorization outcome Api's are tagged as follow:\n  * `b2b - pagoPA side` are implemented and exposed by pagoPA to receive authorization outcome\n",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "b2b - pagoPA side",
      "description": "Api's to notify transaction outcome"
    }
  ],
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "externalDocs": {
    "url": "https://docs.pagopa.it/sanp/prestatore-di-servizi-di-pagamento/modalita-di-integrazione/integrazione-per-strumento-di-pagamento-tramite-redirect",
    "description": "SANP"
  },
  "paths": {
    "/redirections/{idTransaction}/outcomes": {
      "post": {
        "externalDocs": {
          "url": "https://docs.pagopa.it/sanp/prestatore-di-servizi-di-pagamento/modalita-di-integrazione/integrazione-per-strumento-di-pagamento-tramite-redirect#api-callback-esito-transazione",
          "description": "Api callback esito transazione (SANP)"
        },
        "tags": [
          "b2b - pagoPA side"
        ],
        "operationId": "CallbackOutcome",
        "summary": "Callback API for communicate authorization outcome",
        "description": "Communicate the outcome for the authorization process",
        "security": [
          {
            "PagopaApiKeyAuth": []
          }
        ],
        "parameters": [
          {
            "in": "path",
            "name": "idTransaction",
            "schema": {
              "$ref": "#/components/schemas/PagopaIdTransaction"
            },
            "required": true,
            "description": "PagoPA unique identifier of the transaction to be refund (the same given in the redirections/url request)"
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/TransactionResultRequest"
        },
        "responses": {
          "200": {
            "description": "Outcome response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TransactionResultResponse"
                }
              }
            }
          },
          "400": {
            "description": "Formally invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "status": 400,
                  "detail": "Bad request",
                  "idTransaction": "3fa85f6457174562b3fc2c963f66afa6"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "status": 401,
                  "detail": "Unauthorized",
                  "idTransaction": "3fa85f6457174562b3fc2c963f66afa6"
                }
              }
            }
          },
          "404": {
            "description": "Not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "status": 404,
                  "detail": "Transaction not found",
                  "idTransaction": "3fa85f6457174562b3fc2c963f66afa6"
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
                },
                "example": {
                  "status": 500,
                  "detail": "There was an error processing the request",
                  "idTransaction": "3fa85f6457174562b3fc2c963f66afa6"
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
      "ProblemJson": {
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
          },
          "idTransaction": {
            "$ref": "#/components/schemas/PagopaIdTransaction"
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 400,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 400
      },
      "PagopaIdTransaction": {
        "description": "Uniquely identify a transaction",
        "type": "string",
        "minLength": 32,
        "maxLength": 32,
        "example": "3fa85f6457174562b3fc2c963f66afa6"
      },
      "TransactionResultRequest": {
        "description": "Callback api transaction outcome request body",
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string",
            "description": "PSP identifier as received in redirections url request"
          },
          "idPSPTransaction": {
            "type": "string",
            "description": "Unique PSP transaction identifier"
          },
          "outcome": {
            "$ref": "#/components/schemas/AuthorizationOutcome"
          },
          "details": {
            "$ref": "#/components/schemas/TransactionResultDetails"
          }
        },
        "required": [
          "idPsp",
          "idPSPTransaction",
          "outcome",
          "details"
        ]
      },
      "TransactionResultDetails": {
        "type": "object",
        "oneOf": [
          {
            "$ref": "#/components/schemas/TransactionAuthorizedOutcomeDetails"
          },
          {
            "$ref": "#/components/schemas/TransactionDeniedOutcomeDetails"
          }
        ],
        "discriminator": {
          "propertyName": "outcome",
          "mapping": {
            "OK": "#/components/schemas/TransactionAuthorizedOutcomeDetails",
            "KO": "#/components/schemas/TransactionDeniedOutcomeDetails",
            "CANCELED": "#/components/schemas/TransactionDeniedOutcomeDetails",
            "EXPIRED": "#/components/schemas/TransactionDeniedOutcomeDetails",
            "ERROR": "#/components/schemas/TransactionDeniedOutcomeDetails"
          }
        },
        "required": [
          "outcome"
        ]
      },
      "TransactionAuthorizedOutcomeDetails": {
        "type": "object",
        "properties": {
          "timestampOperation": {
            "type": "string",
            "format": "date-time",
            "description": "Payment date and time"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Unique PSP authorization code"
          }
        },
        "required": [
          "timestampOperation",
          "authorizationCode"
        ]
      },
      "TransactionDeniedOutcomeDetails": {
        "type": "object",
        "properties": {
          "errorCode": {
            "type": "string",
            "description": "Authorization error code"
          }
        },
        "required": [
          "errorCode"
        ]
      },
      "TransactionResultResponse": {
        "description": "Callback api transaction outcome response body",
        "type": "object",
        "properties": {
          "idTransaction": {
            "$ref": "#/components/schemas/PagopaIdTransaction"
          },
          "outcome": {
            "$ref": "#/components/schemas/AuthorizationResponseOutcome"
          }
        },
        "required": [
          "idTransaction",
          "outcome"
        ]
      },
      "AuthorizationOutcome": {
        "description": "Transaction outcome enumeration.\nThe outcome can assume the following values:\n* OK -> `Authorization completed successfully`\n* KO -> `Authorization KO (for example missing funds for transaction)`\n* CANCELED -> `User canceled the authorization process`\n* EXPIRED -> `Authorization process has not been completed before timeout set for the operation`\n* ERROR -> `An unexpected error occurred during authorization process`\n",
        "type": "string",
        "enum": [
          "OK",
          "KO",
          "CANCELED",
          "EXPIRED",
          "ERROR"
        ]
      },
      "AuthorizationResponseOutcome": {
        "description": "Transaction authorization callback process outcome.\nThe outcome can assume the following values:\n* OK -> callback request have been processed successfully\n* KO -> there was an error processing the callback request\n",
        "type": "string",
        "enum": [
          "OK",
          "KO"
        ]
      }
    },
    "requestBodies": {
      "TransactionResultRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/TransactionResultRequest"
            },
            "examples": {
              "authorization outcome OK": {
                "value": {
                  "idPsp": "idPsp",
                  "idPSPTransaction": "idPSPTransaction",
                  "outcome": "OK",
                  "details": {
                    "timestampOperation": "2024-01-12T11:59:40.873Z",
                    "authorizationCode": "authorizationCode"
                  }
                }
              },
              "authorization outcome KO": {
                "value": {
                  "idPsp": "idPsp",
                  "idPSPTransaction": "idPSPTransaction",
                  "outcome": "OK",
                  "details": {
                    "errorCode": "errorCode"
                  }
                }
              }
            }
          }
        }
      }
    },
    "securitySchemes": {
      "PagopaApiKeyAuth": {
        "type": "apiKey",
        "in": "header",
        "name": "x-api-key",
        "description": "pagoPA api key"
      }
    }
  }
}