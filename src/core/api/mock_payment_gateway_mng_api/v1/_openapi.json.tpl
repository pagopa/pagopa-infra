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
    },
    "/bpayweb/change/client": {
      "post": {
        "operationId": "bpayChangeClientPOST",
        "description": "Change client for BPAY",
        "requestBody": {
          "description": "bpayChangeClientRequest",
          "required": true,
          "content": {
            "text/plain": {
              "schema": {
                "type": "string"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Client changed"
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
    "/bpayweb/change/outcome": {
      "post": {
        "operationId": "bpayChangeOutcomePOST",
        "description": "Change Outcome for BPAY",
        "parameters": [
          {
            "in": "query",
            "name": "code",
            "description": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "timeoutMs",
            "description": "timeout Ms",
            "required": false,
            "schema": {
              "type": "integer"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Outcome changed"
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
    "/postepayweb/change/outcome": {
      "post": {
        "operationId": "changeOutcomePostePay",
        "tags": [
          "Payment Manager Controller"
        ],
        "parameters": [
          {
            "in": "query",
            "name": "paymentOutcome",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "timeoutMs",
            "schema": {
              "type": "integer"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    }
  }
}