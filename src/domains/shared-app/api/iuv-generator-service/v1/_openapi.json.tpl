{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition - Iuv Generator ${service}",
    "version": "0.0.1-17"
  },
  "servers": [
    {
      "url": "${host}/shared/iuv-generator-service/v1",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "Health Check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {}
            }
          },
          "401": {
            "description": "Unauthorized",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "403": {
            "description": "Forbidden",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {}
            }
          }
        }
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/organizations/{organizationfiscalcode}/iuv": {
      "post": {
        "tags": [
          "Iuv Generator API"
        ],
        "summary": "Generate a unique IUV.",
        "operationId": "generateIUV",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "The fiscal code of the organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/IuvGenerationModel"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created a valid iuv.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/IuvGenerationModelResponse"
                }
              }
            }
          },
          "400": {
            "description": "Malformed request.",
            "content": {
              "application/json": {}
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {}
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "IuvGenerationModel": {
        "required": [
          "auxDigit",
          "segregationCode"
        ],
        "type": "object",
        "properties": {
          "segregationCode": {
            "type": "integer",
            "format": "int64"
          },
          "auxDigit": {
            "type": "integer",
            "format": "int64"
          }
        }
      },
      "IuvGenerationModelResponse": {
        "type": "object",
        "properties": {
          "iuv": {
            "type": "string"
          }
        }
      }
    }
  }
}
