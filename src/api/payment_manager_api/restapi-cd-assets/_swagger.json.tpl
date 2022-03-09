{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-restapi-cd static resources",
    "version": "1.0",
    "title": "Payment Manager API - pp-restapi-cd static resources",
  },
  "host": "${host}",
  "basePath": "/pp-restapi-CD/assets",
  "schemes": [
    "https"
  ],
  "paths": {
    "/*": {
      "get": {
        "operationId": "GETstaticResourcesStaticAssets",
        "description": "static resources of static assets",
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
