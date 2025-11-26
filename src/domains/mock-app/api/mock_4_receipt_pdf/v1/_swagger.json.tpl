{
  "swagger": "2.0",
  "info": {
    "title": "Mock IO api for Receipt PDF integration",
    "description": "Mock IO api for Receipt PDF integration",
    "x-ibm-name": "test",
    "version": "1.0.0"
  },
  "host": "api.platform.pagopa.it",
  "schemes": [
    "https"
  ],
  "produces": [
    "application/xml"
  ],
  "consumes": [
    "text/xml"
  ],
  "paths": {
    "/profiles": {
      "post": {
        "summary": "profiles",
        "description": "profiles",
        "operationId": "profiles",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "",
            "schema": {
              "type": "string"
            }
          }
        }
      }
    },
    "/messages": {
      "post": {
        "summary": "messages",
        "description": "messages",
        "operationId": "messages",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "",
            "schema": {
              "type": "string"
            }
          }
        }
      }
    }
  }
}
