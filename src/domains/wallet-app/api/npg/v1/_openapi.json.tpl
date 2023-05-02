{
    "openapi": "3.0.3",
    "info": {
      "version": "0.0.1,",
      "title": "pagoPA Wallet Notification API - OpenAPI 3.0",
      "description": "Notification API to implement callback providing order status updates after wallet creation on Nexi's NPG",
      "contact": {
        "name": "pagoPA - Touchpoints team"
      }
    },
    "tags": [
      {
        "name": "Wallet",
        "description": "Intercat with wallet"
      }
    ],
    "externalDocs": {
      "description": "Nexi API to handle Hosted Payment Page (HPP) payments",
      "url": "https://developer.nexigroup.com/it/api/post-orders-hpp"
    },
    "servers": [
      {
        "url": "https://${hostname}"
      }
    ],
    "paths": {
      "/notify": {
        "post": {
          "tags": [
            "notifyWallet"
          ],
          "summary": "Update Wallet on NPG payment instrument creation",
          "description": "Update Wallet on NPG payment instrument creation",
          "operationId": "notifyWallet",
          "parameters": [
            {
              "in": "header",
              "name": "correlation-Id",
              "schema": {
                "type": "string",
                "format": "uuid"
              },
              "required": true,
              "description": "Unique identifier of the request"
            }
          ],
          "requestBody": {
            "description": "Notify wallet",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NotificationRequest"
                }
              }
            },
            "required": true
          },
          "responses": {
            "204": {
              "description": "Notification handled successfully"
            },
            "400": {
              "description": "Invalid input",
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
      }
    },
    "components": {
      "schemas": {
        "NotificationRequest": {
          "properties": {
            "contractId": {
              "type": "string",
              "maxLength": 255,
              "example": "C2834987"
            },
            "status": {
              "type": "string",
              "description": "Status of the payment order",
              "enum": [
                "OK",
                "KO"
              ],
              "example": "OK"
            },
            "securityToken": {
              "type": "string",
              "description": "Payment gateway security token used to validate the request",
              "example": "2f0ea5059b41414ca3744fe672327d85"
            }
          }
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