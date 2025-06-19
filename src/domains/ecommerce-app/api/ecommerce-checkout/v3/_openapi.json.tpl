{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa eCommerce services for Authenticated user in Checkout",
    "description": "This microservice that expose eCommerce services to Checkout to be used by authenticated users.",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
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
    "/auth/payment-requests/{rpt_id}": {
      "get": {
        "summary": "Verify single payment notice",
        "description": "Api used to perform verify on payment notice by mean of Nodo call",
        "tags": [
          "ecommerce-payment-requests"
        ],
        "operationId": "getPaymentRequestInfoV3",
        "security": [
          {
            "bearerAuth": []
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
    "/auth/transactions": {
      "post": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "newTransactionV3",
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "summary": "Make a new transaction",
        "description": "Create a new transaction activating the payments notice by meaning of 'Nodo' ActivatePaymentNotice primitive",
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
        "parameters": [
          {
            "in": "header",
            "name": "x-correlation-id",
            "required": true,
            "description": "Flow correlation id",
            "schema": {
              "type": "string",
              "format": "uuid"
            }
          },
          {
            "in": "header",
            "name": "x-client-id-from-client",
            "required": true,
            "description": "Client id from client",
            "schema": {
              "type": "string",
              "enum": [
                "CHECKOUT",
                "CHECKOUT_CART",
                "WISP_REDIRECT"
              ]
            }
          },
          {
            "in": "header",
            "name": "x-rpt-ids",
            "required": false,
            "description": "Optional RPT ID used to track post transaction attempts to payment notices",
            "schema": {
              "type": "string"
            }
          }
        ],
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
    "/auth/payment-methods": {
      "get": {
        "tags": [
          "ecommerce-methods"
        ],
        "operationId": "getAllPaymentMethodsV3",
        "security": [
          {
            "bearerAuth": []
          }
        ],
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
          },
          {
            "in": "header",
            "name": "x-rpt-ids",
            "required": false,
            "description": "Optional RPT ID used to track get payment-methods attempts to payment notices",
            "schema": {
              "type": "string"
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
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Payment methods not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "PagoPA services are not available or request is rejected by PagoPa",
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
    "/auth/payment-methods/{id}/sessions": {
      "post": {
        "tags": [
          "ecommerce-methods"
        ],
        "operationId": "createSessionV3",
        "security": [
          {
            "bearerAuth": []
          }
        ],
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
          },
          {
            "in": "header",
            "name": "x-rpt-ids",
            "required": false,
            "description": "Optional RPT ID used to track post session attempts to payment notices",
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
            "maximum": 999999999
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
          },
          "creditorReferenceId": {
            "type": "string",
            "description": "Creditor notice number's"
          }
        },
        "required": [
          "rptId",
          "amount",
          "transferList",
          "isAllCCP"
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
            "maxItems": 5,
            "example": [
              {
                "rptId": "77777777777302012387654312384",
                "paymentContextCode": "12345678901234567890123456789011",
                "amount": 100
              },
              {
                "rptId": "77777777777302012387654312385",
                "paymentContextCode": "12345678901234567890123456789012",
                "amount": 200
              }
            ]
          },
          "email": {
            "type": "string"
          },
          "idCart": {
            "description": "Cart identifier provided by creditor institution",
            "type": "string",
            "example": "idCartFromCreditorInstitution"
          },
          "orderId": {
            "description": "NPG order id",
            "type": "string",
            "example": "orderId"
          }
        },
        "required": [
          "paymentNotices",
          "email",
          "orderId"
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
            "maxItems": 5,
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
              },
              {
                "rptId": "77777777777302012387654312385",
                "paymentToken": "paymentToken2",
                "reason": "reason2",
                "amount": 300,
                "transferList": [
                  {
                    "paFiscalCode": "44444444444",
                    "digitalStamp": true,
                    "transferCategory": "transferCategory1",
                    "transferAmount": 200
                  },
                  {
                    "paFiscalCode": "22222222222",
                    "digitalStamp": false,
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
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART",
              "UNKNOWN"
            ]
          },
          "authToken": {
            "type": "string"
          },
          "idCart": {
            "description": "Cart identifier provided by creditor institution",
            "type": "string",
            "example": "idCartFromCreditorInstitution"
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
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 999999999
      },
      "TransactionStatus": {
        "type": "string",
        "description": "Possible statuses a transaction can be in",
        "enum": [
          "ACTIVATED",
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
      "NewTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/NewTransactionRequest"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "Authentication opaque token realeased by authorization service for checkout",
        "bearerFormat": "opaque token"
      }
    }
  }
}
