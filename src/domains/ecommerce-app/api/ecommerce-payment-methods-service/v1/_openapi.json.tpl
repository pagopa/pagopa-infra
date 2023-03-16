{
  "openapi": "3.0.0",
  "info": {
    "version": "0.1.0",
    "title": "Pagopa eCommerce payment methods service",
    "description": "This microservice handles payment methods."
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/payment-methods": {
      "post": {
        "operationId": "newPaymentMethod",
        "summary": "Make a new payment method",
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
        "operationId": "patchPaymentMethod",
        "summary": "Update payment method",
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
    "/payment-methods/{id}/fee/calculate": {
      "post": {
        "operationId": "calculateFees",
        "summary": "Retrieve payment method psps",
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
    }
  },
  "components": {
    "schemas": {
      "PaymentMethodRequest": {
        "type": "object",
        "description": "New Payment method Request",
        "properties": {
          "name": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "asset": {
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
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
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "asset": {
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
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
      "CalculateFeeRequest": {
        "type": "object",
        "properties": {
          "touchpoint": {
            "type": "string"
          },
          "bin": {
            "type": "string"
          },
          "idPspList": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
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
        },
        "required": [
          "paymentAmount",
          "primaryCreditorInstitution",
          "transferList",
          "touchpoint"
        ]
      },
      "CalculateFeeResponse": {
        "type": "object",
        "properties": {
          "paymentMethodName": {
            "type": "string"
          },
          "paymentMethodStatus": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
          },
          "belowThreshold": {
            "type": "boolean"
          },
          "bundles": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Bundle"
            }
          }
        },
        "required": [
          "bundles",
          "paymentMethodName",
          "paymentMethodStatus"
        ]
      },
      "Bundle": {
        "type": "object",
        "properties": {
          "abi": {
            "type": "string"
          },
          "bundleDescription": {
            "type": "string"
          },
          "bundleName": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "idBundle": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "idCiBundle": {
            "type": "string"
          },
          "idPsp": {
            "type": "string"
          },
          "onUs": {
            "type": "boolean"
          },
          "paymentMethod": {
            "type": "string"
          },
          "primaryCiIncurredFee": {
            "type": "integer",
            "format": "int64"
          },
          "taxPayerFee": {
            "type": "integer",
            "format": "int64"
          },
          "touchpoint": {
            "type": "string"
          }
        }
      },
      "TransferListItem": {
        "type": "object",
        "properties": {
          "creditorInstitution": {
            "type": "string"
          },
          "digitalStamp": {
            "type": "boolean"
          },
          "transferCategory": {
            "type": "string"
          }
        }
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "detail": {
            "type": "string"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "format": "int32",
            "example": 200
          },
          "title": {
            "type": "string"
          }
        }
      },
      "PaymentMethodStatus": {
        "type": "string",
        "description": "the payment method status",
        "enum": [
          "ENABLED",
          "DISABLED",
          "INCOMING"
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
      }
    }
  }
}