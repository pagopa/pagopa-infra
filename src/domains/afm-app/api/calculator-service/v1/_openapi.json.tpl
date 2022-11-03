{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API Calculator Logic",
    "description": "Calculator Logic microservice for pagoPA AFM",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.0.5-1-cosmos"
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
      "name": "Actuator",
      "description": "Monitor and interact",
      "externalDocs": {
        "description": "Spring Boot Actuator Web API Documentation",
        "url": "https://docs.spring.io/spring-boot/docs/current/actuator-api/html/"
      }
    }
  ],
  "paths": {
    "/actuator": {
      "get": {
        "tags": [
          "Actuator"
        ],
        "summary": "Actuator root web endpoint",
        "operationId": "links",
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
              "application/vnd.spring-boot.actuator.v3+json": {
                "schema": {
                  "type": "object",
                  "additionalProperties": {
                    "type": "object",
                    "additionalProperties": {
                      "$ref": "#/components/schemas/Link"
                    }
                  }
                }
              },
              "application/vnd.spring-boot.actuator.v2+json": {
                "schema": {
                  "type": "object",
                  "additionalProperties": {
                    "type": "object",
                    "additionalProperties": {
                      "$ref": "#/components/schemas/Link"
                    }
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "object",
                  "additionalProperties": {
                    "type": "object",
                    "additionalProperties": {
                      "$ref": "#/components/schemas/Link"
                    }
                  }
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
    "/actuator/health": {
      "get": {
        "tags": [
          "Actuator"
        ],
        "summary": "Actuator web endpoint 'health'",
        "operationId": "health",
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
              "application/vnd.spring-boot.actuator.v3+json": {
                "schema": {
                  "type": "object"
                }
              },
              "application/vnd.spring-boot.actuator.v2+json": {
                "schema": {
                  "type": "object"
                }
              },
              "application/json": {
                "schema": {
                  "type": "object"
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
    "/actuator/health/**": {
      "get": {
        "tags": [
          "Actuator"
        ],
        "summary": "Actuator web endpoint 'health-path'",
        "operationId": "health-path",
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
              "application/vnd.spring-boot.actuator.v3+json": {
                "schema": {
                  "type": "object"
                }
              },
              "application/vnd.spring-boot.actuator.v2+json": {
                "schema": {
                  "type": "object"
                }
              },
              "application/json": {
                "schema": {
                  "type": "object"
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
    "/actuator/info": {
      "get": {
        "tags": [
          "Actuator"
        ],
        "summary": "Actuator web endpoint 'info'",
        "operationId": "info",
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
              "application/vnd.spring-boot.actuator.v3+json": {
                "schema": {
                  "type": "object"
                }
              },
              "application/vnd.spring-boot.actuator.v2+json": {
                "schema": {
                  "type": "object"
                }
              },
              "application/json": {
                "schema": {
                  "type": "object"
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
      "PaymentOptionByPsp": {
        "type": "object",
        "properties": {
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "primaryCreditorInstitution": {
            "type": "string"
          },
          "paymentMethod": {
            "type": "string",
            "enum": [
              "PaymentMethod.ANY(value=ANY)",
              "PaymentMethod.PPAL(value=PPAL)",
              "PaymentMethod.BPAY(value=BPAY)",
              "PaymentMethod.PAYBP(value=PayBP)",
              "PaymentMethod.BBT(value=BBT)",
              "PaymentMethod.AD(value=AD)",
              "PaymentMethod.CP(value=CP)",
              "PaymentMethod.PO(value=PO)",
              "PaymentMethod.JIF(value=JIF)",
              "PaymentMethod.MYBK(value=MYBK)"
            ]
          },
          "touchpoint": {
            "type": "string",
            "enum": [
              "Touchpoint.ANY(value=ANY)",
              "Touchpoint.IO(value=IO)",
              "Touchpoint.WISP(value=WISP)",
              "Touchpoint.CHECKOUT(value=CHECKOUT)",
              "Touchpoint.PSP(value=PSP)"
            ]
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
        "type": "object",
        "properties": {
          "creditorInstitution": {
            "type": "string"
          },
          "transferCategory": {
            "type": "string"
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
            "type": "string",
            "enum": [
              "PaymentMethod.ANY(value=ANY)",
              "PaymentMethod.PPAL(value=PPAL)",
              "PaymentMethod.BPAY(value=BPAY)",
              "PaymentMethod.PAYBP(value=PayBP)",
              "PaymentMethod.BBT(value=BBT)",
              "PaymentMethod.AD(value=AD)",
              "PaymentMethod.CP(value=CP)",
              "PaymentMethod.PO(value=PO)",
              "PaymentMethod.JIF(value=JIF)",
              "PaymentMethod.MYBK(value=MYBK)"
            ]
          },
          "touchpoint": {
            "type": "string",
            "enum": [
              "Touchpoint.ANY(value=ANY)",
              "Touchpoint.IO(value=IO)",
              "Touchpoint.WISP(value=WISP)",
              "Touchpoint.CHECKOUT(value=CHECKOUT)",
              "Touchpoint.PSP(value=PSP)"
            ]
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
          }
        }
      },
      "PaymentOption": {
        "required": [
          "paymentAmount",
          "primaryCreditorInstitution"
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
          "paymentMethod": {
            "type": "string",
            "enum": [
              "PaymentMethod.ANY(value=ANY)",
              "PaymentMethod.PPAL(value=PPAL)",
              "PaymentMethod.BPAY(value=BPAY)",
              "PaymentMethod.PAYBP(value=PayBP)",
              "PaymentMethod.BBT(value=BBT)",
              "PaymentMethod.AD(value=AD)",
              "PaymentMethod.CP(value=CP)",
              "PaymentMethod.PO(value=PO)",
              "PaymentMethod.JIF(value=JIF)",
              "PaymentMethod.MYBK(value=MYBK)"
            ]
          },
          "touchpoint": {
            "type": "string",
            "enum": [
              "Touchpoint.ANY(value=ANY)",
              "Touchpoint.IO(value=IO)",
              "Touchpoint.WISP(value=WISP)",
              "Touchpoint.CHECKOUT(value=CHECKOUT)",
              "Touchpoint.PSP(value=PSP)"
            ]
          },
          "idPspList": {
            "type": "array",
            "items": {
              "type": "string"
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
      },
      "Link": {
        "type": "object",
        "properties": {
          "href": {
            "type": "string"
          },
          "templated": {
            "type": "boolean"
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
