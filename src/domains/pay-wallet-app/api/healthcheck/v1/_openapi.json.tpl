{
  "openapi": "3.0.3",
  "info": {
    "version": "0.0.1,",
    "title": "Payment Wallet pagoPA - healthcheck",
    "description": "The Healthcheck API is used to monitor the operational status of a REST API by providing endpoints for liveness and readiness checks.\n- Liveness Check: This endpoint verifies that the API is running and able to process requests.\n- Readiness Check: This endpoint confirms that the API is fully initialized and ready to handle traffic. It ensures that all necessary resources, such as databases or external services, are available before the API starts accepting requests.\n",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "PaymentWalletHealthcheck",
      "description": "Api's to handle payment wallet healtcheck"
    }
  ],
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/liveness": {
      "get": {
        "tags": [
          "PaymentWalletHealthcheck"
        ],
        "summary": "API to support Liveness Check",
        "operationId": "PaymentWalletHealthcheckLiveness",
        "responses": {
          "200": {
            "description": "Healthcheck Liveness info",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentWalletHealthcheckLivenessResponse"
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
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 401,
                  "detail": "Unauthorized"
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
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 500,
                  "detail": "Internal server error"
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
      "PaymentWalletHealthcheckLivenessResponse": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "enum": [
              "UP",
              "DOWN"
            ],
            "description": "The overall status of all services."
          },
          "details": {
            "type": "object",
            "description": "Detailed status of each payment wallet service (additionalProperties).",
            "additionalProperties": {
              "type": "object",
              "properties": {
                "status": {
                  "type": "string",
                  "enum": [
                    "UP",
                    "DOWN"
                  ],
                  "description": "The status of the individual service."
                },
                "groups": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "description": "Groups associated with the service status (e.g., liveness, readiness)."
                }
              }
            }
          }
        },
        "required": [
          "status"
        ]
      },
      "ProblemJson": {
        "description": "Body definition for error responses containing failure details",
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
        "example": 502
      }
    }
  }
}