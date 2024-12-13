{
  "openapi": "3.0.0",
  "info": {
    "version": "2.0.0",
    "title": "Pagopa eCommerce payment transactions service",
    "description": "This microservice handles transaction's lifecycle and workflow.",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "transactions",
      "description": "Api's for performing a transaction",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611287199/-servizio+transactions+service",
        "description": "Technical specifications"
      }
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
    "description": "Design review"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "security": [
    {
      "ApiKeyAuth": []
    }
  ],
  "paths": {
    "/transactions/{transactionId}": {
      "get": {
        "tags": [
          "transactions"
        ],
        "operationId": "getTransactionInfo",
        "summary": "Get transaction information",
        "description": "Return information for the input specific transaction resource",
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
      }
    },
    "/transactions": {
      "post": {
        "operationId": "newTransaction",
        "tags": [
          "transactions"
        ],
        "description": "Create a new transaction activating the payments notice by meaning of 'Nodo' ActivatePaymentNotice primitive",
        "parameters": [
          {
            "in": "header",
            "name": "x-correlation-id",
            "required": true,
            "description": "Flow correlation id",
            "schema": {
              "$ref": "#/components/schemas/CorrelationId"
            }
          }
        ],
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
      "RptId": {
        "description": "Digital payment receipt identifier",
        "type": "string",
        "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
      },
      "PaymentNoticeInfo": {
        "description": "Informations about a single payment notice",
        "type": "object",
        "properties": {
          "rptId": {
            "$ref": "#/components/schemas/RptId"
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
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Transfer"
            },
            "minItems": 1,
            "maxItems": 5
          },
          "isAllCCP": {
            "type": "boolean",
            "description": "Flag for poste psp enabling in gec request"
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
      "TransactionInfo": {
        "description": "Transaction data returned when querying for an existing transaction",
        "type": "object",
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
            "enum": [
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART"
            ]
          },
          "nodeInfo":{
            "type": "object",
            "description": "Gateway infos",
            "properties": {
              "closePaymentResultError": {
                "type": "object",
                "description": "Error details for close payment result",
                "properties": {
                  "statusCode": {
                    "description": "Status code (4xx, 5xx) of the error received on the node",
                    "type": "number"
                  },
                  "description": {
                    "description": "Description of the error received on the node",
                    "type": "string"
                  }
                }
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
            }
          },
          "gatewayInfo":{
            "type": "object",
            "description": "Gateway infos",
            "properties": {
              "gateway": {
                "type": "string",
                "pattern": "NPG|REDIRECT",
                "description": "Payment gateway identifier"
              },
              "authorizationStatus": {
                "type": "string",
                "description": "Payment gateway authorization status"
              },
              "authorizationCode": {
                "type": "string",
                "description": "Payment gateway-specific authorization code related to the transaction"
              },
              "errorCode": {
                "type": "string",
                "description": "Payment gateway-specific error code from the gateway"
              },
            }
          },
        },
        "required": [
          "status",
          "transactionId",
          "payments"
        ]
      },
      "NewTransactionRequest": {
        "description": "Request body for creating a new transaction",
        "type": "object",
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
                "amount": 100
              },
              {
                "rptId": "77777777777302012387654312385",
                "amount": 200
              }
            ]
          },
          "email": {
            "description": "Email string format",
            "type": "string",
            "pattern": "(?:[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])",
            "example": "mario.rossi@gmail.it"
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
            "description": "the transaction unique identifier",
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
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
                "amount": 400,
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
          "clientId": {
            "description": "transaction client id",
            "enum": [
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART"
            ]
          },
          "authToken": {
            "description": "authorization token",
            "type": "string"
          },
          "idCart": {
            "description": "Cart identifier provided by creditor institution",
            "type": "string",
            "example": "idCartFromCreditorInstitution"
          }
        },
        "required": [
          "transactionId",
          "status",
          "payments",
          "clientId"
        ]
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
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
      "CorrelationId": {
        "description": "correlationId",
        "type": "string",
        "format": "uuid"
      },
      "ProblemJson": {
        "description": "Body definition for error responses containing failure details",
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
      "ApiKeyAuth": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
