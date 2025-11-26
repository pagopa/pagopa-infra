{
  "openapi": "3.0.0",
  "info": {
    "title": "Debezium API - GPD",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "${host}"
    }
  ],
  "paths": {
    "/connectors/{connectorId}/status": {
      "get": {
        "tags": [
          "Get Detail on Connector Status"
        ],
        "summary": "getConnectorStatus",
        "parameters": [
          {
            "name": "connectorId",
            "in": "path",
            "schema": {
              "type": "string"
            },
            "required": true,
            "example": "debezium-connector-postgres"
          }
        ],
        "responses": {
          "200": {
            "description": "Successful response",
            "content": {
              "application/json": {}
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {}
            }
          }
        }
      }
    },
    "/connectors/{connectorId}/restart": {
      "post": {
        "tags": [
          "Restart Connector"
        ],
        "summary": "restartConnector",
        "parameters": [
          {
            "name": "connectorId",
            "in": "path",
            "schema": {
              "type": "string"
            },
            "required": true,
            "example": "debezium-connector-postgres"
          }
        ],
        "responses": {
          "204": {
            "description": "Successful response",
            "content": {
              "application/json": {}
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {}
            }
          }
        }
      }
    },
    "/connectors/{connectorId}/tasks/{taskId}/restart": {
      "post": {
        "tags": [
          "Restart Task "
        ],
        "summary": "restartTask",
        "parameters": [
          {
            "name": "connectorId",
            "in": "path",
            "schema": {
              "type": "string"
            },
            "required": true,
            "example": "debezium-connector-postgres"
          },
          {
            "name": "taskId",
            "in": "path",
            "schema": {
              "type": "string"
            },
            "required": true,
            "example": "0"
          }
        ],
        "responses": {
          "204": {
            "description": "Successful response",
            "content": {
              "application/json": {}
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {}
            }
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
