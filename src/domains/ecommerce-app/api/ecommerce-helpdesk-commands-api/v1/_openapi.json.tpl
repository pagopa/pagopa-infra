{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa helpdesk commands services",
    "description": "This microservice exposes API for for manual operation related to eCommerce transactions"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "helpdeskCommands",
      "description": "Api's for performing money refund operations over failed transactions",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
        "description": "Technical specifications"
      }
    }
  ],
  "paths": {
    "/commands/refund": {
      "post": {
        "tags": [
          "ecommerce"
        ],
        "operationId": "refundOperation",
        "summary": "Api's for performing money refunds operations over failed transactions",
        "description": "POST with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/RefundTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions refunded",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RefundTransactionResponse"
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
                }
              }
            }
          },
          "404": {
            "description": "Transaction not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
                }
              }
            }
          }
        }
      }
    },
    "/commands/refund/redirect": {
      "post": {
        "tags": [
          "ecommerce"
        ],
        "summary": "Api's for refund redirect",
        "description": "POST refund redirect",
        "requestBody": {
          "$ref": "#/components/requestBodies/RefundRedirectRequest"
        },
        "responses": {
          "200": {
            "description": "Refund redirect completed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RefundRedirectResponse"
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
                }
              }
            }
          },
          "404": {
            "description": "Transaction not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
                }
              }
            }
          }
        }
      }
    },
    "/commands/transactions/{transactionId}/refund": {
      "post": {
        "tags": [
          "ecommerce"
        ],
        "operationId": "requestTransactionRefund",
        "summary": "Request a refund for a transaction",
        "description": "Sends a refund request to the dedicated service for processing",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "The unique identifier of the transaction"
          },
          {
            "in": "header",
            "name": "X-User-Id",
            "required": true,
            "description": "User ID (populated by APIM policy)",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "header",
            "name": "X-Forwarded-For",
            "required": true,
            "description": "Client Source IP Address",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "202": {
            "description": "TransactionRefundRequested message successfully queued to the dedicated service"
          },
          "400": {
            "description": "Formally invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/constraint-violation",
                  "title": "Bad Request",
                  "status": 400,
                  "detail": "There was an error processing the request",
                  "instance": "/commands/transactions/{transactionId}/refund"
                }
              }
            }
          },
          "404": {
            "description": "Transaction not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/not-found",
                  "title": "Not Found",
                  "status": 404,
                  "detail": "Transaction not found",
                  "instance": "/commands/transactions/{transactionId}/refund"
                }
              }
            }
          },
          "422": {
            "description": "Transaction not in a refundable state",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/unprocessable-entity",
                  "title": "Unprocessable Entity",
                  "status": 422,
                  "detail": "Transaction not in a refundable state",
                  "instance": "/commands/transactions/{transactionId}/refund"
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
                  "type": "https://example.com/problem/internal-error",
                  "title": "Internal Server Error",
                  "status": 500,
                  "detail": "There was an internal server error",
                  "instance": "/commands/transactions/{transactionId}/refund"
                }
              }
            }
          }
        }
      }
    },
    "/commands/transactions/{transactionId}/resend-email": {
      "post": {
        "tags": [
          "ecommerce"
        ],
        "operationId": "resendTransactionEmail",
        "summary": "Request to resend the transaction email notification",
        "description": "Sends an email notification request to the dedicated service for processing",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "The unique identifier of the transaction"
          },
          {
            "in": "header",
            "name": "X-User-Id",
            "required": true,
            "description": "User ID (populated by APIM policy)",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "header",
            "name": "X-Forwarded-For",
            "required": true,
            "description": "Client Source IP Address",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "202": {
            "description": "TransactionUserReceipt message successfully queued to the dedicated service"
          },
          "400": {
            "description": "Invalid transaction ID format",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/constraint-violation",
                  "title": "Bad Request",
                  "status": 400,
                  "detail": "Invalid transaction ID format",
                  "instance": "/commands/transactions/{transactionId}/resend-email"
                }
              }
            }
          },
          "404": {
            "description": "Transaction not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/not-found",
                  "title": "Not Found",
                  "status": 404,
                  "detail": "Transaction not found",
                  "instance": "/commands/transactions/{transactionId}/resend-email"
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
                  "type": "https://example.com/problem/internal-error",
                  "title": "Internal Server Error",
                  "status": 500,
                  "detail": "There was an internal server error",
                  "instance": "/commands/transactions/{transactionId}/resend-email"
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
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "RefundTransactionResponse": {
        "type": "object",
        "properties": {
          "refundOperationId": {
            "type": "string",
            "description": "The id of the refunded operation, if any",
            "default": 0
          }
        }
      },
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
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 200
      },
      "RefundTransactionRequest": {
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "The id of the transaction",
            "minLength": 32,
            "maxLength": 32
          },
          "paymentMethodName": {
            "type": "string",
            "description": "The name of the payment method"
          },
          "pspId": {
            "type": "string",
            "description": "The id of the psp"
          },
          "operationId": {
            "type": "string",
            "description": "The id of the operation"
          },
          "correlationId": {
            "type": "string",
            "description": "correlation id for a transaction executed with NPG"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "transactionId",
          "paymentMethodName",
          "pspId",
          "operationId",
          "correlationId",
          "amount"
        ]
      },
      "RefundRedirectRequest": {
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
          },
          "touchpoint": {
            "type": "string",
            "description": "Name of touchpoint"
          },
          "paymentTypeCode": {
            "type": "string",
            "description": "The code of the payment method"
          },
          "pspId": {
            "type": "string",
            "description": "The id of the psp"
          }
        },
        "required": [
          "idTransaction",
          "idPSPTransaction",
          "action",
          "touchpoint",
          "pspId",
          "paymentTypeCode"
        ]
      },
      "RefundRedirectResponse": {
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
      },
      "PagopaIdTransaction": {
        "description": "Uniquely identify a transaction",
        "type": "string",
        "minLength": 32,
        "maxLength": 32,
        "example": "3fa85f6457174562b3fc2c963f66afa6"
      },
      "RefundOutcome": {
        "description": "Refund operation outcome:\nit can be one of the following values:\n* OK - `Refund operation processed successfully`\n* KO - `There was an error performing refund`\n* CANCELED - `The transaction was already refunded`\n",
        "type": "string",
        "enum": [
          "OK",
          "KO",
          "CANCELED"
        ]
      }
    },
    "requestBodies": {
      "RefundTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/RefundTransactionRequest"
            }
          }
        }
      },
      "RefundRedirectRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/RefundRedirectRequest"
            }
          }
        }
      }
    }
  }
}