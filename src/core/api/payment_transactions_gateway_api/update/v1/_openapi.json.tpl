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
          "BancomatPay"
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
    },
    "/request-payments/xpay/{requestId}/resume": {
      "get": {
        "summary": "payment request to xPay",
        "tags": [
          "XPay"
        ],
        "operationId": "resumeXPayPayment",
        "parameters": [
          {
            "name": "requestId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "esito",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "idOperazione",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "xpayNonce",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "timeStamp",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "mac",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "resumeType",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "302": {
            "description": "OK-FOUND",
            "headers": {
              "Location": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "Bad Request - mandatory parameters missing"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "Unauthorized - transaction already processed"
                }
              }
            }
          },
          "404": {
            "description": "TimeOut",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "RequestId not Found"
                }
              }
            }
          }
        }
      }
    },
    "/xpay/authorizations/{requestId}/resume": {
      "get": {
        "summary": "payment request to xPay",
        "tags": [
          "XPay-auth"
        ],
        "operationId": "resumeXPayPaymentAuth",
        "parameters": [
          {
            "name": "requestId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "esito",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "idOperazione",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "xpayNonce",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "timeStamp",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "mac",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "resumeType",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "302": {
            "description": "OK-FOUND",
            "headers": {
              "Location": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "Bad Request - mandatory parameters missing"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "Unauthorized - transaction already processed"
                }
              }
            }
          },
          "404": {
            "description": "TimeOut",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "RequestId not Found"
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