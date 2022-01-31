{
  "swagger": "2.0",
  "info": {
    "version": "1.1.0",
    "title": "IO Function API",
    "contact": {
      "name": "IO team",
      "url": "https://forum.italia.it/c/progetto-io"
    },
    "x-logo": {
      "url": "https://io.italia.it/assets/img/io-logo-blue.svg"
    },
    "description": "Documentation of the IO Function API here.\n"
  },
  "host": "${host}",
  "basePath": "/api",
  "schemes": [
    "https"
  ],
  "security": [
    {
      "Bearer": []
    }
  ],
  "paths": {
    "/user": {
      "x-swagger-router-controller": "SSOController",
      "get": {
        "operationId": "getUserForBPD",
        "summary": "Get user's data",
        "description": "Returns the user data needed by BPD backend.",
        "responses": {
          "200": {
            "description": "Found.",
            "schema": {
              "$ref": "#/definitions/BPDUser"
            },
            "examples": {
              "application/json": {
                "name": "Name",
                "family_name": "Surname",
                "fiscal_code": "AAABBB01C02D123Z"
              }
            }
          },
          "401": {
            "description": "Token null or expired."
          },
          "500": {
            "description": "There was an error in retrieving the user data.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    }
  },
  "definitions": {
    "LimitedFederatedUser": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-backend/master/api_backend.yaml#/definitions/LimitedFederatedUser"
    },
    "BPDUser": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-backend/master/api_backend.yaml#/definitions/FederatedUser"
    },
    "ProblemJson": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v5.0.0/openapi/definitions.yaml#/ProblemJson"
    },
    "FiscalCode": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v5.0.0/openapi/definitions.yaml#/FiscalCode"
    }
  },
  "responses": {},
  "parameters": {},
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ],
  "securityDefinitions": {
    "Bearer": {
      "type": "apiKey",
      "name": "Authorization",
      "in": "header"
    }
  }
}
