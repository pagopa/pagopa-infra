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
    }
  },
  "components": {
    "schemas": {
      "PaymentNotice": {
        "description": "Payment notice data",
        "type": "object",
        "properties": {
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
          }
        },
        "required": [
          "paymentAmount",
          "primaryCreditorInstitution",
          "transferList"
        ]
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
          "paymentNotices": {
            "type": "array",
            "minItems": 1,
            "maxItems": 5,
            "items": {
              "$ref": "#/components/schemas/PaymentNotice"
            }
          },
          "isAllCCP": {
            "description": "Flag for the inclusion of Poste bundles. false -> excluded, true -> included",
            "type": "boolean"
          }
        },
        "required": [
          "paymentNotices",
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
      }
    },
    "requestBodies": {
      "PostPaymentMethodPSP": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/CalculateFeeRequest"
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
