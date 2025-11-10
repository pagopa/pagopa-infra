{
  "openapi": "3.0.0",
  "info": {
    "title": "pagoPA Session Wallet API - MOCK",
    "version": "0.0.1",
    "description": "API to generate Session wallet token pagoPA for App IO - MOCK",
    "termsOfService": "https://pagopa.it/terms/"
  },
  "tags": [
    {
      "name": "sessionWalletToken",
      "description": "Api's to generate Session wallet token pagoPA for App IO - MOCK",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/x/XAAaP",
        "description": "Documentation"
      }
    }
  ],
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/session": {
      "post": {
        "tags": [
          "sessionWalletToken"
        ],
        "summary": "Generate a JWT wallet session for AppIO",
        "description": "Generate a JWT wallet session for AppIO",
        "operationId": "generateSessionWallet",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MockTokenRequest"
              }
            }
          }
        },
        "security": [
          {
            "Authorization": []
          }
        ],
        "responses": {
          "201": {
            "description": "Wallet created successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SessionTokenResponse"
                }
              }
            }
          },
          "400": {
            "description": "Formally invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized: the provided token is not valid or expired.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error serving request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "Gateway error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "504": {
            "description": "Timeout serving request"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "MockTokenRequest": {
        "description": "Request to mock JWT wallet token",
        "type": "object",
        "properties": {
          "userId": {
            "type": "string",
            "description": "Token's userId"
          },
          "expiryInMinutes": {
            "type": "integer",
            "description": "Expiration in minutes for JWT"
          },
          "userEmail": {
            "type": "string",
            "description": "User email"
          },
          "usePDV": {
            "type": "boolean",
            "description": "True to use PDV tokenization, false otherwise"
          }
        }
      },
      "SessionTokenResponse": {
        "description": "Body JWT wallet session token pagoPa_4_AppIO",
        "type": "object",
        "properties": {
          "token": {
            "type": "string",
            "description": "JWT wallet session token pagoPa_4_AppIO or Opaque token for backward compatibility with PM token (transient phase)",
            "example": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJncm91cCI6ImFuZHJvaWQiLCJhdWQiOiJhbmRyb2lkIiwiaXNzIjoiYXBpLnNvY2lhbGRlYWwubmwiLCJtZW1iZXIiOnsibmFtZSI6ImVyaWsifSwiZXhwIjoxNDUyMDgzMjA3LCJpYXQiOjE0NTE5OTY4MDd9.u7ZBa9RB8U4QL8eBk4hmsjg8oFW19AHuen12c8CvLMj0IQUsNqeC-vwNQvAINpgBM0bzDf5cotyrUzf55eXch6mzfKMa-OJXguO-lARp4fc40HaBWbfnEvGe7yEgSESkt6gJNuprG51A6f4AJyNlXG_3u7O4bAMwiPZJc3AAU84_JXC7Vlq1X3FMaLVGmZdxzA4TvYZEiTt_KHoA49UgzeZtNXo3YiDq-GgL1eV8Li01fwy-M--xzbp4cPcY89jkPyYxUIJEoITOULr3zXQwRfYVe6i0P28oyu5ZzAwYCajBb2T98zN7sFJarNmtcxSKNfhCPnMVn3wrpxx4_Kd2Pw"
          }
        }
      },
      "ProblemJson": {
        "description": "Body definition for error responses containing failure details",
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
            "default": "about:blank",
            "example": "https://example.com/problem/constraint-violation"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Application Unavailable"
          },
          "status": {
            "$ref": "#/components/schemas/HttpStatusCode"
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the\nproblem.",
            "example": "There was an error processing the request"
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 502
      }
    },
    "securitySchemes": {
      "Authorization": {
        "type": "http",
        "scheme": "bearer",
        "description": "Wallet token associated to the user"
      }
    }
  }
}
