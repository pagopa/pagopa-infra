{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa authService endpoints used by the checkout authenticated payment flow",
    "description": "This microservice that expose authService services to allow authenticaded flow."
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "tags": [
    {
      "name": "authService",
      "description": "Api's used as interface towards the identity provider, it provides Login, Logout, Self information and token validation",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/1443463171/DR+-+Autenticazione+in+Checkout+-+Fase+1",
        "description": "Technical specifications"
      }
    }
  ],
  "paths": {
    "/auth/login": {
      "get": {
        "tags": [
          "authService"
        ],
        "operationId": "authLogin",
        "summary": "Login endpoint",
        "description": "GET login endpoint with reCAPTCHA code",
        "parameters": [
          {
            "in": "header",
            "name": "x-rpt-ids",
            "required": false,
            "description": "Optional RPT ID used to track login attempts to payment notices",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "recaptcha",
            "required": true,
            "description": "reCAPTCHA code",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful login",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/LoginResponse"
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
          "404": {
            "description": "User not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
                }
              }
            }
          }
        }
      }
    },
    "/auth/users": {
      "get": {
        "tags": [
          "authService"
        ],
        "operationId": "authUsers",
        "summary": "Get user information",
        "description": "GET user information",
        "parameters": [
          {
            "in": "header",
            "name": "x-rpt-ids",
            "required": false,
            "description": "Optional RPT ID used to track get user information attempts to payment notices",
            "schema": {
              "type": "string"
            }
          }
        ],
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "responses": {
          "200": {
            "description": "Successful retrieval of user information",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UserInfoResponse"
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
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404": {
            "description": "User not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
                }
              }
            }
          }
        }
      }
    },
    "/auth/logout": {
      "post": {
        "tags": [
          "authService"
        ],
        "operationId": "authLogout",
        "summary": "Logout endpoint",
        "description": "POST logout endpoint",
        "parameters": [
          {
            "in": "header",
            "name": "x-rpt-ids",
            "required": false,
            "description": "Optional RPT ID used to track logout attempts to payment notices",
            "schema": {
              "type": "string"
            }
          }
        ],
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "responses": {
          "204": {
            "description": "Successful logout"
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
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
                }
              }
            }
          }
        }
      }
    },
    "/auth/token": {
      "post": {
        "tags": [
          "authService"
        ],
        "operationId": "authenticateWithAuthToken",
        "summary": "Authentication endpoint",
        "description": "POST authentication endpoint with auth code",
        "parameters": [
          {
            "in": "header",
            "name": "x-rpt-ids",
            "required": false,
            "description": "Optional RPT ID used to track auth token generation attempts to payment notices",
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/AuthRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful authentication",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AuthResponse"
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
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404": {
            "description": "User not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "authentication opaque token",
        "bearerFormat": "opaque token"
      }
    },
    "schemas": {
      "LoginResponse": {
        "type": "object",
        "properties": {
          "urlRedirect": {
            "type": "string",
            "description": "the login redirect URL"
          }
        },
        "required": [
          "urlRedirect"
        ]
      },
      "ProblemJson": {
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
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
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
        "example": 200
      },
      "UserInfoResponse": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "user first name"
          },
          "familyName": {
            "type": "string",
            "description": "user family name"
          }
        },
        "required": [
          "name",
          "familyName"
        ]
      },
      "AuthResponse": {
        "type": "object",
        "properties": {
          "authToken": {
            "type": "string",
            "description": "authorization token"
          }
        },
        "required": [
          "authToken"
        ]
      },
      "AuthRequest": {
        "type": "object",
        "properties": {
          "authCode": {
            "type": "string",
            "description": "OIDC auth code"
          },
          "state": {
            "type": "string",
            "description": "state opaque token, used to correlate auth requests"
          }
        },
        "required": [
          "authCode",
          "state"
        ]
      }
    }
  }
}
