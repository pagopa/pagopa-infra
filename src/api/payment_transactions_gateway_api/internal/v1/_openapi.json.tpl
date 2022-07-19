{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition for internal payment-transactions-gateway",
    "version": "v0"
  },
  "servers": [
    {
      "url": "${host}/payment-gateway"
    }
  ],
  "paths": {
    "/request-payments/postepay": {
      "post": {
        "summary": "payment authorization request to PostePay",
        "tags": [
          "payment-transactions-controller"
        ],
        "operationId": "auth-request",
        "parameters": [
          {
            "in": "header",
            "name": "clientId",
            "description": "channel origin (APP/Web)",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true
          },
          {
            "in": "header",
            "name": "mdc_info",
            "description": "MDC information",
            "example": "97g10t83x7bb0437bbc50sdf58e970gt",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PostePayAuthRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthResponseEntity"
                }
              }
            }
          },
          "400": {
            "description": "Bad request - missing mandatory parameters",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthError"
                }
              }
            }
          },
          "401": {
            "description": "transactionId already processed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthError"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthError"
                }
              }
            }
          },
          "504": {
            "description": "Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthError"
                }
              }
            }
          }
        }
      }
    },
    "/request-payments/postepay/{requestId}": {
      "delete": {
        "summary": "refund PostePay requests",
        "operationId": "refund-request",
        "parameters": [
          {
            "in": "path",
            "name": "requestId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "PGS-generated GUID of the request to retrieve",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "404": {
            "description": "Request doesn't exist",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "500": {
            "description": "Generic Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "502": {
            "description": "Gateway Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "504": {
            "description": "Request timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
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
      "AuthMessage": {
        "required": [
          "auth_outcome"
        ],
        "type": "object",
        "properties": {
          "auth_outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "auth_code": {
            "type": "string"
          }
        }
      },
      "ACKMessage": {
        "required": [
          "outcome"
        ],
        "type": "object",
        "properties": {
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          }
        }
      },
      "PostePayAuthRequest": {
        "required": [
          "grandTotal",
          "idTransaction",
          "description"
        ],
        "type": "object",
        "properties": {
          "grandTotal": {
            "type": "number",
            "format": "integer",
            "description": "amount + fee as euro cents",
            "example": 2350
          },
          "idTransaction": {
            "type": "integer",
            "format": "int64",
            "description": "transaction id on Payment Manager",
            "example": 123456
          },
          "description": {
            "type": "string",
            "description": "payment object description",
            "example": "pagamento bollo auto"
          },
          "paymentChannel": {
            "type": "string",
            "description": "request payment channel (APP or WEB)",
            "example": "APP"
          },
          "name": {
            "type": "string",
            "description": "debtor's name and surname",
            "example": "Mario Rossi"
          },
          "email_notice": {
            "type": "string",
            "description": "debtor's email address",
            "example": "mario.rossi@gmail.com"
          }
        }
      },
      "PostePayAuthResponseEntity": {
        "type": "object",
        "required": [
          "requestId",
          "channel",
          "urlRedirect"
        ],
        "properties": {
          "requestId": {
            "type": "string",
            "description": "request payment ID"
          },
          "channel": {
            "type": "string",
            "description": "request payment channel (APP or WEB)",
            "example": "APP"
          },
          "urlRedirect": {
            "type": "string",
            "description": "redirect URL generated by PGS logic",
            "example": "https://.../e2f518a9-9de4-4a27-afb0-5303e6eefcbf"
          }
        }
      },
      "PollingResponseEntity": {
        "type": "object",
        "required": [
          "channel",
          "authOutcome",
          "urlRedirect",
          "error"
        ],
        "properties": {
          "channel": {
            "type": "string",
            "description": "request payment channel (APP or WEB)",
            "example": "APP"
          },
          "urlRedirect": {
            "type": "string",
            "description": "redirect URL generated by PGS logic",
            "example": "https://.../e2f518a9-9de4-4a27-afb0-5303e6eefcbf"
          },
          "authOutcome": {
            "type": "string",
            "description": "authorization outcome",
            "example": "OK"
          },
          "clientResponseUrl": {
            "type": "string",
            "description": "redirect URL for authorization OK, empty for KO case",
            "example": "https://..."
          },
          "error": {
            "type": "string",
            "description": "error description for 400/500 http error codes",
            "example": ""
          }
        }
      },
      "PostePayAuthError": {
        "type": "object",
        "required": [
          "channel",
          "error"
        ],
        "properties": {
          "channel": {
            "type": "string",
            "description": "request payment channel (APP or WEB)",
            "example": "APP"
          },
          "error": {
            "type": "string",
            "description": "error description",
            "example": "Error description"
          }
        }
      },
      "Error": {
        "type": "object",
        "required": [
          "outcome",
          "message"
        ],
        "properties": {
          "outcome": {
            "type": "string",
            "description": "error outcome",
            "example": "KO"
          },
          "message": {
            "type": "string",
            "description": "error message",
            "example": "error message"
          }
        }
      },
      "PostePayRefundResponse": {
        "type": "object",
        "properties": {
          "requestId": {
            "type": "string"
          },
          "paymentId": {
            "type": "string"
          },
          "refundOutcome": {
            "type": "string"
          },
          "error": {
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "paymentId",
          "refundOutcome",
          "error"
        ]
      }
    }
  }
}