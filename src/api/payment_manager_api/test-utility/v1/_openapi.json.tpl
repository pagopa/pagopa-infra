{
  "openapi": "3.0.1",
  "info": {
    "title": "Payment Manager test-utility-api",
    "description": "Payment Manager API to support testing",
    "version": "1.0"
  },
  "servers": [
    {
      "url": "${host}"
    }
  ],
  "paths": {
    "/testing-sessions/{env}": {
      "post": {
        "summary": "API to get tokens for testing",
        "operationId": "new-testing-sessions",
        "parameters": [
          {
            "in": "path",
            "name": "env",
            "schema": {
              "type": "string",
              "enum": [
                "uat"
              ]
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "PM sessionToken e idPayment",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TestingTokens"
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
      "TestingTokens": {
        "required": [
          "paymentToken",
          "sessionToken"
        ],
        "type": "object",
        "properties": {
          "paymentToken": {
            "type": "string"
          },
          "sessionToken": {
            "type": "string"
          }
        }
      }
    },
    "securitySchemes": {
      "apiKeyHeader": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  },
  "security": [
    {
      "apiKeyHeader": []
    }
  ]
}