{
  "openapi": "3.0.3",
  "info": {
    "title": "pagoPA payment wallet helpdesk API",
    "description": "pagoPA payment wallet helpdesk API",
    "version": "1.0.0",
    "contact": {
      "name": "pagoPA - Touchpoints team",
      "url": "https://www.pagopa.it/"
    }
  },
  "tags": [
    {
      "name": "helpdesk",
      "description": "Api's to be exposed to helpdesk team",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/PPR/pages/749371770/NW+-+Design+di+dettaglio",
        "description": "Technical specifications"
      }
    },
    {
      "name": "internalApi",
      "description": "Internal api's (such as running service informatio)",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/PPR/pages/749371770/NW+-+Design+di+dettaglio",
        "description": "Technical specifications"
      }
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/PPR/pages/749371770/NW+-+Design+di+dettaglio",
    "description": "Design review"
  },
  "security": [
    {
      "ApiKeyAuth": []
    }
  ],
  "servers": [
    {
      "url": "https://${hostname}",
      "x-internal": true,
      "variables": {
        "hostname": {
          "description": "The hostname of the API server",
          "default": "itnprod.pay-wallet.internal.platform.pagopa.it",
          "enum": [
            "itndev.pay-wallet.internal.dev.platform.pagopa.it",
            "itnuat.pay-wallet.internal.uat.platform.pagopa.it",
            "itnprod.pay-wallet.internal.platform.pagopa.it"
          ]
        }
      }
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "operationId": "getServiceInfo",
        "security": [],
        "tags": [
          "internalApi"
        ],
        "description": "Get information about this service.\nCurrently returns just the version number.",
        "summary": "Get information about this service.\nCurrently returns just the version number.",
        "responses": {
          "200": {
            "description": "Service informations",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ServiceInfo"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
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
    "/helpdesk/wallets/contractId/deactivations/dlq": {
      "get": {
        "operationId": "getWalletContractIdDeactivationDlq",
        "tags": [
          "helpdesk"
        ],
        "description": "Retrieve wallets with failed contract ID deactivations, ordered by DLQ\ntimestamp and wallet ID descending. Errors belong to the latest contract\nrecorded for each wallet and are ordered by attempt number and timestamp.",
        "summary": "Search the contract ID deactivation dead-letter queue",
        "parameters": [
          {
            "in": "query",
            "name": "pageSize",
            "required": true,
            "description": "Maximum number of wallets returned per page",
            "schema": {
              "type": "integer",
              "minimum": 1,
              "maximum": 10
            }
          },
          {
            "in": "query",
            "name": "continuationCursor",
            "required": false,
            "description": "Opaque continuation cursor returned by the previous page",
            "schema": {
              "type": "string",
              "maxLength": 512
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Wallet deactivation failures",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletContractIdDlqPageResponse"
                }
              }
            }
          },
          "400": {
            "description": "Invalid page size or continuation cursor",
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
          "404": {
            "description": "No DLQ entries found for this page",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Database error or inconsistent DLQ event data",
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
    "/helpdesk/wallets/{walletId}/deactivationRetryCount": {
      "patch": {
        "operationId": "resetWalletDeactivationRetryCount",
        "tags": [
          "helpdesk"
        ],
        "summary": "Reset the wallet contract deactivation retry counter",
        "description": "Set deactivationRetryCount to zero on an existing wallet, regardless of\nits status. A missing counter is initialized to zero. Repeated requests\nsucceed even when the counter is already zero. No other wallet fields\nor DLQ entries are changed, and no deactivation attempt is triggered\ndirectly by this operation.",
        "parameters": [
          {
            "in": "path",
            "name": "walletId",
            "required": true,
            "description": "Wallet ID as a canonical lowercase UUID",
            "schema": {
              "type": "string",
              "format": "uuid",
              "pattern": "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Counter reset, or already zero"
          },
          "400": {
            "description": "Invalid wallet ID",
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
          "404": {
            "description": "Wallet not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Database error",
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
    "/helpdesk/wallets/{userId}": {
      "get": {
        "operationId": "getWallets",
        "tags": [
          "helpdesk"
        ],
        "description": "Retrieve wallets associated to an user id",
        "summary": "Retrieve wallets associated to an user id",
        "parameters": [
          {
            "in": "path",
            "name": "userId",
            "required": true,
            "description": "User ID",
            "schema": {
              "$ref": "#/components/schemas/UserId"
            }
          },
          {
            "in": "query",
            "name": "status",
            "required": false,
            "description": "Filter searched wallet by status",
            "schema": {
              "$ref": "#/components/schemas/WalletStatus"
            }
          },
          {
            "in": "query",
            "name": "type",
            "required": false,
            "description": "Filter searched wallet by type",
            "schema": {
              "$ref": "#/components/schemas/WalletType"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Wallet details",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletsDetails"
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
                },
                "example": {
                  "title": "Bad request",
                  "status": 400,
                  "detail": "Invalid input request"
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
                },
                "example": {
                  "title": "Unauthorized",
                  "status": 401,
                  "detail": "Unauthorized request"
                }
              }
            }
          },
          "404": {
            "description": "No wallet found for input search criteria",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "title": "Not found",
                  "status": 404,
                  "detail": "No wallet found for input search criteria"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error handling command",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "title": "Internal Server Error",
                  "status": 500,
                  "detail": "There was an error processing the request"
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
      "WalletContractIdDlqPageResponse": {
        "type": "object",
        "properties": {
          "results": {
            "type": "array",
            "minItems": 1,
            "items": {
              "$ref": "#/components/schemas/WalletContractIdDeactivationDlqDetail"
            }
          },
          "continuationCursor": {
            "type": "string",
            "description": "Opaque continuation cursor; empty string on the last page"
          }
        },
        "required": [
          "results",
          "continuationCursor"
        ]
      },
      "WalletContractIdDeactivationDlqDetail": {
        "type": "object",
        "description": "Wallet entry from the DLQ. If there are no matching events, contractId\nand deactivationErrors are omitted. If matching event data is malformed,\nboth detail fields are also omitted.",
        "properties": {
          "id": {
            "type": "string",
            "description": "Wallet unique identifier"
          },
          "contractId": {
            "type": "string",
            "description": "Latest contract ID whose deactivation failed; omitted when event details are unavailable"
          },
          "deactivationErrors": {
            "type": "array",
            "description": "Errors for the latest contract; omitted when event details are unavailable",
            "items": {
              "$ref": "#/components/schemas/WalletContractIdDeactivationError"
            }
          }
        },
        "required": [
          "id"
        ]
      },
      "WalletContractIdDeactivationError": {
        "type": "object",
        "description": "Error recorded during a contract ID deactivation attempt",
        "properties": {
          "errorType": {
            "type": "string",
            "enum": [
              "COMMUNICATION_ERROR",
              "KO_RESPONSE_RECEIVED"
            ]
          },
          "httpErrorCode": {
            "$ref": "#/components/schemas/HttpStatusCode"
          },
          "npgErrorCode": {
            "type": "string",
            "description": "Application error code received from NPG, when available"
          }
        },
        "required": [
          "errorType"
        ]
      },
      "ServiceInfo": {
        "type": "object",
        "description": "Service information",
        "properties": {
          "version": {
            "type": "string",
            "description": "The running service version"
          }
        },
        "required": [
          "version"
        ],
        "example": {
          "version": "1.0.0"
        }
      },
      "WalletsDetails": {
        "type": "object",
        "properties": {
          "wallets": {
            "type": "array",
            "minItems": 1,
            "items": {
              "$ref": "#/components/schemas/WalletDetail"
            }
          }
        },
        "required": [
          "wallets"
        ]
      },
      "WalletDetail": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "wallet unique identifier"
          },
          "status": {
            "type": "string",
            "description": "wallet status"
          },
          "type": {
            "$ref": "#/components/schemas/WalletType"
          },
          "applications": {
            "type": "array",
            "minLength": 1,
            "description": "list of all applications for the wallet",
            "items": {
              "$ref": "#/components/schemas/WalletApplicationInfo"
            }
          },
          "onboardingChannel": {
            "type": "string",
            "description": "the channel from which wallet have been onboarded"
          }
        },
        "required": [
          "id",
          "status",
          "type",
          "applications",
          "onboardingChannel"
        ]
      },
      "WalletApplicationInfo": {
        "type": "object",
        "properties": {
          "name": {
            "$ref": "#/components/schemas/WalletApplicationId"
          },
          "status": {
            "$ref": "#/components/schemas/WalletApplicationStatus"
          },
          "lastUsage": {
            "type": "string",
            "format": "date-time"
          }
        },
        "required": [
          "name",
          "status"
        ]
      },
      "WalletApplicationId": {
        "type": "string",
        "description": "id of the application associated to the wallet"
      },
      "WalletApplicationStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "ENABLED",
          "DISABLED"
        ]
      },
      "WalletType": {
        "type": "string",
        "description": "wallet type",
        "enum": [
          "CARDS",
          "PAYPAL"
        ]
      },
      "WalletStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "CREATED",
          "INITIALIZED",
          "VALIDATION_REQUESTED",
          "VALIDATED",
          "DELETED",
          "ERROR"
        ]
      },
      "UserId": {
        "type": "string",
        "description": "The user ID"
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
      }
    },
    "securitySchemes": {
      "ApiKeyAuth": {
        "type": "apiKey",
        "in": "header",
        "name": "Ocp-Apim-Subscription-Key"
      }
    }
  }
}
