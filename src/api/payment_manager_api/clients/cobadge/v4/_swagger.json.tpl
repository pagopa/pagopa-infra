{
  "swagger": "2.0",
  "info": {
    "version": "1.1.0",
    "title": "Codbage privative API",
    "description": "Codbage privative\n"
  },
  "host": "${host}",
  "basePath": "/utils/payment-instruments/",
  "schemes": [
    "https"
  ],
  "security": [
    {
      "Bearer": []
    }
  ],
  "paths": {
    "/{searchRequestId}": {
      "get": {
        "summary": "getCobadgeByRequestId",
        "operationId": "getCobadgeByRequestIdUsingGET",
        "parameters": [
          {
            "name": "searchRequestId",
            "in": "path",
            "description": "searchRequestId",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/CobadgeResponse"
            }
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
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    },
    "/search": {
      "post": {
        "summary": "postCobadge",
        "operationId": "cobadgeUsingPost",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "schema": {
              "$ref": "#/definitions/CobadgeRequest"
            },
            "required": true,
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/CobadgeResponse"
            }
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
        },
        "security": [
          {
            "Bearer": []
          }
        ]
      }
    }
  },
  "definitions": {
    "CobadgeResponse": {
      "type": "object",
      "properties": {
        "errors": {
          "type": "array",
          "items": {
            "$ref": "#/definitions/ErrorModel"
          }
        },
        "payload": {
          "$ref": "#/definitions/Payload"
        },
        "status": {
          "type": "string"
        }
      },
      "title": "CobadgeResponse"
    },
    "CobadgeRequest": {
      "type": "object",
      "properties": {
        "requestId": {
          "type": "string"
        },
        "fiscalCode": {
          "type": "string"
        },
        "abiCode": {
          "type": "string"
        },
        "panCode": {
          "type": "string"
        },
        "acquirerId": {
          "type": "string"
        },
        "productType": {
          "type": "string",
          "enum": [
            "CREDIT",
            "PREPAID",
            "DEBIT",
            "PRIVATIVE"
           ]
        }
      },
      "title": "CobadgeRequest"
    },
  },
  "responses": {},
  "parameters": {},
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ]
}
