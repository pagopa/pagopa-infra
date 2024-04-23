{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API Debt Position",
    "description": "Progetto Gestione Posizioni Debitorie",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.11.19"
  },
  "servers": [
    {
      "url": "https://api.uat.platform.pagopa.it/gpd/api/v1/",
      "description": "Test environment"
    },
    {
      "url": "https://api.platform.pagopa.it/gpd/api/v1/",
      "description": "Production environment"
    }
  ],
  "tags": [
    {
      "name": "Debt Positions API"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
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
          "200": {
            "description": "OK.",
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
          "403": {
            "description": "Forbidden.",
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
            "ApiKey": []
          },
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
    "/organizations/{organizationfiscalcode}/debtpositions": {
      "put": {
        "tags": [
          "Debt Positions API"
        ],
        "summary": "The Organization updates multiple debt positions.",
        "operationId": "updateMultiplePositions",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "toPublish",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean",
              "default": false
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MultiplePaymentPositionModel"
              }
            }
          },
          "required": true
        },
        "responses": {
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
          "200": {
            "description": "Debt Positions updated.",
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
            "description": "Malformed request.",
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
          "409": {
            "description": "Conflict: existing related payment found.",
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
          },
          {
            "Authorization": []
          }
        ]
      },
      "delete": {
        "tags": [
          "Debt Positions API"
        ],
        "summary": "The Organization deletes multiple debt positions.",
        "operationId": "deleteMultipleDebtPositions",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "pattern": "\\b\\w{11}\\b",
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MultipleIUPDModel"
              }
            }
          },
          "required": true
        },
        "responses": {
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
          "409": {
            "description": "Payment Position not found.",
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
              "application/json": {}
            }
          },
          "200": {
            "description": "Debt Positions updated.",
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
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "Malformed request.",
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
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ]
      },
      "post": {
        "tags": [
          "Debt Positions API"
        ],
        "summary": "The Organization creates multiple debt positions.",
        "operationId": "createMultiplePositions",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "toPublish",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean",
              "default": false
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MultiplePaymentPositionModel"
              }
            }
          },
          "required": true
        },
        "responses": {
          "409": {
            "description": "Conflict: duplicate debt position found.",
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
          },
          "201": {
            "description": "Request created.",
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
          },
          "400": {
            "description": "Malformed request.",
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
          },
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
  },
  "components": {
    "schemas": {
      "NotificationFeeUpdateModel": {
        "required": [
          "notificationFee"
        ],
        "type": "object",
        "properties": {
          "notificationFee": {
            "type": "integer",
            "format": "int64"
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
      "PaymentOptionMetadataModelResponse": {
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
      "PaymentsModelResponse": {
        "type": "object",
        "properties": {
          "nav": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          },
          "organizationFiscalCode": {
            "type": "string"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "description": {
            "type": "string"
          },
          "isPartialPayment": {
            "type": "boolean"
          },
          "dueDate": {
            "type": "string",
            "format": "date-time"
          },
          "retentionDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentDate": {
            "type": "string",
            "format": "date-time"
          },
          "reportingDate": {
            "type": "string",
            "format": "date-time"
          },
          "insertedDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentMethod": {
            "type": "string"
          },
          "fee": {
            "type": "integer",
            "format": "int64"
          },
          "notificationFee": {
            "type": "integer",
            "format": "int64"
          },
          "pspCompany": {
            "type": "string"
          },
          "idReceipt": {
            "type": "string"
          },
          "idFlowReporting": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "PO_UNPAID",
              "PO_PAID",
              "PO_PARTIALLY_REPORTED",
              "PO_REPORTED"
            ]
          },
          "lastUpdatedDate": {
            "type": "string",
            "format": "date-time"
          },
          "lastUpdatedDateNotificationFee": {
            "type": "string",
            "format": "date-time"
          },
          "paymentOptionMetadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentOptionMetadataModelResponse"
            }
          },
          "transfer": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentsTransferModelResponse"
            }
          }
        }
      },
      "PaymentsTransferModelResponse": {
        "type": "object",
        "properties": {
          "organizationFiscalCode": {
            "type": "string"
          },
          "idTransfer": {
            "type": "string"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "category": {
            "type": "string"
          },
          "iban": {
            "type": "string"
          },
          "postalIban": {
            "type": "string"
          },
          "stamp": {
            "$ref": "#/components/schemas/Stamp"
          },
          "insertedDate": {
            "type": "string",
            "format": "date-time"
          },
          "status": {
            "type": "string",
            "enum": [
              "T_UNREPORTED",
              "T_REPORTED"
            ]
          },
          "lastUpdatedDate": {
            "type": "string",
            "format": "date-time"
          },
          "transferMetadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferMetadataModelResponse"
            }
          }
        }
      },
      "Stamp": {
        "required": [
          "hashDocument",
          "provincialResidence",
          "stampType"
        ],
        "type": "object",
        "properties": {
          "hashDocument": {
            "type": "string",
            "description": "Document hash"
          },
          "stampType": {
            "maxLength": 2,
            "minLength": 2,
            "type": "string",
            "description": "The type of the stamp"
          },
          "provincialResidence": {
            "pattern": "[A-Z]{2}",
            "type": "string",
            "description": "The provincial of the residence",
            "example": "RM"
          }
        }
      },
      "TransferMetadataModelResponse": {
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
      "MultiplePaymentPositionModel": {
        "required": [
          "paymentPositions"
        ],
        "type": "object",
        "properties": {
          "paymentPositions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentPositionModel"
            }
          }
        }
      },
      "PaymentOptionMetadataModel": {
        "required": [
          "key"
        ],
        "type": "object",
        "properties": {
          "key": {
            "type": "string"
          },
          "value": {
            "type": "string"
          }
        },
        "description": "it can added a maximum of 10 key-value pairs for metadata"
      },
      "PaymentOptionModel": {
        "required": [
          "amount",
          "description",
          "dueDate",
          "isPartialPayment",
          "iuv"
        ],
        "type": "object",
        "properties": {
          "nav": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "description": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string"
          },
          "isPartialPayment": {
            "type": "boolean"
          },
          "dueDate": {
            "type": "string",
            "format": "date-time"
          },
          "retentionDate": {
            "type": "string",
            "format": "date-time"
          },
          "fee": {
            "type": "integer",
            "format": "int64"
          },
          "notificationFee": {
            "type": "integer",
            "format": "int64",
            "readOnly": true
          },
          "transfer": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferModel"
            }
          },
          "paymentOptionMetadata": {
            "maxItems": 10,
            "minItems": 0,
            "type": "array",
            "description": "it can added a maximum of 10 key-value pairs for metadata",
            "items": {
              "$ref": "#/components/schemas/PaymentOptionMetadataModel"
            }
          }
        }
      },
      "PaymentPositionModel": {
        "required": [
          "companyName",
          "fiscalCode",
          "fullName",
          "iupd",
          "switchToExpired",
          "type"
        ],
        "type": "object",
        "properties": {
          "iupd": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "payStandIn": {
            "type": "boolean",
            "description": "feature flag to enable a debt position in stand-in mode",
            "example": true,
            "default": true
          },
          "fiscalCode": {
            "type": "string"
          },
          "fullName": {
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
          "province": {
            "type": "string"
          },
          "region": {
            "type": "string"
          },
          "country": {
            "pattern": "[A-Z]{2}",
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "phone": {
            "type": "string"
          },
          "switchToExpired": {
            "type": "boolean",
            "description": "feature flag to enable the debt position to expire after the due date",
            "example": false,
            "default": false
          },
          "companyName": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string"
          },
          "officeName": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string"
          },
          "validityDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentDate": {
            "type": "string",
            "format": "date-time",
            "readOnly": true
          },
          "status": {
            "type": "string",
            "readOnly": true,
            "enum": [
              "DRAFT",
              "PUBLISHED",
              "VALID",
              "INVALID",
              "EXPIRED",
              "PARTIALLY_PAID",
              "PAID",
              "REPORTED"
            ]
          },
          "paymentOption": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentOptionModel"
            }
          }
        }
      },
      "TransferMetadataModel": {
        "required": [
          "key"
        ],
        "type": "object",
        "properties": {
          "key": {
            "type": "string"
          },
          "value": {
            "type": "string"
          }
        },
        "description": "it can added a maximum of 10 key-value pairs for metadata"
      },
      "TransferModel": {
        "required": [
          "amount",
          "category",
          "idTransfer",
          "remittanceInformation"
        ],
        "type": "object",
        "properties": {
          "idTransfer": {
            "type": "string",
            "enum": [
              "1",
              "2",
              "3",
              "4",
              "5"
            ]
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "organizationFiscalCode": {
            "type": "string",
            "description": "Fiscal code related to the organization targeted by this transfer.",
            "example": "00000000000"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "category": {
            "type": "string"
          },
          "iban": {
            "type": "string",
            "description": "mutual exclusive with stamp",
            "example": "IT0000000000000000000000000"
          },
          "postalIban": {
            "type": "string",
            "description": "optional - can be combined with iban but not with stamp",
            "example": "IT0000000000000000000000000"
          },
          "stamp": {
            "$ref": "#/components/schemas/Stamp"
          },
          "transferMetadata": {
            "maxItems": 10,
            "minItems": 0,
            "type": "array",
            "description": "it can added a maximum of 10 key-value pairs for metadata",
            "items": {
              "$ref": "#/components/schemas/TransferMetadataModel"
            }
          }
        }
      },
      "PayPaymentOptionModel": {
        "required": [
          "idReceipt",
          "pspCompany"
        ],
        "type": "object",
        "properties": {
          "paymentDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentMethod": {
            "type": "string"
          },
          "pspCompany": {
            "type": "string"
          },
          "idReceipt": {
            "type": "string"
          },
          "fee": {
            "type": "string"
          }
        }
      },
      "PaymentsWithDebtorInfoModelResponse": {
        "type": "object",
        "properties": {
          "nav": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          },
          "organizationFiscalCode": {
            "type": "string"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "description": {
            "type": "string"
          },
          "isPartialPayment": {
            "type": "boolean"
          },
          "dueDate": {
            "type": "string",
            "format": "date-time"
          },
          "retentionDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentDate": {
            "type": "string",
            "format": "date-time"
          },
          "reportingDate": {
            "type": "string",
            "format": "date-time"
          },
          "insertedDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentMethod": {
            "type": "string"
          },
          "fee": {
            "type": "integer",
            "format": "int64"
          },
          "notificationFee": {
            "type": "integer",
            "format": "int64"
          },
          "pspCompany": {
            "type": "string"
          },
          "idReceipt": {
            "type": "string"
          },
          "idFlowReporting": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "PO_UNPAID",
              "PO_PAID",
              "PO_PARTIALLY_REPORTED",
              "PO_REPORTED"
            ]
          },
          "paymentOptionMetadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentOptionMetadataModelResponse"
            }
          },
          "iupd": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "fiscalCode": {
            "type": "string"
          },
          "fullName": {
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
          "province": {
            "type": "string"
          },
          "region": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "email": {
            "type": "string"
          },
          "phone": {
            "type": "string"
          },
          "companyName": {
            "type": "string"
          },
          "officeName": {
            "type": "string"
          },
          "debtPositionStatus": {
            "type": "string",
            "enum": [
              "DRAFT",
              "PUBLISHED",
              "VALID",
              "INVALID",
              "EXPIRED",
              "PARTIALLY_PAID",
              "PAID",
              "REPORTED"
            ]
          },
          "transfer": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentsTransferModelResponse"
            }
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
      "PaymentOptionModelResponse": {
        "type": "object",
        "properties": {
          "nav": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          },
          "organizationFiscalCode": {
            "type": "string"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "description": {
            "type": "string"
          },
          "isPartialPayment": {
            "type": "boolean"
          },
          "dueDate": {
            "type": "string",
            "format": "date-time"
          },
          "retentionDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentDate": {
            "type": "string",
            "format": "date-time"
          },
          "reportingDate": {
            "type": "string",
            "format": "date-time"
          },
          "insertedDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentMethod": {
            "type": "string"
          },
          "fee": {
            "type": "integer",
            "format": "int64"
          },
          "notificationFee": {
            "type": "integer",
            "format": "int64"
          },
          "pspCompany": {
            "type": "string"
          },
          "idReceipt": {
            "type": "string"
          },
          "idFlowReporting": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "PO_UNPAID",
              "PO_PAID",
              "PO_PARTIALLY_REPORTED",
              "PO_REPORTED"
            ]
          },
          "lastUpdatedDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentOptionMetadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentOptionMetadataModelResponse"
            }
          },
          "transfer": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferModelResponse"
            }
          }
        }
      },
      "PaymentPositionModelBaseResponse": {
        "type": "object",
        "properties": {
          "iupd": {
            "type": "string"
          },
          "organizationFiscalCode": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "companyName": {
            "type": "string"
          },
          "officeName": {
            "type": "string"
          },
          "insertedDate": {
            "type": "string",
            "format": "date-time"
          },
          "publishDate": {
            "type": "string",
            "format": "date-time"
          },
          "validityDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentDate": {
            "type": "string",
            "format": "date-time"
          },
          "status": {
            "type": "string",
            "enum": [
              "DRAFT",
              "PUBLISHED",
              "VALID",
              "INVALID",
              "EXPIRED",
              "PARTIALLY_PAID",
              "PAID",
              "REPORTED"
            ]
          },
          "lastUpdatedDate": {
            "type": "string",
            "format": "date-time"
          },
          "paymentOption": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentOptionModelResponse"
            }
          }
        }
      },
      "PaymentPositionsInfo": {
        "required": [
          "page_info",
          "payment_position_list"
        ],
        "type": "object",
        "properties": {
          "payment_position_list": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentPositionModelBaseResponse"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "TransferModelResponse": {
        "type": "object",
        "properties": {
          "organizationFiscalCode": {
            "type": "string"
          },
          "idTransfer": {
            "type": "string"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "category": {
            "type": "string"
          },
          "iban": {
            "type": "string"
          },
          "postalIban": {
            "type": "string"
          },
          "stamp": {
            "$ref": "#/components/schemas/Stamp"
          },
          "insertedDate": {
            "type": "string",
            "format": "date-time"
          },
          "status": {
            "type": "string",
            "enum": [
              "T_UNREPORTED",
              "T_REPORTED"
            ]
          },
          "lastUpdatedDate": {
            "type": "string",
            "format": "date-time"
          },
          "transferMetadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferMetadataModelResponse"
            }
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
      },
      "MultipleIUPDModel": {
        "required": [
          "paymentPositionIUPDs"
        ],
        "type": "object",
        "properties": {
          "paymentPositionIUPDs": {
            "maxItems": 100,
            "minItems": 0,
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      },
      "Authorization": {
        "type": "http",
        "description": "JWT token get after Azure Login",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      }
    }
  }
}
