{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Service - Biz-Events Helpdesk",
    "description": "Microservice for exposing REST APIs for bizevent Helpdesk.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.1.69"
  },
  "servers": [
    {
      "url": "http://localhost:8080"
    },
    {
      "url": "https://api.platform.pagopa.it/bizevents/helpdesk/v1"
    }
  ],
  "paths": {
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
          "required": false,
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/events/{biz-event-id}": {
      "get": {
        "tags": [
          "Biz-Events Helpdesk"
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
          "required": false,
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/events/organizations/{organization-fiscal-code}/iuvs/{iuv}": {
      "get": {
        "tags": [
          "Biz-Events Helpdesk"
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
          "required": false,
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  },
  "components": {
    "schemas": {
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
              "DONE",
              "INGESTED"
            ]
          },
          "eventRetryEnrichmentCount": {
            "type": "integer",
            "format": "int32"
          },
          "_ts": {
            "type": "string",
            "format": "date-time"
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
      "Debtor": {
        "type": "object",
        "properties": {
          "fullName": {
            "type": "string"
          },
          "entityUniqueIdentifierType": {
            "type": "string"
          },
          "entityUniqueIdentifierValue": {
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
          },
          "iur": {
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
      "InfoTransaction": {
        "type": "object",
        "properties": {
          "brand": {
            "type": "string"
          },
          "brandLogo": {
            "type": "string"
          },
          "clientId": {
            "type": "string"
          },
          "paymentMethodName": {
            "type": "string"
          },
          "type": {
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
        "type": "object",
        "properties": {
          "fullName": {
            "type": "string"
          },
          "entityUniqueIdentifierType": {
            "type": "string"
          },
          "entityUniqueIdentifierValue": {
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
          },
          "IUR": {
            "type": "string"
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
      "Transaction": {
        "type": "object",
        "properties": {
          "idTransaction": {
            "type": "string"
          },
          "transactionId": {
            "type": "string"
          },
          "grandTotal": {
            "type": "integer",
            "format": "int64"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "fee": {
            "type": "integer",
            "format": "int64"
          },
          "transactionStatus": {
            "type": "string"
          },
          "accountingStatus": {
            "type": "string"
          },
          "rrn": {
            "type": "string"
          },
          "authorizationCode": {
            "type": "string"
          },
          "creationDate": {
            "type": "string"
          },
          "numAut": {
            "type": "string"
          },
          "accountCode": {
            "type": "string"
          },
          "psp": {
            "$ref": "#/components/schemas/TransactionPsp"
          },
          "origin": {
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
          },
          "origin": {
            "type": "string"
          },
          "transaction": {
            "$ref": "#/components/schemas/Transaction"
          },
          "info": {
            "$ref": "#/components/schemas/InfoTransaction"
          }
        }
      },
      "TransactionPsp": {
        "type": "object",
        "properties": {
          "idChannel": {
            "type": "string"
          },
          "businessName": {
            "type": "string"
          },
          "serviceName": {
            "type": "string"
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
              "G",
              "GUEST",
              "REGISTERED"
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
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The Azure Subscription Key to access this API.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
