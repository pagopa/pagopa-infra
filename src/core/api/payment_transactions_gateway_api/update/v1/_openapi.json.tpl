{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition for payment-transactions-gateway",
    "version": "v0"
  },
  "servers": [
    {
      "url": "${host}/payment-gateway"
    }
  ],
  "paths": {
    "/request-payments/postepay": {
      "put": {
        "tags": [
          "payment-transactions-controller"
        ],
        "summary": "authorization outcome response from PostePay",
        "operationId": "auth-response",
        "parameters": [
          {
            "name": "X-Correlation-ID",
            "in": "header",
            "required": true,
            "description": "PostePay correlation ID",
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/AuthMessage"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ACKMessage"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized - idPostePay already processed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "404": {
            "description": "Unknown idPostePay",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "500": {
            "description": "Generic Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "504": {
            "description": "Request timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
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
            "type": "string",
            "description": "transaction id on Payment Manager",
            "example": "e8c7a6bf-0e52-45b0-b62e-03ae29b59522"
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
          "channel",
          "urlRedirect"
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
      }
    }
  }
}
