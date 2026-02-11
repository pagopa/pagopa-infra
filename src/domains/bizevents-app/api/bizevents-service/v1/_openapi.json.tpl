{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Service - Payment Receipts REST APIs",
    "description": "Microservice for exposing REST APIs about payment receipts.\n### APP ERROR CODES ###\n\n\n<details><summary>Details</summary>\n\n| Code | Group | Domain | Description |\n| ---- | ----- | ------ | ----------- |\n| **BZ_404_001** | *NOT FOUND* | biz event | Biz Event not found with IUR and IUV |\n| **BZ_404_002** | *NOT FOUND* | biz event | Biz Event not found with IUR |\n| **BZ_404_003** | *NOT FOUND* | biz event | Biz Event not found with ID |\n| **BZ_404_004** | *NOT FOUND* | biz event | Biz Event not found with CF and IUV |\n| **BZ_422_001** | *Unprocessable Entity* | biz event | Multiple BizEvents found with IUR and IUV |\n| **BZ_422_002** | *Unprocessable Entity* | biz event | Multiple BizEvents found with CF and IUR |\n| **BZ_422_003** | *Unprocessable Entity* | biz event | Multiple BizEvents found with CF and IUV |\n| **GN_400_001** | *BAD REQUEST* | generic | - |\n| **GN_400_002** | *BAD REQUEST* | generic | Invalid input |\n| **GN_400_003** | *BAD REQUEST* | generic | Invalid CF (Tax Code) |\n| **GN_400_004** | *BAD REQUEST* | generic | Invalid input type |\n| **GN_400_005** | *BAD REQUEST* | generic | Invalid input parameter constraints |\n| **GN_500_001** | *Internal Server Error* | generic | Generic Error |\n| **GN_500_002** | *Internal Server Error* | generic | Generic Error |\n| **GN_500_003** | *Internal Server Error* | generic | Generic Error |\n| **GN_500_004** | *Internal Server Error* | generic | Generic Error |\n| **FG_000_001** | *Variable* | feign client | Error occurred during call to underlying services |\n| **VU_404_001** | *NOT FOUND* | view user | View User not found with CF |\n| **VU_404_002** | *NOT FOUND* | view user | View User not found with CF and filters |\n| **VU_404_003** | *NOT FOUND* | view user | View User not found with ID |\n| **VG_404_001** | *NOT FOUND* | view general | View General not found with ID |\n| **VC_404_001** | *NOT FOUND* | view cart | View Cart not found with ID and CF |\n| **AT_404_001** | *NOT FOUND* | attachment | Attachment not found |\n| **AT_404_002** | *NOT FOUND* | attachment | Attachment not found because it is currently being generated |\n| **UN_500_000** | *Internal Server Error* | unknown | Unexpected error |\n| **TS_000_000** | *test* | test | used for testing |\n</details>",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.3.5"
  },
  "servers": [
    {
      "url": "http://localhost:8080"
    },
    {
      "url": "https://api.platform.pagopa.it/bizevents/service/v1"
    }
  ],
  "paths": {
    "/organizations/{organizationfiscalcode}/receipts/{iur}": {
      "get": {
        "tags": [
          "Payment Receipts REST APIs"
        ],
        "summary": "The organization get the receipt for the creditor institution using IUR.",
        "operationId": "getOrganizationReceiptIur",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "iur",
            "in": "path",
            "description": "The unique reference of the operation assigned to the payment (Payment Token).",
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
          "422": {
            "description": "Unable to process the request.",
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
          "200": {
            "description": "Obtained receipt.",
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
                  "$ref": "#/components/schemas/CtReceiptModelResponse"
                }
              }
            }
          },
          "404": {
            "description": "Not found the receipt.",
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
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/organizations/{organizationfiscalcode}/receipts/{iur}/paymentoptions/{iuv}": {
      "get": {
        "tags": [
          "Payment Receipts REST APIs"
        ],
        "summary": "The organization get the receipt for the creditor institution using IUV and IUR.",
        "operationId": "getOrganizationReceiptIuvIur",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "iur",
            "in": "path",
            "description": "The unique reference of the operation assigned to the payment (Payment Token).",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "iuv",
            "in": "path",
            "description": "The unique payment identification. Alphanumeric code that uniquely associates and identifies three key elements of a payment: reason, payer, amount",
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
          "422": {
            "description": "Unable to process the request.",
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
          "200": {
            "description": "Obtained receipt.",
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
                  "$ref": "#/components/schemas/CtReceiptModelResponse"
                }
              }
            }
          },
          "404": {
            "description": "Not found the receipt.",
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
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "parameters": [
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
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    }
  },
  "components": {
    "schemas": {
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
      },
      "CtReceiptModelResponse": {
        "required": [
          "companyName",
          "creditorReferenceId",
          "debtor",
          "description",
          "fiscalCode",
          "idChannel",
          "idPSP",
          "noticeNumber",
          "outcome",
          "paymentAmount",
          "pspCompanyName",
          "receiptId",
          "transferList"
        ],
        "type": "object",
        "properties": {
          "receiptId": {
            "type": "string"
          },
          "noticeNumber": {
            "type": "string"
          },
          "fiscalCode": {
            "type": "string"
          },
          "outcome": {
            "type": "string"
          },
          "creditorReferenceId": {
            "type": "string"
          },
          "paymentAmount": {
            "type": "number"
          },
          "description": {
            "type": "string"
          },
          "companyName": {
            "type": "string"
          },
          "officeName": {
            "type": "string"
          },
          "debtor": {
            "$ref": "#/components/schemas/Debtor"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferPA"
            }
          },
          "idPSP": {
            "type": "string"
          },
          "pspFiscalCode": {
            "type": "string"
          },
          "pspPartitaIVA": {
            "type": "string"
          },
          "pspCompanyName": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "channelDescription": {
            "type": "string"
          },
          "payer": {
            "$ref": "#/components/schemas/Payer"
          },
          "paymentMethod": {
            "type": "string"
          },
          "fee": {
            "type": "number"
          },
          "primaryCiIncurredFee": {
            "type": "number"
          },
          "idBundle": {
            "type": "string"
          },
          "idCiBundle": {
            "type": "string"
          },
          "paymentDateTime": {
            "type": "string",
            "format": "date"
          },
          "paymentDateTimeFormatted": {
            "type": "string",
            "format": "date-time"
          },
          "applicationDate": {
            "type": "string",
            "format": "date"
          },
          "transferDate": {
            "type": "string",
            "format": "date"
          },
          "metadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/MapEntry"
            }
          }
        }
      },
      "Debtor": {
        "required": [
          "entityUniqueIdentifierType",
          "entityUniqueIdentifierValue",
          "fullName"
        ],
        "type": "object",
        "properties": {
          "entityUniqueIdentifierType": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "entityUniqueIdentifierValue": {
            "type": "string"
          },
          "fullName": {
            "type": "string"
          },
          "streetName": {
            "type": "string"
          },
          "civicNumber": {
            "type": "string"
          },
          "postalCode": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "stateProvinceRegion": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "email": {
            "type": "string"
          }
        }
      },
      "MapEntry": {
        "type": "object",
        "properties": {
          "key": {
            "type": "string"
          },
          "value": {
            "type": "string"
          }
        }
      },
      "Payer": {
        "required": [
          "entityUniqueIdentifierType",
          "entityUniqueIdentifierValue",
          "fullName"
        ],
        "type": "object",
        "properties": {
          "entityUniqueIdentifierType": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "entityUniqueIdentifierValue": {
            "type": "string"
          },
          "fullName": {
            "type": "string"
          },
          "streetName": {
            "type": "string"
          },
          "civicNumber": {
            "type": "string"
          },
          "postalCode": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "stateProvinceRegion": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "email": {
            "type": "string"
          }
        }
      },
      "TransferPA": {
        "required": [
          "fiscalCodePA",
          "iban",
          "mbdAttachment",
          "remittanceInformation",
          "transferAmount",
          "transferCategory"
        ],
        "type": "object",
        "properties": {
          "idTransfer": {
            "maximum": 5,
            "minimum": 1,
            "type": "integer",
            "format": "int32"
          },
          "transferAmount": {
            "type": "number"
          },
          "fiscalCodePA": {
            "type": "string"
          },
          "iban": {
            "type": "string"
          },
          "mbdAttachment": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "transferCategory": {
            "type": "string"
          },
          "metadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/MapEntry"
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
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The Azure Subscription Key to access this API.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
