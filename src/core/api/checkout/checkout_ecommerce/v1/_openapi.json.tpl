{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa eCommerce services for Checkout",
    "description": "This microservice that expose eCommerce services to Checkout."
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/payment-requests/{rpt_id}": {
      "get": {
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
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "New transaction successfully created",
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
                  "$ref": "#/components/schemas/ValidationFaultPaymentProblemJson"
                }
              }
            }
          },
          "409": {
            "description": "Conflict on payment status",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentStatusFaultPaymentProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "PagoPA services are not available or request is rejected by PagoPa",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GatewayFaultPaymentProblemJson"
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
          },
          "504": {
            "description": "Timeout from PagoPA services",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PartyTimeoutFaultPaymentProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/transactions": {
      "post": {
        "operationId": "newTransaction",
        "summary": "Make a new transaction",
        "requestBody": {
          "$ref": "#/components/requestBodies/NewTransactionRequest"
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
          }
        }
      }
    },
    "/transactions/{transactionId}": {
      "get": {
        "operationId": "getTransactionInfo",
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
        "summary": "Get information about a specific transaction",
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
          "404": {
            "description": "Transaction not found",
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
    "/transactions/{transactionId}/auth-request": {
      "summary": "Request authorization for the transaction identified by payment token",
      "post": {
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
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/RequestAuthorizationRequest"
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
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/PaymentMethodResponse"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/payment-methods/{id}": {
      "get": {
        "operationId": "getPaymentMethod",
        "summary": "Retrive payment method by ID",
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
    "/payment-methods/psps": {
      "get": {
        "operationId": "getPSPs",
        "summary": "Retrieve psps",
        "parameters": [
          {
            "in": "query",
            "name": "amount",
            "schema": {
              "type": "integer"
            },
            "description": "Amount in cents",
            "required": false
          },
          {
            "in": "query",
            "name": "lang",
            "schema": {
              "type": "string",
              "enum": [
                "IT",
                "EN",
                "FR",
                "DE",
                "SL"
              ]
            },
            "description": "Service language",
            "required": false
          },
          {
            "in": "query",
            "name": "paymentTypeCode",
            "schema": {
              "type": "string"
            },
            "description": "Payment Type Code",
            "required": false
          }
        ],
        "responses": {
          "200": {
            "description": "PSP list successfully retrieved",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PSPsResponse"
                }
              }
            }
          }
        }
      }
    },
    "/payment-methods/{id}/psps": {
      "get": {
        "operationId": "getPaymentMethodsPSPs",
        "summary": "Retrive PSPs by payment method ID",
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
            "in": "query",
            "name": "amount",
            "schema": {
              "type": "integer"
            },
            "description": "Amount in cents",
            "required": false
          },
          {
            "in": "query",
            "name": "lang",
            "schema": {
              "type": "string",
              "enum": [
                "IT",
                "EN",
                "FR",
                "DE",
                "SL"
              ]
            },
            "description": "Service language",
            "required": false
          }
        ],
        "responses": {
          "200": {
            "description": "New payment method successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PSPsResponse"
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
      "PaymentMethodRequest": {
        "type": "object",
        "description": "New Payment Instrument Request",
        "properties": {
          "name": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ENABLED",
              "DISABLED",
              "INCOMING"
            ]
          },
          "paymentTypeCode": {
            "type": "string"
          },
          "ranges": {
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
            "minimum": 0
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
            "type": "string",
            "pattern": "([a-zA-Z0-9]{1,35})|(RFd{2}[a-zA-Z0-9]{1,21})"
          },
          "paFiscalCode": {
            "type": "string",
            "minLength": 11,
            "maxLength": 11
          },
          "paName": {
            "type": "string",
            "minLength": 1,
            "maxLength": 70
          },
          "description": {
            "type": "string",
            "minLength": 1,
            "maxLength": 140
          },
          "amount": {
            "type": "integer",
            "minimum": 0,
            "maximum": 99999999
          },
          "paymentContextCode": {
            "type": "string",
            "minLength": 32,
            "maxLength": 32
          },
          "dueDate": {
            "type": "string",
            "pattern": "([0-9]{4})-(1[0-2]|0[1-9])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])",
            "example": "2025-07-31"
          }
        },
        "required": [
          "amount",
          "paymentContextCode"
        ]
      },
      "ValidationFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/ValidationFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PaymentStatusFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PaymentStatusFault"
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
            "$ref": "#/components/schemas/FaultCategory"
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
            "$ref": "#/components/schemas/FaultCategory"
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
      "PartyTimeoutFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment an operations.",
        "type": "object",
        "properties": {
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PartyTimeoutFault"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "FaultCategory": {
        "description": "Fault code categorization for the PagoPA Verifica and Attiva operations.\nPossible categories are:\n- `PAYMENT_DUPLICATED`\n- `PAYMENT_ONGOING`\n- `PAYMENT_EXPIRED`\n- `PAYMENT_UNAVAILABLE`\n- `PAYMENT_UNKNOWN`\n- `DOMAIN_UNKNOWN`\n- `PAYMENT_CANCELED`\n- `GENERIC_ERROR`",
        "type": "string",
        "enum": [
          "PAYMENT_DUPLICATED",
          "PAYMENT_ONGOING",
          "PAYMENT_EXPIRED",
          "PAYMENT_UNAVAILABLE",
          "PAYMENT_UNKNOWN",
          "DOMAIN_UNKNOWN",
          "PAYMENT_CANCELED",
          "GENERIC_ERROR"
        ]
      },
      "PaymentStatusFault": {
        "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_PAGAMENTO_IN_CORSO`\n- `PAA_PAGAMENTO_IN_CORSO`\n- `PPT_PAGAMENTO_DUPLICATO`\n- `PAA_PAGAMENTO_DUPLICATO`\n- `PAA_PAGAMENTO_SCADUTO`",
        "type": "string",
        "enum": [
          "PPT_PAGAMENTO_IN_CORSO",
          "PAA_PAGAMENTO_IN_CORSO",
          "PPT_PAGAMENTO_DUPLICATO",
          "PAA_PAGAMENTO_DUPLICATO",
          "PAA_PAGAMENTO_SCADUTO"
        ]
      },
      "ValidationFault": {
        "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_SCONOSCIUTO`\n- `PPT_DOMINIO_SCONOSCIUTO`\n- `PPT_INTERMEDIARIO_PA_SCONOSCIUTO`\n- `PPT_STAZIONE_INT_PA_SCONOSCIUTA`\n- `PAA_PAGAMENTO_ANNULLATO`",
        "type": "string",
        "enum": [
          "PAA_PAGAMENTO_SCONOSCIUTO",
          "PPT_DOMINIO_SCONOSCIUTO",
          "PPT_INTERMEDIARIO_PA_SCONOSCIUTO",
          "PPT_STAZIONE_INT_PA_SCONOSCIUTA",
          "PAA_PAGAMENTO_ANNULLATO"
        ]
      },
      "GatewayFault": {
        "description": "Fault codes for generic downstream services errors, should be mapped to 502 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `GENERIC_ERROR`\n- `PPT_SINTASSI_EXTRAXSD`\n- `PPT_SINTASSI_XSD`\n- `PPT_PSP_SCONOSCIUTO`\n- `PPT_PSP_DISABILITATO`\n- `PPT_INTERMEDIARIO_PSP_SCONOSCIUTO`\n- `PPT_INTERMEDIARIO_PSP_DISABILITATO`\n- `PPT_CANALE_SCONOSCIUTO`\n- `PPT_CANALE_DISABILITATO`\n- `PPT_AUTENTICAZIONE`\n- `PPT_AUTORIZZAZIONE`\n- `PPT_CODIFICA_PSP_SCONOSCIUTA`\n- `PAA_SEMANTICA`\n- `PPT_SEMANTICA`\n- `PPT_SYSTEM_ERROR`\n- `PAA_SYSTEM_ERROR`",
        "type": "string",
        "enum": [
          "GENERIC_ERROR",
          "PPT_SINTASSI_EXTRAXSD",
          "PPT_SINTASSI_XSD",
          "PPT_PSP_SCONOSCIUTO",
          "PPT_PSP_DISABILITATO",
          "PPT_INTERMEDIARIO_PSP_SCONOSCIUTO",
          "PPT_INTERMEDIARIO_PSP_DISABILITATO",
          "PPT_CANALE_SCONOSCIUTO",
          "PPT_CANALE_DISABILITATO",
          "PPT_AUTENTICAZIONE",
          "PPT_AUTORIZZAZIONE",
          "PPT_CODIFICA_PSP_SCONOSCIUTA",
          "PAA_SEMANTICA",
          "PPT_SEMANTICA",
          "PPT_SYSTEM_ERROR",
          "PAA_SYSTEM_ERROR"
        ]
      },
      "PartyConfigurationFault": {
        "description": "Fault codes for fatal errors from ECs, should be mapped to 503 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_DOMINIO_DISABILITATO`\n- `PPT_INTERMEDIARIO_PA_DISABILITATO`\n- `PPT_STAZIONE_INT_PA_DISABILITATA`\n- `PPT_ERRORE_EMESSO_DA_PAA`\n- `PPT_STAZIONE_INT_PA_ERRORE_RESPONSE`\n- `PPT_IBAN_NON_CENSITO`\n- `PAA_SINTASSI_EXTRAXSD`\n- `PAA_SINTASSI_XSD`\n- `PAA_ID_DOMINIO_ERRATO`\n- `PAA_ID_INTERMEDIARIO_ERRATO`\n- `PAA_STAZIONE_INT_ERRATA`\n- `PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO`",
        "type": "string",
        "enum": [
          "PPT_DOMINIO_DISABILITATO",
          "PPT_INTERMEDIARIO_PA_DISABILITATO",
          "PPT_STAZIONE_INT_PA_DISABILITATA",
          "PPT_ERRORE_EMESSO_DA_PAA",
          "PPT_STAZIONE_INT_PA_ERRORE_RESPONSE",
          "PPT_IBAN_NON_CENSITO",
          "PAA_SINTASSI_EXTRAXSD",
          "PAA_SINTASSI_XSD",
          "PAA_ID_DOMINIO_ERRATO",
          "PAA_ID_INTERMEDIARIO_ERRATO",
          "PAA_STAZIONE_INT_ERRATA",
          "PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO"
        ]
      },
      "PartyTimeoutFault": {
        "description": "Fault codes for timeout errors, should be mapped to 504 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_STAZIONE_INT_PA_TIMEOUT`\n- `PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE`\n- `PPT_STAZIONE_INT_PA_SERVIZIO_NONATTIVO`\n- `GENERIC_ERROR`",
        "type": "string",
        "enum": [
          "PPT_STAZIONE_INT_PA_TIMEOUT",
          "PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE",
          "PPT_STAZIONE_INT_PA_SERVIZIO_NONATTIVO",
          "GENERIC_ERROR"
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
      "NewTransactionRequest": {
        "type": "object",
        "description": "Request body for creating a new transaction",
        "properties": {
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "paymentContextCode": {
            "$ref": "#/components/schemas/PaymentContextCode"
          },
          "email": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "rptId",
          "email",
          "amount"
        ],
        "example": {
          "rptId": "string"
        }
      },
      "NewTransactionResponse": {
        "type": "object",
        "description": "Transaction data returned when creating a new transaction",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          },
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
          },
          "reason": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "authToken": {
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "amount",
          "status"
        ],
        "example": {
          "amount": 200
        }
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
          }
        },
        "required": [
          "amount",
          "fee",
          "paymentInstrumentId",
          "pspId",
          "language"
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
          "timestampOperation": "2022-02-11T12:00:00.000Z"
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
          }
        },
        "required": [
          "authorizationUrl"
        ],
        "example": {
          "authorizationUrl": "https://example.com"
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
              }
            },
            "required": [
              "status"
            ]
          }
        ],
        "example": {
          "amount": 200,
          "status": "ACTIVATED"
        }
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
          "ACTIVATION_REQUESTED",
          "ACTIVATED",
          "AUTHORIZATION_REQUESTED",
          "AUTHORIZED",
          "AUTHORIZATION_FAILED",
          "CLOSED",
          "CLOSURE_FAILED",
          "NOTIFIED",
          "NOTIFIED_FAILED"
        ]
      },
      "PaymentMethodResponse": {
        "type": "object",
        "description": "Payment method Response",
        "properties": {
          "id": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ENABLED",
              "DISABLED",
              "INCOMING"
            ]
          },
          "paymentTypeCode": {
            "type": "string"
          },
          "ranges": {
            "type": "array",
            "minItems": 1,
            "items": {
              "$ref": "#/components/schemas/Range"
            }
          }
        },
        "required": [
          "id",
          "name",
          "description",
          "status",
          "paymentTypeCode",
          "ranges"
        ]
      },
      "PSPsResponse": {
        "type": "object",
        "description": "Get available PSP list Response",
        "properties": {
          "psp": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Psp"
            }
          }
        }
      },
      "Psp": {
        "type": "object",
        "description": "PSP object",
        "properties": {
          "code": {
            "type": "string"
          },
          "paymentTypeCode": {
            "type": "string"
          },
          "channelCode": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "ENABLED",
              "DISABLED",
              "INCOMING"
            ]
          },
          "businessName": {
            "type": "string"
          },
          "brokerName": {
            "type": "string"
          },
          "language": {
            "type": "string",
            "enum": [
              "IT",
              "EN",
              "FR",
              "DE",
              "SL"
            ]
          },
          "minAmount": {
            "type": "number",
            "format": "double"
          },
          "maxAmount": {
            "type": "number",
            "format": "double"
          },
          "fixedCost": {
            "type": "number",
            "format": "double"
          }
        },
        "required": [
          "code",
          "paymentMethodID",
          "description",
          "status",
          "type",
          "name",
          "brokerName",
          "language",
          "minAmount",
          "maxAmount",
          "fixedCost"
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
      }
    }
  }
}