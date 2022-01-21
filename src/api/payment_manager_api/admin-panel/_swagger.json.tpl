{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-admin-panel",
    "version": "1.0",
    "title": "Payment Manager API",
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
        "operationId": "staticResourcesAdminPanel",
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
