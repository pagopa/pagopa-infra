{
  "swagger": "2.0",
  "info": {
    "description": "Specifiche di interfaccia Nodo - Payment Manager",
    "version": "1.0.0",
    "title": "Nodo-PaymentManager ${service}",
    "license": {
      "name": "Apache 2.0",
      "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
    }
  },
  "host": "${host}",
  "tags": [
    {
      "name": "Nodo",
      "description": "Servizi esposti da Nodo dei Pagamenti"
    }
  ],
  "schemes": [
    "http"
  ],
  "paths": {
    "/checkPosition": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "checkPosition",
        "description": "Ha lo scopo di consentire al Payment Manager di fare il check di positions",
        "operationId": "checkPosition",
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CheckPosition"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "successful operation",
            "schema": {
              "$ref": "#/definitions/CheckPositionResponse"
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
    "CheckPosition" : {
      "type": "object",
      "required": ["positionslist"],
      "properties": {
        "positionslist": {
          "type": "array",
          "items": { "$ref": "#/definitions/listelement" },
          "minItems": 1,
          "maxItems": 5
        }
      },
    },
    "listelement": {
      "type": "object",
      "required": [ "fiscalCode", "noticeNumber" ],
      "properties": {
        "fiscalCode": {
          "type": "string",
          "pattern": "^[0-9]{11}$"
        },
        "noticeNumber": {
          "type": "string",
          "pattern": "^[0-9]{18}$"
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
    "CheckPositionResponse": {
      "type": "object",
      "required": [
        "esito"
      ],
      "properties": {
        "esito": {
          "type": "string",
          "enum": [
            "OK",
            "KO"
          ]
        }
      }
    }
  }
}