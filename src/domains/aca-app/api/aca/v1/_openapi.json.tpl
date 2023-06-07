{
  "openapi": "3.0.3",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa ACA",
    "description": "pagoPA ACA microservice pagoPA ACA microservice contains the api to allow the creation of a new debt position.",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/PPR/pages/649265163/ACA+-+Dati+in+input+API",
    "description": "Technical specifications"
  },
  "servers": [
    {
      "url": "https://${hostname}/pagopa-aca-service"
    }
  ],
  "tags": [
    {
      "name": "ACA",
      "description": "Api's for performing a debt position census",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/PPR/pages/649265163/ACA+-+Dati+in+input+API",
        "description": "Technical specifications"
      }
    }
  ],
  "paths": {
    "/paCreatePosition": {
      "post": {
        "tags": [
          "ACA"
        ],
        "operationId": "newDebtPosition",
        "summary": "Create a new debt position",
        "description": "Create a new debt position.",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NewDebtPositionRequest"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "New debt position successfully created"
          },
          "400": {
            "description": "Formally invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "value": {
                    "type": "https://example.com/problem/",
                    "title": "string",
                    "status": 400,
                    "detail": "Formally invalid input"
                  }
                }
              }
            }
          },
          "404": {
            "description": "PA or IBAN not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "value": {
                    "type": "https://example.com/problem/",
                    "title": "string",
                    "status": 404,
                    "detail": "PA or IBAN not found"
                  }
                }
              }
            }
          },
          "409": {
            "description": "Conflict during the debt position census",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "value": {
                    "type": "https://example.com/problem/",
                    "title": "string",
                    "status": 409,
                    "detail": "Conflict during the debt position census"
                  }
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "value": {
                    "type": "https://example.com/problem/",
                    "title": "string",
                    "status": 500,
                    "detail": "Internal server error"
                  }
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
      "NewDebtPositionRequest": {
        "type": "object",
        "required": [
          "paFiscalCode",
          "entityType",
          "entityFiscalCode",
          "entityFullName",
          "iuv",
          "amount",
          "description",
          "expirationDate"
        ],
        "description": "Request body for creating a new transaction",
        "properties": {
          "paFiscalCode": {
            "type": "string"
          },
          "entityType": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "entityFiscalCode": {
            "type": "string"
          },
          "entityFullName": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "description": {
            "type": "string"
          },
          "expirationDate": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
            "default": "about:blank",
            "example": "https://example.com/problem/"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "status": {
            "type": "integer",
            "format": "int32",
            "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
            "minimum": 100,
            "maximum": 600,
            "exclusiveMaximum": true,
            "example": 400
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the\nproblem."
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
          }
        }
      }
    }
  }
}
