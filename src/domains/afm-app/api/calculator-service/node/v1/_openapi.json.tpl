{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API Calculator Logic for Node",
    "description": "Calculator Logic microservice for pagoPA AFM",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "2.4.1-1-main"
  },
  "servers": [
    {
      "url": "${host}",
      "description": "Generated server url"
    }
  ],
  "tags": [
    {
      "name": "Calculator",
      "description": "Everything about Calculator business logic"
    }
  ],
  "paths": {
    "/fees": {
      "post": {
        "tags": [
          "Calculator"
        ],
        "summary": "Get taxpayer fees of all or specified idPSP",
        "operationId": "getFees",
        "parameters": [
          {
            "name": "maxOccurrences",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 10
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PaymentOption"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Ok",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/Transfer"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
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
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AppInfo"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/psps/{idPsp}/fees": {
      "post": {
        "tags": [
          "Calculator"
        ],
        "summary": "Get taxpayer fees of the specified idPSP",
        "operationId": "getFeesByPsp",
        "parameters": [
          {
            "name": "idPsp",
            "in": "path",
            "description": "PSP identifier",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "maxOccurrences",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 10
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PaymentOptionByPsp"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Ok",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/Transfer"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
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
      "PaymentOption": {
        "type": "object",
        "properties": {
          "idPspList": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "paymentMethod": {
            "type": "string"
          },
          "primaryCreditorInstitution": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferListItem"
            }
          }
        },
        "required": [
          "paymentAmount",
          "primaryCreditorInstitution",
          "transferList"
        ]
      },
      "PaymentOptionByPsp": {
        "type": "object",
        "properties": {
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "paymentMethod": {
            "type": "string"
          },
          "primaryCreditorInstitution": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferListItem"
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
      "Transfer": {
        "type": "object",
        "properties": {
          "bundleDescription": {
            "type": "string"
          },
          "bundleName": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "idBundle": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "idCiBundle": {
            "type": "string"
          },
          "idPsp": {
            "type": "string"
          },
          "onUs": {
            "type": "boolean"
          },
          "paymentMethod": {
            "type": "string"
          },
          "primaryCiIncurredFee": {
            "type": "integer",
            "format": "int64"
          },
          "taxPayerFee": {
            "type": "integer",
            "format": "int64"
          },
          "touchpoint": {
            "type": "string"
          }
        }
      },
      "TransferListItem": {
        "type": "object",
        "properties": {
          "creditorInstitution": {
            "type": "string"
          },
          "digitalStamp": {
            "type": "boolean"
          },
          "transferCategory": {
            "type": "string"
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
