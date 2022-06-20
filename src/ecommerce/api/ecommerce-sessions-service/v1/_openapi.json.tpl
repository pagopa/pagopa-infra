{
  "openapi": "3.0.1",
  "info": {
    "title": "ecommerce pagoPA",
    "description": "RESTful APIs to provide sessions for ecommerce pagoPA",
    "version": "0.0.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/sessions": {
      "post": {
        "summary": "API to create new token",
        "operationId": "postToken",
        "requestBody": {
          "description": "Session Data",
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SessionRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SessionData"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      },
      "get": {
        "summary": "API to retrieve all session tokens",
        "operationId": "getAllTokens",
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "$ref": "#/components/schemas/SessionData"
                  }
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    },
    "/session/{rptId}": {
      "get": {
        "summary": "API retrieve the session token bound to an rptId",
        "operationId": "getToken",
        "parameters": [
          {
            "in": "path",
            "name": "rptId",
            "required": true,
            "schema": {
              "type": "string",
              "minimum": 1
            },
            "description": "The rptId of the transaction"
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SessionData"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    },
    "/session/validate": {
      "post": {
        "summary": "API to validate the session token",
        "operationId": "validateSession",
        "requestBody": {
          "description": "Session Data",
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SessionData"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success"
          },
          "404": {
            "description": "Not valid"
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "SessionRequest": {
        "required": [
          "rptId",
          "email",
          "paymentToken"
        ],
        "type": "object",
        "properties": {
          "rptId": {
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          }
        }
      },
      "SessionData": {
        "required": [
          "rptId",
          "email",
          "paymentToken",
          "sessionToken"
        ],
        "type": "object",
        "properties": {
          "rptId": {
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          },
          "sessionToken": {
            "type": "string"
          }
        }
      },
      "SessionToken": {
        "required": [
          "token"
        ],
        "type": "object",
        "properties": {
          "rptId": {
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          },
          "sessionToken": {
            "type": "string"
          }
        }
      }
    }
  }
}