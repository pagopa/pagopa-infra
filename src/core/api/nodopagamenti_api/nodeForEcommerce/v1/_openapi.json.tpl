{
  "openapi": "3.0.0",
  "info": {
    "description": "Node API to support eCommerce transactions",
    "version": "1.0.0",
    "title": "Node-for-eCommerce ${service}",
    "license": {
      "name": "Apache 2.0",
      "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
    }
  },
  "tags": [
    {
      "name": "eCommerce",
      "description": "Services exposed by eCommerce"
    },
    {
      "name": "Nodo",
      "description": "Services exposed by Nodo dei Pagamenti"
    }
  ],
  "servers": [
    {
      "url": "http://${host}"
    }
  ],
  "paths": {
    "/checkPosition": {
      "post": {
        "tags": [
          "Nodo"
        ],
        "summary": "checkPosition",
        "description": "Allows the eCommerce system to check positions",
        "operationId": "checkPosition",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CheckPosition"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CheckPositionResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "404": {
            "description": "Not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "408": {
            "description": "Request Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "422": {
            "description": "Unprocessable entry",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "CheckPosition": {
        "type": "object",
        "required": [
          "positionslist"
        ],
        "properties": {
          "positionslist": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/listelement"
            },
            "minItems": 1,
            "maxItems": 5
          }
        }
      },
      "listelement": {
        "type": "object",
        "required": [
          "fiscalCode",
          "noticeNumber"
        ],
        "properties": {
          "fiscalCode": {
            "type": "string",
            "pattern": "^[0-9]{11}$"
          },
          "noticeNumber": {
            "type": "string",
            "pattern": "^[0-9]{18}$"
          }
        }
      },
      "Error": {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "string",
            "example": "error message"
          }
        }
      },
      "CheckPositionResponse": {
        "type": "object",
        "required": [
          "esito"
        ],
        "properties": {
          "esito": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          }
        }
      }
    }
  }
}