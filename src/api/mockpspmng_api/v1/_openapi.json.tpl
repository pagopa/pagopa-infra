{
  "openapi": "3.0.1",
  "info": {
    "title": "Pagopa webview PM Mock",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "tags": [
    {
      "name": "paypalmanagement",
      "description": "todo"
    }
  ],
  "paths": {
    "/paypalpsp/management/response": {
      "get": {
        "operationId": "getmanagementresponse",
        "description": "get management",
        "tags": [
          "paypalmanagement"
        ],
        "responses": {
          "200": {
            "description": "json response"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "patch": {
        "tags": [
          "paypalmanagement"
        ],
        "operationId": "patchmanagement",
        "description": "patch management",
        "responses": {
          "200": {
            "description": "json response"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    },
    "/paypalpsp/management/response/{idappio}/{apiid}": {
      "get": {
        "tags": [
          "paypalmanagement"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "idappio",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "path",
            "name": "apiid",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "operationId": "getmanagementwithapiid",
        "description": "GET management with api Id",
        "responses": {
          "200": {
            "description": "json response"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    },
    "/paypalpsp/management/response/{idappio}": {
      "get": {
        "tags": [
          "paypalmanagement"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "idappio",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "operationId": "getmanagement",
        "description": "GET management",
        "responses": {
          "200": {
            "description": "json response"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    },
    "/info": {
      "get": {
        "operationId": "getappinfo",
        "description": "GET Application info",
        "responses": {
          "200": {
            "description": "json response"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    }
  }
}
