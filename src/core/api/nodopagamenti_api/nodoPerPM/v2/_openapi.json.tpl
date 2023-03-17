{
  "openapi": "3.0.1",
  "info": {
    "title": "Nodo-Per-PaymentManager",
    "description": "Specifiche di interfaccia Nodo per Payment Manager",
    "version": "3.0.1"
  },
  "servers": [
    {
      "url": "http://${host}/"
    }
  ],
  "paths": {
    "/closepayment": {
      "post": {
        "tags": [
          "nodo"
        ],
        "summary": "closePaymentV2",
        "description": "Called after the request is validated by PPay",
        "operationId": "closePaymentV2",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ClosePaymentRequestV2"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ClosePaymentResponse"
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
          "404": {
            "description": "Not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "408": {
            "description": "Request Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "422": {
            "description": "Unprocessable entry",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        },
        "x-codegen-request-body-name": "body"
      }
    }
  },
  "components": {
    "schemas": {
      "ClosePaymentResponse": {
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
        "required": [
          "error"
        ],
        "type": "object",
        "properties": {
          "error": {
            "type": "string",
            "example": "error message"
          }
        }
      },
      "CancelPaymentRequestV2": {
        "type": "object",
        "properties": {
          "paymentTokens": {
            "minItems": 1,
            "type": "array",
            "items": {
              "maxLength": 36,
              "minLength": 1,
              "type": "string"
            }
          },
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "transactionId": {
            "maxLength": 255,
            "minLength": 1,
            "type": "string"
          }
        },
        "required": [
          "paymentTokens",
          "outcome",
          "transactionId"
        ],
        "discriminator": {
          "propertyName": "outcome",
          "mapping": {
            "OK": "#/components/schemas/ClosePaymentRequestV2",
            "KO": "#/components/schemas/CancelPaymentRequestV2"
          },
          "oneOf": [
            {
              "$ref": "#/components/schemas/ClosePaymentRequestV2"
            },
            {
              "$ref": "#/components/schemas/CancelPaymentRequestV2"
            }
          ]
        }
      },
      "ClosePaymentRequestV2": {
        "type": "object",
        "allOf": [
          {
            "$ref": "#/components/schemas/CancelPaymentRequestV2"
          }
        ],
        "properties": {
          "idPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string"
          },
          "idBrokerPSP": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string"
          },
          "idChannel": {
            "maxLength": 35,
            "minLength": 1,
            "type": "string"
          },
          "paymentMethod": {
            "minLength": 1,
            "type": "string"
          },
          "totalAmount": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "example": 20.1
          },
          "fee": {
            "maximum": 1000000000,
            "minimum": 0,
            "type": "number",
            "description": "commission amount",
            "example": 10
          },
          "timestampOperation": {
            "type": "string",
            "format": "date-time",
            "example": "2022-02-22T13:41:58.811Z"
          },
          "additionalPaymentInformations": {
            "maxProperties": 9,
            "type": "object",
            "additionalProperties": {
              "maxLength": 140,
              "minLength": 1,
              "type": "string"
            }
          }
        },
        "required": [
          "idPSP",
          "idBrokerPSP",
          "idChannel",
          "paymentMethod",
          "totalAmount",
          "fee",
          "timestampOperation"
        ]
      }
    }
  }
}