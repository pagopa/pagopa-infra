{
  "openapi": "3.0.1",
  "info": {
    "description": "Utility microservice for pagoPA AFM",
    "termsOfService": "https://www.pagopa.gov.it/",
    "title": "afm-utils",
    "version": "0.6.1"
  },
  "servers": [
    {
      "description": "Generated server url",
      "url": "${host}"
    }
  ],
  "paths": {
    "/cdis/sync": {
      "delete": {
        "operationId": "syncCDIDeletion",
        "responses": {
          "200": {
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
        "summary": "API to trigger the bulk deletion of the CDIs and its related bundles.",
        "tags": [
          "Delete CDI rest API"
        ]
      },
      "get": {
        "operationId": "syncCDI_1",
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
        "summary": "API to retry the import of the CDIs and convert to bundles.",
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
      ],
      "post": {
        "operationId": "syncCDI",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/CDI"
                }
              }
            }
          },
          "required": true
        },
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
      }
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
    },
    "/psps/{pspCode}/cdis/{idCdi}": {
      "delete": {
        "operationId": "syncBundlesDeletionByIdCDI",
        "parameters": [
          {
            "description": "CDI identifier",
            "in": "path",
            "name": "idCdi",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "description": "PSP code",
            "in": "path",
            "name": "pspCode",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
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
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
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
        "summary": "API to trigger the deletion of the bundles by a CDI id.",
        "tags": [
          "Delete Bundles by id CDI rest API"
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
      "CDI": {
        "type": "object",
        "properties": {
          "abi": {
            "type": "string"
          },
          "cdiErrorDesc": {
            "type": "string"
          },
          "cdiStatus": {
            "type": "string",
            "enum": [
              "NEW",
              "FAILED",
              "PROCESSING"
            ]
          },
          "details": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Detail"
            }
          },
          "digitalStamp": {
            "type": "boolean"
          },
          "id": {
            "type": "string"
          },
          "idCdi": {
            "type": "string"
          },
          "idPsp": {
            "type": "string"
          },
          "pspBusinessName": {
            "type": "string"
          },
          "validityDateFrom": {
            "type": "string"
          }
        }
      },
      "Detail": {
        "type": "object",
        "properties": {
          "channelApp": {
            "type": "boolean"
          },
          "channelCardsCart": {
            "type": "boolean"
          },
          "description": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "paymentType": {
            "type": "string"
          },
          "serviceAmount": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ServiceAmount"
            }
          }
        }
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
      },
      "ServiceAmount": {
        "type": "object",
        "properties": {
          "maxPaymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "minPaymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
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
