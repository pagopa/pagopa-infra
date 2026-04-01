{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Service - Search payment transactions REST APIs",
    "description": "Microservice for exposing REST APIs about payment receipts.\n### APP ERROR CODES ###\n\n\n<details><summary>Details</summary>\n\n| Code | Group | Domain | Description |\n| ---- | ----- | ------ | ----------- |\n| **BZ_404_001** | *NOT FOUND* | biz event | Biz Event not found with IUR and IUV |\n| **BZ_404_002** | *NOT FOUND* | biz event | Biz Event not found with IUR |\n| **BZ_404_003** | *NOT FOUND* | biz event | Biz Event not found with ID |\n| **BZ_404_004** | *NOT FOUND* | biz event | Biz Event not found with CF and IUV |\n| **BZ_422_001** | *Unprocessable Entity* | biz event | Multiple BizEvents found with IUR and IUV |\n| **BZ_422_002** | *Unprocessable Entity* | biz event | Multiple BizEvents found with CF and IUR |\n| **BZ_422_003** | *Unprocessable Entity* | biz event | Multiple BizEvents found with CF and IUV |\n| **GN_400_001** | *BAD REQUEST* | generic | - |\n| **GN_400_002** | *BAD REQUEST* | generic | Invalid input |\n| **GN_400_003** | *BAD REQUEST* | generic | Invalid CF (Tax Code) |\n| **GN_400_004** | *BAD REQUEST* | generic | Invalid input type |\n| **GN_400_005** | *BAD REQUEST* | generic | Invalid input parameter constraints |\n| **GN_500_001** | *Internal Server Error* | generic | Generic Error |\n| **GN_500_002** | *Internal Server Error* | generic | Generic Error |\n| **GN_500_003** | *Internal Server Error* | generic | Generic Error |\n| **GN_500_004** | *Internal Server Error* | generic | Generic Error |\n| **FG_000_001** | *Variable* | feign client | Error occurred during call to underlying services |\n| **VU_404_001** | *NOT FOUND* | view user | View User not found with CF |\n| **VU_404_002** | *NOT FOUND* | view user | View User not found with CF and filters |\n| **VU_404_003** | *NOT FOUND* | view user | View User not found with ID |\n| **VG_404_001** | *NOT FOUND* | view general | View General not found with ID |\n| **VC_404_001** | *NOT FOUND* | view cart | View Cart not found with ID and CF |\n| **VC_404_002** | *NOT FOUND* | biz event | View Cart not found with CF and NAV |\n| **AT_404_001** | *NOT FOUND* | attachment | Attachment not found |\n| **AT_404_002** | *NOT FOUND* | attachment | Attachment not found because it is currently being generated |\n| **UN_500_000** | *Internal Server Error* | unknown | Unexpected error |\n| **TS_000_000** | *test* | test | used for testing |\n</details>",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.5.4"
  },
  "servers": [
    {
      "url": "https://${host}"
    },
    {
      "url": "https://api.platform.pagopa.it/searchtransactions/v1"
    }
  ],
  "tags": [
    {
      "name": "Search payment transactions REST APIs",
      "description": "Api to handle paid notice details for a debtor"
    }
  ],
  "paths": {
    "/transactions/organizations/{organization-fiscal-code}/notices/{nav}": {
      "get": {
        "tags": [
          "Transactions REST APIs"
        ],
        "summary": "Retrieve the paid notice details given nav, organization-fiscal-code and debtorFiscalCode.",
        "operationId": "getPaidNoticeDetail",
        "parameters": [
          {
            "name": "organization-fiscal-code",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "nav",
            "in": "path",
            "description": "The unique payment identification. Alphanumeric code that uniquely associates and identifies three key elements of a payment: reason, payer, amount",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "x-fiscal-code",
            "in": "header",
            "description": "Fiscal code of the citizen.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "X-Request-Id",
            "in": "header",
            "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained paid notice detail.",
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
                  "$ref": "#/components/schemas/CartItem"
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
            "description": "Wrong or missing function key.",
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
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404": {
            "description": "Not found the transaction.",
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
            "description": "Too many requests.",
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
            "description": "Service unavailable.",
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
        "security" : [ {
          "Authorization" : [ ]
        } ]
      }
    }
  },
  "components": {
    "schemas": {
      "CartItem": {
        "required": [
          "amount",
          "refNumberType",
          "refNumberValue",
          "subject"
        ],
        "type": "object",
        "properties": {
          "subject": {
            "type": "string",
            "description": "The remittance information of the payment notice"
          },
          "amount": {
            "type": "string",
            "description": "The amount in euro. It is a string"
          },
          "payee": {
            "$ref": "#/components/schemas/UserDetail",
            "description": "The payee details"
          },
          "debtor": {
            "$ref": "#/components/schemas/UserDetail",
            "description": "The debtor details"
          },
          "refNumberValue": {
            "type": "string",
            "description": "A reference value for the paid notice"
          },
          "refNumberType": {
            "type": "string",
            "description": "Which field about the payment notice is in the refNumberValue field"
          }
        }
      },
      "UserDetail": {
        "required": [
          "taxCode"
        ],
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "the user name and surname"
          },
          "taxCode": {
            "type": "string",
            "description": "the user tax code"
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
          },
          "code": {
            "type": "string",
            "description": "A machine-readable code specific to this error.",
            "example": "The error code"
          }
        }
      }
    },
    "securitySchemes" : {
      "Authorization" : {
        "type" : "http",
        "description" : "Opaque token associated to the api",
        "scheme" : "bearer"
      }
    }
  }
}
