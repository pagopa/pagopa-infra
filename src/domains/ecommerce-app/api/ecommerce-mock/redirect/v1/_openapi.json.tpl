{
    "openapi": "3.0.0",
    "info": {
      "version": "0.0.1",
      "title": "Pagopa Redirect",
      "description": "Collection of all api used for perform a transaction using redirect payment instrument. Api's are tagged as follow:\n  * `b2b - PSP side` are implemented and exposed by PSP to expose api's  to p retrieve redirection URL and perform refund\n  * `b2b - pagoPA side` are implemented and exposed by pagoPA to receive authorization outcome\n",
      "contact": {
        "name": "pagoPA - Touchpoints team"
      }
    },
    "tags": [
      {
        "name": "b2b - PSP side",
        "description": "Api's to initialize and refund a transaction"
      },
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
      "/redirections": {
        "post": {
          "externalDocs": {
            "url": "https://docs.pagopa.it/sanp/prestatore-di-servizi-di-pagamento/modalita-di-integrazione/integrazione-per-strumento-di-pagamento-tramite-redirect#api-recupero-url",
            "description": "Api recupero URL (SANP)"
          },
          "tags": [
            "b2b - PSP side"
          ],
          "operationId": "RetrieveRedirectUrl",
          "summary": "Retrieve redirect URL",
          "description": "Retrieve redirect URL to be followed to perform transaction payment",
          "security": [
            {
              "PspApiKeyAuth": []
            }
          ],
          "requestBody": {
            "$ref": "#/components/requestBodies/RedirectUrlRequest"
          },
          "responses": {
            "200": {
              "description": "Redirect url response",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/RedirectUrlResponse"
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
      },
      "/redirections/refunds": {
        "post": {
          "externalDocs": {
            "url": "https://docs.pagopa.it/sanp/prestatore-di-servizi-di-pagamento/modalita-di-integrazione/integrazione-per-strumento-di-pagamento-tramite-redirect#api-annullo",
            "description": "Api annullo (SANP)"
          },
          "tags": [
            "b2b - PSP side"
          ],
          "operationId": "RefundTransaction",
          "summary": "Api for refund",
          "description": "Perform a refund for a transaction. Semantically this endpoint is a DELETE with body (HTTP requests with the DELETE method should not have a body as per [RFC 9110, section 9.3.5, paragraph 5](https://www.rfc-editor.org/rfc/rfc9110#DELETE)).\n",
          "requestBody": {
            "$ref": "#/components/requestBodies/RefundRequest"
          },
          "responses": {
            "200": {
              "description": "Successful refund response",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/RefundResponse"
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
        "RedirectUrlRequest": {
          "type": "object",
          "description": "Redirect URL request",
          "properties": {
            "idTransaction": {
              "$ref": "#/components/schemas/PagopaIdTransaction"
            },
            "idPsp": {
              "description": "PSP identifier",
              "type": "string"
            },
            "amount": {
              "$ref": "#/components/schemas/AmountEuroCents"
            },
            "urlBack": {
              "description": "pagoPA platform URL where redirect users after payment transaction have been completed",
              "type": "string",
              "format": "uri"
            },
            "description": {
              "description": "Payment description",
              "type": "string"
            },
            "idPaymentMethod": {
              "description": "Redirect payment method type",
              "type": "string"
            },
            "touchpoint": {
              "description": "Touchpoint used to initiate the transaction",
              "type": "string",
              "enum": [
                "CHECKOUT",
                "IO"
              ]
            },
            "paName": {
              "description": "Name of the payment notice issuer",
              "type": "string",
              "minLength": 1,
              "maxLength": 70
            },
            "paymentMethod": {
              "description": "Description of the payment method chosen by the user",
              "type": "string"
            }
          },
          "required": [
            "idTransaction",
            "idPsp",
            "amount",
            "urlBack",
            "description",
            "idPaymentMethod",
            "touchpoint"
          ],
          "example": {
            "idTransaction": "3fa85f6457174562b3fc2c963f66afa6",
            "idPsp": "idPsp",
            "amount": 99999999,
            "urlBack": "https://psp.site/payment",
            "description": "payment description",
            "idPaymentMethod": "RBPIC",
            "touchpoint": "CHECKOUT",
            "paName": "paName",
            "paymentMethod": "Pago in Conto Intesa"
          }
        },
        "RedirectUrlResponse": {
          "description": "Redirect URL response",
          "type": "object",
          "properties": {
            "url": {
              "description": "URL where user has to be redirect to start payment",
              "type": "string",
              "format": "url"
            },
            "idTransaction": {
              "$ref": "#/components/schemas/PagopaIdTransaction"
            },
            "idPSPTransaction": {
              "description": "Unique identifier for the payment operation PSP side",
              "type": "string"
            },
            "amount": {
              "$ref": "#/components/schemas/AmountEuroCents"
            },
            "timeout": {
              "description": "Max time that pagoPA systems have to await for an outcome callback call. Any request received after this timeout will be discarded and transaction treated as for a missing callback call",
              "type": "integer",
              "format": "int32",
              "minimum": 0,
              "maximum": 600000
            }
          },
          "required": [
            "url",
            "idTransaction",
            "idPSPTransaction",
            "amount"
          ]
        },
        "AmountEuroCents": {
          "description": "Amount for payments, in euro cents",
          "type": "integer",
          "format": "int32",
          "minimum": 0,
          "maximum": 99999999
        },
        "PagopaIdTransaction": {
          "description": "Uniquely identify a transaction",
          "type": "string",
          "minLength": 32,
          "maxLength": 32,
          "example": "3fa85f6457174562b3fc2c963f66afa6"
        },
        "RefundRequest": {
          "type": "object",
          "properties": {
            "idTransaction": {
              "$ref": "#/components/schemas/PagopaIdTransaction"
            },
            "idPSPTransaction": {
              "description": "PSP transaction id",
              "type": "string"
            },
            "action": {
              "description": "Requested action (i.e. refund)",
              "type": "string"
            }
          },
          "required": [
            "idTransaction",
            "idPSPTransaction",
            "action"
          ],
          "example": {
            "idTransaction": "3fa85f6457174562b3fc2c963f66afa6",
            "idPSPTransaction": "idPSPTransaction",
            "action": "refund"
          }
        },
        "RefundOutcome": {
          "description": "Refund operation outcome:\nit can be one of the following values:\n* OK - `Refund operation processed successfully`\n* KO - `There was an error performing refund`\n* CANCELED - `The transaction was already refunded`\n",
          "type": "string",
          "enum": [
            "OK",
            "KO",
            "CANCELED"
          ]
        },
        "RefundResponse": {
          "type": "object",
          "description": "Refund response body",
          "properties": {
            "idTransaction": {
              "$ref": "#/components/schemas/PagopaIdTransaction"
            },
            "outcome": {
              "$ref": "#/components/schemas/RefundOutcome"
            }
          },
          "required": [
            "idTransaction",
            "outcome"
          ]
        }
      },
      "requestBodies": {
        "RedirectUrlRequest": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RedirectUrlRequest"
              },
              "examples": {
                "Poste addebito in conto Retail (RBPR)": {
                  "value": {
                    "idTransaction": "3fa85f6457174562b3fc2c963f66afa6",
                    "idPsp": "idPsp",
                    "amount": 99999999,
                    "urlBack": "https://psp.site/payment",
                    "description": "payment description",
                    "idPaymentMethod": "RBPR",
                    "touchpoint": "CHECKOUT",
                    "paName": "paName",
                    "paymentMethod": "Poste addebito in conto Retail"
                  }
                },
                "Poste addebito in conto Business (RBPB)": {
                  "value": {
                    "idTransaction": "3fa85f6457174562b3fc2c963f66afa6",
                    "idPsp": "idPsp",
                    "amount": 99999999,
                    "urlBack": "https://psp.site/payment",
                    "description": "payment description",
                    "idPaymentMethod": "RBPB",
                    "touchpoint": "CHECKOUT",
                    "paName": "paName",
                    "paymentMethod": "Poste addebito in conto Business"
                  }
                },
                "Pago con BottonePostePay (RBPP)": {
                  "value": {
                    "idTransaction": "3fa85f6457174562b3fc2c963f66afa6",
                    "idPsp": "idPsp",
                    "amount": 99999999,
                    "urlBack": "https://psp.site/payment",
                    "description": "payment description",
                    "idPaymentMethod": "RBPP",
                    "touchpoint": "CHECKOUT",
                    "paName": "paName",
                    "paymentMethod": "Pago con BottonePostePay"
                  }
                },
                "Pago in Conto Intesa (RBPIC)": {
                  "value": {
                    "idTransaction": "3fa85f6457174562b3fc2c963f66afa6",
                    "idPsp": "idPsp",
                    "amount": 99999999,
                    "urlBack": "https://psp.site/payment",
                    "description": "payment description",
                    "idPaymentMethod": "RBPIC",
                    "touchpoint": "CHECKOUT",
                    "paName": "paName",
                    "paymentMethod": "Pago in Conto Intesa"
                  }
                },
                "SCRIGNO Internet Banking (RBPS)": {
                  "value": {
                    "idTransaction": "3fa85f6457174562b3fc2c963f66afa6",
                    "idPsp": "idPsp",
                    "amount": 99999999,
                    "urlBack": "https://psp.site/payment",
                    "description": "payment description",
                    "idPaymentMethod": "RBPS",
                    "touchpoint": "CHECKOUT",
                    "paName": "paName",
                    "paymentMethod": "SCRIGNO Internet Banking"
                  }
                }
              }
            }
          }
        },
        "RefundRequest": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RefundRequest"
              }
            }
          }
        }
      },
      "securitySchemes": {
        "PspApiKeyAuth": {
          "type": "apiKey",
          "in": "header",
          "name": "x-api-key",
          "description": "PSP api key"
        }
      }
    }
  }