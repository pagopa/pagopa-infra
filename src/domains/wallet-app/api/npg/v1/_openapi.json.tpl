{
    "openapi": "3.0.3",
    "info": {
      "version": "0.0.1,",
      "title": "pagoPA Wallet Notification API - OpenAPI 3.0",
      "description": "Notification API to implement callback providing order status updates after wallet creation on Nexi's NPG",
      "contact": {
        "name": "pagoPA - Touchpoints team"
      }
    },
    "tags": [
      {
        "name": "Wallet",
        "description": "Intercat with wallet"
      }
    ],
    "externalDocs": {
      "description": "Nexi API to handle Hosted Payment Page (HPP) payments",
      "url": "https://developer.nexigroup.com/it/api/post-orders-hpp"
    },
    "servers": [
      {
        "url": "https://${hostname}"
      }
    ],
    "paths": {
      "/notify": {
        "post": {
          "tags": [
            "notifyWallet"
          ],
          "summary": "Update Wallet on NPG payment instrument creation",
          "description": "Update Wallet on NPG payment instrument creation",
          "operationId": "notifyWallet",
          "parameters": [
            {
              "in": "header",
              "name": "correlation-Id",
              "schema": {
                "type": "string",
                "format": "uuid"
              },
              "required": true,
              "description": "Unique identifier of the request"
            }
          ],
          "requestBody": {
            "description": "Notify wallet",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NotificationRequest"
                }
              }
            },
            "required": true
          },
          "responses": {
            "204": {
              "description": "Payment reqeust sent successfully"
            },
            "400": {
              "description": "Invalid input",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/ErrorResponse"
                  }
                }
              }
            },
            "500": {
              "description": "Internal server error",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/ErrorResponse"
                  }
                }
              },
            },
            "405": {
              "description": "Invalid input"
            }
          }
        }
      }
    },
    "components": {
      "schemas": {
        "NotificationRequest": {
          "properties": {
            "contractId": {
              "type": "string",
              "maxLength": 255,
              "example": "C2834987"
            },
            "status": {
              "type": "string",
              "description": "Status of the payment order",
              "enum": [
                "OK",
                "KO"
              ],
              "example": "OK"
            },
            "securityToken": {
              "type": "string",
              "description": "Payment gateway security token used to validate the request",
              "example": "2f0ea5059b41414ca3744fe672327d85"
            }
          }
        },
        "ErrorResponse": {
          "type": "object",
          "properties": {
            "errors": {
              "type": "array",
              "items": {
                "$ref": "#/components/schemas/ErrorItem"
              }
            }
          }
        },
        "ErrorItem": {
          "type": "object",
          "properties": {
            "code": {
              "type": "string"
            },
            "description": {
              "type": "string"
            }
          }
        }
      }
    }
  }