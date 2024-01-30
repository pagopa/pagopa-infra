{
  "openapi": "3.0.1",
  "info": {
    "title": "Receipts Helpdesk",
    "description": "Microservice for exposing REST APIs about receipts helpdesk.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.5.1"
  },
  "servers": [
    {
      "url": "https://api.dev.platform.pagopa.it/receipts/helpdesk/v1/",
      "description": "DEV url"
    },
    {
      "url": "https://api.uat.platform.pagopa.it/receipts/helpdesk/v1/",
      "description": "UAT url"
    },
    {
      "url": "https://api.platform.pagopa.it/receipts/helpdesk/v1/",
      "description": "PROD url"
    }
  ],
  "tags": [],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
        "description": "Return the application info, if the application is started",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/{event-id}": {
      "get": {
        "tags": [
          "API-getReceipt"
        ],
        "summary": "Retrieve from CosmosDB the receipt with the given bizEvent id",
        "operationId": "GetReceipt",
        "parameters": [
          {
            "in": "path",
            "name": "event-id",
            "description": "BizEvent id",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Calls.",
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
                  "$ref": "#/components/schemas/Receipt"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "Receipt not found",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/io-message/{message-id}": {
      "get": {
        "tags": [
          "API-getReceiptMessage"
        ],
        "summary": "Retrieve from CosmosDB the receipt message with the given message id",
        "operationId": "GetReceiptMessage",
        "parameters": [
          {
            "in": "path",
            "name": "message-id",
            "description": "Message id",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Calls.",
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
                  "$ref": "#/components/schemas/IOMessage"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "Receipt not found",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/organizations/{organization-fiscal-code}/iuvs/{iuv}": {
      "get": {
        "tags": [
          "API-getReceipt"
        ],
        "summary": "Retrieve from CosmosDB the receipt with the given organization fiscal code and IUV",
        "operationId": "GetReceiptByOrganizationFiscalCodeAndIUV",
        "parameters": [
          {
            "in": "path",
            "name": "organization-fiscal-code",
            "description": "Fiscal code of the organization relative to the payment in the receipt",
            "schema": {
              "type": "string"
            },
            "required": true
          },
          {
            "in": "path",
            "name": "iuv",
            "description": "IUV relative to the payment in the receipt",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Calls.",
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
                  "$ref": "#/components/schemas/Receipt"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "Receipt not found",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/pdf-receipts/{file-name}": {
      "get": {
        "tags": [
          "API-getReceiptPdf"
        ],
        "summary": "Retrieve from Blob storage the receipt pdf with the given filename",
        "operationId": "GetReceiptPdf",
        "parameters": [
          {
            "in": "path",
            "name": "file-name",
            "description": "PDF filename",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/pdf": {
                "schema": {
                  "type": "string",
                  "format": "byte",
                  "description": "Receipt's pdf"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "Receipt's pdf not found",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/errors-toreview/{event-id}": {
      "get": {
        "tags": [
          "API-getErrorsToReview"
        ],
        "summary": "Retrieve from CosmosDB the receiptError with the given bizEvent id",
        "operationId": "GetReceiptError",
        "parameters": [
          {
            "in": "path",
            "name": "event-id",
            "description": "Biz event id.",
            "schema": {
              "type": "string"
            },
            "required": true
          },
          {
            "in": "query",
            "name": "isCart",
            "description": "Boolean to determine if the id refers to a cart",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Calls.",
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
                  "$ref": "#/components/schemas/ReceiptError"
                }
              }
            }
          },
          "400": {
            "description": "Bad request.",
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
            "description": "Receipt error not found.",
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
            "description": "Receipt could not be updated with the new attachments",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/cart/{cart-id}": {
      "get": {
        "tags": [
          "API-getCart"
        ],
        "summary": "Retrieve from CosmosDB the cart with the given cart id",
        "operationId": "GetCart",
        "parameters": [
          {
            "in": "path",
            "name": "cart-id",
            "description": "Cart id.",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Calls.",
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
                  "$ref": "#/components/schemas/CartForReceipt"
                }
              }
            }
          },
          "400": {
            "description": "Bad request.",
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
            "description": "Receipt error not found.",
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
            "description": "Receipt could not be updated with the new attachments",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts-error/{event-id}/reviewed": {
      "post": {
        "tags": [
          "API-toReview"
        ],
        "summary": "Recover a receipt, or group of, in TO_REVIEW status",
        "operationId": "ReceiptToReviewed",
        "parameters": [
          {
            "in": "path",
            "name": "event-id",
            "description": "BizEvent id",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "ReceiptError with id 76abb1f1-c9f9-4ead-9e66-12fec4d51042 and bizEventId 09iuu1f1-c9f9-4ead-9e66-56yuc4d55671 updated to status REVIEWED with success"
                }
              }
            }
          },
          "400": {
            "description": "Bad request.",
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
            "description": "ReceiptError not found",
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
            "description": "Error processing the request",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/carts/{cart-id}/recover-failed": {
      "post": {
        "tags": [
          "API-recoverFailedCart"
        ],
        "summary": "Recover a cart in FAILED or INSERTED status",
        "operationId": "RecoverFailedCart",
        "parameters": [
          {
            "in": "path",
            "name": "cart-id",
            "description": "Cart id.",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Receipt with eventId 76abb1f1-c9f9-4ead-9e66-12fec4d51042 recovered"
                }
              }
            }
          },
          "400": {
            "description": "Bad request.",
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
            "description": "Receipt or BizEvent not found",
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
            "description": "Error processing the request",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/carts/recover-failed": {
      "post": {
        "tags": [
          "API-recoverCartFailed"
        ],
        "summary": "Recover a group of cart in FAILED, or INSERTED status",
        "operationId": "RecoverFailedCartMassive",
        "parameters": [
          {
            "in": "query",
            "name": "status",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Recovered 10 carts"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "Error processing the request",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/{event-id}/recover-failed": {
      "post": {
        "tags": [
          "API-recoverFailed"
        ],
        "summary": "Recover a receipt in FAILED, NOT_QUEUE_SENT or INSERTED status",
        "operationId": "RecoverFailedReceipt",
        "parameters": [
          {
            "in": "path",
            "name": "event-id",
            "description": "BizEvent id.",
            "schema": {
              "type": "string"
            },
            "required": true
          },
          {
            "in": "query",
            "name": "isCart",
            "description": "Boolean to determine if the id refers to a cart",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Receipt with eventId 76abb1f1-c9f9-4ead-9e66-12fec4d51042 recovered"
                }
              }
            }
          },
          "400": {
            "description": "Bad request.",
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
            "description": "Receipt or BizEvent not found",
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
            "description": "Error processing the request",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/recover-failed": {
      "post": {
        "tags": [
          "API-recoverFailed"
        ],
        "summary": "Recover a group of receipts in FAILED, NOT_QUEUE_SENT or INSERTED status",
        "operationId": "RecoverFailedReceiptMassive",
        "parameters": [
          {
            "in": "query",
            "name": "status",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Recovered 10 receipts"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "Error processing the request",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/{event-id}/recover-not-notified": {
      "post": {
        "tags": [
          "API-recoverNotNotified"
        ],
        "summary": "Recover a receipt in IO_ERROR_TO_NOTIFY or GENERATED status",
        "operationId": "RecoverNotNotifiedReceipt",
        "parameters": [
          {
            "in": "path",
            "name": "event-id",
            "description": "BizEvent id.",
            "schema": {
              "type": "string"
            },
            "required": true
          },
          {
            "in": "query",
            "name": "isCart",
            "description": "Boolean to determine if the id refers to a cart",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Receipt with id 235392957832338457-0000-0000-0000-0131 and eventId 76abb1f1-c9f9-4ead-9e66-12fec4d51042 restored in status GENERATED with success"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "Requested receipt not found.",
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
            "description": "The requested receipts is not in a status that can be elaborated.",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/recover-not-notified": {
      "post": {
        "tags": [
          "API-recoverNotNotified"
        ],
        "summary": "Recover a group of receipt in IO_ERROR_TO_NOTIFY or GENERATED status",
        "operationId": "RecoverNotNotifiedReceiptMassive",
        "parameters": [
          {
            "in": "query",
            "name": "status",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "Restored 10 receipt with success"
                }
              }
            }
          },
          "400": {
            "description": "Bad request",
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
            "description": "The requested receipts is not in a status that can be elaborated.",
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
          "default": {
            "description": "Unexpected error.",
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
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/receipts/{event-id}/regenerate-receipt-pdf": {
      "post": {
        "tags": [
          "API-regenerateReceiptPdf"
        ],
        "summary": "Regenerate and update pdf attachment of the receipt with the given bizEvent id",
        "operationId": "RegenerateReceiptPdf",
        "parameters": [
          {
            "in": "path",
            "name": "event-id",
            "description": "BizEvent id.",
            "schema": {
              "type": "string"
            },
            "required": true
          },
          {
            "in": "query",
            "name": "isCart",
            "description": "Boolean to determine if the id refers to a cart",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {}
          },
          "required": false
        },
        "responses": {
          "200": {
            "description": "Successful Calls.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "example": "OK"
                }
              }
            }
          },
          "500": {
            "description": "Receipt could not be updated with the new attachments",
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
          "default": {
            "description": "Unexpected error.",
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
            "type": "string",
            "example": "pagopa-receipt-pdf-helpdesk"
          },
          "version": {
            "type": "string",
            "example": "1.0.0"
          },
          "environment": {
            "type": "string",
            "example": "azure-fn"
          }
        }
      },
      "Receipt": {
        "type": "object",
        "properties": {
          "eventId": {
            "type": "string",
            "example": "712341f1-124419-4ead-9e66-12124fdsf"
          },
          "id": {
            "type": "string",
            "example": "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
          },
          "version": {
            "type": "string",
            "example": "2.0"
          },
          "eventData": {
            "type": "object",
            "properties": {
              "payerFiscalCode": {
                "type": "string",
                "example": "XXXVVV00Q00Z000A"
              },
              "debtorFiscalCode": {
                "type": "string",
                "example": "XXXVVV00Q00Z000A"
              },
              "transactionCreationDate": {
                "type": "string",
                "example": "01/01/1970"
              },
              "amount": {
                "type": "string",
                "example": "2000"
              },
              "cart": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/CartItem"
                }
              }
            }
          },
          "ioMessageData": {
            "type": "object",
            "properties": {
              "idMessageDebtor": {
                "type": "string",
                "example": "82397589u2c8h3rc234ndd324uf"
              },
              "idMessagePayer": {
                "type": "string",
                "example": "82397589u2c8h3rc234ndd324uf"
              }
            }
          },
          "status": {
            "type": "string",
            "example": "INSERTED"
          },
          "mdAttach": {
            "$ref": "#/components/schemas/ReceiptMetadata"
          },
          "mdAttachPayer": {
            "type": "object",
            "$ref": "#/components/schemas/ReceiptMetadata"
          },
          "numRetry": {
            "type": "integer",
            "description": "The number of times the receipt tried to generate and failed",
            "format": "int32",
            "example": 1
          },
          "reasonErr": {
            "$ref": "#/components/schemas/ReasonErr"
          },
          "reasonErrPayer": {
            "$ref": "#/components/schemas/ReasonErr"
          },
          "notificationNumRetry": {
            "type": "integer",
            "description": "The number of times the receipt tried to be notified and failed",
            "format": "int32",
            "example": 1
          },
          "inserted_at": {
            "type": "integer",
            "description": "Timestamp when the receipt was set to status INSERTED",
            "format": "int64",
            "example": 1701766842
          },
          "generated_at": {
            "type": "integer",
            "description": "Timestamp when the receipt was set to status GENERATED",
            "format": "int64",
            "example": 1701766842
          },
          "notified_at": {
            "type": "integer",
            "description": "Timestamp when the receipt was set to status NOTIFIED",
            "format": "int64",
            "example": 1701766842
          }
        }
      },
      "CartItem": {
        "type": "object",
        "properties": {
          "subject": {
            "type": "string",
            "example": "Payment object"
          },
          "payeeName": {
            "type": "string",
            "example": "Payee name"
          }
        }
      },
      "ReceiptMetadata": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "example": "pagopa-receipt.pdf"
          },
          "url": {
            "type": "string",
            "example": "pagopa-receipt.pdf"
          }
        }
      },
      "ReasonErr": {
        "type": "object",
        "properties": {
          "code": {
            "type": "integer",
            "description": "Error code",
            "format": "int32",
            "example": 400
          },
          "message": {
            "type": "string",
            "example": "Error message"
          }
        }
      },
      "IOMessage": {
        "type": "object",
        "properties": {
          "eventId": {
            "type": "string",
            "example": "712341f1-124419-4ead-9e66-12124fdsf"
          },
          "messageId": {
            "type": "string",
            "example": "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
          }
        }
      },
      "ReceiptError": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "example": "712341f1-124419-4ead-9e66-12124fdsf"
          },
          "bizEventId": {
            "type": "string",
            "example": "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
          },
          "messagePayload": {
            "type": "string",
            "example": "TWVzc2FnZSBwYXlsb2FkIGJhc2UgNjQ="
          },
          "messageError": {
            "type": "string",
            "example": "Message error description"
          },
          "status": {
            "type": "string",
            "example": "TO_REVIEW"
          }
        }
      },
      "CartForReceipt": {
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "example": "712341"
          },
          "cartPaymentId": {
            "type": "array",
            "items": {
              "type": "string",
              "example": "76abb1f1-c9f9-4ead-9e66-12fec4d51042"
            }
          },
          "totalNotice": {
            "type": "integer",
            "example": "3"
          },
          "status": {
            "type": "string",
            "enum": [
              "INSERTED",
              "FAILED",
              "SENT"
            ]
          },
          "reasonError": {
            "$ref": "#/components/schemas/ReasonErr"
          }
        }
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized)",
            "example": "Bad Request"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 400
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "The request is invalid"
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
      }
    }
  }
}
