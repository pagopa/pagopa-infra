{
  "swagger": "2.0",
  "info": {
    "version": "1.1.0",
    "title": "Satispay for PM API",
    "description": "Satispay API\n"
  },
  "host": "${host}",
  "schemes": [
    "https"
  ],
  "security": [
    {
      "Bearer": []
    }
  ],
  "paths": {
    "/consumers": {
      "get": {
        "summary": "getConsumersSatispay",
        "operationId": "getConsumersSatispayUsingGET",
        "responses": {
          "200": {
            "description": "OK",
            "schema": {
              "$ref": "#/definitions/RestSatispayResponse"
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
    "RestSatispayResponse": {
      "type": "object",
      "properties": {
        "data": {
          "$ref": "#/definitions/Satispay"
        }
      },
      "title": "RestSatispayResponse"
    },
    "Satispay": {
      "type": "object",
      "properties": {
        "token": {
          "type": "string"
        },
        "uidSatispay": {
          "type": "string"
        },
        "uidSatispayHash": {
          "type": "string"
        },
        "hasMore": {
          "type": "string"
        }
      },
      "title": "Satispay"
    }
  },
  "securityDefinitions": {
    "Bearer": {
      "type": "apiKey",
      "name": "Authorization",
      "in": "header"
    }
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
