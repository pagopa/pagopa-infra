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
    "/transactions/organizations/{organizationfiscalcode}/notices/{nav}" : {
      "get" : {
        "tags" : [ "Payment Receipts REST APIs" ],
        "summary" : "Search an event filtering by citizen fiscal code, nav and entity fiscal code",
        "operationId" : "getTransactionSearch",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "The fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "nav",
          "in" : "path",
          "description" : "The identifier of the advice.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        },
          {
            "name" : "X-Fiscal-Code",
            "in" : "header",
            "description" : "The fiscal code of the debtor.",
            "required" : false,
            "schema" : {
              "type" : "string"
            }
          },
          {
            "name" : "X-Request-Id",
            "in" : "header",
            "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
            "required" : false,
            "schema" : {
              "type" : "string"
            }
          } ],
        "responses" : {
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
          "404" : {
            "description" : "Not found the receipt.",
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
          "200" : {
            "description" : "Obtained receipt.",
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
                  "$ref" : "#/components/schemas/TransactionsResponse"
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
      "TransactionsResponse" : {
        "required" : [ "companyName", "creditorReferenceId", "debtor", "description", "fiscalCode", "idChannel", "idPSP", "noticeNumber", "outcome", "paymentAmount", "pspCompanyName", "receiptId", "transferList" ],
        "type" : "object",
        "properties" : {
          "receiptId" : {
            "type" : "string"
          },
          "noticeNumber" : {
            "type" : "string"
          },
          "fiscalCode" : {
            "type" : "string"
          },
          "outcome" : {
            "type" : "string"
          },
          "creditorReferenceId" : {
            "type" : "string"
          },
          "paymentAmount" : {
            "type" : "number"
          },
          "description" : {
            "type" : "string"
          },
          "companyName" : {
            "type" : "string"
          },
          "officeName" : {
            "type" : "string"
          },
          "debtor" : {
            "$ref" : "#/components/schemas/Debtor"
          },
          "transferList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferPA"
            }
          },
          "idPSP" : {
            "type" : "string"
          },
          "pspFiscalCode" : {
            "type" : "string"
          },
          "pspPartitaIVA" : {
            "type" : "string"
          },
          "pspCompanyName" : {
            "type" : "string"
          },
          "idChannel" : {
            "type" : "string"
          },
          "channelDescription" : {
            "type" : "string"
          },
          "payer" : {
            "$ref" : "#/components/schemas/Payer"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "fee" : {
            "type" : "number"
          },
          "primaryCiIncurredFee" : {
            "type" : "number"
          },
          "idBundle" : {
            "type" : "string"
          },
          "idCiBundle" : {
            "type" : "string"
          },
          "paymentDateTime" : {
            "type" : "string",
            "format" : "date"
          },
          "paymentDateTimeFormatted" : {
            "type" : "string",
            "format" : "date-time"
          },
          "applicationDate" : {
            "type" : "string",
            "format" : "date"
          },
          "transferDate" : {
            "type" : "string",
            "format" : "date"
          }
        }
      },
      "Debtor" : {
        "required" : [ "entityUniqueIdentifierType", "entityUniqueIdentifierValue", "fullName" ],
        "type" : "object",
        "properties" : {
          "entityUniqueIdentifierType" : {
            "type" : "string",
            "enum" : [ "F", "G" ]
          },
          "entityUniqueIdentifierValue" : {
            "type" : "string"
          },
          "fullName" : {
            "type" : "string"
          },
          "streetName" : {
            "type" : "string"
          },
          "civicNumber" : {
            "type" : "string"
          },
          "postalCode" : {
            "type" : "string"
          },
          "city" : {
            "type" : "string"
          },
          "stateProvinceRegion" : {
            "type" : "string"
          },
          "country" : {
            "type" : "string"
          },
          "email" : {
            "type" : "string"
          }
        }
      },
      "Payer" : {
        "required" : [ "entityUniqueIdentifierType", "entityUniqueIdentifierValue", "fullName" ],
        "type" : "object",
        "properties" : {
          "entityUniqueIdentifierType" : {
            "type" : "string",
            "enum" : [ "F", "G" ]
          },
          "entityUniqueIdentifierValue" : {
            "type" : "string"
          },
          "fullName" : {
            "type" : "string"
          },
          "streetName" : {
            "type" : "string"
          },
          "civicNumber" : {
            "type" : "string"
          },
          "postalCode" : {
            "type" : "string"
          },
          "city" : {
            "type" : "string"
          },
          "stateProvinceRegion" : {
            "type" : "string"
          },
          "country" : {
            "type" : "string"
          },
          "email" : {
            "type" : "string"
          }
        }
      },
      "TransferPA" : {
        "required" : [ "fiscalCodePA", "iban", "mbdAttachment", "remittanceInformation", "transferAmount", "transferCategory" ],
        "type" : "object",
        "properties" : {
          "idTransfer" : {
            "maximum" : 5,
            "minimum" : 1,
            "type" : "integer",
            "format" : "int32"
          },
          "transferAmount" : {
            "type" : "number"
          },
          "fiscalCodePA" : {
            "type" : "string"
          },
          "iban" : {
            "type" : "string"
          },
          "mbdAttachment" : {
            "type" : "string"
          },
          "remittanceInformation" : {
            "type" : "string"
          },
          "transferCategory" : {
            "type" : "string"
          },
          "metadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/MapEntry"
            }
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
