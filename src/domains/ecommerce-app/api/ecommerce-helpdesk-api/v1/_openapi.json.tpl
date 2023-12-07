{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa eCommerce helpdesk service api",
    "description": "This microservice that expose eCommerce services for assistance api."
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "PM",
      "description": "Api's for performing transaction search on PM DB",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/PPA/pages/417106103/Design+Review+L+S+PM",
        "description": "Technical specifications"
      }
    },
    {
      "name": "eCommerce",
      "description": "Api's for performing transaction search on ecommerce DB",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
        "description": "Technical specifications"
      }
    },
    {
      "name": "helpDesk",
      "description": "Api's for performing transaction search on both PM and ecommerce DB",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
        "description": "Technical specifications"
      }
    },
    {
      "name": "helpDesk-pgs",
      "description": "Api's for performing authorization search on PGS",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
        "description": "Technical specifications"
      }
    }
  ],
  "paths": {
    "/pm/searchTransaction": {
      "post": {
        "parameters": [
          {
            "in": "query",
            "name": "pageNumber",
            "schema": {
              "type": "integer",
              "default": 0
            },
            "required": true,
            "description": "Searched page number, starting from 0"
          },
          {
            "in": "query",
            "name": "pageSize",
            "schema": {
              "type": "integer",
              "minimum": 1,
              "maximum": 20,
              "default": 10
            },
            "required": true,
            "description": "Max element per page"
          }
        ],
        "tags": [
          "PM"
        ],
        "operationId": "pmSearchTransaction",
        "summary": "PM search transaction by input parameters",
        "description": "GET with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/PmSearchTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchTransactionResponse"
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
            "description": "Transaction not found",
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
    "/ecommerce/searchTransaction": {
      "post": {
        "parameters": [
          {
            "in": "query",
            "name": "pageNumber",
            "schema": {
              "type": "integer",
              "default": 0
            },
            "required": true,
            "description": "Searched page number, starting from 0"
          },
          {
            "in": "query",
            "name": "pageSize",
            "schema": {
              "type": "integer",
              "minimum": 1,
              "maximum": 20,
              "default": 10
            },
            "required": true,
            "description": "Max element per page"
          }
        ],
        "tags": [
          "eCommerce"
        ],
        "operationId": "ecommerceSearchTransaction",
        "summary": "Ecommerce search transaction by input parameters",
        "description": "GET with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/EcommerceSearchTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchTransactionResponse"
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
            "description": "Transaction not found",
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
    "/helpdesk/searchTransaction": {
      "post": {
        "parameters": [
          {
            "in": "query",
            "name": "pageNumber",
            "schema": {
              "type": "integer",
              "default": 0
            },
            "required": true,
            "description": "Searched page number, starting from 0"
          },
          {
            "in": "query",
            "name": "pageSize",
            "schema": {
              "type": "integer",
              "minimum": 1,
              "maximum": 20,
              "default": 10
            },
            "required": true,
            "description": "Max element per page"
          }
        ],
        "tags": [
          "helpDesk"
        ],
        "operationId": "helpDeskSearchTransaction",
        "summary": "Technical helpdesk search transaction by input parameters",
        "description": "GET with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/SearchTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchTransactionResponse"
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
            "description": "Transaction not found",
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
    "/ecommerce/searchDeadLetterEvents": {
      "post": {
        "parameters": [
          {
            "in": "query",
            "name": "pageNumber",
            "schema": {
              "type": "integer",
              "default": 0
            },
            "required": true,
            "description": "Searched page number, starting from 0"
          },
          {
            "in": "query",
            "name": "pageSize",
            "schema": {
              "type": "integer",
              "minimum": 1,
              "maximum": 20,
              "default": 10
            },
            "required": true,
            "description": "Max element per page"
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/SearchDeadLetterEventRequest"
        },
        "tags": [
          "eCommerce"
        ],
        "operationId": "ecommerceSearchDeadLetterEvents",
        "summary": "Search dead letter by input parameters",
        "description": "GET with body payload - no resources created",
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchDeadLetterEventResponse"
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
            "description": "Transaction not found",
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
    "/pgs/vpos/authorizations/{id}": {
      "get": {
        "parameters": [
          {
            "in": "path",
            "name": "id",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "PGS authorization ID"
          }
        ],
        "tags": [
          "helpDesk-pgs"
        ],
        "operationId": "pgsGetVposAuthorization",
        "summary": "PGS search Vpos authorization by ID",
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchPgsStatusResponse"
                }
              }
            }
          },
          "404": {
            "description": "Authorization not found",
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
    "/pgs/xpay/authorizations/{id}": {
      "get": {
        "parameters": [
          {
            "in": "path",
            "name": "id",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "PGS authorization ID"
          }
        ],
        "tags": [
          "helpDesk-pgs"
        ],
        "operationId": "pgsGetXpayAuthorization",
        "summary": "PGS search Xpay authorization by ID",
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchPgsStatusResponse"
                }
              }
            }
          },
          "404": {
            "description": "Authorization not found",
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
    "schemas": {
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
      "SearchTransactionRequestFiscalCode": {
        "type": "object",
        "description": "Search transaction by user fiscal code",
        "properties": {
          "type": {
            "type": "string"
          },
          "userFiscalCode": {
            "type": "string",
            "minLength": 16,
            "maxLength": 16
          }
        },
        "required": [
          "type",
          "userFiscalCode"
        ],
        "example": {
          "type": "USER_FISCAL_CODE",
          "userFiscalCode": "MRGHRN97L02C469W"
        }
      },
      "SearchTransactionRequestEmail": {
        "type": "object",
        "description": "Search transaction by user fiscal code",
        "properties": {
          "type": {
            "type": "string"
          },
          "userEmail": {
            "type": "string",
            "pattern": "(?:[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
          }
        },
        "required": [
          "type",
          "userEmail"
        ],
        "example": {
          "type": "USER_EMAIL",
          "userEmail": "mario.rossi@pagopa.it"
        }
      },
      "SearchTransactionResponse": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "transactions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransactionResult"
            }
          },
          "page": {
            "$ref": "#/components/schemas/PageInfo"
          }
        },
        "required": [
          "transactions",
          "page"
        ]
      },
      "SearchTransactionRequestRptId": {
        "type": "object",
        "description": "Search transaction by user fiscal code",
        "properties": {
          "type": {
            "type": "string"
          },
          "rptId": {
            "type": "string",
            "pattern": "^([0-9]{29})$"
          }
        },
        "required": [
          "type",
          "rptId"
        ],
        "example": {
          "type": "RPT_ID",
          "rptId": "77777777777302011111111111111"
        }
      },
      "SearchTransactionRequestPaymentToken": {
        "type": "object",
        "description": "Search transaction by payment token",
        "properties": {
          "type": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          }
        },
        "required": [
          "type",
          "paymentToken"
        ],
        "example": {
          "type": "PAYMENT_TOKEN",
          "paymentToken": "paymentToken"
        }
      },
      "SearchTransactionRequestTransactionId": {
        "type": "object",
        "description": "Search transaction by transaction id",
        "properties": {
          "type": {
            "type": "string"
          },
          "transactionId": {
            "type": "string",
            "minLength": 32,
            "maxLength": 32
          }
        },
        "required": [
          "type",
          "transactionId"
        ],
        "example": {
          "type": "TRANSACTION_ID",
          "transactionId": "c9644451389e47b0a7d8e9d488fcd502"
        }
      },
      "TransactionResult": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "userInfo": {
            "$ref": "#/components/schemas/UserInfo"
          },
          "transactionInfo": {
            "$ref": "#/components/schemas/TransactionInfo"
          },
          "paymentInfo": {
            "$ref": "#/components/schemas/PaymentInfo"
          },
          "pspInfo": {
            "$ref": "#/components/schemas/PspInfo"
          },
          "product": {
            "$ref": "#/components/schemas/Product"
          }
        },
        "required": [
          "userInfo",
          "transactionInfo",
          "paymentInfo",
          "pspInfo",
          "product"
        ]
      },
      "UserInfo": {
        "type": "object",
        "description": "User information",
        "properties": {
          "userFiscalCode": {
            "type": "string",
            "minLength": 16,
            "maxLength": 16
          },
          "notificationEmail": {
            "type": "string",
            "pattern": "(?:[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
          },
          "surname": {
            "type": "string",
            "maxLength": 512
          },
          "name": {
            "type": "string",
            "maxLength": 512
          },
          "username": {
            "type": "string",
            "maxLength": 128
          },
          "authenticationType": {
            "type": "string"
          }
        },
        "example": {
          "userFiscalCode": "user_fiscal_code",
          "notificationEmail": "test@test.it",
          "surname": "Surname",
          "name": "Name",
          "username": "username",
          "authenticationType": "auth type"
        }
      },
      "TransactionInfo": {
        "type": "object",
        "description": "Transaction info",
        "properties": {
          "creationDate": {
            "type": "string",
            "format": "date-time",
            "description": "transaction creation date"
          },
          "status": {
            "type": "string"
          },
          "statusDetails": {
            "type": "string"
          },
          "eventStatus": {
            "$ref": "https://raw.githubusercontent.com/pagopa/pagopa-ecommerce-transactions-service/main/api-spec/v1/transactions-api.yaml#/components/schemas/TransactionStatus"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "fee": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "grandTotal": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "rrn": {
            "type": "string"
          },
          "authorizationCode": {
            "type": "string"
          },
          "paymentMethodName": {
            "type": "string"
          },
          "brand": {
            "type": "string"
          },
          "authorizationRequestId": {
            "type": "string",
            "description": "Authorization request id"
          },
          "paymentGateway": {
            "type": "string",
            "description": "Payment gateway used to perform transaction"
          }
        },
        "example": {
          "creationDate": "2023-08-02T14:42:54.047",
          "status": "status",
          "statusDetails": "status detail",
          "eventStatus": "NOTIFIED_OK",
          "amount": 100,
          "fee": 10,
          "grandTotal": 110,
          "rrn": "rrn",
          "authorizationCode": "auth code",
          "paymentMethodName": "payment method name",
          "brand": "brand",
          "authorizationRequestId": "authorizationRequestId",
          "paymentGateway": "VPOS"
        }
      },
      "PaymentInfo": {
        "type": "object",
        "description": "Payment info",
        "properties": {
          "origin": {
            "type": "string"
          },
          "details": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentDetailInfo"
            }
          }
        }
      },
      "PaymentDetailInfo": {
        "type": "object",
        "description": "Payment details",
        "properties": {
          "subject": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          },
          "rptId": {
            "type": "string"
          },
          "idTransaction": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          },
          "creditorInstitution": {
            "type": "string"
          },
          "paFiscalCode": {
            "type": "string"
          }
        },
        "example": {
          "subject": "subject",
          "iuv": "302001069073736640",
          "rptId": "rptId",
          "idTransaction": "paymentContextCode",
          "paymentToken": "payment token",
          "creditorInstitution": "66666666666",
          "amount": 99999999,
          "paFiscalCode": "77777777777"
        }
      },
      "PspInfo": {
        "type": "object",
        "description": "PSP info",
        "properties": {
          "pspId": {
            "type": "string"
          },
          "businessName": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          }
        },
        "example": {
          "pspId": "EXAMPLEPSP",
          "businessName": "businessName",
          "idChannel": "13212880150_02_ONUS"
        }
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "PageInfo": {
        "description": "Information about the returned query page",
        "type": "object",
        "properties": {
          "current": {
            "type": "integer",
            "description": "Current returned page index (0-based)"
          },
          "total": {
            "type": "integer",
            "description": "Total pages for the query (based on requested page size)"
          },
          "results": {
            "type": "integer",
            "description": "Transactions returned into the current page"
          }
        },
        "required": [
          "current",
          "results",
          "total"
        ]
      },
      "Product": {
        "type": "string",
        "enum": [
          "PM",
          "ECOMMERCE"
        ],
        "description": "Product from which transaction belongs"
      },
      "PmSearchTransactionRequest": {
        "type": "object",
        "oneOf": [
          {
            "$ref": "#/components/schemas/SearchTransactionRequestFiscalCode"
          },
          {
            "$ref": "#/components/schemas/SearchTransactionRequestEmail"
          }
        ],
        "discriminator": {
          "propertyName": "type",
          "mapping": {
            "USER_FISCAL_CODE": "#/components/schemas/SearchTransactionRequestFiscalCode",
            "USER_EMAIL": "#/components/schemas/SearchTransactionRequestEmail"
          }
        }
      },
      "EcommerceSearchTransactionRequest": {
        "type": "object",
        "oneOf": [
          {
            "$ref": "#/components/schemas/SearchTransactionRequestRptId"
          },
          {
            "$ref": "#/components/schemas/SearchTransactionRequestPaymentToken"
          },
          {
            "$ref": "#/components/schemas/SearchTransactionRequestTransactionId"
          },
          {
            "$ref": "#/components/schemas/SearchTransactionRequestEmail"
          }
        ],
        "discriminator": {
          "propertyName": "type",
          "mapping": {
            "RPT_ID": "#/components/schemas/SearchTransactionRequestRptId",
            "PAYMENT_TOKEN": "#/components/schemas/SearchTransactionRequestPaymentToken",
            "TRANSACTION_ID": "#/components/schemas/SearchTransactionRequestTransactionId",
            "USER_EMAIL": "#/components/schemas/SearchTransactionRequestEmail"
          }
        }
      },
      "SearchDeadLetterEventResponse": {
        "type": "object",
        "description": "Dead letter event response",
        "properties": {
          "deadLetterEvents": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/DeadLetterEvent"
            }
          },
          "page": {
            "$ref": "#/components/schemas/PageInfo"
          }
        },
        "required": [
          "deadLetterEvents",
          "page"
        ]
      },
      "DeadLetterEvent": {
        "type": "object",
        "description": "Dead letter event",
        "properties": {
          "queueName": {
            "type": "string",
            "description": "Name of the dead letter event source queue"
          },
          "data": {
            "type": "string",
            "description": "Dead letter event data"
          },
          "timestamp": {
            "type": "string",
            "format": "date-time",
            "description": "Dead letter event insertion date time"
          }
        },
        "required": [
          "queueName",
          "data",
          "timestamp"
        ]
      },
      "DeadLetterSearchEventSource": {
        "type": "string",
        "enum": [
          "ALL",
          "ECOMMERCE",
          "NOTIFICATIONS_SERVICE"
        ],
        "description": "Dead letter event source"
      },
      "DeadLetterSearchDateTimeRange": {
        "type": "object",
        "description": "Dead letter date time filter",
        "properties": {
          "startDate": {
            "type": "string",
            "format": "date-time",
            "description": "Search start date"
          },
          "endDate": {
            "type": "string",
            "format": "date-time",
            "description": "Search end date"
          }
        },
        "required": [
          "startDate",
          "endDate"
        ]
      },
      "SearchPgsStatusResponse": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "enum": [
              "CREATED",
              "AUTHORIZED",
              "DENIED",
              "CANCELLED"
            ]
          }
        }
      }
    },
    "requestBodies": {
      "PmSearchTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "oneOf": [
                {
                  "$ref": "#/components/schemas/SearchTransactionRequestFiscalCode"
                },
                {
                  "$ref": "#/components/schemas/SearchTransactionRequestEmail"
                }
              ],
              "discriminator": {
                "propertyName": "type",
                "mapping": {
                  "USER_FISCAL_CODE": "#/components/schemas/SearchTransactionRequestFiscalCode",
                  "USER_EMAIL": "#/components/schemas/SearchTransactionRequestEmail"
                }
              }
            },
            "examples": {
              "search by user fiscal code": {
                "value": {
                  "type": "USER_FISCAL_CODE",
                  "userFiscalCode": "user_fiscal_code"
                }
              },
              "search by user email": {
                "value": {
                  "type": "USER_EMAIL",
                  "userEmail": "test@test.it"
                }
              }
            }
          }
        }
      },
      "PmSearchTransactionResponse": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/SearchTransactionResponse"
            }
          }
        }
      },
      "EcommerceSearchTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "oneOf": [
                {
                  "$ref": "#/components/schemas/SearchTransactionRequestRptId"
                },
                {
                  "$ref": "#/components/schemas/SearchTransactionRequestPaymentToken"
                },
                {
                  "$ref": "#/components/schemas/SearchTransactionRequestTransactionId"
                },
                {
                  "$ref": "#/components/schemas/SearchTransactionRequestEmail"
                }
              ],
              "discriminator": {
                "propertyName": "type",
                "mapping": {
                  "RPT_ID": "#/components/schemas/SearchTransactionRequestRptId",
                  "PAYMENT_TOKEN": "#/components/schemas/SearchTransactionRequestPaymentToken",
                  "TRANSACTION_ID": "#/components/schemas/SearchTransactionRequestTransactionId",
                  "USER_EMAIL": "#/components/schemas/SearchTransactionRequestEmail"
                }
              }
            },
            "examples": {
              "search by rpt id": {
                "value": {
                  "type": "RPT_ID",
                  "rptId": "77777777777111111111111111111"
                }
              },
              "search by payment token": {
                "value": {
                  "type": "PAYMENT_TOKEN",
                  "paymentToken": "paymentToken"
                }
              },
              "search by transaction id": {
                "value": {
                  "type": "TRANSACTION_ID",
                  "transactionId": "transactionId"
                }
              },
              "search by user email": {
                "value": {
                  "type": "USER_EMAIL",
                  "userEmail": "test@test.it"
                }
              }
            }
          }
        }
      },
      "EcommerceSearchTransactionResponse": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/SearchTransactionResponse"
            }
          }
        }
      },
      "SearchTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "oneOf": [
                {
                  "$ref": "#/components/schemas/PmSearchTransactionRequest"
                },
                {
                  "$ref": "#/components/schemas/EcommerceSearchTransactionRequest"
                }
              ],
              "discriminator": {
                "propertyName": "type",
                "mapping": {
                  "USER_FISCAL_CODE": "#/components/schemas/SearchTransactionRequestFiscalCode",
                  "USER_EMAIL": "#/components/schemas/SearchTransactionRequestEmail",
                  "RPT_ID": "#/components/schemas/SearchTransactionRequestRptId",
                  "PAYMENT_TOKEN": "#/components/schemas/SearchTransactionRequestPaymentToken",
                  "TRANSACTION_ID": "#/components/schemas/SearchTransactionRequestTransactionId"
                }
              }
            },
            "examples": {
              "search by user fiscal code": {
                "value": {
                  "type": "USER_FISCAL_CODE",
                  "userFiscalCode": "user_fiscal_code"
                }
              },
              "search by user email": {
                "value": {
                  "type": "USER_EMAIL",
                  "userEmail": "test@test.it"
                }
              },
              "search by rpt id": {
                "value": {
                  "type": "RPT_ID",
                  "rptId": "77777777777111111111111111111"
                }
              },
              "search by payment token": {
                "value": {
                  "type": "PAYMENT_TOKEN",
                  "paymentToken": "paymentToken"
                }
              },
              "search by transaction id": {
                "value": {
                  "type": "TRANSACTION_ID",
                  "transactionId": "transactionId"
                }
              }
            }
          }
        }
      },
      "SearchDeadLetterEventRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "type": "object",
              "properties": {
                "source": {
                  "$ref": "#/components/schemas/DeadLetterSearchEventSource"
                },
                "timeRange": {
                  "$ref": "#/components/schemas/DeadLetterSearchDateTimeRange"
                }
              },
              "required": [
                "source"
              ]
            },
            "examples": {
              "search by source without time range": {
                "value": {
                  "source": "ALL"
                }
              },
              "search by source with time range": {
                "value": {
                  "source": "ALL",
                  "timeRange": {
                    "startDate": "2023-01-01T00:00:00.000Z",
                    "endDate": "2023-01-01T02:00:00.000Z"
                  }
                }
              }
            }
          }
        }
      },
      "SearchPgsStatusResponse": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/SearchPgsStatusResponse"
            }
          }
        }
      }
    }
  }
}