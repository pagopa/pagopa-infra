{
  "openapi": "3.0.1",
  "info": {
    "title": "GPS Donation service",
    "description": "GPS microservice for donations",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.0.1"
  },
  "servers": [
    {
      "url": "http://127.0.0.1:8080/api/v1"
    }
  ],
  "tags": [
    {
      "name": "Donation",
      "description": "Everything about donations"
    }
  ],
  "paths": {
    "/donations/paymentoptions": {
      "post": {
        "tags": [
          "Donation"
        ],
        "summary": "Calcuates the amount of the spontaneous payment",
        "operationId": "getPaymentOption",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/Input"
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
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Output"
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
    }
  },
  "components": {
    "schemas": {
      "Input": {
        "type": "object",
        "properties": {
          "properties": {
            "$ref": "#/components/schemas/Properties"
          }
        }
      },
      "Properties": {
        "type": "object",
        "properties": {
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "description": {
            "type": "string"
          }
        }
      },
      "Output": {
        "type": "object",
        "properties": {
          "paymentOption": {
            "$ref": "#/components/schemas/PaymentOption"
          }
        }
      },
      "PaymentOption": {
        "type": "array",
        "items": {
          "$ref": "#/components/schemas/PaymentOptionItem"
        }
      },
      "PaymentOptionItem": {
        "type": "object",
        "properties": {
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "description": {
            "type": "string"
          },
          "dueDate": {
            "type": "string",
            "format": "date-time"
          },
          "isPartialPayment": {
            "type": "boolean"
          },
          "retentionDate": {
            "type": "string",
            "format": "date-time"
          },
          "transfer": {
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
          "amount": {
            "type": "integer",
            "format": "int64"
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
      }
    }
  }
}