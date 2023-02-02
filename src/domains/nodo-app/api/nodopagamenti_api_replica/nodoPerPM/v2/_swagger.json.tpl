{
  "swagger": "2.0",
  "info": {
    "description": "Specifiche di interfaccia Nodo per Payment Manager",
    "version": "2.0.0",
    "title": "Nodo-Per-PaymentManager"
  },
  "schemes": [
    "http"
  ],
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ],
  "host": "${host}",
  "paths": {
    "/closepayment": {
      "post": {
        "tags": [
          "nodo"
        ],
        "summary": "closePaymentV2",
        "description": "Called after the request is validated by PPay",
        "operationId": "closePaymentV2",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/ClosePaymentRequestV2"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/ClosePaymentResponse"
            }
          },
          "400": {
            "description": "Bad Request",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "404": {
            "description": "Not found",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "408": {
            "description": "Request Timeout",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          },
          "422": {
            "description": "Unprocessable entry",
            "schema": {
              "$ref": "#/definitions/Error"
            }
          }
        }
      }
    }
  },
  "definitions": {
    "ClosePaymentResponse": {
      "type": "object",
      "required": [
        "outcome"
      ],
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
        "error"
      ],
      "properties": {
        "error": {
          "type": "string",
          "example": "error message"
        }
      }
    },
    "ClosePaymentRequestV2": {
      "type": "object",
      "required": [
        "paymentTokens",
        "outcome",
        "idPSP",
        "idBrokerPSP",
        "idChannel",
        "paymentMethod",
        "transactionId",
        "totalAmount",
        "fee",
        "timestampOperation",
        "additionalPaymentInformations"
      ],
      "properties": {
        "paymentTokens": {
          "type": "array",
          "minItems": 1,
          "items": {
            "type": "string",
            "minLength": 1,
            "maxLength": 36
          }
        },
        "outcome": {
          "type": "string",
          "enum": [
            "OK",
            "KO"
          ]
        },
        "idPSP": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "idBrokerPSP": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "idChannel": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "paymentMethod": {
          "type": "string",
          "minLength": 1
        },
        "transactionId": {
          "type": "string",
          "minLength": 1,
          "maxLength": 255
        },
        "totalAmount": {
          "type": "number",
          "minimum": 0,
          "maximum": 1000000000,
          "example": "20.10"
        },
        "fee": {
          "type": "number",
          "description": "commission amount",
          "minimum": 0,
          "maximum": 1000000000,
          "example": "10.00"
        },
        "timestampOperation": {
          "type": "string",
          "format": "date-time",
          "example": "2022-02-22T14:41:58.811+01:00"
        },
        "additionalPaymentInformations": {
          "type": "object",
          "additionalProperties": {
            "type": "string",
            "minLength": 1,
            "maxLength": 140
          },
          "maxProperties": 9
        }
      }
    }
  }
}
