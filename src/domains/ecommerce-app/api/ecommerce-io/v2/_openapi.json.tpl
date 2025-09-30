{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce services for app IO with payment wallet",
    "description": "API's exposed from eCommerce services to app IO to allow pagoPA payment with payment wallet.",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "ecommerce-payment-requests",
      "description": "Api's for initiate a transaction given an array of payment tokens",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611745793/-servizio+payment+requests+service",
        "description": "Technical specifications"
      }
    },
    {
      "name": "ecommerce-transactions",
      "description": "Api's for performing a transaction",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611287199/-servizio+transactions+service",
        "description": "Technical specifications"
      }
    },
    {
      "name": "ecommerce-payment-methods",
      "description": "Api's for performing a transaction",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611516433/-servizio+payment+methods+service",
        "description": "Technical specifications"
      }
    },
    {
      "name": "wallets",
      "description": "Api's for wallet operations"
    },
    {
      "name": "users",
      "description": "Api's for users statistics"
    }
  ],
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
    "description": "Design review"
  },
  "paths": {
    "/payment-requests/{rpt_id}": {
      "get": {
        "summary": "Verify single payment notice",
        "description": "Api used to perform verify on payment notice by mean of Nodo call",
        "tags": [
          "ecommerce-payment-requests"
        ],
        "operationId": "getPaymentRequestInfoForIO",
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "parameters": [
          {
            "in": "path",
            "name": "rpt_id",
            "description": "Unique identifier for payment request, so the concatenation of the tax code and notice number.",
            "schema": {
              "type": "string",
              "pattern": "([a-zA-Z0-9]{1,35})|(RFd{2}[a-zA-Z0-9]{1,21})"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Payment request retrieved",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentRequestsGetResponse"
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
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Node cannot find the services needed to process this request in its configuration. This error is most likely to occur when submitting a non-existing RPT id.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NodeProblemJson404"
                }
              }
            }
          },
          "409": {
            "description": "Conflict on payment status",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NodeProblemJson409"
                }
              }
            }
          },
          "502": {
            "description": "PagoPA services are not available or request is rejected by PagoPa",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NodeProblemJson502"
                }
              }
            }
          },
          "503": {
            "description": "EC services are not available",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PartyConfigurationFaultPaymentProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/transactions/{transactionId}/wallets": {
      "post": {
        "tags": [
          "wallets"
        ],
        "summary": "Create wallet for payment with contextual onboard",
        "description": "Create wallet for payment with contextual onboard",
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "operationId": "createWalletForTransactionsForIO",
        "parameters": [
          {
            "name": "transactionId",
            "in": "path",
            "description": "ecommerce transaction id",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "description": "Create a new wallet",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WalletTransactionCreateRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Wallet created successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletTransactionCreateResponse"
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
            "description": "Unauthorized, access token missing or invalid"
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
    },
    "/transactions": {
      "post": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "newTransactionForIO",
        "summary": "Create a new transaction",
        "description": "Create a new transaction activating the payments notice by meaning of 'Nodo' ActivatePaymentNotice primitive",
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NewTransactionRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "New transaction successfully created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NewTransactionResponse"
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
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Node cannot find the services needed to process this request in its configuration. This error is most likely to occur when submitting a non-existing RPT id.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NodeProblemJson404"
                }
              }
            }
          },
          "409": {
            "description": "Conflict on payment status",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NodeProblemJson409"
                }
              }
            }
          },
          "502": {
            "description": "PagoPA services are not available or request is rejected by PagoPa",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NodeProblemJson502"
                }
              }
            }
          },
          "503": {
            "description": "EC services are not available",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PartyConfigurationFaultPaymentProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/transactions/{transactionId}": {
      "get": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "getTransactionInfoForIO",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          }
        ],
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "summary": "Get transaction information",
        "description": "Return information for the input specific transaction resource",
        "responses": {
          "200": {
            "description": "Transaction data successfully retrieved",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TransactionInfo"
                }
              }
            }
          },
          "400": {
            "description": "Invalid transaction id",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
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
          "504": {
            "description": "Gateway timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "requestTransactionUserCancellationForIO",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          }
        ],
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "summary": "Performs the transaction cancellation",
        "responses": {
          "202": {
            "description": "Transaction cancellation request successfully accepted"
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
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
          "409": {
            "description": "Transaction already processed",
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
          },
          "504": {
            "description": "Timeout from PagoPA services",
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
    "/transactions/{transactionId}/auth-requests": {
      "post": {
        "summary": "Create a new request authorization given a transaction",
        "description": "Request authorization for the transaction identified by payment token",
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "requestTransactionAuthorizationForIO",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          }
        ],
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RequestAuthorizationRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Transaction authorization request successfully processed, redirecting client toauthorization web page (webview to open in app)",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RequestAuthorizationResponse"
                }
              }
            }
          },
          "400": {
            "description": "Invalid transaction id",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
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
          "409": {
            "description": "Transaction already processed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "422": {
            "description": "Transaction cannot be processed",
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
          },
          "504": {
            "description": "Gateway timeout",
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
    "/payment-methods": {
      "get": {
        "tags": [
          "ecommerce-payment-methods"
        ],
        "operationId": "getAllPaymentMethodsForIO",
        "summary": "Retrieve all Payment Methods",
        "description": "API for retrieve payment method",
        "parameters": [
          {
            "name": "amount",
            "in": "query",
            "description": "Payment Amount",
            "required": false,
            "schema": {
              "type": "number"
            }
          }
        ],
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "responses": {
          "200": {
            "description": "Payment method successfully retrieved",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentMethodsResponse"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "500": {
            "description": "Service unavailable",
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
    "/payment-methods/{id}/fees": {
      "post": {
        "tags": [
          "ecommerce-payment-methods"
        ],
        "operationId": "calculateFeesForIO",
        "summary": "Calculatefees for given wallet id and amount",
        "description": "GET with body payload - no resources created: Return the fees for the choosen payment method based on payment amount etc.\n",
        "parameters": [
          {
            "in": "path",
            "name": "id",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "The ID of the payment method for which calculate fees"
          },
          {
            "name": "maxOccurrences",
            "in": "query",
            "description": "max occurrences",
            "required": false,
            "schema": {
              "type": "integer"
            }
          }
        ],
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CalculateFeeRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "New payment method successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CalculateFeeResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Payment method not found",
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
    "/payment-methods/{id}/redirectUrl": {
      "get": {
        "tags": [
          "ecommerce-payment-methods"
        ],
        "operationId": "getMethodRedirectUrl",
        "summary": "Redirection URL for input payment method",
        "description": "Return the URL to be followed for a specific method\n",
        "parameters": [
          {
            "in": "path",
            "name": "id",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "The ID of the payment method for which calculate fees"
          }
        ],
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "responses": {
          "200": {
            "description": "New payment method successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RedirectUrlResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Payment method not found",
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
    "/wallets": {
      "get": {
        "tags": [
          "wallets"
        ],
        "summary": "Get wallet by user identifier",
        "description": "Returns a of wallets related to user",
        "operationId": "getWalletsByIdIOUser",
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "responses": {
          "200": {
            "description": "Wallet retrieved successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Wallets"
                }
              }
            }
          },
          "400": {
            "description": "Invalid input id",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Wallet not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "Bad gateway",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "504": {
            "description": "Timeout serving request",
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
    "/user/lastPaymentMethodUsed": {
      "get": {
        "operationId": "getUserLastPaymentMethodUsed",
        "description": "Retrieve the last payment method used by a user",
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "tags": [
          "users"
        ],
        "summary": "Get user last payment method used, saved or guest",
        "responses": {
          "200": {
            "description": "Successful response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UserLastPaymentMethodResponse"
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
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Cannot find the requested user by user id",
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
      "NodeProblemJson404": {
        "oneOf": [
          {
            "$ref": "#/components/schemas/ValidationFaultPaymentDataErrorProblemJson"
          },
          {
            "$ref": "#/components/schemas/ValidationFaultPaymentUnknownProblemJson"
          }
        ]
      },
      "NodeProblemJson409": {
        "oneOf": [
          {
            "$ref": "#/components/schemas/PaymentOngoingStatusFaultPaymentProblemJson"
          },
          {
            "$ref": "#/components/schemas/PaymentExpiredStatusFaultPaymentProblemJson"
          },
          {
            "$ref": "#/components/schemas/PaymentCanceledStatusFaultPaymentProblemJson"
          },
          {
            "$ref": "#/components/schemas/PaymentDuplicatedStatusFaultPaymentProblemJson"
          }
        ]
      },
      "NodeProblemJson502": {
        "oneOf": [
          {
            "$ref": "#/components/schemas/GatewayFaultPaymentProblemJson"
          },
          {
            "$ref": "#/components/schemas/ValidationFaultPaymentUnavailableProblemJson"
          }
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
        "example": 500
      },
      "PaymentMethodRequest": {
        "type": "object",
        "description": "New Payment method Request",
        "properties": {
          "name": {
            "type": "string",
            "description": "Payment method name"
          },
          "description": {
            "type": "string",
            "description": "Payment method description string"
          },
          "asset": {
            "type": "string",
            "description": "Asset name associated to this payment method"
          },
          "status": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
          },
          "paymentTypeCode": {
            "type": "string",
            "description": "Payment method type code"
          },
          "ranges": {
            "description": "Payment method ranges",
            "type": "array",
            "minItems": 1,
            "items": {
              "$ref": "#/components/schemas/Range"
            }
          }
        },
        "required": [
          "name",
          "description",
          "status",
          "paymentTypeCode",
          "ranges"
        ]
      },
      "Range": {
        "type": "object",
        "description": "Payment amount range in cents",
        "properties": {
          "min": {
            "type": "integer",
            "format": "int64",
            "minimum": 0,
            "description": "Range min amount"
          },
          "max": {
            "type": "integer",
            "format": "int64",
            "minimum": 0
          }
        }
      },
      "PaymentRequestsGetResponse": {
        "type": "object",
        "title": "PaymentRequestsGetResponse",
        "description": "Response with payment request information",
        "properties": {
          "rptId": {
            "description": "Digital payment request id",
            "type": "string",
            "pattern": "([a-zA-Z0-9]{1,35})|(RFd{2}[a-zA-Z0-9]{1,21})"
          },
          "paFiscalCode": {
            "description": "Fiscal code associated to the payment notice",
            "type": "string",
            "minLength": 11,
            "maxLength": 11
          },
          "paName": {
            "description": "Name of the payment notice issuer",
            "type": "string",
            "minLength": 1,
            "maxLength": 140
          },
          "description": {
            "description": "Payment notice description",
            "type": "string",
            "minLength": 1,
            "maxLength": 140
          },
          "amount": {
            "description": "Payment notice amount",
            "type": "integer",
            "minimum": 0,
            "maximum": 99999999999
          },
          "dueDate": {
            "description": "Payment notice due date",
            "type": "string",
            "pattern": "([0-9]{4})-(1[0-2]|0[1-9])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])",
            "example": "2025-07-31"
          }
        },
        "required": [
          "amount"
        ]
      },
      "ValidationFaultPaymentDataErrorProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "PAYMENT_DATA_ERROR"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/ValidationFaultPaymentDataError"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PaymentOngoingStatusFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "PAYMENT_ONGOING"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PaymentOngoingStatusFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PaymentExpiredStatusFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "PAYMENT_EXPIRED"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PaymentExpiredStatusFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PaymentCanceledStatusFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "PAYMENT_CANCELED"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PaymentCanceledStatusFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PaymentDuplicatedStatusFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "PAYMENT_DUPLICATED"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PaymentDuplicatedStatusFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "GatewayFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "GENERIC_ERROR"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/GatewayFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PartyConfigurationFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "DOMAIN_UNKNOWN"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PartyConfigurationFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "FaultCategory": {
        "description": "Fault code categorization for the PagoPA Verifica and Attiva operations.\nPossible categories are:\n- `PAYMENT_DUPLICATED`\n- `PAYMENT_ONGOING`\n- `PAYMENT_EXPIRED`\n- `PAYMENT_UNAVAILABLE`\n- `PAYMENT_UNKNOWN`\n- `DOMAIN_UNKNOWN`\n- `PAYMENT_CANCELED`\n- `GENERIC_ERROR`\n- `PAYMENT_DATA_ERROR`",
        "type": "string",
        "enum": [
          "PAYMENT_DUPLICATED",
          "PAYMENT_ONGOING",
          "PAYMENT_EXPIRED",
          "PAYMENT_UNAVAILABLE",
          "PAYMENT_UNKNOWN",
          "DOMAIN_UNKNOWN",
          "PAYMENT_CANCELED",
          "GENERIC_ERROR",
          "PAYMENT_DATA_ERROR"
        ]
      },
      "PaymentOngoingStatusFault": {
        "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_PAGAMENTO_IN_CORSO`\n- `PAA_PAGAMENTO_IN_CORSO`",
        "type": "string",
        "enum": [
          "PPT_PAGAMENTO_IN_CORSO",
          "PAA_PAGAMENTO_IN_CORSO"
        ]
      },
      "PaymentExpiredStatusFault": {
        "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_SCADUTO`",
        "type": "string",
        "enum": [
          "PAA_PAGAMENTO_SCADUTO"
        ]
      },
      "PaymentCanceledStatusFault": {
        "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_ANNULLATO`",
        "type": "string",
        "enum": [
          "PAA_PAGAMENTO_ANNULLATO"
        ]
      },
      "PaymentDuplicatedStatusFault": {
        "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_DUPLICATO`\n- `PPT_PAGAMENTO_DUPLICATO`",
        "type": "string",
        "enum": [
          "PAA_PAGAMENTO_DUPLICATO",
          "PPT_PAGAMENTO_DUPLICATO"
        ]
      },
      "ValidationFaultPaymentUnavailable": {
        "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_PSP_SCONOSCIUTO`\n- `PPT_PSP_DISABILITATO`\n- `PPT_INTERMEDIARIO_PSP_SCONOSCIUTO`\n- `PPT_INTERMEDIARIO_PSP_DISABILITATO`\n- `PPT_CANALE_SCONOSCIUTO`\n- `PPT_CANALE_DISABILITATO`\n- `PPT_AUTENTICAZIONE`\n- `PPT_AUTORIZZAZIONE`\n- `PPT_DOMINIO_DISABILITATO`\n- `PPT_INTERMEDIARIO_PA_DISABILITATO`\n- `PPT_STAZIONE_INT_PA_DISABILITATA`\n- `PPT_CODIFICA_PSP_SCONOSCIUTA`\n- `PPT_SEMANTICA`\n- `PPT_SYSTEM_ERROR`\n- `PAA_SEMANTICA`",
        "type": "string",
        "enum": [
          "PPT_PSP_SCONOSCIUTO",
          "PPT_PSP_DISABILITATO",
          "PPT_INTERMEDIARIO_PSP_SCONOSCIUTO",
          "PPT_INTERMEDIARIO_PSP_DISABILITATO",
          "PPT_CANALE_SCONOSCIUTO",
          "PPT_CANALE_DISABILITATO",
          "PPT_AUTENTICAZIONE",
          "PPT_AUTORIZZAZIONE",
          "PPT_DOMINIO_DISABILITATO",
          "PPT_INTERMEDIARIO_PA_DISABILITATO",
          "PPT_STAZIONE_INT_PA_DISABILITATA",
          "PPT_CODIFICA_PSP_SCONOSCIUTA",
          "PPT_SEMANTICA",
          "PPT_SYSTEM_ERROR",
          "PAA_SEMANTICA"
        ]
      },
      "ValidationFaultPaymentDataError": {
        "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_SINTASSI_EXTRAXSD`\n- `PPT_SINTASSI_XSD`\n- `PPT_DOMINIO_SCONOSCIUTO`\n- `PPT_STAZIONE_INT_PA_SCONOSCIUTA`",
        "type": "string",
        "enum": [
          "PPT_SINTASSI_EXTRAXSD",
          "PPT_SINTASSI_XSD",
          "PPT_DOMINIO_SCONOSCIUTO",
          "PPT_STAZIONE_INT_PA_SCONOSCIUTA"
        ]
      },
      "ValidationFaultPaymentUnknown": {
        "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_SCONOSCIUTO`",
        "type": "string",
        "enum": [
          "PAA_PAGAMENTO_SCONOSCIUTO"
        ]
      },
      "GatewayFault": {
        "description": "Fault codes for generic downstream services errors, should be mapped to 502 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.",
        "type": "string"
      },
      "PartyConfigurationFault": {
        "description": "Fault codes for fatal errors from ECs, should be mapped to 503 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE`\n- `PPT_STAZIONE_INT_PA_TIMEOUT`\n- `PPT_STAZIONE_INT_PA_ERRORE_RESPONSE`\n- `PPT_IBAN_NON_CENSITO`\n- `PAA_SINTASSI_EXTRAXSD`\n- `PAA_SINTASSI_XSD`\n- `PAA_ID_DOMINIO_ERRATO`\n- `PAA_ID_INTERMEDIARIO_ERRATO`\n- `PAA_STAZIONE_INT_ERRATA`\n- `PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO`\n- `PPT_ERRORE_EMESSO_DA_PAA`\n- `PAA_SYSTEM_ERROR`",
        "type": "string",
        "enum": [
          "PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE",
          "PPT_STAZIONE_INT_PA_TIMEOUT",
          "PPT_STAZIONE_INT_PA_ERRORE_RESPONSE",
          "PPT_IBAN_NON_CENSITO",
          "PAA_SINTASSI_EXTRAXSD",
          "PAA_SINTASSI_XSD",
          "PAA_ID_DOMINIO_ERRATO",
          "PAA_ID_INTERMEDIARIO_ERRATO",
          "PAA_STAZIONE_INT_ERRATA",
          "PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO",
          "PPT_ERRORE_EMESSO_DA_PAA",
          "PAA_SYSTEM_ERROR"
        ]
      },
      "ValidationFaultPaymentUnknownProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "PAYMENT_UNKNOWN"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/ValidationFaultPaymentUnknown"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "ValidationFaultPaymentUnavailableProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "type": "string",
            "enum": [
              "PAYMENT_UNAVAILABLE"
            ]
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/ValidationFaultPaymentUnavailable"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "RptId": {
        "type": "string",
        "pattern": "([a-zA-Z0-9]{1,35})|(RFd{2}[a-zA-Z0-9]{1,21})"
      },
      "PaymentContextCode": {
        "description": "Payment context code used for verifivaRPT/attivaRPT",
        "type": "string",
        "minLength": 32,
        "maxLength": 32
      },
      "PaymentNoticeInfo": {
        "description": "Informations about a single payment notice",
        "type": "object",
        "properties": {
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "paymentContextCode": {
            "$ref": "#/components/schemas/PaymentContextCode"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "rptId",
          "amount"
        ],
        "example": {
          "rptId": "string",
          "paymentContextCode": "12345678901234567890123456789012",
          "amount": 100
        }
      },
      "PaymentInfo": {
        "description": "Informations about transaction payments",
        "type": "object",
        "properties": {
          "paymentToken": {
            "type": "string"
          },
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "reason": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "isAllCCP": {
            "description": "Flag for the inclusion of Poste bundles. false -> excluded, true -> included",
            "type": "boolean"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Transfer"
            },
            "minItems": 1,
            "maxItems": 5
          }
        },
        "required": [
          "rptId",
          "amount"
        ],
        "example": {
          "rptId": "77777777777302012387654312384",
          "paymentToken": "paymentToken1",
          "reason": "reason1",
          "amount": 600,
          "authToken": "authToken1",
          "isAllCCP": false,
          "transferList": [
            {
              "paFiscalCode": "77777777777",
              "digitalStamp": false,
              "transferCategory": "transferCategory1",
              "transferAmount": 500
            },
            {
              "paFiscalCode": "11111111111",
              "digitalStamp": true,
              "transferCategory": "transferCategory2",
              "transferAmount": 100
            }
          ]
        }
      },
      "NewTransactionRequest": {
        "type": "object",
        "description": "Request body for creating a new transaction",
        "properties": {
          "paymentNotices": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentNoticeInfo"
            },
            "minItems": 1,
            "maxItems": 1,
            "example": [
              {
                "rptId": "77777777777302012387654312384",
                "amount": 12000
              }
            ]
          }
        },
        "required": [
          "paymentNotices"
        ]
      },
      "NewTransactionResponse": {
        "type": "object",
        "description": "Transaction data returned when creating a new transaction",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "payments": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentInfo"
            },
            "minItems": 1,
            "maxItems": 1,
            "example": [
              {
                "rptId": "77777777777302012387654312384",
                "paymentToken": "paymentToken1",
                "reason": "reason1",
                "amount": 600,
                "transferList": [
                  {
                    "paFiscalCode": "77777777777",
                    "digitalStamp": false,
                    "transferCategory": "transferCategory1",
                    "transferAmount": 500
                  },
                  {
                    "paFiscalCode": "11111111111",
                    "digitalStamp": true,
                    "transferCategory": "transferCategory2",
                    "transferAmount": 100
                  }
                ]
              }
            ]
          },
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
          },
          "feeTotal": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "clientId": {
            "description": "transaction client id",
            "type": "string",
            "enum": [
              "IO"
            ]
          },
          "sendPaymentResultOutcome": {
            "description": "The outcome of sendPaymentResult api (OK, KO, NOT_RECEIVED)",
            "type": "string",
            "enum": [
              "OK",
              "KO",
              "NOT_RECEIVED"
            ]
          },
          "authorizationCode": {
            "type": "string",
            "description": "Payment gateway-specific authorization code related to the transaction"
          },
          "errorCode": {
            "type": "string",
            "description": "Payment gateway-specific error code from the gateway"
          },
          "gateway": {
            "type": "string",
            "pattern": "XPAY|VPOS|NPG",
            "description": "Pgs identifier"
          }
        },
        "required": [
          "transactionId",
          "status",
          "payments"
        ]
      },
      "RequestAuthorizationRequest": {
        "type": "object",
        "description": "Request body for requesting an authorization for a transaction",
        "properties": {
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "fee": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "pspId": {
            "type": "string",
            "description": "PSP id"
          },
          "language": {
            "type": "string",
            "enum": [
              "IT",
              "EN",
              "FR",
              "DE",
              "SL"
            ],
            "description": "Requested language"
          },
          "isAllCCP": {
            "type": "boolean",
            "description": "Check flag for psp validation"
          },
          "details": {
            "$ref": "#/components/schemas/AuthorizationDetails"
          }
        },
        "required": [
          "amount",
          "fee",
          "pspId",
          "language",
          "isAllCCP",
          "details"
        ]
      },
      "AuthorizationDetails": {
        "description": "Additional payment authorization details. Must match the correct format for the chosen payment method.",
        "oneOf": [
          {
            "type": "object",
            "description": "Additional payment authorization details for authorization performed with a wallet",
            "properties": {
              "detailType": {
                "$ref": "#/components/schemas/WalletDetailType"
              },
              "walletId": {
                "type": "string",
                "format": "uuid",
                "description": "WalletId"
              }
            },
            "required": [
              "detailType",
              "walletId"
            ],
            "example": {
              "detailType": "wallet",
              "walletId": "9972eb61-bea1-405f-846a-980b9aebe017"
            }
          },
          {
            "type": "object",
            "description": "Additional payment authorization details apm method",
            "properties": {
              "detailType": {
                "$ref": "#/components/schemas/ApmDetailType"
              },
              "paymentMethodId": {
                "description": "User selected payment method id",
                "type": "string",
                "format": "uuid"
              }
            },
            "required": [
              "detailType",
              "paymentMethodId"
            ],
            "example": {
              "detailType": "apm",
              "paymentMethodId": "dbc12081-ea5c-4a73-ae0a-7d6a881a1160"
            }
          },
          {
            "type": "object",
            "description": "Additional payment authorization details for redirect method",
            "properties": {
              "detailType": {
                "$ref": "#/components/schemas/RedirectDetailType"
              },
              "paymentMethodId": {
                "description": "User selected payment method id",
                "type": "string",
                "format": "uuid"
              }
            },
            "required": [
              "detailType",
              "paymentMethodId"
            ],
            "example": {
              "detailType": "redirect",
              "paymentMethodId": "dbc12081-ea5c-4a73-ae0a-7d6a881a1160"
            }
          },
          {
            "type": "object",
            "description": "Additional payment authorization details for cards NPG authorization",
            "properties": {
              "detailType": {
                "$ref": "#/components/schemas/CardsDetailType"
              },
              "orderId": {
                "type": "string",
                "description": "NPG transaction order id"
              }
            },
            "required": [
              "detailType",
              "orderId"
            ],
            "example": {
              "detailType": "cards",
              "orderId": "order-id"
            }
          }
        ]
      },
      "WalletDetailType": {
        "description": "wallet detail type discriminator field",
        "type": "string",
        "enum": [
          "wallet"
        ]
      },
      "ApmDetailType": {
        "description": "apm detail type discriminator field",
        "type": "string",
        "enum": [
          "apm"
        ]
      },
      "RedirectDetailType": {
        "description": "redirect detail type discriminator field",
        "type": "string",
        "enum": [
          "redirect"
        ]
      },
      "CardsDetailType": {
        "description": "cards detail type discriminator field",
        "type": "string",
        "enum": [
          "cards"
        ]
      },
      "UpdateAuthorizationRequest": {
        "type": "object",
        "description": "Request body for updating an authorization for a transaction",
        "properties": {
          "authorizationResult": {
            "$ref": "#/components/schemas/AuthorizationResult"
          },
          "timestampOperation": {
            "type": "string",
            "format": "date-time",
            "description": "Payment timestamp"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Payment gateway-specific authorization code related to the transaction"
          }
        },
        "required": [
          "authorizationResult",
          "timestampOperation",
          "authorizationCode"
        ],
        "example": {
          "authorizationResult": "OK",
          "timestampOperation": "2022-02-11T12:00:00.000Z",
          "authorizationCode": "auth-code"
        }
      },
      "RequestAuthorizationResponse": {
        "type": "object",
        "description": "Response body for requesting an authorization for a transaction",
        "properties": {
          "authorizationUrl": {
            "type": "string",
            "format": "url",
            "description": "URL where to redirect clients to continue the authorization process"
          },
          "authorizationRequestId": {
            "type": "string",
            "description": "Authorization request id"
          }
        },
        "required": [
          "authorizationUrl",
          "authorizationRequestId"
        ],
        "example": {
          "authorizationUrl": "https://example.com",
          "authorizationRequestId": "auth-request-id"
        }
      },
      "TransactionInfo": {
        "description": "Transaction data returned when querying for an existing transaction",
        "allOf": [
          {
            "$ref": "#/components/schemas/NewTransactionResponse"
          },
          {
            "type": "object",
            "properties": {
              "status": {
                "$ref": "#/components/schemas/TransactionStatus"
              },
              "gatewayAuthorizationStatus": {
                "type": "string",
                "description": "payment gateway authorization status"
              }
            },
            "required": [
              "status"
            ]
          }
        ]
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "AuthorizationResult": {
        "description": "Authorization result",
        "type": "string",
        "enum": [
          "OK",
          "KO"
        ]
      },
      "TransactionStatus": {
        "type": "string",
        "description": "Possible statuses a transaction can be in",
        "enum": [
          "ACTIVATED",
          "ACTIVATION_REQUESTED",
          "AUTHORIZATION_REQUESTED",
          "AUTHORIZATION_COMPLETED",
          "CLOSURE_REQUESTED",
          "CLOSED",
          "CLOSURE_ERROR",
          "NOTIFIED_OK",
          "NOTIFIED_KO",
          "NOTIFICATION_ERROR",
          "NOTIFICATION_REQUESTED",
          "EXPIRED",
          "REFUNDED",
          "CANCELED",
          "EXPIRED_NOT_AUTHORIZED",
          "UNAUTHORIZED",
          "REFUND_ERROR",
          "REFUND_REQUESTED",
          "CANCELLATION_REQUESTED",
          "CANCELLATION_EXPIRED"
        ]
      },
      "Transfer": {
        "type": "object",
        "description": "The dto that contains information about the creditor entities",
        "properties": {
          "paFiscalCode": {
            "type": "string",
            "description": "The creditor institution fiscal code",
            "pattern": "^[a-zA-Z0-9]{11}"
          },
          "digitalStamp": {
            "type": "boolean",
            "description": "True if it is a digital stamp. False otherwise"
          },
          "transferCategory": {
            "type": "string",
            "description": "The taxonomy of the transfer"
          },
          "transferAmount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "paFiscalCode",
          "digitalStamp",
          "transferAmount"
        ]
      },
      "PaymentMethodStatus": {
        "type": "string",
        "description": "Payment method status",
        "enum": [
          "ENABLED",
          "DISABLED",
          "INCOMING"
        ]
      },
      "PaymentMethodManagementType": {
        "type": "string",
        "description": "Describes how to manage the payment method authorization flow in wallet and eCommerce domain:\n- REDIRECT if it must be managed with a redirect flow;\n- ONBOARDABLE if it must be managed with NPG and it is possible to save the payment method in the wallet, but also guest payment is accepted;\n- NOT_ONBOARDABLE if it must be managed with NPG but the method cannot be saved, only guest payment is accepted;\n- ONBOARDABLE_ONLY if it must be managed with NPG and it is mandatory to save the payment method in the wallet to use it. Guest payment isn't accepted;\n- ONBORDABLE_WITH_PAYMENT if it must be managed with NPG and it is possible to save it, to use it as guest payment, and to onboard it during the payment;",
        "enum": [
          "ONBOARDABLE",
          "NOT_ONBOARDABLE",
          "REDIRECT",
          "ONBOARDABLE_ONLY",
          "ONBOARDABLE_WITH_PAYMENT"
        ]
      },
      "CalculateFeeRequest": {
        "description": "Calculate fee request",
        "type": "object",
        "properties": {
          "walletId": {
            "type": "string",
            "description": "ID of the wallet"
          },
          "paymentToken": {
            "type": "string",
            "description": "paymentToken related to nodo activation"
          },
          "language": {
            "type": "string"
          },
          "idPspList": {
            "description": "List of psps",
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "paymentAmount": {
            "description": "The transaction payment amount",
            "type": "integer",
            "format": "int64"
          },
          "primaryCreditorInstitution": {
            "description": "The primary creditor institution",
            "type": "string"
          },
          "transferList": {
            "description": "Transfert list",
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferListItem"
            }
          },
          "isAllCCP": {
            "description": "Flag for the inclusion of Poste bundles. false -> excluded, true -> included",
            "type": "boolean"
          }
        },
        "required": [
          "paymentAmount"
        ]
      },
      "CalculateFeeResponse": {
        "description": "Calculate fee response",
        "type": "object",
        "properties": {
          "paymentMethodName": {
            "description": "Payment method name",
            "type": "string"
          },
          "paymentMethodDescription": {
            "description": "Payment method description",
            "type": "string"
          },
          "paymentMethodStatus": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
          },
          "belowThreshold": {
            "description": "Boolean value indicating if the payment is below the configured threshold",
            "type": "boolean"
          },
          "bundles": {
            "description": "Bundle list",
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Bundle"
            }
          },
          "asset": {
            "description": "Payment method asset",
            "type": "string"
          },
          "brandAssets": {
            "description": "Brand assets map associated to the selected payment method",
            "type": "object",
            "additionalProperties": {
              "type": "string"
            }
          }
        },
        "required": [
          "bundles",
          "paymentMethodName",
          "paymentMethodDescription",
          "paymentMethodStatus",
          "asset"
        ]
      },
      "Bundle": {
        "description": "Bundle object",
        "type": "object",
        "properties": {
          "abi": {
            "description": "Bundle ABI code",
            "type": "string"
          },
          "bundleDescription": {
            "description": "Bundle description",
            "type": "string"
          },
          "bundleName": {
            "description": "DEPRECATED: use pspBusinessName instead",
            "type": "string",
            "deprecated": true
          },
          "idBrokerPsp": {
            "description": "Bundle PSP broker id",
            "type": "string"
          },
          "idBundle": {
            "description": "Bundle id",
            "type": "string"
          },
          "idChannel": {
            "description": "Channel id",
            "type": "string"
          },
          "idCiBundle": {
            "description": "CI bundle id",
            "type": "string"
          },
          "idPsp": {
            "description": "PSP id",
            "type": "string"
          },
          "onUs": {
            "description": "Boolean value indicating if this bundle is an on-us ones",
            "type": "boolean"
          },
          "paymentMethod": {
            "description": "Payment method",
            "type": "string"
          },
          "primaryCiIncurredFee": {
            "description": "Primary CI incurred fee",
            "type": "integer",
            "format": "int64"
          },
          "taxPayerFee": {
            "description": "Tax payer fee",
            "type": "integer",
            "format": "int64"
          },
          "touchpoint": {
            "description": "The touchpoint name",
            "type": "string"
          },
          "pspBusinessName": {
            "description": "The psp business name",
            "type": "string"
          }
        }
      },
      "TransferListItem": {
        "description": "Transfert list item",
        "type": "object",
        "properties": {
          "creditorInstitution": {
            "description": "Creditor institution",
            "type": "string"
          },
          "digitalStamp": {
            "description": "Boolean value indicating if there is digital stamp",
            "type": "boolean"
          },
          "transferCategory": {
            "description": "Transfer category",
            "type": "string"
          }
        }
      },
      "PaymentMethodResponse": {
        "type": "object",
        "description": "Payment method Response",
        "properties": {
          "id": {
            "type": "string",
            "description": "Payment method ID"
          },
          "name": {
            "type": "string",
            "description": "Payment method name"
          },
          "description": {
            "type": "string",
            "description": "Payment method description"
          },
          "asset": {
            "type": "string",
            "description": "Payment method asset name"
          },
          "status": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
          },
          "paymentTypeCode": {
            "type": "string",
            "description": "Payment method type code"
          },
          "methodManagement": {
            "$ref": "#/components/schemas/PaymentMethodManagementType"
          },
          "ranges": {
            "description": "Payment amount range in eurocents",
            "type": "array",
            "minItems": 1,
            "items": {
              "$ref": "#/components/schemas/Range"
            }
          },
          "brandAssets": {
            "description": "Brand assets map associated to the selected payment method",
            "type": "object",
            "additionalProperties": {
              "type": "string"
            }
          }
        },
        "required": [
          "id",
          "name",
          "description",
          "status",
          "paymentTypeCode",
          "ranges",
          "methodManagement"
        ]
      },
      "PaymentMethodsResponse": {
        "type": "object",
        "description": "Payment methods response",
        "properties": {
          "paymentMethods": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentMethodResponse"
            }
          }
        }
      },
      "UserLastPaymentMethodResponse": {
        "description": "Last usage data for wallet or payment method (guest)",
        "oneOf": [
          {
            "type": "object",
            "description": "Last usage data for wallets.",
            "properties": {
              "walletId": {
                "$ref": "#/components/schemas/WalletId"
              },
              "date": {
                "type": "string",
                "format": "date-time"
              },
              "type": {
                "$ref": "#/components/schemas/WalletLastUsageType"
              }
            },
            "required": [
              "walletId",
              "date",
              "type"
            ]
          },
          {
            "type": "object",
            "description": "Last usage data for wallets",
            "properties": {
              "paymentMethodId": {
                "type": "string",
                "format": "uuid",
                "description": "eCommerce payment method id associated to this last usage"
              },
              "date": {
                "type": "string",
                "format": "date-time"
              },
              "type": {
                "$ref": "#/components/schemas/GuestMethodLastUsageType"
              }
            },
            "required": [
              "paymentMethodId",
              "date",
              "type"
            ]
          }
        ]
      },
      "WalletLastUsageType": {
        "type": "string",
        "description": "Discriminant type for last usage of a wallet",
        "enum": [
          "wallet"
        ]
      },
      "GuestMethodLastUsageType": {
        "type": "string",
        "description": "Discriminant type for last usage of a guest (non-wallet) payment method",
        "enum": [
          "guest"
        ]
      },
      "WalletId": {
        "description": "Wallet identifier",
        "type": "string",
        "format": "uuid"
      },
      "WalletTransactionCreateRequest": {
        "type": "object",
        "description": "Wallet for transaction with contextual onboarding creation request",
        "properties": {
          "useDiagnosticTracing": {
            "type": "boolean"
          },
          "paymentMethodId": {
            "type": "string",
            "format": "uuid"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "useDiagnosticTracing",
          "paymentMethodId",
          "amount"
        ]
      },
      "WalletTransactionCreateResponse": {
        "type": "object",
        "description": "Wallet for transaction with contextual onboarding creation response",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "redirectUrl": {
            "type": "string",
            "format": "url",
            "description": "Redirection URL to a payment gateway page where the user can input a payment instrument information with walletId and useDiagnosticTracing as query param",
            "example": "http://localhost/inputPage?walletId=123&useDiagnosticTracing=true&sessionToken=sessionToken"
          }
        },
        "required": [
          "walletId"
        ]
      },
      "Wallets": {
        "type": "object",
        "description": "Wallets information",
        "properties": {
          "wallets": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/WalletInfo"
            }
          }
        }
      },
      "WalletClientStatus": {
        "type": "string",
        "description": "Enumeration of wallet client statuses",
        "enum": [
          "ENABLED",
          "DISABLED"
        ]
      },
      "WalletClient": {
        "type": "object",
        "properties": {
          "status": {
            "$ref": "#/components/schemas/WalletClientStatus"
          },
          "lastUsage": {
            "type": "string",
            "description": "(DEPRECATED\\: use GET /user/lastPaymentMethodUsed to retrieve user last used method) Time of last usage of this wallet by the client\n",
            "format": "date-time",
            "deprecated": true
          }
        },
        "required": [
          "status"
        ]
      },
      "WalletInfo": {
        "type": "object",
        "description": "Wallet information",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "paymentMethodId": {
            "description": "Payment method identifier",
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/WalletStatus"
          },
          "creationDate": {
            "description": "Wallet creation date",
            "type": "string",
            "format": "date-time"
          },
          "updateDate": {
            "description": "Wallet update date",
            "type": "string",
            "format": "date-time"
          },
          "applications": {
            "description": "list of applications for which this wallet is created for",
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/WalletApplication"
            }
          },
          "clients": {
            "description": "Client-specific state (e.g. last usage) and configuration (enabled/disabled). Currently the only supported client is `IO`.",
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/WalletClient"
            }
          },
          "details": {
            "$ref": "#/components/schemas/WalletInfoDetails"
          },
          "paymentMethodAsset": {
            "description": "Payment method asset",
            "type": "string",
            "format": "uri",
            "example": "http://logo.cdn/brandLogo"
          }
        },
        "required": [
          "walletId",
          "paymentMethodId",
          "status",
          "creationDate",
          "updateDate",
          "applications",
          "clients",
          "paymentMethodAsset"
        ]
      },
      "WalletInfoDetails": {
        "description": "details for the specific payment instrument. This field is disciminated by the type field",
        "oneOf": [
          {
            "type": "object",
            "description": "Card payment instrument details",
            "properties": {
              "type": {
                "type": "string",
                "description": "Wallet details discriminator field. Fixed valued 'CARDS'"
              },
              "lastFourDigits": {
                "description": "Card last 4 digits",
                "type": "string",
                "example": "9876"
              },
              "expiryDate": {
                "type": "string",
                "description": "Credit card expiry date. The date format is `YYYYMM`",
                "pattern": "^[0-9]{6}$",
                "example": "203012"
              },
              "brand": {
                "description": "Payment instrument brand",
                "type": "string"
              }
            },
            "required": [
              "type",
              "lastFourDigits",
              "expiryDate",
              "brand"
            ]
          },
          {
            "type": "object",
            "description": "Paypal instrument details",
            "properties": {
              "type": {
                "type": "string",
                "description": "Wallet details discriminator field. Fixed valued 'PAYPAL'"
              },
              "pspId": {
                "description": "bank identifier",
                "type": "string"
              },
              "pspBusinessName": {
                "description": "PSP business name",
                "type": "string"
              },
              "maskedEmail": {
                "description": "email masked pan",
                "type": "string",
                "example": "test***@***test.it"
              }
            },
            "required": [
              "type",
              "pspId",
              "pspBusinessName",
              "maskedEmail"
            ]
          },
          {
            "type": "object",
            "description": "Bancomat pay instrument details",
            "properties": {
              "type": {
                "type": "string",
                "description": "Wallet details discriminator field. Fixed valued 'BANCOMATPAY'"
              },
              "maskedNumber": {
                "description": "masked number",
                "type": "string",
                "minLength": 1,
                "maxLength": 20,
                "example": "+3938*******202"
              },
              "instituteCode": {
                "description": "institute code",
                "type": "string",
                "minLength": 1,
                "maxLength": 5,
                "example": "12345"
              },
              "bankName": {
                "description": "bank name",
                "type": "string",
                "example": "banca di banca"
              }
            },
            "required": [
              "type",
              "maskedNumber",
              "instituteCode",
              "bankName"
            ]
          }
        ]
      },
      "WalletStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "VALIDATED"
        ]
      },
      "WalletApplication": {
        "type": "object",
        "properties": {
          "name": {
            "$ref": "#/components/schemas/WalletApplicationName"
          },
          "status": {
            "$ref": "#/components/schemas/WalletApplicationStatus"
          },
          "updateDate": {
            "description": "Service last update date",
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "WalletApplicationStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "ENABLED",
          "DISABLED",
          "INCOMING"
        ]
      },
      "WalletApplicationName": {
        "type": "string",
        "description": "Enumeration of applications",
        "enum": [
          "PAGOPA"
        ]
      },
      "RedirectUrlResponse": {
        "type": "object",
        "description": "Redirect URL response",
        "properties": {
          "redirectUrl": {
            "type": "string",
            "format": "url",
            "description": "The redirection URL to be followed for the input method"
          }
        }
      }
    },
    "requestBodies": {
      "PaymentMethodRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/PaymentMethodRequest"
            }
          }
        }
      },
      "NewTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/NewTransactionRequest"
            }
          }
        }
      },
      "RequestAuthorizationRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/RequestAuthorizationRequest"
            }
          }
        }
      },
      "UpdateAuthorizationRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/UpdateAuthorizationRequest"
            }
          }
        }
      },
      "RedirectUrlResponse": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/RedirectUrlResponse"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "pagoPAPlatformSessionToken": {
        "type": "http",
        "scheme": "bearer",
        "description": "JWT session token taken according to pagoPA platform auth for IO app"
      }
    }
  }
}