{
  "swagger": "2.0",
  "info": {
    "title": "paForNode_Service",
    "description": "",
    "x-ibm-name": "pafornodeservice",
    "version": "1.0.0"
  },
  "host": "${host}",
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
    "/": {
      "post": {
        "summary": "Operation paVerifyPaymentNotice, paGetPayment, paSendRT",
        "description": "To call paVerifyPaymentNotice, paGetPayment, paSendRT. The primitive to invoke is specified in the body request.",
        "operationId": "mockEc",
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
    "/mock-psp": {
      "post": {
        "summary": "Operation pspNotifyPayment",
        "description": "To call pspNotifyPayment. The primitive to invoke is specified in the body request.",
        "operationId": "mockPsp",
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
    "/info": {
      "get": {
        "summary": "health check",
        "description": "health check status",
        "operationId": "info",
        "produces": [
          "text/plain"
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
    "/history/{noticenumber}/{primitive}": {
      "get": {
        "summary": "Operation history Notice Number",
        "description": "To retrieve the history of requests and responses",
        "operationId": "history",
        "parameters": [
          {
            "in": "path",
            "name": "noticenumber",
            "required": true,
            "type": "string"
          },
          {
            "in": "path",
            "name": "primitive",
            "required": true,
            "type": "string"
          }
        ],
        "produces": [
          "application/json"
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
    "/response/{primitive}": {
      "post": {
        "summary": "To configure the mock with response queue",
        "description": "To configure the mock to respond with the body when {primitive} is invoked",
        "operationId": "response",
        "parameters": [
          {
            "in": "path",
            "name": "primitive",
            "required": true,
            "type": "string"
          },
          {
            "in": "query",
            "name": "override",
            "default": "false",
            "description": "To override last response set",
            "type": "boolean"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "produces": [
          "text/plain"
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
