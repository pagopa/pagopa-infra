{
  "openapi" : "3.0.1",
  "info" : {
    "title": "Biz-Events Service - Search transactions REST APIs",
    "description": "Microservice for exposing REST APIs about payment transactions search .\n### APP ERROR CODES ###\n\n\n<details><summary>Details</summary>\n\n| Code | Group | Domain | Description |\n| ---- | ----- | ------ | ----------- |\n| **BZ_400_001** | *NOT FOUND* | biz event | Biz Event bad request |\n| **BZ_401_001** | *NOT FOUND* | biz event | Biz Event Unauthorized |\n| **BZ_404_001** | *NOT FOUND* | biz event | Biz Event not found with CF-ORG, NAV and debtor fiscal code |\n| **BZ_429_001** | *NOT FOUND* | biz event | Biz Event Too many request |\n| **BZ_500_001** | *NOT FOUND* | biz event | Biz Event bad gateway |\n|</details>",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.3.5"
  },
  "servers" : [ {
    "url" : "http://localhost:8080"
  }, {
    "url" : "https://api.platform.pagopa.it/bizevents/service/v1"
  } ],
  "paths" : {
    "/transactions/organizations/{organization-fiscal-code}/notices/{nav}" : {
      "get" : {
        "tags" : [ "Payment Receipts REST APIs" ],
        "summary" : "Retrieve the paid notice details given nav, organization-fiscal-code and debtorFiscalCode.",
        "operationId" : "getPaidNoticeDetail",
        "parameters" : [ {
          "name" : "organization-fiscal-code",
          "in" : "path",
          "description" : "The fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "nav",
          "in" : "path",
          "description" : "The unique payment identification. Alphanumeric code that uniquely associates and identifies three key elements of a payment: reason, payer, amount",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "x-fiscal-code",
          "in" : "header",
          "description" : "Fiscal code of the citizen.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "X-Request-Id",
          "in" : "header",
          "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Obtained paid notice detail.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/CartItem"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "404" : {
            "description" : "Not found the transaction.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          },
          "code" : {
            "type" : "string",
            "description" : "A machine-readable code specific to this error.",
            "example" : "The error code"
          }
        }
      },
      "CartItem" : {
        "required" : [ "amount", "refNumberType", "refNumberValue", "subject" ],
        "type" : "object",
        "properties" : {
          "subject" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "string"
          },
          "payee" : {
            "$ref" : "#/components/schemas/UserDetail"
          },
          "debtor" : {
            "$ref" : "#/components/schemas/UserDetail"
          },
          "refNumberValue" : {
            "type" : "string"
          },
          "refNumberType" : {
            "type" : "string"
          }
        }
      },
      "UserDetail" : {
        "required" : [ "taxCode" ],
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string"
          },
          "taxCode" : {
            "type" : "string"
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "type" : "apiKey",
        "description" : "The Azure Subscription Key to access this API.",
        "name" : "Ocp-Apim-Subscription-Key",
        "in" : "header"
      }
    }
  }
}
