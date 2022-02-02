{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-admin-panel",
    "version": "1.0",
    "title": "Payment Manager API - pp-admin-panel",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-admin-panel",
  "schemes": [
    "https"
  ],
  "paths": {
    "/*": {
      "get": {
        "operationId": "GETstaticResourcesAdminPanel",
        "description": "static resources of Admin Panel",
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
        "operationId": "POSTstaticResourcesAdminPanel",
        "description": "static resources of Admin Panel",
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
        "operationId": "HEADstaticResourcesAdminPanel",
        "description": "static resources of Admin Panel",
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
        "operationId": "OPTstaticResourcesAdminPanel",
        "description": "static resources of Admin Panel",
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
