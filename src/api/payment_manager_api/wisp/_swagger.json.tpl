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
        "operationId": "staticResourcesWisp",
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
