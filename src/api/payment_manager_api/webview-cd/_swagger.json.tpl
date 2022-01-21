{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager Webview - pp-restapi-CD",
    "version": "1.0",
    "title": "Payment Manager API",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-restapi-CD",
  "schemes": [
    "https"
  ],
  "paths": {
    "/*": {
      "get": {
        "operationId": "staticResourcesWebview",
        "description": "static resources of Webview",
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
