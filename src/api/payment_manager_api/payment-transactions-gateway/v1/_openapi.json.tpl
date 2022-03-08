{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition",
    "version": "v1"
  },
  "servers": [
    {
      "url": "${host}/payment-gateway"
    }
  ],
  "paths": {
    "/request-payments/bancomatpay": {
      "put": {
        "tags": [
          "payment-transactions-controller"
        ],
        "operationId": "updateTransaction",
        "parameters": [
          {
            "name": "X-Correlation-ID",
            "in": "header",
            "required": true,
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
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/ACKMessage"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "payment-transactions-controller"
        ],
        "operationId": "requestPaymentToBancomatPay",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BPayPaymentRequest"
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
                  "$ref": "#/components/schemas/BPayPaymentResponseEntity"
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
      "BPayPaymentRequest": {
        "required": [
          "amount",
          "encryptedTelephoneNumber",
          "idPagoPa",
          "idPsp"
        ],
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string"
          },
          "idPagoPa": {
            "type": "integer",
            "format": "int64"
          },
          "amount": {
            "type": "number",
            "format": "double"
          },
          "subject": {
            "type": "string"
          },
          "encryptedTelephoneNumber": {
            "type": "string"
          },
          "language": {
            "type": "string"
          }
        }
      },
      "BPayPaymentResponseEntity": {
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "format": "int64"
          },
          "idPagoPa": {
            "type": "integer",
            "format": "int64"
          },
          "outcome": {
            "type": "boolean"
          },
          "errorCode": {
            "type": "string"
          },
          "message": {
            "type": "string"
          },
          "correlationId": {
            "type": "string"
          },
          "clientGuid": {
            "type": "string"
          },
          "isProcessed": {
            "type": "boolean"
          }
        }
      }
    }
  }
}