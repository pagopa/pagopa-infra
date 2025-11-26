{
  "openapi": "3.0.1",
  "info": {
    "title": "Mocker - Core",
    "description": "A generic endpoint that permits to retrieve dynamical mock response for pagoPA platform",
    "version": "1.0"
  },
  "servers": [
    {
      "url": "${host}",
      "description" : "Generated server url"
    }
  ],
  "paths": {
    "/*": {
      "get": {
        "summary": "Retrieve mock response with GET method",
        "operationId": "get",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "post": {
        "summary": "Retrieve mock response with POST method",
        "operationId": "post",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "put": {
        "summary": "Retrieve mock response with PUT method",
        "operationId": "put",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "delete": {
        "summary": "Retrieve mock response with DELETE method",
        "operationId": "del",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "head": {
        "summary": "Retrieve mock response with HEAD method",
        "operationId": "head",
        "responses": {
          "200": {
            "description": ""
          }
        }
      },
      "options": {
        "summary": "Retrieve mock response with OPTIONS method",
        "operationId": "opt",
        "responses": {
          "200": {
            "description": ""
          }
        }
      }
    }
  }
}
