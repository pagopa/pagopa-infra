{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-wallet",
    "version": "1.0",
    "title": "Payment Manager API - wisp",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/wallet",
  "schemes": [
    "https"
  ],
  "paths": {
    "/*": {
      "get": {
        "operationId": "GETstaticResourcesWisp",
        "description": "static resources of Wisp",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "post": {
        "operationId": "POSTstaticResourcesWisp",
        "description": "static resources of Wisp",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "head": {
        "operationId": "HEADstaticResourcesWisp",
        "description": "static resources of Wisp",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "options": {
        "operationId": "OPTstaticResourcesWisp",
        "description": "static resources of Wisp",
        "responses": {
          "200": {
            "description": "static resource"
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
