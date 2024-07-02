{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce payment methods service",
    "description": "This microservice handles payment methods.",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "payment-methods",
      "description": "Api's for handle payment methods",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611516433/-servizio+payment+methods+service",
        "description": "Technical specifications"
      }
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
    "description": "Design review"
  },
  "security": [
    {
      "ApiKeyAuth": []
    }
  ],
  "paths": {
    "/payment-methods": {
      "post": {
        "tags": [
          "payment-methods"
        ],
        "operationId": "newPaymentMethod",
        "summary": "Create a new payment method",
        "description": "API for create a new payment method",
        "requestBody": {
          "$ref": "#/components/requestBodies/PaymentMethodRequest"
        },
        "responses": {
          "200": {
            "description": "New payment method successfully created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentMethodResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
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
      },
      "get": {
        "tags": [
          "payment-methods"
        ],
        "operationId": "getAllPaymentMethods",
        "summary": "Retrieve all Payment Methods (by filter)",
        "description": "API for retrieve payment method using the request query parameter filters",
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
    "/payment-methods/{id}": {
      "patch": {
        "tags": [
          "payment-methods"
        ],
        "operationId": "patchPaymentMethod",
        "summary": "Update payment method",
        "description": "API for update a specific payment method properties such as status",
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
        "requestBody": {
          "$ref": "#/components/requestBodies/PatchPaymentMethodRequest"
        },
        "responses": {
          "200": {
            "description": "Payment method successfully retrived",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentMethodResponse"
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
      },
      "get": {
        "tags": [
          "payment-methods"
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
          },
          {
            "name": "x-client-id",
            "in": "header",
            "description": "client id related to a given touchpoint",
            "required": false,
            "schema": {
              "type": "string",
              "enum": [
                "IO",
                "CHECKOUT"
              ]
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
    "/payment-methods/{id}/fees": {
      "post": {
        "tags": [
          "payment-methods"
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
            "name": "x-transaction-id",
            "in": "header",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "The ecommerce transaction id"
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/PostPaymentMethodPSP"
        },
        "responses": {
          "200": {
            "description": "Return list of psp ordered by fee.",
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
            "description": "Resource not found",
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
          "payment-methods"
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
          "payment-methods"
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
            "description": "order ID related to NPG",
            "required": true,
            "schema": {
              "type": "string"
            }
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
      },
      "patch": {
        "tags": [
          "payment-methods"
        ],
        "operationId": "updateSession",
        "summary": "Update session data",
        "description": "API for updating session data",
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
            "description": "order ID related to NPG",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/PatchSession"
        },
        "responses": {
          "204": {
            "description": "Session updated"
          },
          "404": {
            "description": "Session not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "409": {
            "description": "Session already associated to transaction",
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
    "/payment-methods/{id}/sessions/{orderId}/transactionId": {
      "get": {
        "tags": [
          "payment-methods"
        ],
        "operationId": "getTransactionIdForSession",
        "summary": "Get eCommerce transaction id for the given NPG session",
        "description": "API to get a transaction id from a NPG session",
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
            "description": "Order id related to NPG",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "security": [
          {
            "BearerAuth": []
          }
        ],
        "responses": {
          "200": {
            "description": "Session found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SessionGetTransactionId"
                }
              }
            }
          },
          "404": {
            "description": "Session not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "409": {
            "description": "Invalid session",
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
          "methodManagement": {
            "$ref": "#/components/schemas/PaymentMethodManagementType"
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
          "methodManagement",
          "paymentTypeCode",
          "ranges"
        ]
      },
      "Range": {
        "type": "object",
        "description": "Payment amount range in eurocents",
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
            "minimum": 0,
            "description": "Range max amount"
          }
        }
      },
      "PatchPaymentMethodRequest": {
        "type": "object",
        "description": "Patch Payment Method Request",
        "properties": {
          "status": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
          }
        },
        "required": [
          "status"
        ]
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
      "ProblemJson": {
        "type": "object",
        "description": "Problem json structure",
        "properties": {
          "detail": {
            "description": "Problem detail",
            "type": "string"
          },
          "status": {
            "description": "Error status code",
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "format": "int32",
            "example": 200
          },
          "title": {
            "description": "Problem title",
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
      "PatchSessionRequest": {
        "type": "object",
        "description": "Session data to update",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "Transaction id to associate to this session"
          }
        },
        "required": [
          "transactionId"
        ]
      },
      "SessionGetTransactionId": {
        "type": "object",
        "description": "Transaction id for session successful response",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "Transaction id associated to this NPG session"
          }
        },
        "required": [
          "transactionId"
        ]
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
      "PatchPaymentMethodRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/PatchPaymentMethodRequest"
            }
          }
        }
      },
      "PostPaymentMethodPSP": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/CalculateFeeRequest"
            }
          }
        }
      },
      "PatchSession": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/PatchSessionRequest"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKeyAuth": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      },
      "BearerAuth": {
        "type": "http",
        "scheme": "bearer"
      }
    }
  }
}
