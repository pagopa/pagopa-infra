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
        "summary": "Create / Update / Invalidate a debt position",
        "description": "Create / Update / Invalidate a debt position.",
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
          "200": {
            "description": "create / update / invalidate debt position successfully"
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
                    "invalidInput": {
                      "type": "https://example.com/problem/",
                      "title": "string",
                      "status": 400,
                      "detail": "Formally invalid input"
                    }
                  }
                }
              }
            }
          },
          "404": {
            "description": "Entity not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "examples": {
                  "iupd_not_found": {
                    "value": {
                      "type": "https://example.com/problem/",
                      "title": "Invocation exception",
                      "status": 404,
                      "detail": "Error while invalidate debit position. Debit position not found with {iupd}"
                    }
                  },
                  "pa_fiscal_code_not_found": {
                    "value": {
                      "type": "https://example.com/problem/",
                      "title": "Invocation exception",
                      "status": 404,
                      "detail": "No debt position found with Creditor institution code {creditorInstitutionCode} and {iupd}"
                    }
                  }
                }
              }
            }
          },
          "409": {
            "description": "Conflict into requested action",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "examples": {
                  "create": {
                    "value": {
                      "type": "https://example.com/problem/",
                      "title": "Invocation exception",
                      "status": 409,
                      "detail": "Error while create new debit position conflict into request"
                    }
                  },
                  "update": {
                    "value": {
                      "type": "https://example.com/problem/",
                      "title": "Invocation exception",
                      "status": 409,
                      "detail": "Error while update debit position conflict into request"
                    }
                  },
                  "invalidate": {
                    "value": {
                      "type": "https://example.com/problem/",
                      "title": "Invocation exception",
                      "status": 409,
                      "detail": "Error while invalidate debit position conflict into request"
                    }
                  },
                  "unauthorized_action": {
                    "value": {
                      "type": "https://example.com/problem/",
                      "title": "Unauthorized action",
                      "status": 409,
                      "detail": "Unauthorized action on debt position with iuv {iuv}"
                    }
                  }
                }
              }
            }
          },
          "422": {
            "description": "Can not perform the requested action on debit position",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "value": {
                    "type": "https://example.com/problem/",
                    "title": "Unprocessable request",
                    "status": 422,
                    "detail": "Can not perform the requested action on debit position"
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
          },
          "502": {
            "description": "Bad gateway",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "value": {
                    "type": "https://example.com/problem/",
                    "title": "string",
                    "status": 502,
                    "detail": "Bad gateway, error while execute request"
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
            "type": "string",
            "minLength": 11,
            "maxLength": 11
          },
          "entityType": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "entityFiscalCode": {
            "type": "string",
            "minLength": 2
          },
          "entityFullName": {
            "type": "string",
            "minLength": 1,
            "maxLength": 255
          },
          "iuv": {
            "type": "string",
            "minLength": 1,
            "maxLength": 255
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "description": {
            "type": "string",
            "minLength": 1,
            "maxLength": 255
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
        "maximum": 99999999999
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
