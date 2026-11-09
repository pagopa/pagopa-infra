{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Ecommerce API for checkout pagoPA",
    "description": "Ecommerce pagoPA API dedicated to checkout pagoPA for pagoPA payment"
  },
  "tags": [
    {
      "name": "ecommerce-transactions",
      "description": "Api's for performing a transaction",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611287199/-servizio+transactions+service",
        "description": "Technical specifications"
      }
    },
    {
      "name": "ecommerce-methods",
      "description": "Api's for retrieve payment methods for perform transactions",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611516433/-servizio+payment+methods+service",
        "description": "Technical specifications"
      }
    },
    {
      "name": "ecommerce-payment-requests",
      "description": "Api's for initiate a transaction given an array of payment tokens",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611745793/-servizio+payment+requests+service",
        "description": "Technical specifications"
      }
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
        "operationId": "getPaymentRequestInfo",
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
          },
          {
            "in": "query",
            "name": "recaptchaResponse",
            "description": "Recaptcha response",
            "schema": {
              "type": "string"
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
    "/transactions/{transactionId}/outcomes": {
      "get": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "getTransactionOutcomes",
        "summary": "Get transaction outcome",
        "description": "Return outcome information for the input specific transaction resource",
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
            "bearerAuth": []
          }
        ],
        "responses": {
          "200": {
            "description": "Transaction authorization request successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TransactionOutcomeInfo"
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
          "429": {
            "description": "Too Many Requests",
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
    "/transactions/{transactionId}/auth-requests": {
      "post": {
        "summary": "Request authorization",
        "description": "Request authorization for the transaction identified by payment token",
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "requestTransactionAuthorization",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          },
          {
            "in": "header",
            "name": "lang",
            "required": false,
            "description": "Language requested by the user",
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
            "description": "Transaction authorization request successfully processed, redirecting client to authorization web page",
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
          "ecommerce-methods"
        ],
        "operationId": "getAllPaymentMethods",
        "summary": "Retrieve all Payment Methods (by filter)",
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
          }
        }
      }
    },
    "/payment-methods/{id}": {
      "get": {
        "tags": [
          "ecommerce-methods"
        ],
        "operationId": "getPaymentMethod",
        "summary": "Get payment method by ID",
        "description": "API for retrieve payment method information for a given payment method ID",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Payment Method ID",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "New payment method successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentMethodResponse"
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
          "ecommerce-methods"
        ],
        "operationId": "calculateFees",
        "summary": "Calculate payment method fees",
        "description": "GET with body payload - no resources created: Return the fees for the choosen payment method based on transaction amount etc.\n",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Payment Method ID",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "maxOccurrences",
            "in": "query",
            "description": "max occurrences",
            "required": false,
            "schema": {
              "type": "integer"
            }
          },
          {
            "name": "x-transaction-id-from-client",
            "in": "header",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "The ecommerce transaction id"
          }
        ],
        "security": [
          {
            "bearerAuth": []
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
          "429": {
            "description": "Too Many Requests",
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
    "/payment-methods/{id}/sessions": {
      "post": {
        "tags": [
          "ecommerce-methods"
        ],
        "operationId": "createSession",
        "summary": "Create frontend field data paired with a payment gateway session",
        "description": "This endpoint returns an object containing data on how a frontend can build a form\nto allow direct exchanging of payment information to the payment gateway without eCommerce\nhaving to store PCI data (or other sensitive data tied to the payment method).\nThe returned data is tied to a session on the payment gateway identified by the field `orderId`.",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Payment Method id",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "header",
            "name": "lang",
            "required": false,
            "description": "Language requested by the user",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Payment form data successfully created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreateSessionResponse"
                }
              }
            }
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
          "502": {
            "description": "Payment gateway did return error",
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
    "/payment-methods/{id}/sessions/{orderId}": {
      "get": {
        "tags": [
          "ecommerce-methods"
        ],
        "operationId": "getSessionPaymentMethod",
        "summary": "Get session payment method by ID",
        "description": "API for retrieve payment method information for a given payment method ID",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Payment Method ID",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "orderId",
            "in": "path",
            "description": "OrderId ID related to NPG",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "x-transaction-id-from-client",
            "in": "header",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "The ecommerce transaction id"
          }
        ],
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "responses": {
          "200": {
            "description": "Session payment method successfully retrieved",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SessionPaymentMethodResponse"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Session Payment method not found",
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
    "/carts/{id_cart}": {
      "get": {
        "tags": [
          "ecommerce-payment-requests"
        ],
        "operationId": "GetCarts",
        "summary": "Get a cart data",
        "description": "Retrieve cart information",
        "parameters": [
          {
            "in": "path",
            "name": "id_cart",
            "description": "Unique identifier for cart",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Cart data",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CartRequest"
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
            "description": "Cart not found",
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
    "/carts/{cart_id}/redirect": {
      "get": {
        "tags": [
          "ecommerce-payment-requests"
        ],
        "operationId": "GetCartsRedirect",
        "description": "Redirect to checkout with cart",
        "parameters": [
          {
            "in": "path",
            "name": "cart_id",
            "description": "Unique identifier for cart",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Redirect with meta http-equiv"
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
        "example": 200
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
          "paymentInstrumentId": {
            "type": "string",
            "description": "Payment instrument id"
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
            "$ref": "#/components/schemas/PaymentInstrumentDetail"
          }
        },
        "required": [
          "amount",
          "fee",
          "paymentInstrumentId",
          "pspId",
          "language",
          "isAllCCP",
          "details"
        ]
      },
      "PaymentInstrumentDetail": {
        "description": "Additional payment authorization details. Must match the correct format for the chosen payment method.",
        "oneOf": [
          {
            "type": "object",
            "description": "Additional payment authorization details for credit cards",
            "properties": {
              "detailType": {
                "type": "string",
                "description": "fixed value 'card'"
              },
              "cvv": {
                "type": "string",
                "description": "Credit card CVV",
                "pattern": "^[0-9]{3,4}$"
              },
              "pan": {
                "type": "string",
                "description": "Credit card PAN",
                "pattern": "^[0-9]{14,16}$"
              },
              "expiryDate": {
                "type": "string",
                "description": "Credit card expiry date. The date format is `YYYYMM`",
                "pattern": "^[0-9]{6}$"
              },
              "holderName": {
                "type": "string",
                "description": "The card holder name"
              },
              "brand": {
                "description": "The card brand name",
                "type": "string",
                "enum": [
                  "VISA",
                  "MASTERCARD",
                  "UNKNOWN",
                  "DINERS",
                  "MAESTRO",
                  "AMEX"
                ]
              },
              "threeDsData": {
                "type": "string",
                "description": "the 3ds data evaluated by the client"
              }
            },
            "required": [
              "detailType",
              "cvv",
              "pan",
              "expiryDate",
              "holderName",
              "brand",
              "threeDsData"
            ],
            "example": {
              "detailType": "card",
              "cvv": "123",
              "pan": "0123456789012345",
              "expiryDate": "209901",
              "holderName": "Name Surname",
              "brand": "VISA",
              "threeDsData": "threeDsData"
            }
          },
          {
            "type": "object",
            "description": "Additional payment authorization details for cards NPG authorization",
            "properties": {
              "detailType": {
                "description": "fixed value 'cards'",
                "type": "string"
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
          },
          {
            "type": "object",
            "description": "Additional payment authorization details for Redirection authorization request",
            "properties": {
              "detailType": {
                "description": "fixed value 'redirect'",
                "type": "string"
              }
            },
            "required": [
              "detailType"
            ],
            "example": {
              "detailType": "redirect"
            }
          },
          {
            "type": "object",
            "description": "Additional payment authorization details for APM authorization request",
            "properties": {
              "detailType": {
                "description": "fixed value 'apm'",
                "type": "string"
              }
            },
            "required": [
              "detailType"
            ],
            "example": {
              "detailType": "apm"
            }
          },
          {
            "type": "object",
            "description": "Additional payment authorization details for wallet NPG authorization",
            "properties": {
              "detailType": {
                "description": "fixed value 'wallet'",
                "type": "string"
              },
              "walletId": {
                "type": "string",
                "description": "The user wallet id"
              }
            },
            "required": [
              "detailType",
              "walletId"
            ],
            "example": {
              "detailType": "wallet",
              "walletId": "walletId"
            }
          }
        ]
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
      "TransactionOutcomeInfo" : {
        "type": "object",
        "description": "Transaction outcome info returned when querying for an existing transaction outcome status. The field totalAmount, if present, is intended as the total amount paid for the transaction in eurocents fees excluded. Fees too, if present, is in eurocents",
        "properties": {
          "outcome": {
            "type": "number",
            "enum": [
              0, 1, 2, 3, 4, 7, 8, 10, 17, 18, 25, 99, 116, 117, 121
            ],
            "description": "`0` - Success `1` - Generic error `2` - Authorization error `3` - Invalid data `4` - Timeout `7` - Invalid card: expired card etc `8` - Canceled by the user `10` - Excessive amount `17` - Taken in charge `18` - Refunded `25` - PSP Error `99` - Backend Error `116` - Balance not available `117` - CVV Error `121` - Limit exceeded"
          },
          "isFinalStatus": {
            "type": "boolean",
            "description": "A flag that describe the outcome as final or not. If true, the outcome will not change in the future and the client can interrupt polling."
          },
          "totalAmount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "fees": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "outcome",
          "isFinalStatus"
        ]
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999999
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
      "CreateSessionResponse": {
        "type": "object",
        "description": "Form data needed to create a payment method input form",
        "properties": {
          "orderId": {
            "type": "string",
            "description": "Identifier of the payment gateway session associated to the form"
          },
          "correlationId": {
            "type": "string",
            "format": "uuid",
            "description": "Identifier of the payment session associated to the transaction flow"
          },
          "paymentMethodData": {
            "$ref": "#/components/schemas/CardFormFields"
          }
        },
        "required": [
          "paymentMethodData",
          "orderId",
          "correlationId"
        ]
      },
      "CardFormFields": {
        "type": "object",
        "description": "Form fields for credit cards",
        "properties": {
          "paymentMethod": {
            "type": "string"
          },
          "form": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Field"
            }
          }
        },
        "required": [
          "paymentMethod",
          "form"
        ]
      },
      "Field": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "example": "text"
          },
          "class": {
            "type": "string",
            "example": "cardData"
          },
          "id": {
            "type": "string",
            "example": "cardholderName"
          },
          "src": {
            "type": "string",
            "format": "uri",
            "example": "https://<fe>/field.html?id=CARDHOLDER_NAME&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
          }
        }
      },
      "SessionPaymentMethodResponse": {
        "type": "object",
        "description": "Session Payment method Response",
        "properties": {
          "sessionId": {
            "type": "string",
            "description": "session ID related to NPG"
          },
          "bin": {
            "type": "string",
            "description": "Bin of user card"
          },
          "lastFourDigits": {
            "type": "string",
            "description": "Last four digits of user card"
          },
          "expiringDate": {
            "type": "string",
            "description": "expiring date of user card"
          },
          "brand": {
            "description": "The card brand name",
            "type": "string"
          }
        },
        "required": [
          "sessionId",
          "bin",
          "lastFourDigits",
          "expiringDate",
          "brand"
        ]
      },
      "CartRequest": {
        "description": "Cart request body",
        "type": "object",
        "required": [
          "paymentNotices",
          "returnUrls"
        ],
        "properties": {
          "emailNotice": {
            "description": "Email to which send the payment receipt",
            "type": "string",
            "format": "email",
            "example": "my_email@mail.it"
          },
          "paymentNotices": {
            "description": "List of payment notices in the cart",
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentNotice"
            },
            "minItems": 1,
            "maxItems": 5,
            "example": [
              {
                "noticeNumber": "302012387654312384",
                "fiscalCode": "77777777777",
                "amount": 10000,
                "companyName": "companyName",
                "description": "description"
              },
              {
                "noticeNumber": "302012387654312385",
                "fiscalCode": "77777777777",
                "amount": 5000,
                "companyName": "companyName",
                "description": "description"
              }
            ]
          },
          "returnUrls": {
            "description": "Structure containing all the returning URL's to which user will be redirect after payment process has been completed",
            "type": "object",
            "required": [
              "returnOkUrl",
              "returnCancelUrl",
              "returnErrorUrl"
            ],
            "properties": {
              "returnOkUrl": {
                "description": "Return URL in case of payment operation is completed successfully",
                "type": "string",
                "format": "uri",
                "example": "https://www.comune.di.prova.it/pagopa/success.html"
              },
              "returnCancelUrl": {
                "description": "Return URL in case of payment operation is cancelled",
                "type": "string",
                "format": "uri",
                "example": "https://www.comune.di.prova.it/pagopa/cancel.html"
              },
              "returnErrorUrl": {
                "description": "Return URL in case an error occurred during payment operation processing",
                "type": "string",
                "format": "uri",
                "example": "https://www.comune.di.prova.it/pagopa/error.html"
              },
              "returnWaitingUrl": {
                "type": "string",
                "format": "uri",
                "example": "https://www.comune.di.prova.it/pagopa/waiting.html"
              }
            }
          },
          "idCart": {
            "type": "string",
            "example": "id_cart"
          },
          "allCCP": {
            "type": "boolean",
            "example": "false"
          }
        }
      },
      "PaymentNotice": {
        "description": "Payment notice informations",
        "type": "object",
        "required": [
          "noticeNumber",
          "fiscalCode",
          "amount",
          "companyName",
          "description"
        ],
        "properties": {
          "noticeNumber": {
            "description": "Payment notice number",
            "type": "string",
            "minLength": 18,
            "maxLength": 18
          },
          "fiscalCode": {
            "description": "Payment notice fiscal code",
            "type": "string",
            "minLength": 11,
            "maxLength": 11
          },
          "amount": {
            "description": "Payment notice amount",
            "type": "integer",
            "minimum": 1
          },
          "companyName": {
            "description": "Payment notice company name",
            "type": "string",
            "maxLength": 140
          },
          "description": {
            "description": "Payment notice description",
            "type": "string",
            "maxLength": 140
          }
        }
      },
      "CalculateFeeRequest": {
        "description": "Calculate fee request",
        "type": "object",
        "properties": {
          "touchpoint": {
            "type": "string",
            "description": "The touchpoint name"
          },
          "bin": {
            "type": "string",
            "description": "The user card bin"
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
          "paymentAmount",
          "primaryCreditorInstitution",
          "transferList",
          "touchpoint",
          "isAllCCP"
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
            "description": "DEPRECATED: Use pspBusinessName instead.",
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
      }
    },
    "requestBodies": {
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      }
    }
  }
}
