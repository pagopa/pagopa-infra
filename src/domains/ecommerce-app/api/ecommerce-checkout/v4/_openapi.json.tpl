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
      "name": "ecommerce-methods-handler",
      "description": "Api's for retrieve payment methods for performing transactions payment",
    },
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
    "/auth/payment-methods": {
      "post": {
        "tags": [
          "ecommerce-methods-handler"
        ],
        "operationId": "getAllPaymentMethodsAuth",
        "summary": "Retrieve all Payment Methods (by filter)",
        "description": "GET with body payload - no resources created: API for retrieve payment method using the request query parameter filters",
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PaymentMethodsRequest"
              }
            }
          },
          "required": true
        },
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
            "description": "Unauthorized",
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
  },
  "components": {
    "schemas": {
      "PaymentMethodsRequest": {
        "required": [
          "paymentNotice",
          "totalAmount",
          "userTouchpoint"
        ],
        "type": "object",
        "properties": {
          "userTouchpoint": {
            "type": "string",
            "enum": [
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART"
            ]
          },
          "userDevice": {
            "type": "string",
            "enum": [
              "IOS",
              "ANDROID",
              "WEB",
              "SAFARI"
            ]
          },
          "totalAmount": {
            "type": "integer",
            "format": "int64"
          },
          "paymentNotice": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentNoticeItem"
            }
          },
          "allCCp": {
            "type": "boolean"
          },
          "targetKey": {
            "type": "string"
          }
        }
      },
      "PaymentNoticeItem": {
        "required": [
          "paymentAmount",
          "primaryCreditorInstitution"
        ],
        "type": "object",
        "properties": {
          "paymentAmount": {
            "type": "integer",
            "format": "int64"
          },
          "primaryCreditorInstitution": {
            "type": "string"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransferListItem"
            }
          }
        }
      },
      "TransferListItem": {
        "required": [
          "creditorInstitution"
        ],
        "type": "object",
        "properties": {
          "creditorInstitution": {
            "type": "string"
          },
          "transferCategory": {
            "type": "string"
          },
          "digitalStamp": {
            "type": "boolean"
          }
        }
      },
      "FeeRange": {
        "required": [
          "max",
          "min"
        ],
        "type": "object",
        "properties": {
          "min": {
            "type": "integer",
            "format": "int64"
          },
          "max": {
            "type": "integer",
            "format": "int64"
          }
        }
      },
      "PaymentMethodResponse": {
        "required": [
          "description",
          "feeRange",
          "paymentTypeCode",
          "methodManagement",
          "name",
          "paymentMethodAsset",
          "id",
          "paymentMethodTypes",
          "status",
          "validityDateFrom"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "name": {
            "type": "object",
            "additionalProperties": {
              "type": "string"
            }
          },
          "description": {
            "type": "object",
            "additionalProperties": {
              "type": "string"
            }
          },
          "status": {
            "type": "string",
            "enum": [
              "ENABLED",
              "DISABLED",
              "MAINTENANCE"
            ]
          },
          "validityDateFrom": {
            "type": "string",
            "format": "date"
          },
          "paymentTypeCode": {
            "type": "string",
            "enum": [
              "CP",
              "MYBK",
              "BPAY",
              "PPAL",
              "RPIC",
              "RBPS",
              "SATY",
              "APPL",
              "RICO",
              "RBPB",
              "RBPP",
              "RBPR",
              "GOOG",
              "KLRN"
            ]
          },
          "paymentMethodTypes": {
            "type": "array",
            "items": {
              "type": "string",
              "enum": [
                "CARTE",
                "CONTO",
                "APP"
              ]
            }
          },
          "feeRange": {
            "$ref": "#/components/schemas/FeeRange"
          },
          "paymentMethodAsset": {
            "type": "string"
          },
          "methodManagement": {
            "type": "string",
            "enum": [
              "ONBOARDABLE",
              "ONBOARDABLE_ONLY",
              "NOT_ONBOARDABLE",
              "REDIRECT"
            ]
          },
          "disabledReason": {
            "type": "string",
            "enum": [
              "AMOUNT_OUT_OF_BOUND",
              "MAINTENANCE_IN_PROGRESS",
              "METHOD_DISABLED",
              "NOT_YET_VALID",
              "TARGET_PREVIEW",
              "NO_BUNDLE_AVAILABLE"
            ]
          },
          "paymentMethodsBrandAssets": {
            "type": "object",
            "additionalProperties": {
              "type": "string"
            }
          },
          "metadata": {
            "type": "object",
            "additionalProperties": {
              "type": "string"
            }
          }
        }
      },
      "PaymentMethodsResponse": {
        "required": [
          "paymentMethods"
        ],
        "type": "object",
        "properties": {
          "paymentMethods": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentMethodResponse"
            }
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
      }
    },
    "requestBodies": {
      "PaymentMethodsRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/PaymentMethodsRequest"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "Authentication opaque token released by authorization service for checkout",
        "bearerFormat": "opaque token"
      }
    }
  }
}
