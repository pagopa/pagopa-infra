{
  "openapi": "3.0.1",
  "info": {
    "title": "Receipts Generator Helpdesk",
    "description": "Microservice for exposing REST APIs about receipts helpdesk.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "1.16.3"
  },
  "servers": [
    {
      "url": "https://api.dev.platform.pagopa.it/receipts/helpdesk/v1/",
      "description": "DEV url"
    },
    {
      "url": "https://api.uat.platform.pagopa.it/receipts/helpdesk/v1/",
      "description": "UAT url"
    },
    {
      "url": "https://api.platform.pagopa.it/receipts/helpdesk/v1/",
      "description": "PROD url"
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
        "description": "Return the application info, if the application is started",
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
    "/receipts/{event-id}/regenerate-receipt-pdf": {
      "post": {
        "tags": [
          "API-regenerateReceiptPdf"
        ],
        "summary": "Regenerate and update pdf attachment of the receipt with the given bizEvent id",
        "operationId": "RegenerateReceiptPdf",
        "parameters": [
          {
            "in": "path",
            "name": "event-id",
            "description": "BizEvent id.",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
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
          "500": {
            "description": "Receipt could not be updated with the new attachments",
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
      "ProblemJson": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized)",
            "example": "Bad Request"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 400
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "The request is invalid"
          }
        }
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
