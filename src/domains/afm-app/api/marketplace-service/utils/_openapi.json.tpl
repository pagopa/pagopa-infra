{
  "openapi": "3.0.1",
  "info": {
    "description": "Utility microservice for pagoPA AFM",
    "termsOfService": "https://www.pagopa.gov.it/",
    "title": "afm-utils",
    "version": "0.4.3"
  },
  "servers": [
    {
      "description": "Generated server url",
      "url": "${host}"
    }
  ],
  "paths": {
    "/cdis/sync": {
      "get": {
        "operationId": "syncCDI",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/BundleResponse"
                  }
                }
              }
            },
            "description": "Obtained bundle list.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ],
        "summary": "API to trigger the import of the CDIs and convert to bundles.",
        "tags": [
          "Import CDI rest API"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/importCDIFunction": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "description": "importCDIFunction function",
        "operationId": "importCDIFunction_POST",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MonoCDIWrapper"
              }
            },
            "text/plain": {
              "schema": {
                "$ref": "#/components/schemas/MonoCDIWrapper"
              }
            }
          }
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/MonoListBundleResponse"
                }
              },
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/MonoListBundleResponse"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "/importCDIFunction/{importCDIFunction}": {
      "get": {
        "description": "importCDIFunction function",
        "operationId": "importCDIFunction_GET",
        "parameters": [
          {
            "in": "path",
            "name": "importCDIFunction",
            "required": true,
            "schema": {
              "$ref": "#/components/schemas/MonoCDIWrapper"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/MonoListBundleResponse"
                }
              },
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/MonoListBundleResponse"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/info": {
      "get": {
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AppInfo"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ],
        "summary": "health check",
        "tags": [
          "Home"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  },
  "components": {
    "schemas": {
      "AppInfo": {
        "type": "object",
        "properties": {
          "environment": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string"
          }
        }
      },
      "BundleResponse": {
        "type": "object",
        "properties": {
          "idBundle": {
            "type": "string"
          }
        }
      },
      "MonoCDIWrapper": {
        "type": "object"
      },
      "MonoListBundleResponse": {
        "type": "object"
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "There was an error processing the request"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 200
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "description": "The API key to access this function app.",
        "in": "header",
        "name": "Ocp-Apim-Subscription-Key",
        "type": "apiKey"
      }
    }
  }
}
