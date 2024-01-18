{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Service",
    "description": "Microservice for exposing REST APIs about payment receipts.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.0.2-4"
  },
  "servers": [
    {
      "url": "http://localhost:8080",
      "description": "Generated server url"
    }
  ],
  "tags": [
    {
      "name": "Actuator",
      "description": "Monitor and interact",
      "externalDocs": {
        "description": "Spring Boot Actuator Web API Documentation",
        "url": "https://docs.spring.io/spring-boot/docs/current/actuator-api/html/"
      }
    }
  ],
  "paths": {
    "/events/organizations/{organization-fiscal-code}/iuvs/{iuv}": {
      "get": {
        "tags": [
          "get BizEvent APIs"
        ],
        "summary": "Retrieve the biz-event given the organization fiscal code and IUV.",
        "operationId": "getBizEventByOrganizationFiscalCodeAndIuv",
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
            "name": "iuv",
            "in": "path",
            "description": "The unique payment identification. Alphanumeric code that uniquely associates and identifies three key elements of a payment: reason, payer, amount",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained biz-event.",
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
                  "$ref": "#/components/schemas/BizEvent"
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
          "404": {
            "description": "Not found the biz-event.",
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
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/events/{biz-event-id}": {
      "get": {
        "tags": [
          "get BizEvent APIs"
        ],
        "summary": "Retrieve the biz-event given its id.",
        "operationId": "getBizEvent",
        "parameters": [
          {
            "name": "biz-event-id",
            "in": "path",
            "description": "The id of the biz-event.",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained biz-event.",
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
                  "$ref": "#/components/schemas/BizEvent"
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
          "404": {
            "description": "Not found the biz-event.",
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
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
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
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AppInfo"
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
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/organizations/{organizationfiscalcode}/receipts/{iur}/paymentoptions/{iuv}": {
      "get": {
        "tags": [
          "Payment Receipts REST APIs"
        ],
        "summary": "The organization get the receipt for the creditor institution.",
        "operationId": "getOrganizationReceipt",
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
          }
        ],
        "responses": {
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
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/transactions": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Recover paged transaction list from Biz Event data.",
        "operationId": "getPagedTransactions",
        "parameters": [
          {
            "name": "start",
            "in": "query",
            "description": "page start offset",
            "required": true,
            "schema": {
              "type": "integer"
            }
          },
          {
            "name": "size",
            "in": "query",
            "description": "page size",
            "required": false,
            "schema": {
              "type": "integer"
            }
          },
          {
            "name": "x-fiscal-code",
            "in": "header",
            "description": "User Fiscal Code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained transaction list.",
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
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/TransactionListItem"
                  }
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
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/transactions/{id}": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Recover paged transaction detail from Biz Event data.",
        "operationId": "getBizEventTransactionDetail",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Id referencing either a single biz-event, or the idTransaction",
            "required": true,
            "schema": {
              "type": "integer"
            }
          },
          {
            "name": "isCart",
            "in": "query",
            "description": "determines if the id comes fromn a single biz-event, or from a group related to the same cart idTransaction",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "x-fiscal-code",
            "in": "header",
            "description": "User Fiscal Code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained transaction list.",
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
                  "$ref": "#/components/schemas/TransactionDetail"
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
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/transactions/{id}/pdf": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Recover or create pdf receipt for the transaction.",
        "operationId": "getBizEventTransactionReceiptPDF",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Id referencing either a single biz-event, or the idTransaction",
            "required": true,
            "schema": {
              "type": "integer"
            }
          },
          {
            "name": "x-fiscal-code",
            "in": "header",
            "description": "User Fiscal Code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained transaction list.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/pdf": {
                "schema": {
                  "$ref": "#/components/schemas/PdfResponse"
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
        "security": [
          {
            "ApiKey": []
          }
        ]
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
    "/transactions/{id}/disable": {
      "patch": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "disable transaction with provided id.",
        "operationId": "disableBizEventTransactionWithId",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Id referencing either a single biz-event, or the idTransaction",
            "required": true,
            "schema": {
              "type": "integer"
            }
          },
          {
            "name": "x-fiscal-code",
            "in": "header",
            "description": "User Fiscal Code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "transaction disabled.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
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
        "security": [
          {
            "ApiKey": []
          }
        ]
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
      },
      "CtReceiptModelResponse": {
        "required": [
          "channelDescription",
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
      },
      "AuthRequest": {
        "type": "object",
        "properties": {
          "authOutcome": {
            "type": "string"
          },
          "guid": {
            "type": "string"
          },
          "correlationId": {
            "type": "string"
          },
          "error": {
            "type": "string"
          },
          "auth_code": {
            "type": "string"
          }
        }
      },
      "BizEvent": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "idPaymentManager": {
            "type": "string"
          },
          "complete": {
            "type": "string"
          },
          "receiptId": {
            "type": "string"
          },
          "missingInfo": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "debtorPosition": {
            "$ref": "#/components/schemas/DebtorPosition"
          },
          "creditor": {
            "$ref": "#/components/schemas/Creditor"
          },
          "psp": {
            "$ref": "#/components/schemas/Psp"
          },
          "debtor": {
            "$ref": "#/components/schemas/Debtor"
          },
          "payer": {
            "$ref": "#/components/schemas/Payer"
          },
          "paymentInfo": {
            "$ref": "#/components/schemas/PaymentInfo"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Transfer"
            }
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          },
          "eventStatus": {
            "type": "string",
            "enum": [
              "NA",
              "RETRY",
              "FAILED",
              "DONE"
            ]
          },
          "eventRetryEnrichmentCount": {
            "type": "integer",
            "format": "int32"
          }
        }
      },
      "Creditor": {
        "type": "object",
        "properties": {
          "idPA": {
            "type": "string"
          },
          "idBrokerPA": {
            "type": "string"
          },
          "idStation": {
            "type": "string"
          },
          "companyName": {
            "type": "string"
          },
          "officeName": {
            "type": "string"
          }
        }
      },
      "DebtorPosition": {
        "type": "object",
        "properties": {
          "modelType": {
            "type": "string"
          },
          "noticeNumber": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          }
        }
      },
      "Details": {
        "type": "object",
        "properties": {
          "blurredNumber": {
            "type": "string"
          },
          "holder": {
            "type": "string"
          },
          "circuit": {
            "type": "string"
          }
        }
      },
      "Info": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string"
          },
          "blurredNumber": {
            "type": "string"
          },
          "holder": {
            "type": "string"
          },
          "expireMonth": {
            "type": "string"
          },
          "expireYear": {
            "type": "string"
          },
          "brand": {
            "type": "string"
          },
          "issuerAbi": {
            "type": "string"
          },
          "issuerName": {
            "type": "string"
          },
          "label": {
            "type": "string"
          }
        }
      },
      "MBD": {
        "type": "object",
        "properties": {
          "IUBD": {
            "type": "string"
          },
          "oraAcquisto": {
            "type": "string"
          },
          "importo": {
            "type": "string"
          },
          "tipoBollo": {
            "type": "string"
          },
          "MBDAttachment": {
            "type": "string"
          }
        }
      },
      "PaymentAuthorizationRequest": {
        "type": "object",
        "properties": {
          "authOutcome": {
            "type": "string"
          },
          "requestId": {
            "type": "string"
          },
          "correlationId": {
            "type": "string"
          },
          "authCode": {
            "type": "string"
          },
          "paymentMethodType": {
            "type": "string"
          },
          "details": {
            "$ref": "#/components/schemas/Details"
          }
        }
      },
      "PaymentInfo": {
        "type": "object",
        "properties": {
          "paymentDateTime": {
            "type": "string"
          },
          "applicationDate": {
            "type": "string"
          },
          "transferDate": {
            "type": "string"
          },
          "dueDate": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          },
          "amount": {
            "type": "string"
          },
          "fee": {
            "type": "string"
          },
          "primaryCiIncurredFee": {
            "type": "string"
          },
          "idBundle": {
            "type": "string"
          },
          "idCiBundle": {
            "type": "string"
          },
          "totalNotice": {
            "type": "string"
          },
          "paymentMethod": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "description": {
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
      "Psp": {
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "psp": {
            "type": "string"
          },
          "pspPartitaIVA": {
            "type": "string"
          },
          "pspFiscalCode": {
            "type": "string"
          },
          "channelDescription": {
            "type": "string"
          }
        }
      },
      "TransactionDetails": {
        "type": "object",
        "properties": {
          "user": {
            "$ref": "#/components/schemas/User"
          },
          "paymentAuthorizationRequest": {
            "$ref": "#/components/schemas/PaymentAuthorizationRequest"
          },
          "wallet": {
            "$ref": "#/components/schemas/WalletItem"
          }
        }
      },
      "Transfer": {
        "type": "object",
        "properties": {
          "idTransfer": {
            "type": "string"
          },
          "fiscalCodePA": {
            "type": "string"
          },
          "companyName": {
            "type": "string"
          },
          "amount": {
            "type": "string"
          },
          "transferCategory": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "metadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/MapEntry"
            }
          },
          "IBAN": {
            "type": "string"
          },
          "MBD": {
            "$ref": "#/components/schemas/MBD"
          }
        }
      },
      "User": {
        "type": "object",
        "properties": {
          "fullName": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "fiscalCode": {
            "type": "string"
          },
          "notificationEmail": {
            "type": "string"
          },
          "userId": {
            "type": "string"
          },
          "userStatus": {
            "type": "string"
          },
          "userStatusDescription": {
            "type": "string"
          }
        }
      },
      "WalletItem": {
        "type": "object",
        "properties": {
          "idWallet": {
            "type": "string"
          },
          "walletType": {
            "type": "string",
            "enum": [
              "CARD",
              "PAYPAL",
              "BANCOMATPAY"
            ]
          },
          "enableableFunctions": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "pagoPa": {
            "type": "boolean"
          },
          "onboardingChannel": {
            "type": "string"
          },
          "favourite": {
            "type": "boolean"
          },
          "createDate": {
            "type": "string"
          },
          "info": {
            "$ref": "#/components/schemas/Info"
          },
          "authRequest": {
            "$ref": "#/components/schemas/AuthRequest"
          }
        }
      },
      "Link": {
        "type": "object",
        "properties": {
          "href": {
            "type": "string"
          },
          "templated": {
            "type": "boolean"
          }
        }
      },
      "TransactionListItem": {
        "required": [
          "transactionId",
          "payeeName",
          "amount",
          "transactionDate",
          "isCart"
        ],
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "contains either the biz-event id, or the transactionDetails.transaction.idTransaction value stored in the biz-event data"
          },
          "payeeName": {
            "type": "string",
             "description": "contains either the company name as payee (Ente Creditore), or a default value (Pagamento Multiplo) if it is a cart based transaction"
          },
          "payeeTaxCode": {
            "type": "string"
            "description": "contains the payee (Ente Creditore) company tax code. null if the biz event does not contain a value"
          },
          "amount": {
            "type": "string"
            "description": "contains the total amount for the transaction (sum of all the same transaction related amounts if a cart based payment)"
          },
          "transactionDate": {
            "type": "string"
            "format": "date-time"
            "description": "contains the transaction date value"
          },
          "isCart": {
            "type": "boolean",
            "description": "boolean that defines if the transaction is from a cart (the transactionId comes from the idTransaction value)"
          }
        }
      },
      "TransactionDetail": {
        "required": [
          "infoTransaction",
          "cartItem"
        ],
        "type": "object",
        "properties": {
          "infoTransaction": {
            "$ref": "#/components/schemas/DetailInfoTransaction"
          },
          "carts": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CartItem"
            }
          }
        }
      },
      "DetailInfoTransaction": {
        "required": [
          "transactionId",
          "amount",
        ],
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "contains either the biz-event id, or the transactionDetails.transaction.idTransaction value stored in the biz-event data"
          },
          "authCode": {
            "type": "string"
          },
          "paymentMethod": {
            "type": "string"
          },
          "rnn": {
            "type": "string"
          },
          "transactionDate": {
            "type": "string",
            "format": "date-time"
          },
          "pspName": {
            "type": "string"
          },
          "walletInfo": {
            "$ref": "#/components/schemas/TransactionDetailWalletInfo"
          },
          "payer": {
            "$ref": "#/components/schemas/TransactionDetailPayer"
          },
          "amount": {
            "type": "string"
          },
          "fee": {
            "type": "string"
          },
          "origin": {
            "type": "string",
            "enum": [
              "INTERNAL",
              "PM",
              "NDP001PROD",
              "NDP002PROD",
              "NDP003PROD"
            ]
          }
        }
      },
      "TransactionDetailWalletInfo": {
        "type": "object",
        "properties": {
          "accountHolder": {
            "type": "string"
          },
          "brand": {
            "type": "string"
          },
          "blurredNumber": {
            "type": "string"
          },
        }
      },
      "TransactionDetailPayer": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "CartItem": {
        "type": "object",
        "properties": {
          "subject": {
            "type": "string"
          },
          "amount": {
            "type": "number"
          },
          "payee": {
            "$ref": "#/components/schemas/TransactionDetailPayee"
          },
          "debtor": {
            "$ref": "#/components/schemas/TransactionDetailDebtor"
          },
          "refNumberValue": {
            "type": "string"
          },
          "refNumberType": {
            "type": "string"
          }
        }
      },
      "TransactionDetailPayee": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "TransactionDetailDebtor": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "taxCode": {
            "type": "string"
          }
        }
      },
      "PdfResponse": {
        "type": "object",
        "properties": {
          "errorId": {
            "type": "integer",
            "format": "int64"
          },
          "httpStatusDescription": {
            "type": "string"
          },
          "httpStatusCode": {},
          "appErrorCode": {},
          "errors": {}
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
