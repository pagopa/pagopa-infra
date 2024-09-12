{
  "openapi": "3.0.1",
  "info": {
    "title": "Print Notices Storage Access",
    "description": "",
    "version": "1.0"
  },
  "servers": [
    {
      "url": "${host}/blob"
    }
  ],
  "paths": {
    "/institutionslogoblob/{folderId}/logo.png": {
      "get": {
        "summary": "getLogo",
        "operationId": "getLogo",
        "parameters": [
          {
            "name": "folderId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": ""
          }
        }
      }
    },
    "/notices/{folderId}/{zipName}.zip": {
      "get": {
        "summary": "getNotices",
        "operationId": "getNotices",
        "parameters": [
          {
            "name": "folderId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "zipName",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": ""
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "apiKeyHeader": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      },
      "apiKeyQuery": {
        "type": "apiKey",
        "name": "subscription-key",
        "in": "query"
      }
    }
  },
  "security": [
    {
      "apiKeyHeader": []
    },
    {
      "apiKeyQuery": []
    }
  ]
}
