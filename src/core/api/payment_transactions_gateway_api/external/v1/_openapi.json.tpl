{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition for external payment-transactions-gateway",
    "version": "v0"
  },
  "servers": [
    {
      "url": "${host}/payment-gateway"
    }
  ],
  "paths": {
    "/request-payments/xpay/{requestId}/resume": {
      "get": {
        "summary": "payment request to xPay",
        "tags": [
          "XPay-external"
        ],
        "operationId": "resumeXPayPayment",
        "parameters": [
          {
            "name": "requestId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "esito",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "idOperazione",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "xpayNonce",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "timeStamp",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "mac",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "resumeType",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "302": {
            "description": "OK-FOUND"
          },
          "400": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "Bad Request - mandatory parameters missing"
                }
              }
            }
          },
          "404": {
            "description": "TimeOut",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "RequestId not Found"
                }
              }
            }
          },
          "500": {
            "description": "Internal server Error",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "example": "Error during payment for requestId: xxx "
                }
              }
            }
          }
        }
      }
    },
    "/request-payments/vpos/{requestId}/resume/challenge": {
      "post": {
        "summary": "resume Vpos payment request",
        "tags": [
          "Vpos-external"
        ],
        "parameters": [
          {
            "in": "path",
            "required": true,
            "name": "requestId",
            "description": "Id of the request",
            "example": "41bc2409-5926-4aa9-afcc-797c7054e467",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "header",
            "name": "MDC-Fields",
            "description": "MDC information",
            "example": "97g10t83x7bb0437bbc50sdf58e970gt",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "responses": {
          "302": {
            "description": "FOUND, Redirect to url"
          }
        }
      }
    },
    "/request-payments/vpos/{requestId}/method/notifications": {
      "post": {
        "summary": "API used to notify the end of the method step (invoked inside the iframe)",
        "tags": [
          "Vpos-external"
        ],
        "parameters": [
          {
            "in": "path",
            "required": true,
            "name": "requestId",
            "description": "Id of the request",
            "example": "41bc2409-5926-4aa9-afcc-797c7054e467",
            "schema": {
              "type": "string",
              "format": "uuid"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK, returns html",
            "content": {
              "text/html": {}
            }
          }
        }
      }
    }
  }
}