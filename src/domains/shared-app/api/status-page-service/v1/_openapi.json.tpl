{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition - Status Page",
    "version": "0.0.1"
  },
  "servers": [
    {
      "url": "${host}/shared/status-page-service/v1",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "Health Check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {}
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "403": {
            "description": "Forbidden"
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable",
            "content": {
              "application/json": {}
            }
          }
        }
      },
      "parameters": [
        {
          "name": "product",
          "in": "query",
          "description": "It identifies the product to retrive info about.",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  }
}
