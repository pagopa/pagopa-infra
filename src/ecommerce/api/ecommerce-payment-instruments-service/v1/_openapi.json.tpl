{
  "openapi": "3.0.0",
  "info": {
    "version": "0.1.0",
    "title": "Pagopa eCommerce payment instruments service",
    "description": "This microservice handles payment instruments."
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/payment-instruments": {
      "post": {
        "operationId": "newPaymentInstrument",
        "summary": "Make a new payment instruments",
        "requestBody": {
          "$ref": "#/components/requestBodies/PaymentInstrumentRequest"
        },
        "responses": {
          "200": {
            "description": "New payment instrument successfully created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentInstrumentResponse"
                }
              }
            }
          }
        }
      },
      "get": {
        "operationId": "getAllPaymentInstruments",
        "summary": "Retrive all Payment Instruments",
        "responses": {
          "200": {
            "description": "Payment instrument successfully retrived",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/PaymentInstrumentResponse"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/payment-instruments/{id}": {
      "patch": {
        "operationId": "patchPaymentInstrument",
        "summary": "Update payment instruments",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Payment Instrument ID",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/PatchPaymentInstrumentRequest"
        },
        "responses": {
          "200": {
            "description": "Payment instrument successfully retrived",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentInstrumentResponse"
                }
              }
            }
          }
        }
      },
      "get": {
        "operationId": "getPaymentInstrument",
        "summary": "Retrive payment instrument by ID",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Payment Instrument ID",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "New payment instrument successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentInstrumentResponse"
                }
              }
            }
          }
        }
      }
    },
    "/payment-instruments/psps": {
      "put": {
        "operationId": "scheduleUpdatePSPs",
        "summary": "Update psps list",
        "responses": {
          "200": {
            "description": "Update successfully scheduled"
          }
        }
      },
      "get": {
        "operationId": "getPSPs",
        "summary": "Retrieve payment instrument by ID",
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
    }
  },
  "components": {
    "schemas": {
      "PaymentInstrumentRequest": {
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
          "type": {
            "type": "string"
          }
        },
        "required": [
          "name",
          "description",
          "status"
        ]
      },
      "PatchPaymentInstrumentRequest": {
        "type": "object",
        "description": "Patch Payment Instrument Request",
        "properties": {
          "status": {
            "type": "string",
            "enum": [
              "ENABLED",
              "DISABLED",
              "INCOMING"
            ]
          }
        },
        "required": [
          "status"
        ]
      },
      "PaymentInstrumentResponse": {
        "type": "object",
        "description": "New Payment Instrument Response",
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
          }
        },
        "required": [
          "id",
          "name",
          "description",
          "status"
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
          "paymentInstrumentID",
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
      "PaymentInstrumentRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/PaymentInstrumentRequest"
            }
          }
        }
      },
      "PatchPaymentInstrumentRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/PatchPaymentInstrumentRequest"
            }
          }
        }
      }
    }
  }
}