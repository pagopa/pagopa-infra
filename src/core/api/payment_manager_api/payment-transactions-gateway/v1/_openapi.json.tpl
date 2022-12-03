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
    },
    "/request-payments/bancomatpay/{requestId}": {
      "get": {
        "tags": [
          "payment-transactions-controller"
        ],
        "operationId": "retrieve the correlationId of a BancomatPay payment request",
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
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/BPayInfoResponse"
                }
              }
            }
          },
          "404": {
            "description": "Not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BPayInfoResponse"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BPayInfoResponse"
                }
              }
            }
          }
        }
      }
    },
    "/request-refunds/bancomatpay": {
      "post": {
        "tags": [
          "payment-transactions-controller"
        ],
        "operationId": "refundTransaction",
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
                "$ref": "#/components/schemas/BPayRefundRequest"
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
                  "$ref": "#/components/schemas/BPayOutcomeResponse"
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
            "description": "Timeout",
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
      },
      "BPayInfoResponse": {
        "type": "object",
        "properties": {
          "correlationId": {
            "type": "string",
            "example": "7cbf110b-6ebe-49ed-ab39-cd2f35339622"
          },
          "errorMessage": {
            "type": "string",
            "example": "RequestId 77e1c83b-7bb0-437b-bc50-a7a58e5660ac has not been found"
          }
        },
        "required": [
          "correlationId"
        ]
      },
      "BPayRefundRequest": {
        "required": [
          "idPagoPa"
        ],
        "type": "object",
        "properties": {
          "idPagoPa": {
            "type": "integer",
            "format": "int64"
          },
          "refundAttempt": {
            "type": "number",
            "format": "integer"
          },
          "subject": {
            "type": "string"
          },
          "language": {
            "type": "string"
          }
        }
      },
      "BPayOutcomeResponse": {
        "type": "object",
        "properties": {
          "outcome": {
            "type": "boolean"
          }
        }
      },
      "Error": {
        "type": "object",
        "properties": {
          "code": {
            "type": "integer",
            "format": "int64"
          },
          "message": {
            "type": "string"
          }
        },
        "required": [
          "code",
          "message"
        ]
      }
    }
  }
}