{
  "openapi": "3.0.1",
  "info": {
    "title": "core",
    "description": "Spring application exposes APIs to manage configuration for CI/PSP on the Nodo dei Pagamenti",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.59.35"
  },
  "servers": [
    {
      "url": "${host}/apiconfig/api/v1"
    },
    {
      "url": "https://{host}{basePath}",
      "variables": {
        "host": {
          "default": "api.dev.platform.pagopa.it",
          "enum": [
            "api.dev.platform.pagopa.it",
            "api.uat.platform.pagopa.it",
            "api.platform.pagopa.it"
          ]
        },
        "basePath": {
          "default": "/apiconfig/auth/api/v1",
          "enum": [
            "/apiconfig/auth/api/v1",
            "/apiconfig/api/v1"
          ]
        }
      }
    }
  ],
  "tags": [
    {
      "name": "Payment Service Providers",
      "description": "Everything about Payment Service Providers"
    },
    {
      "name": "Ibans",
      "description": "Everything about Iban"
    },
    {
      "name": "Batch Operation",
      "description": "Everything about Batch Operation"
    },
    {
      "name": "Creditor Institutions",
      "description": "Everything about Creditor Institution"
    },
    {
      "name": "Configuration",
      "description": "Everything about Configuration"
    },
    {
      "name": "Cache",
      "description": "Everything about Cache"
    },
    {
      "name": "Utilities",
      "description": "Everything about Utilities"
    },
    {
      "name": "Refresh Operation",
      "description": "Refresh and trigger job for node configuration"
    }
  ],
  "paths": {
    "/batchoperation/creditorinstitution-station/loading": {
      "post": {
        "tags": [
          "Batch Operation"
        ],
        "summary": "Update a CSV file containing the relationship between Creditor Institution and Station",
        "operationId": "manageCIStationRelationship",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "CSV file regarding CI-Station relationship to manage",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/batchoperation/creditorinstitution-station/migration": {
      "post": {
        "tags": [
          "Batch Operation"
        ],
        "summary": "Massive migration of the Station-CI relations",
        "operationId": "massiveMigration",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "CSV file regarding relations to migrate",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/brokers": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get paginated list of creditor brokers",
        "operationId": "getBrokers",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "code",
            "in": "query",
            "description": "Filter by code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "name",
            "in": "query",
            "description": "Filter by name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "orderby",
            "in": "query",
            "description": "Order by code or name",
            "required": false,
            "schema": {
              "type": "string",
              "default": "CODE",
              "enum": [
                "CODE",
                "NAME"
              ]
            }
          },
          {
            "name": "ordering",
            "in": "query",
            "description": "Direction of ordering",
            "required": false,
            "schema": {
              "type": "string",
              "default": "DESC",
              "enum": [
                "ASC",
                "DESC"
              ]
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Brokers"
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
          "Creditor Institutions"
        ],
        "summary": "Create a broker",
        "operationId": "createBroker",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BrokerDetails"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/BrokerDetails"
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
          },
          "409": {
            "description": "Conflict",
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
    "/brokers/station-maintenances": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get a list of all stations' maintenance filtered by dates",
        "operationId": "getAllStationsMaintenances",
        "parameters": [
          {
            "name": "startDateTimeBefore",
            "in": "query",
            "description": "Start date of maintenance, used to retrieve all maintenance that start before the provided date (yyyy-MM-dd'T'HH:mm:ss.SSS'Z')",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T10:00:00.000Z"
          },
          {
            "name": "startDateTimeAfter",
            "in": "query",
            "description": "Start date of maintenance, used to retrieve all maintenance that start after the provided date (yyyy-MM-dd'T'HH:mm:ss.SSS'Z')",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T10:00:00.000Z"
          },
          {
            "name": "endDateTimeBefore",
            "in": "query",
            "description": "End date of maintenance, used to retrieve all maintenance that start before the provided date (yyyy-MM-dd'T'HH:mm:ss.SSS'Z')",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T13:00:00.000Z"
          },
          {
            "name": "endDateTimeAfter",
            "in": "query",
            "description": "End date of maintenance, used to retrieve all maintenance that start after the provided date (yyyy-MM-dd'T'HH:mm:ss.SSS'Z')",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T13:00:00.000Z"
          }
        ],
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
                  "$ref": "#/components/schemas/StationMaintenanceListResource"
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
    "/brokers/{brokercode}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get creditor broker details ",
        "operationId": "getBroker",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "broker code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/BrokerDetails"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Update a broker",
        "operationId": "updateBroker",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "broker code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "description": "The values to update of the broker",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BrokerDetails"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/BrokerDetails"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Delete a broker",
        "operationId": "deleteBroker",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "broker code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/brokers/{brokercode}/station-maintenances": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get a paginated list of station's maintenance for the specified broker",
        "operationId": "getStationMaintenances",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "Broker's tax code",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "stationCode",
            "in": "query",
            "description": "Station's code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "startDateTimeBefore",
            "in": "query",
            "description": "Start date of maintenance, used to retrieve all maintenance that start before the provided date (yyyy-MM-dd'T'HH:mm:ss.SSSXXX)",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T10:00:00.000+02:00"
          },
          {
            "name": "startDateTimeAfter",
            "in": "query",
            "description": "Start date of maintenance, used to retrieve all maintenance that start after the provided date (yyyy-MM-dd'T'HH:mm:ss.SSSXXX)",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T10:00:00.000+02:00"
          },
          {
            "name": "endDateTimeBefore",
            "in": "query",
            "description": "End date of maintenance, used to retrieve all maintenance that start before the provided date (yyyy-MM-dd'T'HH:mm:ss.SSSXXX)",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T13:00:00.000+02:00"
          },
          {
            "name": "endDateTimeAfter",
            "in": "query",
            "description": "End date of maintenance, used to retrieve all maintenance that start after the provided date (yyyy-MM-dd'T'HH:mm:ss.SSSXXX)",
            "required": false,
            "schema": {
              "type": "string",
              "format": "date-time"
            },
            "example": "2024-04-01T13:00:00.000+02:00"
          },
          {
            "name": "limit",
            "in": "query",
            "description": "Number of items for page",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number",
            "required": false,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32",
              "default": 0
            }
          }
        ],
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
                  "$ref": "#/components/schemas/StationMaintenanceListResource"
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
          "Creditor Institutions"
        ],
        "summary": "Create a maintenance for the specified station",
        "operationId": "createStationMaintenance",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "Broker's tax code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreateStationMaintenance"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/StationMaintenanceResource"
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
          },
          "409": {
            "description": "Conflict",
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
    "/brokers/{brokercode}/station-maintenances/summary": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get the hours' summary of stations' maintenance for the specified broker",
        "operationId": "getBrokerMaintenancesSummary",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "Broker's tax code",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "maintenanceYear",
            "in": "query",
            "description": "Year of maintenance (yyyy)",
            "required": true,
            "schema": {
              "maxLength": 4,
              "minLength": 4,
              "type": "string"
            },
            "example": 2024
          }
        ],
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
                  "$ref": "#/components/schemas/MaintenanceHoursSummaryResource"
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
    "/brokers/{brokercode}/station-maintenances/{maintenanceid}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get a maintenance for the specified station, given its broker code and maintenance id",
        "operationId": "getStationMaintenance",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "Broker's tax code",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "maintenanceid",
            "in": "path",
            "description": "Maintenance's id",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/StationMaintenanceResource"
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
          },
          "409": {
            "description": "Conflict",
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
      "put": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Update a maintenance for the specified station",
        "operationId": "updateStationMaintenance",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "Broker's tax code",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "maintenanceid",
            "in": "path",
            "description": "Maintenance's id",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UpdateStationMaintenance"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/StationMaintenanceResource"
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
          },
          "409": {
            "description": "Conflict",
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
          "Creditor Institutions"
        ],
        "summary": "Delete a station's maintenance",
        "operationId": "deleteStationMaintenance",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "Broker's tax code",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "maintenanceid",
            "in": "path",
            "description": "Maintenance's id",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/brokerspsp": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get paginated list of PSP brokers",
        "operationId": "getBrokersPsp",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "code",
            "in": "query",
            "description": "Filter by code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "name",
            "in": "query",
            "description": "Filter by name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "orderby",
            "in": "query",
            "description": "Order by code or name",
            "required": false,
            "schema": {
              "type": "string",
              "default": "CODE",
              "enum": [
                "CODE",
                "NAME"
              ]
            }
          },
          {
            "name": "ordering",
            "in": "query",
            "description": "Direction of ordering",
            "required": false,
            "schema": {
              "type": "string",
              "default": "DESC",
              "enum": [
                "ASC",
                "DESC"
              ]
            }
          }
        ],
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
                  "$ref": "#/components/schemas/BrokersPsp"
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
          "Payment Service Providers"
        ],
        "summary": "Create a PSP broker",
        "operationId": "createBrokerPsp",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BrokerPspDetails"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/BrokerPspDetails"
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
          },
          "409": {
            "description": "Conflict",
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
    "/brokerspsp/{brokerpspcode}": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get PSP broker details",
        "operationId": "getBrokerPsp",
        "parameters": [
          {
            "name": "brokerpspcode",
            "in": "path",
            "description": "Broker code of a PSP.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/BrokerPspDetails"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Update a broker PSP",
        "operationId": "updateBrokerPsp",
        "parameters": [
          {
            "name": "brokerpspcode",
            "in": "path",
            "description": "broker PSP code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "description": "The values to update of the broker PSP",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BrokerPspDetails"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/BrokerPspDetails"
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
          },
          "404": {
            "description": "Not Found",
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
          "Payment Service Providers"
        ],
        "summary": "Delete a broker PSP",
        "operationId": "deleteBrokerPsp",
        "parameters": [
          {
            "name": "brokerpspcode",
            "in": "path",
            "description": "broker PSP code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/brokerspsp/{brokerpspcode}/paymentserviceproviders": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get the PSP list of a broker",
        "operationId": "getPspBrokerPsp",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "brokerpspcode",
            "in": "path",
            "description": "Broker code of a PSP.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/PaymentServiceProviders"
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
          },
          "404": {
            "description": "Not Found",
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
    "/cache/versions": {
      "get": {
        "tags": [
          "Cache"
        ],
        "summary": "Get cache versions",
        "operationId": "getCacheVersions",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 3",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 3
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": false,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32",
              "default": 0
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CacheVersions"
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
          },
          "404": {
            "description": "Not Found",
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
    "/cache/versions/{version}": {
      "get": {
        "tags": [
          "Cache"
        ],
        "summary": "Get cache by version",
        "operationId": "getCacheByVersion",
        "parameters": [
          {
            "name": "version",
            "in": "path",
            "description": "Node version",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "type": "string",
                  "format": "binary"
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
          },
          "404": {
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/octet-stream": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
    "/cache/versions/{version}/id": {
      "get": {
        "tags": [
          "Cache"
        ],
        "summary": "Get cache id by version",
        "operationId": "getCacheId",
        "parameters": [
          {
            "name": "version",
            "in": "path",
            "description": "Node version",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Cache"
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
          },
          "404": {
            "description": "Not Found",
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
    "/cdis": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get paginated list of CDIs",
        "operationId": "getCdis",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "idcdi",
            "in": "query",
            "description": "filter by Id CDI",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "pspcode",
            "in": "query",
            "description": "filter by PSP",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Cdis"
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
          "Payment Service Providers"
        ],
        "summary": "Update a XML file containing the details of an CDI",
        "operationId": "createCdi",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "XML file regarding CDI to create",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
          "422": {
            "description": "Unprocessable Content",
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
    "/cdis/check": {
      "post": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Verify a XML file containing the details of an CDI",
        "operationId": "verifyCdi",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "XML file regarding CDI to check",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
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
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/CheckItem"
                  }
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
          },
          "404": {
            "description": "Not Found",
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
    "/cdis/history": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Sync CDI history",
        "operationId": "uploadHistory_1",
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
              "application/json": {}
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
    "/cdis/{idcdi}": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Download a XML file containing the details of a CDI",
        "operationId": "getCdi",
        "parameters": [
          {
            "name": "idcdi",
            "in": "path",
            "description": "Id of a CDI",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "pspcode",
            "in": "query",
            "description": "PSP code",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
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
              "application/xml": {
                "schema": {
                  "type": "string",
                  "format": "binary"
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
          },
          "404": {
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/xml": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
          "Payment Service Providers"
        ],
        "summary": "Delete an CDI file",
        "operationId": "deleteCdi",
        "parameters": [
          {
            "name": "idcdi",
            "in": "path",
            "description": "Id of a CDI",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "pspcode",
            "in": "query",
            "description": "PSP code",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
    "/channels": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get paginated list of channels",
        "operationId": "getChannels",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "brokercode",
            "in": "query",
            "description": "Filter by broker",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "brokerdescription",
            "in": "query",
            "description": "Filter by broker description",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "code",
            "in": "query",
            "description": "Filter by code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "ordering",
            "in": "query",
            "description": "Direction of ordering. Results are ordered by code",
            "required": false,
            "schema": {
              "type": "string",
              "default": "DESC",
              "enum": [
                "ASC",
                "DESC"
              ]
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Channels"
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
          "Payment Service Providers"
        ],
        "summary": "Create a Channel",
        "operationId": "createChannel",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ChannelDetails"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/ChannelDetails"
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
          },
          "409": {
            "description": "Conflict",
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
    "/channels/csv": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Download the list of channelss as CSV file",
        "operationId": "getChannelsCSV",
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
                  "type": "string",
                  "format": "binary"
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
    "/channels/{channelcode}": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get Channel details ",
        "operationId": "getChannel",
        "parameters": [
          {
            "name": "channelcode",
            "in": "path",
            "description": "channel code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/ChannelDetails"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Update a Channel",
        "operationId": "updateChannel",
        "parameters": [
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ChannelDetails"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/ChannelDetails"
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
          },
          "404": {
            "description": "Not Found",
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
          "Payment Service Providers"
        ],
        "summary": "Delete a Channel",
        "operationId": "deleteChannel",
        "parameters": [
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/channels/{channelcode}/paymentserviceproviders": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get the list of PSPs associated with the channel",
        "operationId": "getChannelPaymentServiceProviders",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "pspCode",
            "in": "query",
            "description": "Filter by psp code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "pspName",
            "in": "query",
            "description": "Filter by psp name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "pspEnabled",
            "in": "query",
            "description": "Filter by psp enabled",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/ChannelPspList"
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
          },
          "404": {
            "description": "Not Found",
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
    "/channels/{channelcode}/paymentserviceproviders/csv": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Download the list of PSPs as CSV file",
        "operationId": "getChannelPaymentServiceProvidersCSV",
        "parameters": [
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "type": "string",
                  "format": "binary"
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
          },
          "404": {
            "description": "Not Found",
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
    "/channels/{channelcode}/paymenttypes": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get a payment types of a channel",
        "operationId": "getChannelPaymentTypes",
        "parameters": [
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/PspChannelPaymentTypes"
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
          },
          "404": {
            "description": "Not Found",
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
          "Payment Service Providers"
        ],
        "summary": "Create a payment types of a channel",
        "operationId": "createChannelPaymentType",
        "parameters": [
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PspChannelPaymentTypes"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/PspChannelPaymentTypes"
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
    "/channels/{channelcode}/paymenttypes/{paymenttypecode}": {
      "delete": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Delete a payment types of a channel",
        "operationId": "deleteChannelPaymentType",
        "parameters": [
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "paymenttypecode",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/configuration/ftpservers": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get list of ftp server",
        "operationId": "getFtpServers",
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
                  "$ref": "#/components/schemas/FtpServers"
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
          "Configuration"
        ],
        "summary": "Create ftp server",
        "operationId": "createFtpServer",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FtpServer"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/FtpServer"
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
          },
          "409": {
            "description": "Conflict",
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
    "/configuration/ftpservers/host/{host}/port/{port}/service/{service}": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get details of ftp server",
        "operationId": "getFtpServer",
        "parameters": [
          {
            "name": "host",
            "in": "path",
            "description": "Host",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "port",
            "in": "path",
            "description": "Port",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "service",
            "in": "path",
            "description": "Service",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/FtpServer"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Configuration"
        ],
        "summary": "Update configuration key",
        "operationId": "updateFtpServer",
        "parameters": [
          {
            "name": "host",
            "in": "path",
            "description": "Host",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "port",
            "in": "path",
            "description": "Port",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "service",
            "in": "path",
            "description": "Service",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FtpServer"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/FtpServer"
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
          },
          "404": {
            "description": "Not Found",
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
          "Configuration"
        ],
        "summary": "Delete configuration key",
        "operationId": "deleteFtpServer",
        "parameters": [
          {
            "name": "host",
            "in": "path",
            "description": "Host",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "port",
            "in": "path",
            "description": "Port",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "service",
            "in": "path",
            "description": "Service",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/configuration/keys": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get list of configuration key",
        "operationId": "getConfigurationKeys",
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
                  "$ref": "#/components/schemas/ConfigurationKeys"
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
          "Configuration"
        ],
        "summary": "Create configuration key",
        "operationId": "createConfigurationKey",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ConfigurationKey"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/ConfigurationKey"
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
          },
          "409": {
            "description": "Conflict",
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
    "/configuration/keys/category/{category}/key/{key}": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get details of configuration key",
        "operationId": "getConfigurationKey",
        "parameters": [
          {
            "name": "category",
            "in": "path",
            "description": "Configuration category",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "key",
            "in": "path",
            "description": "Configuration key",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/ConfigurationKey"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Configuration"
        ],
        "summary": "Update configuration key",
        "operationId": "updateConfigurationKey",
        "parameters": [
          {
            "name": "category",
            "in": "path",
            "description": "Configuration category",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "key",
            "in": "path",
            "description": "Configuration key",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ConfigurationKeyBase"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/ConfigurationKeyBase"
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
          },
          "404": {
            "description": "Not Found",
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
          "Configuration"
        ],
        "summary": "Delete configuration key",
        "operationId": "deleteConfigurationKey",
        "parameters": [
          {
            "name": "category",
            "in": "path",
            "description": "Configuration category",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "key",
            "in": "path",
            "description": "Configuration key",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/configuration/paymenttypes": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get list of payment type",
        "operationId": "getPaymentTypes",
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
                  "$ref": "#/components/schemas/PaymentTypes"
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
          "Configuration"
        ],
        "summary": "Create payment type",
        "operationId": "createPaymentType",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PaymentType"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/PaymentType"
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
          },
          "409": {
            "description": "Conflict",
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
    "/configuration/paymenttypes/history": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Trigger to upload payment types history on AFM Marketplace",
        "operationId": "uploadHistory",
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/configuration/paymenttypes/{paymentTypeCode}": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get details of payment type",
        "operationId": "getPaymentType",
        "parameters": [
          {
            "name": "paymentTypeCode",
            "in": "path",
            "description": "Payment type code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/PaymentType"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Configuration"
        ],
        "summary": "Update payment type",
        "operationId": "updatePaymentType",
        "parameters": [
          {
            "name": "paymentTypeCode",
            "in": "path",
            "description": "Payment type code",
            "required": true,
            "schema": {
              "pattern": "[A-Z]*",
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PaymentTypeBase"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/PaymentType"
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
          },
          "404": {
            "description": "Not Found",
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
          "Configuration"
        ],
        "summary": "Delete payment type",
        "operationId": "deletePaymentType",
        "parameters": [
          {
            "name": "paymentTypeCode",
            "in": "path",
            "description": "Payment type code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/configuration/pdds": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get list of pdd",
        "operationId": "getPdds",
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
                  "$ref": "#/components/schemas/Pdds"
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
          "Configuration"
        ],
        "summary": "Create pdd",
        "operationId": "createPdd",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/Pdd"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/Pdd"
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
          },
          "409": {
            "description": "Conflict",
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
    "/configuration/pdds/{id_pdd}": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get details of a pdd",
        "operationId": "getPdd",
        "parameters": [
          {
            "name": "id_pdd",
            "in": "path",
            "description": "Configuration identifier",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Pdd"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Configuration"
        ],
        "summary": "Update pdd",
        "operationId": "updatePdd",
        "parameters": [
          {
            "name": "id_pdd",
            "in": "path",
            "description": "Configuration identifier",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PddBase"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/PddBase"
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
          },
          "404": {
            "description": "Not Found",
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
          "Configuration"
        ],
        "summary": "Delete pdd",
        "operationId": "deletePdd",
        "parameters": [
          {
            "name": "id_pdd",
            "in": "path",
            "description": "Configuration identifier",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/configuration/wfespplugins": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get list of WFESP Plugin configuration",
        "operationId": "getWfespPlugins",
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
                  "$ref": "#/components/schemas/WfespPluginConfs"
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
          "Configuration"
        ],
        "summary": "Create configuration key",
        "operationId": "createWfespPlugin",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WfespPluginConf"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/WfespPluginConf"
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
          },
          "409": {
            "description": "Conflict",
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
    "/configuration/wfespplugins/{idServPlugin}": {
      "get": {
        "tags": [
          "Configuration"
        ],
        "summary": "Get details of a Wfesp plugin",
        "operationId": "getWfespPlugin",
        "parameters": [
          {
            "name": "idServPlugin",
            "in": "path",
            "description": "idServPlugin",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/WfespPluginConf"
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
      "put": {
        "tags": [
          "Configuration"
        ],
        "summary": "Update Wfesp plugin configuration",
        "operationId": "updateWfespPlugin",
        "parameters": [
          {
            "name": "idServPlugin",
            "in": "path",
            "description": "idServPlugin",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WfespPluginConfBase"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/WfespPluginConfBase"
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
          },
          "404": {
            "description": "Not Found",
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
          "Configuration"
        ],
        "summary": "Delete configuration key",
        "operationId": "deleteWfespPlugin",
        "parameters": [
          {
            "name": "idServPlugin",
            "in": "path",
            "description": "idServPlugin",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/counterparttables": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get the counterparties table",
        "operationId": "getCounterpartTables",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "idcounterparttable",
            "in": "query",
            "description": "filter by Id of counterpart table",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "filter by Creditor Institution",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CounterpartTables"
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
          "Creditor Institutions"
        ],
        "summary": "Upload a XML file containing the details of a Counterpart table",
        "operationId": "createCounterpartTable",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "The file to upload",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/counterparttables/{idcounterparttable}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Download a XML file containing the details of a counterpart table",
        "operationId": "getCounterpartTable",
        "parameters": [
          {
            "name": "idcounterparttable",
            "in": "path",
            "description": "Id counterpart table",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "Creditor institution code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/xml": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              },
              "application/json": {
                "schema": {
                  "type": "string",
                  "format": "binary"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Delete a Counterpart table XML file ",
        "operationId": "deleteCounterpartTable",
        "parameters": [
          {
            "name": "idcounterparttable",
            "in": "path",
            "description": "ID of a counterpart table",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "Creditor institution code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
    "/creditorinstitutions": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get paginated list of creditor institutions",
        "operationId": "getCreditorInstitutions",
        "parameters": [
          {
            "name": "code",
            "in": "query",
            "description": "Filter by creditor institution's tax code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "name",
            "in": "query",
            "description": "Filter by creditor institution's business name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "enabled",
            "in": "query",
            "description": "Filter by creditor institution's enabled",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "orderby",
            "in": "query",
            "description": "Order by creditor institution's tax code or business name",
            "required": false,
            "schema": {
              "type": "string",
              "default": "CODE",
              "enum": [
                "CODE",
                "NAME"
              ]
            }
          },
          {
            "name": "ordering",
            "in": "query",
            "description": "Direction of ordering",
            "required": false,
            "schema": {
              "type": "string",
              "default": "DESC",
              "enum": [
                "ASC",
                "DESC"
              ]
            }
          },
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "hasCBILL",
            "in": "query",
            "description": "Filter used to include creditor institutions with or without CBILL parameter",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "hasValidIban",
            "in": "query",
            "description": "Filter used to include creditor institutions with or without at least one valid iban",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CreditorInstitutions"
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
          "Creditor Institutions"
        ],
        "summary": "Create creditor institution",
        "operationId": "createCreditorInstitution",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreditorInstitutionDetails"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/CreditorInstitutionDetails"
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
          },
          "409": {
            "description": "Conflict",
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
    "/creditorinstitutions/cbill": {
      "post": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Upload a CSV file containing the cbill codes",
        "operationId": "massiveUploadCbillCsv",
        "parameters": [
          {
            "name": "incremental",
            "in": "query",
            "description": "Loading mode (true = incremental|false = full): incremental sets only PA entry with no cbill code, full replace the cbill code for all the CI in the PA table",
            "required": false,
            "schema": {
              "type": "boolean",
              "default": true
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "CSV file regarding cbill codes to load",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/ibans": {
      "post": {
        "tags": [
          "Ibans"
        ],
        "summary": "Upload a zip file containing the details of multiple ibans to create",
        "operationId": "massiveCreateIbans",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "Zip file containing IBANs to create",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/ibans/csv": {
      "post": {
        "tags": [
          "Ibans"
        ],
        "summary": "Upload a CSV file containing the details of multiple ibans to create",
        "operationId": "massiveCreateIbansCsv",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "CSV file regarding various Ibans actions",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/ibans/labels": {
      "post": {
        "tags": [
          "Ibans"
        ],
        "summary": "Create or update a label to be associated to IBANs",
        "operationId": "upsertIbanLabel",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/IbanLabel"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/IbanLabel"
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/view": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get view creditor institutions broker station",
        "operationId": "getCreditorInstitutionsView",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "creditorInstitutionCode",
            "in": "query",
            "description": "Filter by creditor institution code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "paBrokerCode",
            "in": "query",
            "description": "Filter by pa broker code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "stationCode",
            "in": "query",
            "description": "Filter by station code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "enabled",
            "in": "query",
            "description": "Filter by enabled",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "auxDigit",
            "in": "query",
            "description": "Filter by aux digit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          },
          {
            "name": "applicationCode",
            "in": "query",
            "description": "Filter by application code",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          },
          {
            "name": "segregationCode",
            "in": "query",
            "description": "Filter by segregation code",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          },
          {
            "name": "mod4",
            "in": "query",
            "description": "Filter by mod4",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CreditorInstitutionsView"
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
    "/creditorinstitutions/{creditorinstitutioncode}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get creditor institution details",
        "operationId": "getCreditorInstitution",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CreditorInstitutionDetails"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Update creditor institution",
        "operationId": "updateCreditorInstitution",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "The fiscal code of the Organization to update",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "description": "The values to update of the organization",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreditorInstitutionDetails"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/CreditorInstitutionDetails"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Delete creditor institution",
        "operationId": "deleteCreditorInstitution",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/{creditorinstitutioncode}/encodings": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get creditor institution encodings",
        "operationId": "getCreditorInstitutionEncodings",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CreditorInstitutionEncodings"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Create a creditor institution encoding",
        "operationId": "createCreditorInstitutionEncoding",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/Encoding"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/Encoding"
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
          },
          "409": {
            "description": "Conflict",
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
    "/creditorinstitutions/{creditorinstitutioncode}/encodings/{encodingcode}": {
      "delete": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Delete a creditor institution encoding",
        "operationId": "deleteCreditorInstitutionEncoding",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "encodingcode",
            "in": "path",
            "description": "Code of the Encoding",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/{creditorinstitutioncode}/ibans": {
      "get": {
        "tags": [
          "Ibans"
        ],
        "summary": "Get creditor institution ibans",
        "operationId": "getCreditorInstitutionsIbans",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Ibans"
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
          },
          "404": {
            "description": "Not Found",
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
          "Ibans"
        ],
        "summary": "Create creditor institution ibans",
        "operationId": "createCreditorInstitutionsIbans",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/IbanEnhanced"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/IbanEnhanced"
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
          "422": {
            "description": "Unprocessable Entity",
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
    "/creditorinstitutions/{creditorinstitutioncode}/ibans/list": {
      "get": {
        "tags": [
          "Ibans"
        ],
        "summary": "Get creditor institution ibans list",
        "operationId": "getIbans",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32",
              "default": 0
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "pattern": "\\d{11}",
              "type": "string"
            }
          },
          {
            "name": "label",
            "in": "query",
            "description": "Filter by label",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/IbansEnhanced"
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/{creditorinstitutioncode}/ibans/{ibanId}": {
      "put": {
        "tags": [
          "Ibans"
        ],
        "summary": "Update creditor institution ibans",
        "operationId": "updateCreditorInstitutionsIbans",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "ibanId",
            "in": "path",
            "description": "The IBAN identifier code, used to reference the object.",
            "required": true,
            "schema": {
              "maxLength": 35,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/IbanEnhanced"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/IbanEnhanced"
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
          "422": {
            "description": "Unprocessable Entity",
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
    "/creditorinstitutions/{creditorinstitutioncode}/ibans/{ibanValue}": {
      "delete": {
        "tags": [
          "Ibans"
        ],
        "summary": "Delete a creditor institution iban",
        "operationId": "deleteCreditorInstitutionsIban",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "ibanValue",
            "in": "path",
            "description": "Value of the Iban to be deleted",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Ok",
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
          },
          "404": {
            "description": "Not Found",
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
    "/creditorinstitutions/{creditorinstitutioncode}/stations": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get station details and relation info with creditor institution",
        "operationId": "getCreditorInstitutionStations",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CreditorInstitutionStationList"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Create station details and relation info with creditor institution",
        "operationId": "createCreditorInstitutionStation",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreditorInstitutionStationEdit"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/CreditorInstitutionStationEdit"
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
          },
          "409": {
            "description": "Conflict",
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
    "/creditorinstitutions/{creditorinstitutioncode}/stations/{stationcode}": {
      "put": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Update a relation between creditor institution and station",
        "operationId": "updateCreditorInstitutionStation",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "The fiscal code of the Organization to update",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          },
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreditorInstitutionStationEdit"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/CreditorInstitutionStationEdit"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Delete a relation between creditor institution and station",
        "operationId": "deleteCreditorInstitutionStation",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          },
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/encodings/{encodingcode}": {
      "get": {
        "tags": [
          "Utilities"
        ],
        "summary": "Get creditor institutions by encoding",
        "operationId": "getCreditorInstitutionByPostalEncoding",
        "parameters": [
          {
            "name": "encodingcode",
            "in": "path",
            "description": "Code of the Encoding",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CreditorInstitutionList"
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
          },
          "404": {
            "description": "Not Found",
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
    "/ibans/{iban}": {
      "get": {
        "tags": [
          "Utilities"
        ],
        "summary": "Get list of creditor institutions having IBAN",
        "operationId": "getCreditorInstitutionsByIban",
        "parameters": [
          {
            "name": "iban",
            "in": "path",
            "description": "Iban to find",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/CreditorInstitutionList"
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
    "/icas": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get the list of ICAs",
        "operationId": "getIcas",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "idica",
            "in": "query",
            "description": "filter by Id ICA",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "filter by Creditor Institution",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Icas"
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
          "Creditor Institutions"
        ],
        "summary": "Upload a XML file containing the details of an ICA",
        "operationId": "createIca",
        "parameters": [
          {
            "name": "force",
            "in": "query",
            "description": "Force upload ignoring the validity date",
            "required": false,
            "schema": {
              "type": "boolean",
              "default": false
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "XML file regarding ICA to create",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/icas/check": {
      "post": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Validate XML file containing the details of an ICA",
        "operationId": "verifyIca",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "XML file regarding ICA to check",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
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
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/CheckItem"
                  }
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
    "/icas/check/massive": {
      "post": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Massive validation of XML files containing the details of an ICA",
        "operationId": "massiveVerifyIcas",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "Zip file containing ICA XMLs to check",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
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
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/MassiveCheck"
                  }
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
    "/icas/massive": {
      "post": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Upload a zip file containing the details of multiple ICAs",
        "operationId": "massiveCreateIcas",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "Zip file containing ICAs to create",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
    "/icas/xsd": {
      "post": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Validate XML against XSD",
        "operationId": "checkXSD",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "file"
                ],
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "description": "XML file regarding ICA to check",
                    "format": "binary"
                  }
                }
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/XSDValidation"
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
    "/icas/{idica}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Download a XML file containing the details of an ICA",
        "operationId": "getIca",
        "parameters": [
          {
            "name": "idica",
            "in": "path",
            "description": "Id ICA",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "Creditor institution code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/xml": {
                "schema": {
                  "type": "string",
                  "format": "binary"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Delete an ICA XML file",
        "operationId": "deleteIca",
        "parameters": [
          {
            "name": "idica",
            "in": "path",
            "description": "Id ICA",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "Creditor institution code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "Return OK if application is started",
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
    "/paymentserviceproviders": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get paginated list of Payment Service Providers",
        "operationId": "getPaymentServiceProviders",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "code",
            "in": "query",
            "description": "Filter by code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "name",
            "in": "query",
            "description": "Filter by name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "taxCode",
            "in": "query",
            "description": "Filter by tax code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "orderby",
            "in": "query",
            "description": "Order by code or name",
            "required": false,
            "schema": {
              "type": "string",
              "default": "CODE",
              "enum": [
                "CODE",
                "NAME"
              ]
            }
          },
          {
            "name": "ordering",
            "in": "query",
            "description": "Direction of ordering",
            "required": false,
            "schema": {
              "type": "string",
              "default": "DESC",
              "enum": [
                "ASC",
                "DESC"
              ]
            }
          }
        ],
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
                  "$ref": "#/components/schemas/PaymentServiceProviders"
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
          "Payment Service Providers"
        ],
        "summary": "Create a payment service provider",
        "operationId": "createPaymentServiceProvider",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PaymentServiceProviderDetails"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/PaymentServiceProviderDetails"
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
          },
          "409": {
            "description": "Conflict",
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
    "/paymentserviceproviders/view": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get view Payment Service Providers channel broker",
        "operationId": "getPaymentServiceProvidersView",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "pspCode",
            "in": "query",
            "description": "Filter by psp code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "pspBrokerCode",
            "in": "query",
            "description": "Filter by psp broker code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "channelCode",
            "in": "query",
            "description": "Filter by channel code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "paymentType",
            "in": "query",
            "description": "Filter by payment type",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "paymentModel",
            "in": "query",
            "description": "Filter by payment model",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/PaymentServiceProvidersView"
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
    "/paymentserviceproviders/{pspcode}": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get payment service provider details",
        "operationId": "getPaymentServiceProvider",
        "parameters": [
          {
            "name": "pspcode",
            "in": "path",
            "description": "Code of the payment service provider",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/PaymentServiceProviderDetails"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Update a payment service provider",
        "operationId": "updatePaymentServiceProvider",
        "parameters": [
          {
            "name": "pspcode",
            "in": "path",
            "description": "Code of the payment service provider",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PaymentServiceProviderDetails"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/PaymentServiceProviderDetails"
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
          },
          "404": {
            "description": "Not Found",
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
          "Payment Service Providers"
        ],
        "summary": "Delete a payment service provider",
        "operationId": "deletePaymentServiceProvider",
        "parameters": [
          {
            "name": "pspcode",
            "in": "path",
            "description": "Code of the payment service provider",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/paymentserviceproviders/{pspcode}/channels": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get channels details and relation info with PSP",
        "operationId": "getPaymentServiceProvidersChannels",
        "parameters": [
          {
            "name": "pspcode",
            "in": "path",
            "description": "Code of the payment service provider",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "responses": {
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
                  "$ref": "#/components/schemas/PspChannelList"
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
          },
          "404": {
            "description": "Not Found",
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
          "Payment Service Providers"
        ],
        "summary": "Create channel details and relation info with PSP",
        "operationId": "createPaymentServiceProvidersChannels",
        "parameters": [
          {
            "name": "pspcode",
            "in": "path",
            "description": "Code of the payment service provider",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PspChannelCode"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/PspChannelCode"
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
    "/paymentserviceproviders/{pspcode}/channels/{channelcode}": {
      "put": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Update a relation between PSP and channel",
        "operationId": "updatePaymentServiceProvidersChannels",
        "parameters": [
          {
            "name": "pspcode",
            "in": "path",
            "description": "Code of the payment service provider",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          },
          {
            "name": "channelcode",
            "in": "path",
            "description": "Channel code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PspChannelPaymentTypes"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/PspChannelPaymentTypes"
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
          },
          "404": {
            "description": "Not Found",
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
          "Payment Service Providers"
        ],
        "summary": "Delete a relation between a PSP and a channel",
        "operationId": "deletePaymentServiceProvidersChannels",
        "parameters": [
          {
            "name": "pspcode",
            "in": "path",
            "description": "Code of the payment service provider",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          },
          {
            "name": "channelcode",
            "in": "path",
            "description": "Code of the channel",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
              "application/json": {}
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
          },
          "404": {
            "description": "Not Found",
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
            "description": "Conflict",
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
    "/refresh/config": {
      "get": {
        "tags": [
          "Refresh Operation"
        ],
        "summary": "Global Refresh Configuration activation: for all domains",
        "operationId": "getRefreshGlobalConfig",
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
              "text/plain": {
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
    "/refresh/job/{jobtype}": {
      "get": {
        "tags": [
          "Refresh Operation"
        ],
        "summary": "Job trigger activation ",
        "operationId": "getJobTrigger",
        "parameters": [
          {
            "name": "jobtype",
            "in": "path",
            "description": "Job Trigger",
            "required": true,
            "schema": {
              "type": "string",
              "enum": [
                "PA_INVIA_RT",
                "PA_RETRY_PA_INVIA_RT_NEGATIVE",
                "PA_INVIA_RT_RECOVERY",
                "PA_SEND_RT",
                "REFRESH_CONFIGURATION"
              ]
            }
          }
        ],
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
              "text/plain": {
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
          "504": {
            "description": "Gateway Timeout",
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
    "/services": {
      "get": {
        "tags": [
          "Payment Service Providers"
        ],
        "summary": "Get paginated list of services",
        "operationId": "getServices",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "pspcode",
            "in": "query",
            "required": false,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          },
          {
            "name": "brokerpspcode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "channelcode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "paymentmethodchannel",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          },
          {
            "name": "paymenttypecode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "pspflagftamp",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "channelapp",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "onus",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "flagio",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "name": "flowid",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "minimumamount",
            "in": "query",
            "required": false,
            "schema": {
              "type": "number",
              "format": "double"
            }
          },
          {
            "name": "maximumamount",
            "in": "query",
            "required": false,
            "schema": {
              "type": "number",
              "format": "double"
            }
          },
          {
            "name": "languagecode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string",
              "default": "IT",
              "enum": [
                "IT",
                "EN",
                "FR",
                "DE",
                "SL"
              ]
            }
          },
          {
            "name": "conventionCode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Services"
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
    "/stations": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get paginated list of stations",
        "operationId": "getStations",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "brokercode",
            "in": "query",
            "description": "Filter by broker",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "brokerdescription",
            "in": "query",
            "description": "Filter by broker description",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "Filter by creditor institution",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "code",
            "in": "query",
            "description": "Filter by code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "ordering",
            "in": "query",
            "description": "Direction of ordering. Results are ordered by code",
            "required": false,
            "schema": {
              "type": "string",
              "default": "DESC",
              "enum": [
                "ASC",
                "DESC"
              ]
            }
          }
        ],
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
                  "$ref": "#/components/schemas/Stations"
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
          "Creditor Institutions"
        ],
        "summary": "Create a station",
        "operationId": "createStation",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/StationDetails"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/StationDetails"
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
          },
          "409": {
            "description": "Conflict",
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
    "/stations/csv": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Download a CSV with all the stations in the system",
        "operationId": "getStationsCSV",
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
                  "type": "string",
                  "format": "binary"
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
    "/stations/{stationcode}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get station details",
        "operationId": "getStation",
        "parameters": [
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/StationDetails"
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
          },
          "404": {
            "description": "Not Found",
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
      "put": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Update a station",
        "operationId": "updateStation",
        "parameters": [
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "description": "The values to update of the station",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/StationDetails"
              }
            }
          },
          "required": true
        },
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
                  "$ref": "#/components/schemas/StationDetails"
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
          },
          "404": {
            "description": "Not Found",
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
          "Creditor Institutions"
        ],
        "summary": "Delete a station",
        "operationId": "deleteStation",
        "parameters": [
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
          },
          "404": {
            "description": "Not Found",
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
    "/stations/{stationcode}/creditorinstitutions": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get station creditor institution list",
        "operationId": "getStationCreditorInstitutions",
        "parameters": [
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "ciNameOrCF",
            "in": "query",
            "description": "Filter by name or tax code of the creditor institution",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/StationCreditorInstitutions"
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
          },
          "404": {
            "description": "Not Found",
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
    "/stations/{stationcode}/creditorinstitutions/csv": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Download a CSV with station creditor institution list",
        "operationId": "getStationCreditorInstitutionsCSV",
        "parameters": [
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
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
                  "type": "string",
                  "format": "binary"
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
          },
          "404": {
            "description": "Not Found",
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
    "/stations/{stationcode}/creditorinstitutions/{creditorinstitutioncode}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get station creditor institution relation",
        "operationId": "getStationCreditorInstitutionRelation",
        "parameters": [
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          }
        ],
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
                  "$ref": "#/components/schemas/StationCreditorInstitutions"
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
          },
          "404": {
            "description": "Not Found",
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
    }
  },
  "components": {
    "schemas": {
      "StationDetails": {
        "required": [
          "broker_code",
          "enabled",
          "flag_standin",
          "port",
          "primitive_version",
          "protocol",
          "station_code",
          "thread_number",
          "timeout_a",
          "timeout_b",
          "timeout_c",
          "version"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "version": {
            "maximum": 2,
            "minimum": 1,
            "type": "integer",
            "description": "number version",
            "format": "int64"
          },
          "is_connection_sync": {
            "type": "boolean",
            "description": "Describe the station connection's type, true synchronous, false asynchronous"
          },
          "ip": {
            "type": "string"
          },
          "password": {
            "type": "string"
          },
          "port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "redirect_ip": {
            "type": "string"
          },
          "redirect_path": {
            "type": "string"
          },
          "redirect_port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "redirect_query_string": {
            "type": "string"
          },
          "redirect_protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "service": {
            "type": "string"
          },
          "pof_service": {
            "type": "string"
          },
          "broker_code": {
            "type": "string"
          },
          "protocol_4mod": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "ip_4mod": {
            "type": "string"
          },
          "port_4mod": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "service_4mod": {
            "type": "string"
          },
          "proxy_enabled": {
            "type": "boolean"
          },
          "proxy_host": {
            "type": "string"
          },
          "proxy_port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "proxy_username": {
            "type": "string"
          },
          "proxy_password": {
            "type": "string"
          },
          "thread_number": {
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "timeout_a": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "timeout_b": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "timeout_c": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "flag_online": {
            "type": "boolean"
          },
          "invio_rt_istantaneo": {
            "type": "boolean"
          },
          "target_host": {
            "type": "string"
          },
          "target_port": {
            "type": "integer",
            "format": "int64"
          },
          "target_path": {
            "type": "string"
          },
          "target_host_pof": {
            "type": "string"
          },
          "target_port_pof": {
            "type": "integer",
            "format": "int64"
          },
          "target_path_pof": {
            "type": "string"
          },
          "primitive_version": {
            "maximum": 2,
            "minimum": 1,
            "type": "integer",
            "description": "Primitive number version",
            "format": "int32"
          },
          "flag_standin": {
            "type": "boolean",
            "description": "Represents the authorization to use the standin mode with this station"
          },
          "is_payment_options_enabled": {
            "type": "boolean"
          },
          "rest_endpoint": {
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
      "PaymentServiceProviderDetails": {
        "required": [
          "business_name",
          "enabled",
          "psp_code"
        ],
        "type": "object",
        "properties": {
          "psp_code": {
            "pattern": "[A-Z0-9_]{6,14}",
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "business_name": {
            "type": "string"
          },
          "tax_code": {
            "type": "string"
          },
          "abi": {
            "type": "string"
          },
          "bic": {
            "type": "string"
          },
          "my_bank_code": {
            "type": "string",
            "description": "MyBank code"
          },
          "stamp": {
            "type": "boolean"
          },
          "agid_psp": {
            "type": "boolean",
            "description": "True if the PSP is internal"
          },
          "vat_number": {
            "type": "string"
          }
        }
      },
      "PspChannelPaymentTypes": {
        "required": [
          "payment_types"
        ],
        "type": "object",
        "properties": {
          "payment_types": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "CreditorInstitutionAddress": {
        "type": "object",
        "properties": {
          "location": {
            "type": "string",
            "example": "Via delle vie 3"
          },
          "city": {
            "type": "string",
            "example": "Lorem"
          },
          "zip_code": {
            "pattern": "^\\d{5}$|^$",
            "type": "string",
            "example": "00187"
          },
          "country_code": {
            "pattern": "^\\w{2}$|^$",
            "type": "string",
            "example": "RM"
          },
          "tax_domicile": {
            "type": "string"
          }
        }
      },
      "CreditorInstitutionDetails": {
        "required": [
          "address",
          "business_name",
          "creditor_institution_code",
          "enabled",
          "psp_payment",
          "reporting_ftp",
          "reporting_zip"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "creditor institution enabled",
            "default": true
          },
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "description": "The description of the Creditor Institution",
            "example": "Comune di Roma"
          },
          "cbill_code": {
            "type": "string",
            "example": "1234567890100"
          },
          "address": {
            "$ref": "#/components/schemas/CreditorInstitutionAddress"
          },
          "psp_payment": {
            "type": "boolean",
            "default": true
          },
          "reporting_ftp": {
            "type": "boolean",
            "default": false
          },
          "reporting_zip": {
            "type": "boolean",
            "default": false
          }
        }
      },
      "CreditorInstitutionStationEdit": {
        "required": [
          "station_code"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "aux_digit": {
            "maximum": 3,
            "minimum": 0,
            "type": "integer",
            "format": "int64",
            "example": 1,
            "enum": [
              0,
              1,
              2,
              3
            ]
          },
          "application_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "segregation_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "mod4": {
            "type": "boolean"
          },
          "broadcast": {
            "type": "boolean"
          },
          "aca": {
            "type": "boolean"
          },
          "stand_in": {
            "type": "boolean"
          },
          "spontaneous_payment": {
            "type": "boolean"
          }
        }
      },
      "IbanEnhanced": {
        "required": [
          "ci_owner",
          "due_date",
          "iban",
          "is_active",
          "publication_date",
          "validity_date"
        ],
        "type": "object",
        "properties": {
          "iban": {
            "maxLength": 35,
            "minLength": 0,
            "pattern": "[a-zA-Z]{2}\\d{2}[a-zA-Z0-9]{1,30}",
            "type": "string",
            "description": "The iban code",
            "example": "IT99C0222211111000000000000"
          },
          "ci_owner": {
            "maxLength": 11,
            "minLength": 0,
            "type": "string",
            "description": "Fiscal code of the Creditor Institution who owns the iban",
            "readOnly": true,
            "example": "77777777777"
          },
          "company_name": {
            "maxLength": 100,
            "minLength": 0,
            "type": "string",
            "description": "The Creditor Institution company name",
            "readOnly": true,
            "example": "Comune di Firenze"
          },
          "description": {
            "maxLength": 300,
            "minLength": 0,
            "type": "string",
            "description": "The description the Creditor Institution gives to the iban about its usage",
            "example": "Riscossione Tributi"
          },
          "is_active": {
            "type": "boolean",
            "description": "True if the iban is active",
            "example": true
          },
          "validity_date": {
            "type": "string",
            "description": "The date the Creditor Institution wants the iban to be used for its payments",
            "format": "date-time",
            "example": "2023-04-01T13:49:19.897Z"
          },
          "publication_date": {
            "type": "string",
            "description": "The date on which the iban has been inserted in the system",
            "format": "date-time",
            "readOnly": true,
            "example": "2023-06-01T23:59:59.999Z"
          },
          "due_date": {
            "type": "string",
            "description": "The date on which the iban will expire",
            "format": "date-time",
            "example": "2023-12-31T23:59:59.999Z"
          },
          "labels": {
            "type": "array",
            "description": "The labels array associated with the iban",
            "items": {
              "$ref": "#/components/schemas/IbanLabel"
            }
          }
        }
      },
      "IbanLabel": {
        "required": [
          "description",
          "name"
        ],
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "example": "CUP"
          },
          "description": {
            "type": "string",
            "example": "The IBAN to use for CUP payments"
          }
        },
        "description": "The labels array associated with the iban"
      },
      "WfespPluginConfBase": {
        "required": [
          "id_bean",
          "pag_const_string_profile",
          "pag_rpt_xpath_profile",
          "pag_soap_rule_profile"
        ],
        "type": "object",
        "properties": {
          "pag_const_string_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "pag_soap_rule_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "IDVS=$buyerBank$"
          },
          "pag_rpt_xpath_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "id_bean": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "defaultForwardProcessor"
          }
        }
      },
      "PddBase": {
        "required": [
          "description",
          "enabled",
          "ip"
        ],
        "type": "object",
        "properties": {
          "enabled": {
            "type": "boolean",
            "example": false
          },
          "description": {
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "ip": {
            "type": "string",
            "example": "localhost"
          },
          "port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int32",
            "example": 1234
          }
        }
      },
      "PaymentTypeBase": {
        "type": "object",
        "properties": {
          "description": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "Addebito diretto"
          }
        }
      },
      "PaymentType": {
        "required": [
          "payment_type"
        ],
        "type": "object",
        "properties": {
          "description": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "Addebito diretto"
          },
          "payment_type": {
            "maxLength": 15,
            "minLength": 0,
            "pattern": "[A-Z]*",
            "type": "string",
            "example": "AD"
          }
        }
      },
      "ConfigurationKeyBase": {
        "required": [
          "config_value"
        ],
        "type": "object",
        "properties": {
          "config_value": {
            "type": "string",
            "example": "180000"
          },
          "config_description": {
            "type": "string",
            "example": " default millisecondi validitÃ  token"
          }
        }
      },
      "FtpServer": {
        "required": [
          "enabled",
          "host",
          "password",
          "port",
          "root_path",
          "service",
          "type",
          "username"
        ],
        "type": "object",
        "properties": {
          "host": {
            "type": "string",
            "example": "host.domain"
          },
          "port": {
            "type": "integer",
            "format": "int32",
            "example": 1234
          },
          "username": {
            "type": "string",
            "example": "username"
          },
          "password": {
            "type": "string",
            "example": "pwdpwdpwd"
          },
          "root_path": {
            "type": "string",
            "example": "/"
          },
          "service": {
            "type": "string",
            "example": "service"
          },
          "type": {
            "type": "string",
            "example": "out"
          },
          "in_path": {
            "type": "string",
            "example": "/in/service"
          },
          "out_path": {
            "type": "string",
            "example": "/out/service"
          },
          "history_path": {
            "type": "string",
            "example": "/out/history/service"
          },
          "enabled": {
            "type": "boolean",
            "default": true
          }
        }
      },
      "ChannelDetails": {
        "required": [
          "agid",
          "broker_psp_code",
          "card_chart",
          "channel_code",
          "digital_stamp_brand",
          "enabled",
          "flag_psp_cp",
          "flag_standin",
          "on_us",
          "payment_model",
          "port",
          "primitive_version",
          "protocol",
          "recovery",
          "rt_push",
          "thread_number",
          "timeout_a",
          "timeout_b",
          "timeout_c"
        ],
        "type": "object",
        "properties": {
          "channel_code": {
            "type": "string",
            "example": "223344556677889900"
          },
          "enabled": {
            "type": "boolean"
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "primitive_version": {
            "type": "integer",
            "description": "Primitive number version",
            "format": "int32"
          },
          "password": {
            "type": "string"
          },
          "protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "ip": {
            "type": "string"
          },
          "port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "service": {
            "type": "string"
          },
          "broker_psp_code": {
            "type": "string"
          },
          "proxy_enabled": {
            "type": "boolean"
          },
          "proxy_host": {
            "type": "string"
          },
          "proxy_port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "proxy_username": {
            "type": "string"
          },
          "proxy_password": {
            "type": "string"
          },
          "target_host": {
            "type": "string"
          },
          "target_port": {
            "type": "integer",
            "format": "int64"
          },
          "target_path": {
            "type": "string"
          },
          "thread_number": {
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "timeout_a": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "timeout_b": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "timeout_c": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "nmp_service": {
            "type": "string"
          },
          "new_fault_code": {
            "type": "boolean"
          },
          "target_host_nmp": {
            "type": "string"
          },
          "target_port_nmp": {
            "type": "integer",
            "format": "int64"
          },
          "target_path_nmp": {
            "type": "string"
          },
          "redirect_ip": {
            "type": "string"
          },
          "redirect_path": {
            "type": "string"
          },
          "redirect_port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "redirect_query_string": {
            "type": "string"
          },
          "redirect_protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "payment_model": {
            "type": "string",
            "enum": [
              "IMMEDIATE",
              "IMMEDIATE_MULTIBENEFICIARY",
              "DEFERRED",
              "ACTIVATED_AT_PSP"
            ]
          },
          "serv_plugin": {
            "type": "string"
          },
          "rt_push": {
            "type": "boolean"
          },
          "on_us": {
            "type": "boolean"
          },
          "card_chart": {
            "type": "boolean"
          },
          "recovery": {
            "type": "boolean"
          },
          "digital_stamp_brand": {
            "type": "boolean"
          },
          "flag_io": {
            "type": "boolean"
          },
          "agid": {
            "type": "boolean"
          },
          "flag_psp_cp": {
            "type": "boolean",
            "description": "Represents the authorization to carry out the transfer of the information present in additional payment information in the tags relating to payment by card for the PA in V1"
          },
          "flag_standin": {
            "type": "boolean",
            "description": "Represents the authorization to use the standin mode with this channel"
          }
        }
      },
      "BrokerPspDetails": {
        "required": [
          "broker_psp_code",
          "description",
          "enabled",
          "extended_fault_bean"
        ],
        "type": "object",
        "properties": {
          "broker_psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "description": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "extended_fault_bean": {
            "type": "boolean"
          }
        }
      },
      "BrokerDetails": {
        "required": [
          "broker_code",
          "description",
          "enabled",
          "extended_fault_bean"
        ],
        "type": "object",
        "properties": {
          "broker_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "enabled": {
            "type": "boolean"
          },
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "extended_fault_bean": {
            "type": "boolean"
          }
        }
      },
      "UpdateStationMaintenance": {
        "required": [
          "end_date_time"
        ],
        "type": "object",
        "properties": {
          "start_date_time": {
            "type": "string",
            "description": "The start date time of the station maintenance",
            "format": "date-time",
            "example": "2024-04-01T10:00:00+02:00"
          },
          "end_date_time": {
            "type": "string",
            "description": "The end date time of the station maintenance",
            "format": "date-time",
            "example": "2024-04-01T13:00:00+02:00"
          },
          "stand_in": {
            "type": "boolean",
            "description": "StandIn flag"
          }
        }
      },
      "StationMaintenanceResource": {
        "required": [
          "broker_code",
          "end_date_time",
          "maintenance_id",
          "stand_in",
          "start_date_time",
          "station_code"
        ],
        "type": "object",
        "properties": {
          "maintenance_id": {
            "type": "integer",
            "description": "Maintenance's id",
            "format": "int64"
          },
          "start_date_time": {
            "type": "string",
            "description": "The start date time of the station maintenance",
            "format": "date-time",
            "example": "2024-04-01T10:00:00+02:00"
          },
          "end_date_time": {
            "type": "string",
            "description": "The end date time of the station maintenance",
            "format": "date-time",
            "example": "2024-04-01T13:00:00+02:00"
          },
          "stand_in": {
            "type": "boolean",
            "description": "StandIn flag"
          },
          "station_code": {
            "type": "string",
            "description": "Code of the station subject of the maintenance"
          },
          "broker_code": {
            "type": "string",
            "description": "Code of the broker that owns the station"
          }
        },
        "description": "List of station's maintenance"
      },
      "PspChannelCode": {
        "required": [
          "channel_code",
          "payment_types"
        ],
        "type": "object",
        "properties": {
          "payment_types": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "channel_code": {
            "type": "string"
          }
        }
      },
      "XSDValidation": {
        "required": [
          "detail",
          "xsdCompliant",
          "xsdSchema"
        ],
        "type": "object",
        "properties": {
          "xsdCompliant": {
            "type": "boolean",
            "example": false
          },
          "xsdSchema": {
            "type": "string",
            "example": "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"
          },
          "detail": {
            "type": "string",
            "example": "Invalid content was found starting with element 'idBancaSeller'. One of '{ibanAccredito}' is expected. Error at lineNumber: 10"
          }
        }
      },
      "CheckItem": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string"
          },
          "value": {
            "type": "string"
          },
          "valid": {
            "type": "string",
            "enum": [
              "VALID",
              "NOT_VALID"
            ]
          },
          "note": {
            "type": "string"
          },
          "action": {
            "type": "string"
          }
        }
      },
      "MassiveCheck": {
        "type": "object",
        "properties": {
          "fileName": {
            "type": "string"
          },
          "checkItems": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CheckItem"
            }
          }
        }
      },
      "Encoding": {
        "required": [
          "code_type",
          "encoding_code"
        ],
        "type": "object",
        "properties": {
          "code_type": {
            "type": "string",
            "description": "BARCODE_GS1_128 is deprecated and not allowed",
            "enum": [
              "QR_CODE",
              "BARCODE_128_AIM",
              "BARCODE_GS1_128"
            ]
          },
          "encoding_code": {
            "type": "string",
            "example": "0000111"
          }
        }
      },
      "WfespPluginConf": {
        "required": [
          "id_bean",
          "id_serv_plugin",
          "pag_const_string_profile",
          "pag_rpt_xpath_profile",
          "pag_soap_rule_profile"
        ],
        "type": "object",
        "properties": {
          "pag_const_string_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "pag_soap_rule_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "IDVS=$buyerBank$"
          },
          "pag_rpt_xpath_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "id_bean": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "defaultForwardProcessor"
          },
          "id_serv_plugin": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "idPsp1"
          }
        }
      },
      "Pdd": {
        "required": [
          "description",
          "enabled",
          "id_pdd",
          "ip"
        ],
        "type": "object",
        "properties": {
          "enabled": {
            "type": "boolean",
            "example": false
          },
          "description": {
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "ip": {
            "type": "string",
            "example": "localhost"
          },
          "port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int32",
            "example": 1234
          },
          "id_pdd": {
            "type": "string",
            "example": "localhost"
          }
        }
      },
      "ConfigurationKey": {
        "required": [
          "config_category",
          "config_key",
          "config_value"
        ],
        "type": "object",
        "properties": {
          "config_value": {
            "type": "string",
            "example": "180000"
          },
          "config_description": {
            "type": "string",
            "example": " default millisecondi validitÃ  token"
          },
          "config_category": {
            "type": "string",
            "example": "GLOBAL"
          },
          "config_key": {
            "type": "string",
            "example": "default_token_duration_validity_millis"
          }
        }
      },
      "CreateStationMaintenance": {
        "required": [
          "end_date_time",
          "stand_in",
          "start_date_time",
          "station_code"
        ],
        "type": "object",
        "properties": {
          "start_date_time": {
            "type": "string",
            "description": "The start date time of the station maintenance",
            "format": "date-time",
            "example": "2024-04-01T10:00:00+02:00"
          },
          "end_date_time": {
            "type": "string",
            "description": "The end date time of the station maintenance",
            "format": "date-time",
            "example": "2024-04-01T13:00:00+02:00"
          },
          "stand_in": {
            "type": "boolean",
            "description": "StandIn flag"
          },
          "station_code": {
            "type": "string",
            "description": "Code of the station subject of the maintenance"
          }
        }
      },
      "PageInfo": {
        "required": [
          "items_found",
          "limit",
          "page",
          "total_items",
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
          },
          "total_items": {
            "type": "integer",
            "description": "Total number of items for all pages",
            "format": "int64"
          }
        }
      },
      "Station": {
        "required": [
          "enabled",
          "station_code",
          "version"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "version": {
            "maximum": 2,
            "minimum": 1,
            "type": "integer",
            "description": "number version",
            "format": "int64"
          },
          "is_connection_sync": {
            "type": "boolean",
            "description": "Describe the station connection's type, true synchronous, false asynchronous"
          }
        }
      },
      "Stations": {
        "required": [
          "page_info",
          "stations"
        ],
        "type": "object",
        "properties": {
          "stations": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Station"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "StationCreditorInstitution": {
        "required": [
          "business_name",
          "creditor_institution_code",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "creditor institution enabled",
            "default": true
          },
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "description": "The description of the Creditor Institution",
            "example": "Comune di Roma"
          },
          "application_code": {
            "type": "integer",
            "format": "int64"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "segregation_code": {
            "type": "integer",
            "format": "int64"
          },
          "mod4": {
            "type": "boolean"
          },
          "broadcast": {
            "type": "boolean"
          },
          "aca": {
            "type": "boolean"
          },
          "stand_in": {
            "type": "boolean"
          },
          "spontaneous_payment": {
            "type": "boolean"
          }
        }
      },
      "StationCreditorInstitutions": {
        "required": [
          "creditor_institutions",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "creditor_institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/StationCreditorInstitution"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "Service": {
        "type": "object",
        "properties": {
          "psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "flow_id": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "psp_business_name": {
            "type": "string"
          },
          "psp_flag_stamp": {
            "type": "boolean"
          },
          "broker_psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "channel_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "service_name": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "payment_method_channel": {
            "type": "integer",
            "format": "int64"
          },
          "payment_type_code": {
            "type": "string"
          },
          "language_code": {
            "type": "string",
            "enum": [
              "IT",
              "EN",
              "FR",
              "DE",
              "SL"
            ]
          },
          "service_description": {
            "maxLength": 511,
            "minLength": 0,
            "type": "string"
          },
          "service_availability": {
            "maxLength": 511,
            "minLength": 0,
            "type": "string"
          },
          "channel_url": {
            "type": "string"
          },
          "minimum_amount": {
            "type": "number",
            "format": "double"
          },
          "maximum_amount": {
            "type": "number",
            "format": "double"
          },
          "fixed_cost": {
            "type": "number",
            "format": "double"
          },
          "timestamp_insertion": {
            "type": "string",
            "format": "date-time"
          },
          "validity_date": {
            "type": "string",
            "format": "date-time"
          },
          "logo_psp": {
            "type": "string",
            "format": "byte"
          },
          "tags": {
            "maxLength": 135,
            "minLength": 0,
            "type": "string"
          },
          "logo_service": {
            "type": "string",
            "format": "byte"
          },
          "channel_app": {
            "type": "boolean"
          },
          "on_us": {
            "type": "boolean"
          },
          "cart_card": {
            "type": "boolean"
          },
          "abi_code": {
            "maxLength": 5,
            "minLength": 0,
            "type": "string"
          },
          "mybank_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "convention_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "flag_io": {
            "type": "boolean"
          }
        }
      },
      "Services": {
        "required": [
          "page_info",
          "services"
        ],
        "type": "object",
        "properties": {
          "services": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Service"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "PaymentServiceProvider": {
        "required": [
          "business_name",
          "enabled",
          "psp_code"
        ],
        "type": "object",
        "properties": {
          "psp_code": {
            "pattern": "[A-Z0-9_]{6,14}",
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "business_name": {
            "type": "string"
          },
          "tax_code": {
            "type": "string"
          }
        }
      },
      "PaymentServiceProviders": {
        "required": [
          "page_info",
          "payment_service_providers"
        ],
        "type": "object",
        "properties": {
          "payment_service_providers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentServiceProvider"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "PspChannel": {
        "required": [
          "channel_code",
          "enabled",
          "payment_types"
        ],
        "type": "object",
        "properties": {
          "payment_types": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "channel_code": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          }
        }
      },
      "PspChannelList": {
        "required": [
          "channels"
        ],
        "type": "object",
        "properties": {
          "channels": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PspChannel"
            }
          }
        }
      },
      "PaymentServiceProviderView": {
        "required": [
          "broker_psp_code",
          "channel_code",
          "payment_method",
          "payment_type",
          "psp_code"
        ],
        "type": "object",
        "properties": {
          "psp_code": {
            "pattern": "[A-Z0-9_]{6,14}",
            "type": "string"
          },
          "broker_psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "channel_code": {
            "type": "string",
            "example": "223344556677889900"
          },
          "payment_type": {
            "type": "string"
          },
          "payment_method": {
            "type": "string"
          }
        }
      },
      "PaymentServiceProvidersView": {
        "required": [
          "page_info",
          "payment_service_providers"
        ],
        "type": "object",
        "properties": {
          "payment_service_providers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentServiceProviderView"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "AppInfo": {
        "required": [
          "environment",
          "name",
          "version"
        ],
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
          },
          "dbConnection": {
            "type": "string"
          }
        }
      },
      "Ica": {
        "required": [
          "business_name",
          "creditor_institution_code",
          "id_ica",
          "publication_date",
          "validity_date"
        ],
        "type": "object",
        "properties": {
          "id_ica": {
            "type": "string",
            "example": "123456789"
          },
          "creditor_institution_code": {
            "type": "string",
            "example": "1234567890100"
          },
          "business_name": {
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "validity_date": {
            "type": "string",
            "format": "date-time"
          },
          "publication_date": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "Icas": {
        "required": [
          "icas",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "icas": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Ica"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "CreditorInstitution": {
        "required": [
          "business_name",
          "creditor_institution_code",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "creditor institution enabled",
            "default": true
          },
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "description": "The description of the Creditor Institution",
            "example": "Comune di Roma"
          }
        }
      },
      "CreditorInstitutionList": {
        "required": [
          "creditor_institutions"
        ],
        "type": "object",
        "properties": {
          "creditor_institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CreditorInstitution"
            }
          }
        }
      },
      "CreditorInstitutions": {
        "required": [
          "creditor_institutions",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "creditor_institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CreditorInstitution"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "CreditorInstitutionStation": {
        "required": [
          "enabled",
          "station_code",
          "version"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "version": {
            "maximum": 2,
            "minimum": 1,
            "type": "integer",
            "description": "number version",
            "format": "int64"
          },
          "is_connection_sync": {
            "type": "boolean",
            "description": "Describe the station connection's type, true synchronous, false asynchronous"
          },
          "application_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "segregation_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "mod4": {
            "type": "boolean"
          },
          "broadcast": {
            "type": "boolean"
          },
          "aca": {
            "type": "boolean"
          },
          "stand_in": {
            "type": "boolean"
          },
          "spontaneous_payment": {
            "type": "boolean"
          }
        }
      },
      "CreditorInstitutionStationList": {
        "required": [
          "stations"
        ],
        "type": "object",
        "properties": {
          "stations": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CreditorInstitutionStation"
            }
          }
        }
      },
      "Iban": {
        "required": [
          "iban",
          "validity_date"
        ],
        "type": "object",
        "properties": {
          "iban": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "description": "The iban code value",
            "example": "IT99C0222211111000000000000"
          },
          "validity_date": {
            "type": "string",
            "description": "The date until which the iban is valid",
            "format": "date-time"
          },
          "publication_date": {
            "type": "string",
            "description": "The publication date of the iban",
            "format": "date-time"
          }
        }
      },
      "Ibans": {
        "required": [
          "ibans"
        ],
        "type": "object",
        "properties": {
          "ibans": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Iban"
            }
          }
        }
      },
      "IbansEnhanced": {
        "required": [
          "ibans_enhanced",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "ibans_enhanced": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/IbanEnhanced"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "CreditorInstitutionEncodings": {
        "required": [
          "encodings"
        ],
        "type": "object",
        "properties": {
          "encodings": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Encoding"
            }
          }
        }
      },
      "CreditorInstitutionView": {
        "required": [
          "broker_code",
          "creditor_institution_code",
          "station_code"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "broker_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "application_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "segregation_code": {
            "type": "integer",
            "format": "int64"
          },
          "mod4": {
            "type": "boolean"
          },
          "station_enabled": {
            "type": "boolean"
          }
        }
      },
      "CreditorInstitutionsView": {
        "required": [
          "creditor_institutions",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "creditor_institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CreditorInstitutionView"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "CounterpartTable": {
        "required": [
          "business_name",
          "creditor_institution_code",
          "id_counterpart_table",
          "publication_date",
          "validity_date"
        ],
        "type": "object",
        "properties": {
          "id_counterpart_table": {
            "type": "string",
            "example": "123456789"
          },
          "business_name": {
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "creditor_institution_code": {
            "type": "string",
            "example": "1234567890100"
          },
          "publication_date": {
            "type": "string",
            "format": "date-time"
          },
          "validity_date": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "CounterpartTables": {
        "required": [
          "counterpart_tables",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "counterpart_tables": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CounterpartTable"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "WfespPluginConfs": {
        "required": [
          "wfesp_plugin_confs"
        ],
        "type": "object",
        "properties": {
          "wfesp_plugin_confs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/WfespPluginConf"
            }
          }
        }
      },
      "Pdds": {
        "required": [
          "pdds"
        ],
        "type": "object",
        "properties": {
          "pdds": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Pdd"
            }
          }
        }
      },
      "PaymentTypes": {
        "required": [
          "payment_types"
        ],
        "type": "object",
        "properties": {
          "payment_types": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentType"
            }
          }
        }
      },
      "ConfigurationKeys": {
        "required": [
          "configuration_keys"
        ],
        "type": "object",
        "properties": {
          "configuration_keys": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ConfigurationKey"
            }
          }
        }
      },
      "FtpServers": {
        "required": [
          "ftp_servers"
        ],
        "type": "object",
        "properties": {
          "ftp_servers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/FtpServer"
            }
          }
        }
      },
      "Channel": {
        "required": [
          "channel_code",
          "enabled",
          "primitive_version"
        ],
        "type": "object",
        "properties": {
          "channel_code": {
            "type": "string",
            "example": "223344556677889900"
          },
          "enabled": {
            "type": "boolean"
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "primitive_version": {
            "type": "integer",
            "description": "Primitive number version",
            "format": "int32"
          }
        }
      },
      "Channels": {
        "required": [
          "channels",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "channels": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Channel"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "ChannelPsp": {
        "required": [
          "business_name",
          "enabled",
          "payment_types",
          "psp_code",
          "tax_code"
        ],
        "type": "object",
        "properties": {
          "psp_code": {
            "type": "string"
          },
          "business_name": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "payment_types": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "tax_code": {
            "type": "string"
          }
        }
      },
      "ChannelPspList": {
        "required": [
          "page_info",
          "payment_service_providers"
        ],
        "type": "object",
        "properties": {
          "payment_service_providers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ChannelPsp"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "Cdi": {
        "required": [
          "business_name",
          "id_cdi",
          "psp_code"
        ],
        "type": "object",
        "properties": {
          "id_cdi": {
            "type": "string",
            "example": "223344556677889900"
          },
          "psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "business_name": {
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "validity_date": {
            "type": "string",
            "format": "date-time",
            "example": "2021-10-08T14:55:16.302Z"
          },
          "publication_date": {
            "type": "string",
            "format": "date-time",
            "example": "2021-10-08T14:55:16.302Z"
          }
        }
      },
      "Cdis": {
        "required": [
          "cdis",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "cdis": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Cdi"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "Cache": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "time": {
            "type": "string"
          }
        }
      },
      "CacheVersions": {
        "required": [
          "page_info",
          "version_list"
        ],
        "type": "object",
        "properties": {
          "version_list": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Cache"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "BrokerPsp": {
        "required": [
          "broker_psp_code",
          "description",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "broker_psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "description": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          }
        }
      },
      "BrokersPsp": {
        "required": [
          "brokers_psp",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "brokers_psp": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/BrokerPsp"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "Broker": {
        "required": [
          "broker_code",
          "description",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "broker_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "enabled": {
            "type": "boolean"
          },
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          }
        }
      },
      "Brokers": {
        "required": [
          "brokers",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "brokers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Broker"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "StationMaintenanceListResource": {
        "required": [
          "page_info",
          "station_maintenance_list"
        ],
        "type": "object",
        "properties": {
          "station_maintenance_list": {
            "type": "array",
            "description": "List of station's maintenance",
            "items": {
              "$ref": "#/components/schemas/StationMaintenanceResource"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "MaintenanceHoursSummaryResource": {
        "required": [
          "annual_hours_limit",
          "extra_hours",
          "remaining_hours",
          "scheduled_hours",
          "used_hours"
        ],
        "type": "object",
        "properties": {
          "used_hours": {
            "type": "string",
            "description": "Count of used maintenance's hours"
          },
          "scheduled_hours": {
            "type": "string",
            "description": "Count of scheduled maintenance's hours"
          },
          "remaining_hours": {
            "type": "string",
            "description": "Count of remaining maintenance's hours before annual limit"
          },
          "extra_hours": {
            "type": "string",
            "description": "Count of maintenance's hours that exceed annual limit"
          },
          "annual_hours_limit": {
            "type": "string",
            "description": "Annual limit of maintenance hours"
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
