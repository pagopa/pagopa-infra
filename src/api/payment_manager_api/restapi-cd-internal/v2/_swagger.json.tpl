{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - internal pp-rest-CD v2 exposed for payment-transaction-gateway",
    "version": "1.0",
    "title": "Payment Manager API - internal pp-rest-CD v2",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-restapi-CD",
  "paths": {
    "/transactions/{id}": {
      "patch": {
        "summary": "updateTransactionStatus",
        "operationId": "updateTransactionStatusUsingPATCH",
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "id",
            "required": true,
            "type": "integer",
            "format": "int64"
          },
          {
            "name": "transactionUpdateStatusRequest",
            "in": "body",
            "description": "transactionUpdateStatusRequest",
            "required": true,
            "schema": {
              "$ref": "#/definitions/TransactionUpdateStatusRequest"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "404": {
            "description": "Not Found"
          }
        }
      }
    }
  },
  "definitions": {
    "TransactionUpdateStatus": {
      "type": "object",
      "properties": {
        "status": {
          "type": "integer",
          "format": "int64"
        },
        "authCode": {
          "type": "string"
        },
        "rrn": {
          "type": "string"
        }
      },
      "title": "TransactionUpdateStatus"
    },
    "TransactionUpdateStatusRequest": {
      "type": "object",
      "required": [
        "data"
      ],
      "properties": {
        "data": {
          "$ref": "#/definitions/TransactionUpdateStatus"
        }
      },
      "title": "TransactionUpdateStatusRequest"
    }
  }
}