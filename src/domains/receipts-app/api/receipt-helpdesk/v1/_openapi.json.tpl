{
  "openapi": "3.0.1",
  "info": {
    "title": "Receipts Healthcheck",
    "description": "Microservice for exposing REST APIs about receipts Healthcheck.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.0.2-4"
  },
  "servers": [
    {
      "url": "http://localhost:8080",
      "description": "Generated server url"
    }
  ],
  "tags": [],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AppInfo"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "403": {
            "description": "Forbidden",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/recoverFailed": {
      "put": {
        "tags": [
          "Receipts REST APIs"
        ],
        "summary": "Recover failed receipts.",
        "operationId": "recoverFailed",
        "parameters": [],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ReceiptFailedRecoveryRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Succesfull Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "422": {
            "description": "Unable to process the request.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  },
  "/recoverNotNotified": {
      "put": {
        "tags": [
          "Receipts REST APIs"
        ],
        "summary": "Recover a receipt, or group of, in IO_ERROR_TO_NOTIFY or GENERATED status",
        "operationId": "recoverNotNotified",
        "parameters": [],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NotNotifiedRecoveryRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Succesfull Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Receipt with id 235392957832338457-0000-0000-0000-0131 and eventId 76abb1f1-c9f9-4ead-9e66-12fec4d51042 restored in status GENERATED with success"
                }
              }
            }
          },
          "400": {
            "description": "Bad request invalid input.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Please select at least one status to recover"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "description": "Requested receipt not found.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Unable to retrieve the receipt with eventId 76abb1f1-c9f9-4ead-9e66-12fec4d51042"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "description": "The requested receipts is not in a status that can be elaborated.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "The requested receipt with eventId 76abb1f1-c9f9-4ead-9e66-12fec4d51042 is not in the expected status"
                }
              }
            }
          },
          "default": {
            "description": "Unexpected error.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  },
  "/toReviewed": {
      "put": {
        "tags": [
          "Receipts REST APIs"
        ],
        "summary": "Recover a receipt, or group of, in TO_REVIEW status",
        "operationId": "toReviewed",
        "parameters": [],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ReceiptToReviewedRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Succesfull Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "OK"
                }
              }
            }
          },
          "400": {
            "description": "Receipt not found.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "default": {
            "description": "Unexpected error.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/regenerateReceiptPdf": {
      "put": {
        "tags": [
          "Receipts REST APIs"
        ],
        "summary": "Regenerate Receipt PDF",
        "operationId": "recoverFailed",
        "parameters": [],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RegenerateReceiptRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Succesfull Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "OK"
                }
              }
            }
          },
          "400": {
            "description": "Receipt or BizEvent not found.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "description": "Error processing the request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "default": {
            "description": "Unexpected error.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
  },
  "components": {
    "schemas": {
      "AppInfo": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "example": "pagopa-receipt-pdf-helpdesk"
          },
          "version": {
            "type": "string",
            "example": "1.0.0"
          },
          "environment": {
            "type": "string",
            "example": "azure-fn"
          }
        }
      },
      "ReceiptToReviewedRequest": {
        "type": "object",
        "description": "The request body for toReviewed API. The field eventId when not provided enable the massive operation",
        "properties": {
          "eventId": {
            "type": "string",
            "description": "Id of the event to start recovering, if not specified enable massive operation",
            "example" : "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
          }
        }
      },
      "ReceiptFailedRecoveryRequest": {
        "type": "object",
        "description": "The request body for recoverFailed API. The field eventId when not provided enable the massive operation",
        "properties": {
          "eventId": {
            "type": "string",
            "description": "Id of the event to start recovering, if not specified enable massive operation",
            "example" : "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
          }
        }
      },
      "RegenerateReceiptRequest": {
        "type": "object",
        "description": "The request body for regenerateReceipt API. The field eventId when not provided enable the massive operation",
        "properties": {
          "eventId": {
            "type": "string",
            "description": "Id of the event to start recovering, if not specified enable massive operation",
            "example" : "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
          }
        }
      },
      "NotNotifiedRecoveryRequest": {
        "type": "object",
        "description": "The request body for recoverNotNotified API, at least one of generatedStatus or ioErrorToNotifyStatus must be true. The field eventId when not provided enable the massive operation",
        "properties": {
          "eventId": {
            "type": "string",
            "description": "Id of the event to start recovering, if not specified enable massive operation",
            "example" : "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
          },
          "generatedStatus": {
            "type": "boolean",
            "description": "true to recover the receipts in GENERATED status, false otherwise",
            "example" : true
          },
          "ioErrorToNotifyStatus": {
            "type": "boolean",
            "description": "true to recover the receipts in IO_ERROR_TO_NOTIFY status, false otherwise",
            "example" : true
          }
        },
        "required": ["generatedStatus", "ioErrorToNotifyStatus"]
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
