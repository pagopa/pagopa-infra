{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Transaction Service",
    "description": "Microservice for exposing REST APIs about payment transaction.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.1.20"
  },
  "servers": [
    {
      "url": "${host}/bizevents/bizevents/tx-service/v1",
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
            "name": "x-fiscal-code",
            "in": "header",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "transaction-id",
            "in": "path",
            "description": "The id of the transaction.",
            "required": true,
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
        "summary": "Retrieve the paged transaction list from biz events.",
        "operationId": "getTransactionList",
        "parameters": [
          {
            "name": "x-fiscal-code",
            "in": "header",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.transaction.TransactionListItem"
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
          }
        },
        "security": [
          {
            "Authorization": []
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
    "/transactions/{transaction-id}": {
      "get": {
        "tags": [
          "IO Transactions REST APIs"
        ],
        "summary": "Retrieve the transaction details given its id.",
        "operationId": "getTransactionDetails",
        "parameters": [
          {
            "name": "x-fiscal-code",
            "in": "header",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "transaction-id",
            "in": "path",
            "description": "The id of the transaction.",
            "required": true,
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.transaction.TransactionDetailResponse"
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.AppInfo"
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
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
      "it.gov.pagopa.bizeventsservice.model.ProblemJson": {
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
      "it.gov.pagopa.bizeventsservice.model.response.transaction.TransactionListItem": {
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
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.view.UserDetail": {
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
      "it.gov.pagopa.bizeventsservice.entity.view.WalletInfo": {
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
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.response.transaction.CartItem": {
        "type": "object",
        "properties": {
          "subject": {
            "type": "string"
          },
          "amount": {
            "type": "string"
          },
          "payee": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.view.UserDetail"
          },
          "debtor": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.view.UserDetail"
          },
          "refNumberValue": {
            "type": "string"
          },
          "refNumberType": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.response.transaction.InfoTransaction": {
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
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.view.WalletInfo"
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
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.view.UserDetail"
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
      "it.gov.pagopa.bizeventsservice.model.response.transaction.TransactionDetailResponse": {
        "type": "object",
        "properties": {
          "infoTransaction": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.transaction.InfoTransaction"
          },
          "carts": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.transaction.CartItem"
            }
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.AppInfo": {
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
        "description": "JWT Wallet sessione token associated to the user.",
        "name": "Authorization",
        "in": "header"
      }
    }
  }
}
