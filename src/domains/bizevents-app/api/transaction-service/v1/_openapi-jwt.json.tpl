{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Transaction Service JWT",
    "description": "Microservice for exposing REST APIs about payment receipts.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.1.36"
  },
  "servers": [
    {
      "url": "${host}/bizevents/tx-service-jwt/v1",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/transactions/{transaction-id}/disable": {
      "post": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Disable the transaction details given its id.",
        "operationId": "disableTransaction",
        "parameters": [
          {
            "name": "transaction-id",
            "in": "path",
            "description": "The id of the transaction.",
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
          "429": {
            "description": "Too many requests.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {}
            }
          },
          "200": {
            "description": "Disabled Transactions.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {}
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
            "Authorization": []
          }
        ]
      }
    },
    "/transactions": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Retrieve the paged transaction list from biz events.",
        "operationId": "getTransactionList",
        "parameters": [
          {
            "name": "x-continuation-token",
            "in": "header",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "size",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 10
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
          "200": {
            "description": "Obtained transaction list.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "x-continuation-token": {
                "description": "continuation token for paginated query",
                "style": "simple",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TransactionListWrapResponse"
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
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
            "Authorization": []
          }
        ]
      }
    },
    "/transactions/{transaction-id}": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Retrieve the transaction details given its id.",
        "operationId": "getTransactionDetails",
        "parameters": [
          {
            "name": "transaction-id",
            "in": "path",
            "description": "The id of the transaction.",
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
          "200": {
            "description": "Obtained transaction details.",
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
                  "$ref": "#/components/schemas/TransactionDetailResponse"
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
            "Authorization": []
          }
        ]
      }
    },
    "/transactions/{event-id}/pdf": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Retrieve the PDF receipt given event id.",
        "operationId": "getPDFReceipt",
        "parameters": [
          {
            "name": "event-id",
            "in": "path",
            "description": "The id of the event.",
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
            "description": "Unprocessable receipt.",
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
            "description": "Obtained the PDF receipt.",
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
                  "type": "string",
                  "format": "binary"
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
            "Authorization": []
          }
        ]
      }
    },
    "/transactions/cached": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Retrieve the paged transaction list from biz events.",
        "operationId": "getTransactionList_1",
        "parameters": [
          {
            "name": "page",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 0
            }
          },
          {
            "name": "size",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 10
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
                  "$ref": "#/components/schemas/TransactionListWrapResponse"
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
        "security": [
          {
            "Authorization": []
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
        "responses": {
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
            "Authorization": []
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
          }
        }
      },
      "PageInfo": {
        "required": [
          "items_found",
          "limit",
          "page",
          "total_pages"
        ],
        "type": "object",
        "properties": {
          "page": {
            "type": "integer",
            "description": "Page number",
            "format": "int32"
          },
          "limit": {
            "type": "integer",
            "description": "Required number of items per page",
            "format": "int32"
          },
          "items_found": {
            "type": "integer",
            "description": "Number of items found. (The last page may have fewer elements than required)",
            "format": "int32"
          },
          "total_pages": {
            "type": "integer",
            "description": "Total number of pages",
            "format": "int32"
          }
        }
      },
      "TransactionListItem": {
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "payeeName": {
            "type": "string"
          },
          "payeeTaxCode": {
            "type": "string"
          },
          "amount": {
            "type": "string"
          },
          "transactionDate": {
            "type": "string"
          },
          "isCart": {
            "type": "boolean"
          },
          "isPayer": {
            "type": "boolean"
          },
          "isDebtor": {
            "type": "boolean"
          }
        }
      },
      "TransactionListWrapResponse": {
        "type": "object",
        "properties": {
          "transactions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransactionListItem"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
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
            "type": "string"
          },
          "payee": {
            "$ref": "#/components/schemas/UserDetail"
          },
          "debtor": {
            "$ref": "#/components/schemas/UserDetail"
          },
          "refNumberValue": {
            "type": "string"
          },
          "refNumberType": {
            "type": "string"
          }
        }
      },
      "InfoTransactionView": {
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "authCode": {
            "type": "string"
          },
          "rrn": {
            "type": "string"
          },
          "transactionDate": {
            "type": "string"
          },
          "pspName": {
            "type": "string"
          },
          "walletInfo": {
            "$ref": "#/components/schemas/WalletInfo"
          },
          "paymentMethod": {
            "type": "string",
            "enum": [
              "BBT",
              "BP",
              "AD",
              "CP",
              "PO",
              "OBEP",
              "JIF",
              "MYBK",
              "PPAL",
              "UNKNOWN"
            ]
          },
          "payer": {
            "$ref": "#/components/schemas/UserDetail"
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
              "NDP003PROD",
              "UNKNOWN"
            ]
          }
        }
      },
      "TransactionDetailResponse": {
        "type": "object",
        "properties": {
          "infoTransaction": {
            "$ref": "#/components/schemas/InfoTransactionView"
          },
          "carts": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CartItem"
            }
          }
        }
      },
      "UserDetail": {
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
      "WalletInfo": {
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
          "maskedEmail": {
            "type": "string"
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
      "Authorization": {
        "type": "http",
        "scheme": "bearer",
        "description": "JWT token associated to the user"
      }      
    }
  }
}
