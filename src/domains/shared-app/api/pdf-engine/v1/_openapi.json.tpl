{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition - PDF Engine",
    "version": "0.0.1-17"
  },
  "servers": [
    {
      "url": "${host}/shared/pdf-engine/v1",
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
    "/pdf-engine": {
      "post": {
        "tags": [
          "default"
        ],
        "summary": "Create PDF",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "$ref": "#/components/schemas/IuvGenerationModel"
              }
            }
          }
        },
        "parameters": [
          {
            "name": "Content-Type",
            "in": "header",
            "schema": {
              "type": "string"
            },
            "example": "multipart/form-data"
          }
        ],
        "responses": {
          "200": {
            "description": "Successful response",
            "content": {
              "application/pdf": {}
            }
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    }
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
      "PdfEngineResponse": {
        "type": "object",
        "properties": {
          "errorId": {
            "type": "integer",
            "format": "int64"
          },
          "httpStatusDescription": {
            "type": "varchar",
          },
          "httpStatusCode": {},
          "appErrorCode": {},
          errors: {}
        }
      },
      "PdfEngineRequest": {
        "required": [
          "template",
          "data"
        ],
        "type": "object",
        "properties": {
          "template": {
            "type": "string",
            "format": "binary"
          },
          "data": {
            "type": "string",
            "example": "{\n\t\t\"transaction\": {\n\t\t\t\"id\": \"F57E2F8E-25FF-4183-AB7B-4A5EC1A96644\",\n\t\t\t\"timestamp\": \"2020-07-10 15:00:00.000\",\n\t\t\t\"amount\": 300.00,\n\t\t\t\"psp\": {\n\t\t\t\t\"name\": \"Nexi\",\n\t\t\t\t\"fee\": {\n\t\t\t\t\t\"amount\": 2.00\n\t\t\t\t}\n\t\t\t},\n\t\t\t\"rrn\": \"1234567890\",\n\t\t\t\"paymentMethod\": {\n\t\t\t\t\"name\": \"Visa *1234\",\n\t\t\t\t\"logo\": \"https://...\",\n\t\t\t\t\"accountHolder\": \"Marzia Roccaraso\",\n\t\t\t\t\"extraFee\": false\n\t\t\t},\n\t\t\t\"authCode\": \"9999999999\"\n\t\t},\n\t\t\"user\": {\n\t\t\t\"data\": {\n\t\t\t\t\"firstName\": \"Marzia\",\n\t\t\t\t\"lastName\": \"Roccaraso\",\n\t\t\t\t\"taxCode\": \"RCCMRZ88A52C409A\"\n\t\t\t},\n\t\t\t\"email\": \"email@test.it\"\n\t\t},\n\t\t\"cart\": {\n\t\t\t\"items\": [{\n\t\t\t\t\"refNumber\": {\n\t\t\t\t\t\"type\": \"codiceAvviso\",\n\t\t\t\t\t\"value\": \"123456789012345678\"\n\t\t\t\t},\n\t\t\t\t\"debtor\": {\n\t\t\t\t\t\"fullName\": \"Giuseppe Bianchi\",\n\t\t\t\t\t\"taxCode\": \"BNCGSP70A12F205X\"\n\t\t\t\t},\n\t\t\t\t\"payee\": {\n\t\t\t\t\t\"name\": \"Comune di Controguerra\",\n\t\t\t\t\t\"taxCode\": \"82001760675\"\n\t\t\t\t},\n\t\t\t\t\"subject\": \"TARI 2022\",\n\t\t\t\t\"amount\": 150.00\n\t\t\t}],\n\t\t\t\"amountPartial\": 300.00\n\t\t},\n\t\t\"noticeCode\": \"noticeCodeTest\",\n\t\t\"amount\": 100\n\t}"
          }
        }
      }
    }
  }
}
