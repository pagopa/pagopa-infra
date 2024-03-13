{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "PagoPA API Debt Position for PN ${service}",
    "description" : "Progetto Gestione Posizioni Debitorie per PN",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.11.7"
  },
  "servers" : [ {
    "url": "${host}/${service}/v1",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "name" : "Payments API"
  } ],
  "paths" : {
    "/organizations/{organizationfiscalcode}/paymentoptions/{iuv}/notificationfee" : {
      "put" : {
        "tags" : [ "Payments API" ],
        "summary" : "The organization updates the notification fee of a payment option.",
        "operationId" : "updateNotificationFee",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "iuv",
          "in" : "path",
          "description" : "IUV (Unique Payment Identification). Alphanumeric code that uniquely associates and identifies three key elements of a payment: reason, payer, amount",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/NotificationFeeUpdateModel"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "422" : {
            "description" : "Unprocessable payment option.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "400" : {
            "description" : "Malformed request.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404" : {
            "description" : "No payment option found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200" : {
            "description" : "Request updated.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentsModelResponse"
                }
              }
            }
          },
          "209" : {
            "description" : "Request updated with a payment in progress.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentsModelResponse"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/organizations/{organizationfiscalcode}/paymentoptions/{nav}" : {
      "get" : {
        "tags" : [ "Payments API" ],
        "summary" : "Return the details of a specific payment option.",
        "operationId" : "getOrganizationPaymentOptionByNAV",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "nav",
          "in" : "path",
          "description" : "NAV (notice number) is the unique reference assigned to the payment by a creditor institution.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "200" : {
            "description" : "Obtained payment option details.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentsWithDebtorInfoModelResponse"
                }
              }
            }
          },
          "404" : {
            "description" : "No payment option found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/info" : {
      "get" : {
        "tags" : [ "Home" ],
        "summary" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "200" : {
            "description" : "OK.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/AppInfo"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    }
  },
  "components" : {
    "schemas" : {
      "NotificationFeeUpdateModel" : {
        "required" : [ "notificationFee" ],
        "type" : "object",
        "properties" : {
          "notificationFee" : {
            "type" : "integer",
            "format" : "int64"
          }
        }
      },
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          }
        }
      },
      "PaymentOptionMetadataModelResponse" : {
        "type" : "object",
        "properties" : {
          "key" : {
            "type" : "string"
          },
          "value" : {
            "type" : "string"
          }
        }
      },
      "PaymentsModelResponse" : {
        "type" : "object",
        "properties" : {
          "nav" : {
            "type" : "string"
          },
          "iuv" : {
            "type" : "string"
          },
          "organizationFiscalCode" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "description" : {
            "type" : "string"
          },
          "isPartialPayment" : {
            "type" : "boolean"
          },
          "dueDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "retentionDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "reportingDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "insertedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "fee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "notificationFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "pspCompany" : {
            "type" : "string"
          },
          "idReceipt" : {
            "type" : "string"
          },
          "idFlowReporting" : {
            "type" : "string"
          },
          "status" : {
            "type" : "string",
            "enum" : [ "PO_UNPAID", "PO_PAID", "PO_PARTIALLY_REPORTED", "PO_REPORTED" ]
          },
          "lastUpdatedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "lastUpdatedDateNotificationFee" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentOptionMetadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentOptionMetadataModelResponse"
            }
          },
          "transfer" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentsTransferModelResponse"
            }
          }
        }
      },
      "PaymentsTransferModelResponse" : {
        "type" : "object",
        "properties" : {
          "organizationFiscalCode" : {
            "type" : "string"
          },
          "idTransfer" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "remittanceInformation" : {
            "type" : "string"
          },
          "category" : {
            "type" : "string"
          },
          "iban" : {
            "type" : "string"
          },
          "postalIban" : {
            "type" : "string"
          },
          "stamp" : {
            "$ref" : "#/components/schemas/Stamp"
          },
          "insertedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "status" : {
            "type" : "string",
            "enum" : [ "T_UNREPORTED", "T_REPORTED" ]
          },
          "lastUpdatedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "transferMetadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferMetadataModelResponse"
            }
          }
        }
      },
      "Stamp" : {
        "required" : [ "hashDocument", "provincialResidence", "stampType" ],
        "type" : "object",
        "properties" : {
          "hashDocument" : {
            "type" : "string",
            "description" : "Document hash"
          },
          "stampType" : {
            "maxLength" : 2,
            "minLength" : 2,
            "type" : "string",
            "description" : "The type of the stamp"
          },
          "provincialResidence" : {
            "pattern" : "[A-Z]{2}",
            "type" : "string",
            "description" : "The provincial of the residence",
            "example" : "RM"
          }
        }
      },
      "TransferMetadataModelResponse" : {
        "type" : "object",
        "properties" : {
          "key" : {
            "type" : "string"
          },
          "value" : {
            "type" : "string"
          }
        }
      },
      "PaymentsWithDebtorInfoModelResponse" : {
        "type" : "object",
        "properties" : {
          "nav" : {
            "type" : "string"
          },
          "iuv" : {
            "type" : "string"
          },
          "organizationFiscalCode" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "description" : {
            "type" : "string"
          },
          "isPartialPayment" : {
            "type" : "boolean"
          },
          "dueDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "retentionDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "reportingDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "insertedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "fee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "notificationFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "pspCompany" : {
            "type" : "string"
          },
          "idReceipt" : {
            "type" : "string"
          },
          "idFlowReporting" : {
            "type" : "string"
          },
          "status" : {
            "type" : "string",
            "enum" : [ "PO_UNPAID", "PO_PAID", "PO_PARTIALLY_REPORTED", "PO_REPORTED" ]
          },
          "paymentOptionMetadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentOptionMetadataModelResponse"
            }
          },
          "iupd" : {
            "type" : "string"
          },
          "type" : {
            "type" : "string",
            "enum" : [ "F", "G" ]
          },
          "fiscalCode" : {
            "type" : "string"
          },
          "fullName" : {
            "type" : "string"
          },
          "streetName" : {
            "type" : "string"
          },
          "civicNumber" : {
            "type" : "string"
          },
          "postalCode" : {
            "type" : "string"
          },
          "city" : {
            "type" : "string"
          },
          "province" : {
            "type" : "string"
          },
          "region" : {
            "type" : "string"
          },
          "country" : {
            "type" : "string"
          },
          "email" : {
            "type" : "string"
          },
          "phone" : {
            "type" : "string"
          },
          "companyName" : {
            "type" : "string"
          },
          "officeName" : {
            "type" : "string"
          },
          "debtPositionStatus" : {
            "type" : "string",
            "enum" : [ "DRAFT", "PUBLISHED", "VALID", "INVALID", "EXPIRED", "PARTIALLY_PAID", "PAID", "REPORTED" ]
          },
          "transfer" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentsTransferModelResponse"
            }
          }
        }
      },
      "AppInfo" : {
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          },
          "environment" : {
            "type" : "string"
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "type" : "apiKey",
        "description" : "The API key to access this function app.",
        "name" : "Ocp-Apim-Subscription-Key",
        "in" : "header"
      },
      "Authorization" : {
        "type" : "http",
        "description" : "JWT token get after Azure Login",
        "scheme" : "bearer",
        "bearerFormat" : "JWT"
      }
    }
  }
}
