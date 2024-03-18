{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API Calculator Logic",
    "description": "Calculator Logic microservice for pagoPA AFM",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "2.5.7-9-canary"
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
    },
    {
      "name": "Configuration",
      "description": "Utility Services"
    }
  ],
  "paths": {
    "/configuration/bundles/add": {
      "post": {
        "tags": [
          "Configuration"
        ],
        "operationId": "addValidBundles",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/ValidBundle"
                }
              }
            }
          },
          "required": true
        },
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
    "/configuration/bundles/delete": {
      "post": {
        "tags": [
          "Configuration"
        ],
        "operationId": "deleteValidBundles",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/ValidBundle"
                }
              }
            }
          },
          "required": true
        },
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
    "/configuration/paymenttypes/add": {
      "post": {
        "tags": [
          "Configuration"
        ],
        "operationId": "addPaymentTypes",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/PaymentType"
                }
              }
            }
          },
          "required": true
        },
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
    "/configuration/paymenttypes/delete": {
      "post": {
        "tags": [
          "Configuration"
        ],
        "operationId": "deletePaymentTypes",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/PaymentType"
                }
              }
            }
          },
          "required": true
        },
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
    "/configuration/touchpoint/add": {
      "post": {
        "tags": [
          "Configuration"
        ],
        "operationId": "addTouchpoints",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/Touchpoint"
                }
              }
            }
          },
          "required": true
        },
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
    "/configuration/touchpoint/delete": {
      "post": {
        "tags": [
          "Configuration"
        ],
        "operationId": "deleteTouchpoints",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/Touchpoint"
                }
              }
            }
          },
          "required": true
        },
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
      "CiBundle": {
        "type": "object",
        "properties": {
          "attributes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CiBundleAttribute"
            }
          },
          "ciFiscalCode": {
            "type": "string"
          },
          "id": {
            "type": "string"
          }
        },
        "required": [
          "ciFiscalCode",
          "id"
        ]
      },
      "CiBundleAttribute": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "maxPaymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "transferCategory": {
            "type": "string"
          },
          "transferCategoryRelation": {
            "type": "string",
            "enum": [
              "EQUAL",
              "NOT_EQUAL"
            ]
          }
        },
        "required": [
          "id"
        ]
      },
      "PaymentOption": {
        "type": "object",
        "properties": {
          "bin": {
            "type": "string"
          },
          "idPspList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PspSearchCriteria"
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
          "bin": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
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
        }
      },
      "PaymentType": {
        "type": "object",
        "properties": {
          "createdDate": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          }
        },
        "required": [
          "id",
          "name"
        ]
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
      "PspSearchCriteria": {
        "type": "object",
        "properties": {
          "idBrokerPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "idPsp": {
            "type": "string"
          }
        },
        "required": [
          "idPsp"
        ]
      },
      "Touchpoint": {
        "type": "object",
        "properties": {
          "creationDate": {
            "type": "string",
            "format": "date-time"
          },
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          }
        }
      },
      "Transfer": {
        "type": "object",
        "properties": {
          "abi": {
            "type": "string"
          },
          "bundleDescription": {
            "type": "string"
          },
          "bundleName": {
            "type": "string"
          },
          "pspBusinessName": {
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
      },
      "ValidBundle": {
        "type": "object",
        "properties": {
          "abi": {
            "type": "string"
          },
          "ciBundleList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CiBundle"
            }
          },
          "description": {
            "type": "string"
          },
          "digitalStamp": {
            "type": "boolean"
          },
          "digitalStampRestriction": {
            "type": "boolean"
          },
          "id": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "idPsp": {
            "type": "string"
          },
          "maxPaymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "minPaymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "name": {
            "type": "string"
          },
          "onUs": {
            "type": "boolean"
          },
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "paymentType": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "transferCategoryList": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "type": {
            "type": "string",
            "enum": [
              "GLOBAL",
              "PUBLIC",
              "PRIVATE"
            ]
          }
        },
        "required": [
          "digitalStamp",
          "digitalStampRestriction"
        ]
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
