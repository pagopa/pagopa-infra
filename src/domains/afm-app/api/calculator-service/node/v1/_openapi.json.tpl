{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API Calculator Logic - API AFM-Calculator for node v1",
    "description": "Calculator Logic microservice for pagoPA AFM",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "2.11.21"
  },
  "servers": [
    {
      "url": "http://localhost:8080"
    },
    {
      "url": "https://{host}{basePath}",
      "variables": {
        "host": {
          "default": "api.dev.platform.pagopa.it",
          "enum": [
            "api.dev.platform.pagopa.it",
            "api.uat.platform.pagopa.it",
            "api.platform.pagopa.it"
          ]
        },
        "basePath": {
          "default": "afm/node/calculator-service",
          "enum": [
            "afm/node/calculator-service"
          ]
        }
      }
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
          },
          {
            "name": "allCcp",
            "in": "query",
            "description": "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
            "required": false,
            "schema": {
              "type": "string",
              "default": "true"
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
                  "$ref": "#/components/schemas/BundleOption"
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
          "404": {
            "description": "Not Found",
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
          "422": {
            "description": "Unable to process the request",
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
          },
          {
            "name": "allCcp",
            "in": "query",
            "description": "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
            "required": false,
            "schema": {
              "type": "string",
              "default": "true"
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
                  "$ref": "#/components/schemas/BundleOption"
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
          "404": {
            "description": "Not Found",
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
          "422": {
            "description": "Unable to process the request",
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
      "PaymentOptionByPsp": {
        "type": "object",
        "properties": {
          "idChannel": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "primaryCreditorInstitution": {
            "type": "string"
          },
          "paymentMethod": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "bin": {
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
      "TransferListItem": {
        "required": [
          "creditorInstitution"
        ],
        "type": "object",
        "properties": {
          "creditorInstitution": {
            "type": "string"
          },
          "transferCategory": {
            "type": "string"
          },
          "digitalStamp": {
            "type": "boolean"
          }
        }
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 200
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "There was an error processing the request"
          }
        }
      },
      "BundleOption": {
        "type": "object",
        "properties": {
          "belowThreshold": {
            "type": "boolean",
            "description": "if true (the payment amount is lower than the threshold value) the bundles onus is not calculated (always false)"
          },
          "bundleOptions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Transfer"
            }
          }
        }
      },
      "Transfer": {
        "type": "object",
        "properties": {
          "taxPayerFee": {
            "type": "integer",
            "format": "int64"
          },
          "primaryCiIncurredFee": {
            "type": "integer",
            "format": "int64"
          },
          "paymentMethod": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "idBundle": {
            "type": "string"
          },
          "bundleName": {
            "type": "string"
          },
          "bundleDescription": {
            "type": "string"
          },
          "idCiBundle": {
            "type": "string"
          },
          "idPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "onUs": {
            "type": "boolean"
          },
          "abi": {
            "type": "string"
          },
          "pspBusinessName": {
            "type": "string"
          }
        }
      },
      "PaymentOption": {
        "required": [
          "paymentAmount",
          "primaryCreditorInstitution",
          "transferList"
        ],
        "type": "object",
        "properties": {
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "primaryCreditorInstitution": {
            "type": "string"
          },
          "bin": {
            "type": "string"
          },
          "paymentMethod": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "idPspList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PspSearchCriteria"
            }
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferListItem"
            }
          }
        }
      },
      "PspSearchCriteria": {
        "required": [
          "idPsp"
        ],
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          }
        }
      },
      "AppInfo": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "environment": {
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