{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API configuration",
    "description": "Spring Application exposes Api to manage configuration for EC/PSP on the Nodo dei Pagamenti",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.28.2"
  },
  "servers": [
    {
      "url": "${host}/apiconfig/api/v1",
      "description": "Generated server url"
    }
  ],
  "tags": [
    {
      "description": "Everything about Payment Service Providers",
      "name": "Payment Service Providers"
    },
    {
      "description": "Everything about Batch Operation",
      "name": "Batch Operation"
    },
    {
      "description": "Everything about Creditor Institution",
      "name": "Creditor Institutions"
    },
    {
      "description": "Everything about Configuration",
      "name": "Configuration"
    },
    {
      "description": "Everything about Utilities",
      "name": "Utilities"
    }
  ],
  "paths": {
    "/batchoperation/creditorinstitution-station/loading": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "manageCIStationRelationship",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "CSV file regarding CI-Station relationship to manage"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a CSV file containing the relationship between Creditor Institution and Station",
        "tags": [
          "Batch Operation"
        ]
      }
    },
    "/batchoperation/creditorinstitution-station/migration": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "massiveMigration",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "CSV file regarding relations to migrate"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Massive migration of the Station-CI relations",
        "tags": [
          "Batch Operation"
        ]
      }
    },
    "/brokers": {
      "get": {
        "operationId": "getBrokers",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Filter by code",
            "in": "query",
            "name": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Filter by name",
            "in": "query",
            "name": "name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Order by code or name",
            "in": "query",
            "name": "orderby",
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
            "description": "Direction of ordering",
            "in": "query",
            "name": "ordering",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Brokers"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of creditor brokers",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokerDetails"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create a broker",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/brokers/{brokercode}": {
      "delete": {
        "operationId": "deleteBroker",
        "parameters": [
          {
            "description": "broker code",
            "in": "path",
            "name": "brokercode",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a broker",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "get": {
        "operationId": "getBroker",
        "parameters": [
          {
            "description": "broker code.",
            "in": "path",
            "name": "brokercode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokerDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get creditor broker details ",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateBroker",
        "parameters": [
          {
            "description": "broker code",
            "in": "path",
            "name": "brokercode",
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
                "$ref": "#/components/schemas/BrokerDetails"
              }
            }
          },
          "description": "The values to update of the broker",
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokerDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a broker",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/brokerspsp": {
      "get": {
        "operationId": "getBrokersPsp",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Filter by code",
            "in": "query",
            "name": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Filter by name",
            "in": "query",
            "name": "name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Order by code or name",
            "in": "query",
            "name": "orderby",
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
            "description": "Direction of ordering",
            "in": "query",
            "name": "ordering",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokersPsp"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of PSP brokers",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokerPspDetails"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create a PSP broker",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/brokerspsp/{brokerpspcode}": {
      "delete": {
        "operationId": "deleteBrokerPsp",
        "parameters": [
          {
            "description": "broker PSP code",
            "in": "path",
            "name": "brokerpspcode",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a broker PSP",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "get": {
        "operationId": "getBrokerPsp",
        "parameters": [
          {
            "description": "Broker code of a PSP.",
            "in": "path",
            "name": "brokerpspcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokerPspDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get PSP broker details",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateBrokerPsp",
        "parameters": [
          {
            "description": "broker PSP code",
            "in": "path",
            "name": "brokerpspcode",
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
                "$ref": "#/components/schemas/BrokerPspDetails"
              }
            }
          },
          "description": "The values to update of the broker PSP",
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokerPspDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a broker PSP",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/cdis": {
      "get": {
        "operationId": "getCdis",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "filter by Id CDI",
            "in": "query",
            "name": "idcdi",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "filter by PSP",
            "in": "query",
            "name": "pspcode",
            "required": false,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Cdis"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of CDIs",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "createCdi",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "XML file regarding CDI to create"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a XML file containing the details of an CDI",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/cdis/check": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "verifyCdi",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "XML file regarding CDI to check"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/CheckItem"
                  }
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Verify a XML file containing the details of an CDI",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/cdis/{idcdi}": {
      "delete": {
        "operationId": "deleteCdi",
        "parameters": [
          {
            "description": "Id of a CDI",
            "in": "path",
            "name": "idcdi",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "description": "PSP code",
            "in": "query",
            "name": "pspcode",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete an CDI file",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "get": {
        "operationId": "getCdi",
        "parameters": [
          {
            "description": "Id of a CDI",
            "in": "path",
            "name": "idcdi",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "description": "PSP code",
            "in": "query",
            "name": "pspcode",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/xml": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "application/xml": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Download a XML file containing the details of a CDI",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/channels": {
      "get": {
        "operationId": "getChannels",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Filter by code",
            "in": "query",
            "name": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Direction of ordering. Results are ordered by code",
            "in": "query",
            "name": "ordering",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Channels"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of channels",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ChannelDetails"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create a Channel",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/channels/csv": {
      "get": {
        "operationId": "getChannelsCSV",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Download the list of channelss as CSV file",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/channels/{channelcode}": {
      "delete": {
        "operationId": "deleteChannel",
        "parameters": [
          {
            "description": "Channel code",
            "in": "path",
            "name": "channelcode",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a Channel",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "get": {
        "operationId": "getChannel",
        "parameters": [
          {
            "description": "channel code.",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ChannelDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get Channel details ",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateChannel",
        "parameters": [
          {
            "description": "Channel code",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ChannelDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a Channel",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/channels/{channelcode}/paymentserviceproviders": {
      "get": {
        "operationId": "getChannelPaymentServiceProviders",
        "parameters": [
          {
            "description": "Channel code",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ChannelPspList"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get the list of PSPs associated with the channel",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/channels/{channelcode}/paymentserviceproviders/csv": {
      "get": {
        "operationId": "getChannelPaymentServiceProvidersCSV",
        "parameters": [
          {
            "description": "Channel code",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Download the list of PSPs as CSV file",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/channels/{channelcode}/paymenttypes": {
      "get": {
        "operationId": "getChannelPaymentTypes",
        "parameters": [
          {
            "description": "Channel code",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PspChannelPaymentTypes"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get a payment types of a channel",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "createChannelPaymentType",
        "parameters": [
          {
            "description": "Channel code",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PspChannelPaymentTypes"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create a payment types of a channel",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/channels/{channelcode}/paymenttypes/{paymenttypecode}": {
      "delete": {
        "operationId": "deleteChannelPaymentType",
        "parameters": [
          {
            "description": "Channel code",
            "in": "path",
            "name": "channelcode",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "in": "path",
            "name": "paymenttypecode",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a payment types of a channel",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/configuration/ftpservers": {
      "get": {
        "operationId": "getFtpServers",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FtpServers"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get list of ftp server",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FtpServer"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create ftp server",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/ftpservers/host/{host}/port/{port}/service/{service}": {
      "delete": {
        "operationId": "deleteFtpServer",
        "parameters": [
          {
            "description": "Host",
            "in": "path",
            "name": "host",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Port",
            "in": "path",
            "name": "port",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Service",
            "in": "path",
            "name": "service",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete configuration key",
        "tags": [
          "Configuration"
        ]
      },
      "get": {
        "operationId": "getFtpServer",
        "parameters": [
          {
            "description": "Host",
            "in": "path",
            "name": "host",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Port",
            "in": "path",
            "name": "port",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Service",
            "in": "path",
            "name": "service",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FtpServer"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get details of ftp server",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateFtpServer",
        "parameters": [
          {
            "description": "Host",
            "in": "path",
            "name": "host",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Port",
            "in": "path",
            "name": "port",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Service",
            "in": "path",
            "name": "service",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FtpServer"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update configuration key",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/keys": {
      "get": {
        "operationId": "getConfigurationKeys",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ConfigurationKeys"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get list of configuration key",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ConfigurationKey"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create configuration key",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/keys/category/{category}/key/{key}": {
      "delete": {
        "operationId": "deleteConfigurationKey",
        "parameters": [
          {
            "description": "Configuration category",
            "in": "path",
            "name": "category",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Configuration key",
            "in": "path",
            "name": "key",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete configuration key",
        "tags": [
          "Configuration"
        ]
      },
      "get": {
        "operationId": "getConfigurationKey",
        "parameters": [
          {
            "description": "Configuration category",
            "in": "path",
            "name": "category",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Configuration key",
            "in": "path",
            "name": "key",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ConfigurationKey"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get details of configuration key",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateConfigurationKey",
        "parameters": [
          {
            "description": "Configuration category",
            "in": "path",
            "name": "category",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Configuration key",
            "in": "path",
            "name": "key",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ConfigurationKeyBase"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update configuration key",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/paymenttypes": {
      "get": {
        "operationId": "getPaymentTypes",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentTypes"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get list of payment type",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentType"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create payment type",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/paymenttypes/{paymentTypeCode}": {
      "delete": {
        "operationId": "deletePaymentType",
        "parameters": [
          {
            "description": "Payment type code",
            "in": "path",
            "name": "paymentTypeCode",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete payment type",
        "tags": [
          "Configuration"
        ]
      },
      "get": {
        "operationId": "getPaymentType",
        "parameters": [
          {
            "description": "Payment type code",
            "in": "path",
            "name": "paymentTypeCode",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentType"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get details of payment type",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updatePaymentType",
        "parameters": [
          {
            "description": "Payment type code",
            "in": "path",
            "name": "paymentTypeCode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentType"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update payment type",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/pdds": {
      "get": {
        "operationId": "getPdds",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Pdds"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get list of pdd",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Pdd"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create pdd",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/pdds/{id_pdd}": {
      "delete": {
        "operationId": "deletePdd",
        "parameters": [
          {
            "description": "Configuration identifier",
            "in": "path",
            "name": "id_pdd",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete pdd",
        "tags": [
          "Configuration"
        ]
      },
      "get": {
        "operationId": "getPdd",
        "parameters": [
          {
            "description": "Configuration identifier",
            "in": "path",
            "name": "id_pdd",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Pdd"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get details of a pdd",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updatePdd",
        "parameters": [
          {
            "description": "Configuration identifier",
            "in": "path",
            "name": "id_pdd",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PddBase"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update pdd",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/wfespplugins": {
      "get": {
        "operationId": "getWfespPlugins",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WfespPluginConfs"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get list of WFESP Plugin configuration",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WfespPluginConf"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create configuration key",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/configuration/wfespplugins/{idServPlugin}": {
      "delete": {
        "operationId": "deleteWfespPlugin",
        "parameters": [
          {
            "description": "idServPlugin",
            "in": "path",
            "name": "idServPlugin",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete configuration key",
        "tags": [
          "Configuration"
        ]
      },
      "get": {
        "operationId": "getWfespPlugin",
        "parameters": [
          {
            "description": "idServPlugin",
            "in": "path",
            "name": "idServPlugin",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WfespPluginConf"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get details of a Wfesp plugin",
        "tags": [
          "Configuration"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateWfespPlugin",
        "parameters": [
          {
            "description": "idServPlugin",
            "in": "path",
            "name": "idServPlugin",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WfespPluginConfBase"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update Wfesp plugin configuration",
        "tags": [
          "Configuration"
        ]
      }
    },
    "/counterparttables": {
      "get": {
        "operationId": "getCounterpartTables",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "filter by Id of counterpart table",
            "in": "query",
            "name": "idcounterparttable",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "filter by Creditor Institution",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CounterpartTables"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get the counterparties table",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "createCounterpartTable",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "The file to upload"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Upload a XML file containing the details of a Counterpart table",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/counterparttables/{idcounterparttable}": {
      "delete": {
        "operationId": "deleteCounterpartTable",
        "parameters": [
          {
            "description": "ID of a counterpart table",
            "in": "path",
            "name": "idcounterparttable",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "description": "Creditor institution code",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a Counterpart table XML file ",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "get": {
        "operationId": "getCounterpartTable",
        "parameters": [
          {
            "description": "Id counterpart table",
            "in": "path",
            "name": "idcounterparttable",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Creditor institution code",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              },
              "application/xml": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Download a XML file containing the details of a counterpart table",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/creditorinstitutions": {
      "get": {
        "operationId": "getCreditorInstitutions",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Filter by code",
            "in": "query",
            "name": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Filter by name",
            "in": "query",
            "name": "name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Order by code or name",
            "in": "query",
            "name": "orderby",
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
            "description": "Direction of ordering",
            "in": "query",
            "name": "ordering",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutions"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of creditor institutions",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionDetails"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create creditor institution",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}": {
      "delete": {
        "operationId": "deleteCreditorInstitution",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete creditor institution",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "get": {
        "operationId": "getCreditorInstitution",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get creditor institution details",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateCreditorInstitution",
        "parameters": [
          {
            "description": "The fiscal code of the Organization to update",
            "in": "path",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreditorInstitutionDetails"
              }
            }
          },
          "description": "The values to update of the organization",
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update creditor institution",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/encodings": {
      "get": {
        "operationId": "getCreditorInstitutionEncodings",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionEncodings"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get creditor institution encodings",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "createCreditorInstitutionEncoding",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Encoding"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create a creditor institution encoding",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/encodings/{encodingcode}": {
      "delete": {
        "operationId": "deleteCreditorInstitutionEncoding",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "description": "Code of the Encoding",
            "in": "path",
            "name": "encodingcode",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a creditor institution encoding",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/creditorinstitutions/{creditorinstitutioncode}/ibans": {
      "get": {
        "operationId": "getCreditorInstitutionsIbans",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Ibans"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get creditor institution ibans",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/creditorinstitutions/{creditorinstitutioncode}/stations": {
      "get": {
        "operationId": "getCreditorInstitutionStations",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionStationList"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get station details and relation info with creditor institution",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "createCreditorInstitutionStation",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionStationEdit"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create station details and relation info with creditor institution",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/stations/{stationcode}": {
      "delete": {
        "operationId": "deleteCreditorInstitutionStation",
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          },
          {
            "description": "station code.",
            "in": "path",
            "name": "stationcode",
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
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a relation between creditor institution and station",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateCreditorInstitutionStation",
        "parameters": [
          {
            "description": "The fiscal code of the Organization to update",
            "in": "path",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 1,
              "type": "string"
            }
          },
          {
            "description": "station code.",
            "in": "path",
            "name": "stationcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionStationEdit"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a relation between creditor institution and station",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/ibans/{iban}": {
      "get": {
        "operationId": "getCreditorInstitutionsByIban",
        "parameters": [
          {
            "description": "Iban to find",
            "in": "path",
            "name": "iban",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionList"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get list of creditor institutions having IBAN",
        "tags": [
          "Utilities"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/icas": {
      "get": {
        "operationId": "getIcas",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "filter by Id ICA",
            "in": "query",
            "name": "idica",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "filter by Creditor Institution",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Icas"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get the list of ICAs",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "createIca",
        "parameters": [
          {
            "description": "Force upload ignoring the validity date",
            "in": "query",
            "name": "force",
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
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "XML file regarding ICA to create"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Upload a XML file containing the details of an ICA",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/icas/check": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "verifyIca",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "XML file regarding ICA to check"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/CheckItem"
                  }
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Validate XML file containing the details of an ICA",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/icas/check/massive": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "massiveVerifyIcas",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "Zip file containing ICA XMLs to check"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/MassiveCheck"
                  }
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Massive validation of XML files containing the details of an ICA",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/icas/massive": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "massiveCreateIcas",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "Zip file containing ICAs to create"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Upload a zip file containing the details of multiple ICAs",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/icas/xsd": {
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "checkXSD",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary",
                    "description": "XML file regarding ICA to check"
                  }
                },
                "required": [
                  "file"
                ]
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XSDValidation"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Validate XML against XSD",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/icas/{idica}": {
      "delete": {
        "operationId": "deleteIca",
        "parameters": [
          {
            "description": "Id ICA",
            "in": "path",
            "name": "idica",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Creditor institution code",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete an ICA XML file",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "get": {
        "operationId": "getIca",
        "parameters": [
          {
            "description": "Id ICA",
            "in": "path",
            "name": "idica",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Creditor institution code",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/xml": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Download a XML file containing the details of an ICA",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/info": {
      "get": {
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AppInfo"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Return OK if application is started",
        "tags": [
          "Home"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/paymentserviceproviders": {
      "get": {
        "operationId": "getPaymentServiceProviders",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Filter by code",
            "in": "query",
            "name": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Filter by name",
            "in": "query",
            "name": "name",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Order by code or name",
            "in": "query",
            "name": "orderby",
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
            "description": "Direction of ordering",
            "in": "query",
            "name": "ordering",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentServiceProviders"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of Payment Service Providers",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentServiceProviderDetails"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create a payment service provider",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/paymentserviceproviders/{pspcode}": {
      "delete": {
        "operationId": "deletePaymentServiceProvider",
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "name": "pspcode",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a payment service provider",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "get": {
        "operationId": "getPaymentServiceProvider",
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "name": "pspcode",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentServiceProviderDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get payment service provider details",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updatePaymentServiceProvider",
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "name": "pspcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentServiceProviderDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a payment service provider",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/paymentserviceproviders/{pspcode}/channels": {
      "get": {
        "operationId": "getPaymentServiceProvidersChannels",
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "name": "pspcode",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PspChannelList"
                }
              }
            },
            "description": "OK.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get channels details and relation info with PSP",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
        "operationId": "createPaymentServiceProvidersChannels",
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "name": "pspcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PspChannelCode"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create channel details and relation info with PSP",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/paymentserviceproviders/{pspcode}/channels/{channelcode}": {
      "delete": {
        "operationId": "deletePaymentServiceProvidersChannels",
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "name": "pspcode",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          },
          {
            "description": "Code of the channel",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {}
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a relation between a PSP and a channel",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updatePaymentServiceProvidersChannels",
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "name": "pspcode",
            "required": true,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          },
          {
            "description": "Channel code.",
            "in": "path",
            "name": "channelcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PspChannelPaymentTypes"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a relation between creditor institution and station",
        "tags": [
          "Payment Service Providers"
        ]
      }
    },
    "/services": {
      "get": {
        "operationId": "getServices",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "in": "query",
            "name": "pspcode",
            "required": false,
            "schema": {
              "pattern": "[A-Z0-9_]{6,14}",
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "brokerpspcode",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "channelcode",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "paymentmethodchannel",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int64"
            }
          },
          {
            "in": "query",
            "name": "paymenttypecode",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "pspflagftamp",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "in": "query",
            "name": "channelapp",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "in": "query",
            "name": "onus",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "in": "query",
            "name": "flagio",
            "required": false,
            "schema": {
              "type": "boolean"
            }
          },
          {
            "in": "query",
            "name": "flowid",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "minimumamount",
            "required": false,
            "schema": {
              "type": "number",
              "format": "double"
            }
          },
          {
            "in": "query",
            "name": "maximumamount",
            "required": false,
            "schema": {
              "type": "number",
              "format": "double"
            }
          },
          {
            "in": "query",
            "name": "languagecode",
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
            "in": "query",
            "name": "conventionCode",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Services"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of services",
        "tags": [
          "Payment Service Providers"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/stations": {
      "get": {
        "operationId": "getStations",
        "parameters": [
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "description": "Filter by broker",
            "in": "query",
            "name": "brokercode",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Filter by creditor institution",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Filter by code",
            "in": "query",
            "name": "code",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "description": "Direction of ordering. Results are ordered by code",
            "in": "query",
            "name": "ordering",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Stations"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get paginated list of stations",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "post": {
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/StationDetails"
                }
              }
            },
            "description": "Created",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "409": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Conflict",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Create a station",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/stations/csv": {
      "get": {
        "operationId": "getStationsCSV",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Download a CSV with all the stations in the system",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/stations/{stationcode}": {
      "delete": {
        "operationId": "deleteStation",
        "parameters": [
          {
            "description": "station code",
            "in": "path",
            "name": "stationcode",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Delete a station",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "get": {
        "operationId": "getStation",
        "parameters": [
          {
            "description": "station code.",
            "in": "path",
            "name": "stationcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/StationDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get station details",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ],
      "put": {
        "operationId": "updateStation",
        "parameters": [
          {
            "description": "station code",
            "in": "path",
            "name": "stationcode",
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
                "$ref": "#/components/schemas/StationDetails"
              }
            }
          },
          "description": "The values to update of the station",
          "required": true
        },
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/StationDetails"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Update a station",
        "tags": [
          "Creditor Institutions"
        ]
      }
    },
    "/stations/{stationcode}/creditorinstitutions": {
      "get": {
        "operationId": "getStationCreditorInstitutions",
        "parameters": [
          {
            "description": "station code.",
            "in": "path",
            "name": "stationcode",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "description": "Number of elements on one page. Default = 50",
            "in": "query",
            "name": "limit",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "description": "Page number. Page value starts from 0",
            "in": "query",
            "name": "page",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/StationCreditorInstitutions"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get station creditor institution list",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/stations/{stationcode}/creditorinstitutions/csv": {
      "get": {
        "operationId": "getStationCreditorInstitutionsCSV",
        "parameters": [
          {
            "description": "station code.",
            "in": "path",
            "name": "stationcode",
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
            "content": {
              "application/json": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Download a CSV with station creditor institution list",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/stations/{stationcode}/creditorinstitutions/{creditorinstitutioncode}": {
      "get": {
        "operationId": "getStationCreditorInstitutionRelation",
        "parameters": [
          {
            "description": "station code.",
            "in": "path",
            "name": "stationcode",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          },
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "name": "creditorinstitutioncode",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/StationCreditorInstitutions"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Not Found",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              },
              "X-Warning": {
                "description": "This header identifies response validation error",
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
          },
          {
            "Authorization": []
          }
        ],
        "summary": "Get station creditor institution relation",
        "tags": [
          "Creditor Institutions"
        ]
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
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
        "required": [
          "environment",
          "name",
          "version"
        ],
        "type": "object",
        "properties": {
          "dbConnection": {
            "type": "string"
          },
          "environment": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string"
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
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "enabled": {
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
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "enabled": {
            "type": "boolean"
          },
          "extended_fault_bean": {
            "type": "boolean"
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
      "Cdi": {
        "required": [
          "business_name",
          "id_cdi",
          "psp_code"
        ],
        "type": "object",
        "properties": {
          "business_name": {
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
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
          "publication_date": {
            "type": "string",
            "format": "date-time",
            "example": "2021-10-08T14:55:16.302Z"
          },
          "validity_date": {
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
      "Channel": {
        "required": [
          "channel_code",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "channel_code": {
            "type": "string",
            "example": "223344556677889900"
          },
          "enabled": {
            "type": "boolean"
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
          "on_us",
          "payment_model",
          "port",
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
          "agid": {
            "type": "boolean"
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "broker_psp_code": {
            "type": "string"
          },
          "card_chart": {
            "type": "boolean"
          },
          "channel_code": {
            "type": "string",
            "example": "223344556677889900"
          },
          "digital_stamp_brand": {
            "type": "boolean"
          },
          "enabled": {
            "type": "boolean"
          },
          "flag_io": {
            "type": "boolean"
          },
          "ip": {
            "type": "string"
          },
          "new_fault_code": {
            "type": "boolean"
          },
          "new_password": {
            "type": "string"
          },
          "npm_service": {
            "type": "string"
          },
          "on_us": {
            "type": "boolean"
          },
          "password": {
            "type": "string"
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
          "proxy_enabled": {
            "type": "boolean"
          },
          "proxy_host": {
            "type": "string"
          },
          "proxy_password": {
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
          "recovery": {
            "type": "boolean"
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
          "redirect_protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "redirect_query_string": {
            "type": "string"
          },
          "rt_push": {
            "type": "boolean"
          },
          "serv_plugin": {
            "type": "string"
          },
          "service": {
            "type": "string"
          },
          "target_host": {
            "type": "string"
          },
          "target_path": {
            "type": "string"
          },
          "target_port": {
            "type": "integer",
            "format": "int64"
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
          }
        }
      },
      "ChannelPsp": {
        "required": [
          "business_name",
          "enabled",
          "payment_types",
          "psp_code"
        ],
        "type": "object",
        "properties": {
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
          "psp_code": {
            "type": "string"
          }
        }
      },
      "ChannelPspList": {
        "required": [
          "payment_service_providers"
        ],
        "type": "object",
        "properties": {
          "payment_service_providers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ChannelPsp"
            }
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
      "CheckItem": {
        "type": "object",
        "properties": {
          "action": {
            "type": "string"
          },
          "note": {
            "type": "string"
          },
          "title": {
            "type": "string"
          },
          "valid": {
            "type": "string",
            "enum": [
              "VALID",
              "NOT_VALID"
            ]
          },
          "value": {
            "type": "string"
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
          "config_category": {
            "type": "string",
            "example": "GLOBAL"
          },
          "config_description": {
            "type": "string",
            "example": " default millisecondi validità token"
          },
          "config_key": {
            "type": "string",
            "example": "default_token_duration_validity_millis"
          },
          "config_value": {
            "type": "string",
            "example": "180000"
          }
        }
      },
      "ConfigurationKeyBase": {
        "required": [
          "config_value"
        ],
        "type": "object",
        "properties": {
          "config_description": {
            "type": "string",
            "example": " default millisecondi validità token"
          },
          "config_value": {
            "type": "string",
            "example": "180000"
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
          "business_name": {
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "creditor_institution_code": {
            "type": "string",
            "example": "1234567890100"
          },
          "id_counterpart_table": {
            "type": "string",
            "example": "123456789"
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
      "CreditorInstitution": {
        "required": [
          "business_name",
          "creditor_institution_code",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
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
          }
        }
      },
      "CreditorInstitutionAddress": {
        "type": "object",
        "properties": {
          "city": {
            "type": "string",
            "example": "Lorem"
          },
          "country_code": {
            "pattern": "^\\w{2}$|^$",
            "type": "string",
            "example": "RM"
          },
          "location": {
            "type": "string",
            "example": "Via delle vie 3"
          },
          "tax_domicile": {
            "type": "string"
          },
          "zip_code": {
            "pattern": "^\\d{5}$|^$",
            "type": "string",
            "example": "00187"
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
          "address": {
            "$ref": "#/components/schemas/CreditorInstitutionAddress"
          },
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
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
      "CreditorInstitutionStation": {
        "required": [
          "enabled",
          "station_code",
          "version"
        ],
        "type": "object",
        "properties": {
          "application_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "broadcast": {
            "type": "boolean"
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "mod4": {
            "type": "boolean"
          },
          "segregation_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "version": {
            "maximum": 2,
            "minimum": 1,
            "type": "integer",
            "description": "number version",
            "format": "int64"
          }
        }
      },
      "CreditorInstitutionStationEdit": {
        "required": [
          "station_code"
        ],
        "type": "object",
        "properties": {
          "application_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "broadcast": {
            "type": "boolean"
          },
          "mod4": {
            "type": "boolean"
          },
          "segregation_code": {
            "minimum": 0,
            "type": "integer",
            "format": "int64"
          },
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
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
          "enabled": {
            "type": "boolean",
            "default": true
          },
          "history_path": {
            "type": "string",
            "example": "/out/history/service"
          },
          "host": {
            "type": "string",
            "example": "host.domain"
          },
          "in_path": {
            "type": "string",
            "example": "/in/service"
          },
          "out_path": {
            "type": "string",
            "example": "/out/service"
          },
          "password": {
            "type": "string",
            "example": "pwdpwdpwd"
          },
          "port": {
            "type": "integer",
            "format": "int32",
            "example": 1234
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
          "username": {
            "type": "string",
            "example": "username"
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
      "Iban": {
        "required": [
          "iban",
          "publication_date",
          "validity_date"
        ],
        "type": "object",
        "properties": {
          "iban": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "IT99C0222211111000000000000"
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
          "business_name": {
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "creditor_institution_code": {
            "type": "string",
            "example": "1234567890100"
          },
          "id_ica": {
            "type": "string",
            "example": "123456789"
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
      "MassiveCheck": {
        "type": "object",
        "properties": {
          "checkItems": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CheckItem"
            }
          },
          "fileName": {
            "type": "string"
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
          "items_found": {
            "type": "integer",
            "description": "Number of items found. (The last page may have fewer elements than required)",
            "format": "int32"
          },
          "limit": {
            "type": "integer",
            "description": "Required number of items per page",
            "format": "int32"
          },
          "page": {
            "type": "integer",
            "description": "Page number",
            "format": "int32"
          },
          "total_pages": {
            "type": "integer",
            "description": "Total number of pages",
            "format": "int32"
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
          "business_name": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "psp_code": {
            "pattern": "[A-Z0-9_]{6,14}",
            "type": "string"
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
          "abi": {
            "type": "string"
          },
          "agid_psp": {
            "type": "boolean",
            "description": "True if the PSP is internal"
          },
          "bic": {
            "type": "string"
          },
          "business_name": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "my_bank_code": {
            "type": "string",
            "description": "MyBank code"
          },
          "psp_code": {
            "pattern": "[A-Z0-9_]{6,14}",
            "type": "string"
          },
          "stamp": {
            "type": "boolean"
          },
          "tax_code": {
            "type": "string"
          },
          "transfer": {
            "type": "boolean"
          },
          "vat_number": {
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
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          },
          "payment_service_providers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentServiceProvider"
            }
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
      "Pdd": {
        "required": [
          "description",
          "enabled",
          "id_pdd",
          "ip"
        ],
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "enabled": {
            "type": "boolean",
            "example": false
          },
          "id_pdd": {
            "type": "string",
            "example": "localhost"
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
      "PddBase": {
        "required": [
          "description",
          "enabled",
          "ip"
        ],
        "type": "object",
        "properties": {
          "description": {
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "enabled": {
            "type": "boolean",
            "example": false
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
      "ProblemJson": {
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "There was an error processing the request"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 200
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
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
          "channel_code": {
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
          }
        }
      },
      "PspChannelCode": {
        "required": [
          "channel_code",
          "payment_types"
        ],
        "type": "object",
        "properties": {
          "channel_code": {
            "type": "string"
          },
          "payment_types": {
            "type": "array",
            "items": {
              "type": "string"
            }
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
      "Service": {
        "type": "object",
        "properties": {
          "abi_code": {
            "maxLength": 5,
            "minLength": 0,
            "type": "string"
          },
          "broker_psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "cart_card": {
            "type": "boolean"
          },
          "channel_app": {
            "type": "boolean"
          },
          "channel_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "channel_url": {
            "type": "string"
          },
          "convention_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "fixed_cost": {
            "type": "number",
            "format": "double"
          },
          "flag_io": {
            "type": "boolean"
          },
          "flow_id": {
            "maxLength": 35,
            "minLength": 0,
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
          "logo_psp": {
            "type": "string",
            "format": "byte"
          },
          "logo_service": {
            "type": "string",
            "format": "byte"
          },
          "maximum_amount": {
            "type": "number",
            "format": "double"
          },
          "minimum_amount": {
            "type": "number",
            "format": "double"
          },
          "mybank_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "on_us": {
            "type": "boolean"
          },
          "payment_method_channel": {
            "type": "integer",
            "format": "int64"
          },
          "payment_type_code": {
            "type": "string"
          },
          "psp_business_name": {
            "type": "string"
          },
          "psp_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "psp_flag_stamp": {
            "type": "boolean"
          },
          "service_availability": {
            "maxLength": 511,
            "minLength": 0,
            "type": "string"
          },
          "service_description": {
            "maxLength": 511,
            "minLength": 0,
            "type": "string"
          },
          "service_name": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string"
          },
          "tags": {
            "maxLength": 135,
            "minLength": 0,
            "type": "string"
          },
          "timestamp_insertion": {
            "type": "string",
            "format": "date-time"
          },
          "validity_date": {
            "type": "string",
            "format": "date-time"
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
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          },
          "services": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Service"
            }
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
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "version": {
            "maximum": 2,
            "minimum": 1,
            "type": "integer",
            "description": "number version",
            "format": "int64"
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
          "application_code": {
            "type": "integer",
            "format": "int64"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "broadcast": {
            "type": "boolean"
          },
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
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
          "mod4": {
            "type": "boolean"
          },
          "segregation_code": {
            "type": "integer",
            "format": "int64"
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
      "StationDetails": {
        "required": [
          "broker_code",
          "enabled",
          "port",
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
          "broker_code": {
            "type": "string"
          },
          "broker_description": {
            "type": "string",
            "description": "Broker description. Read only field",
            "example": "Lorem ipsum dolor sit amet"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "flag_online": {
            "type": "boolean"
          },
          "invio_rt_istantaneo": {
            "type": "boolean"
          },
          "ip": {
            "type": "string"
          },
          "ip_4mod": {
            "type": "string"
          },
          "new_password": {
            "type": "string"
          },
          "password": {
            "type": "string"
          },
          "pof_service": {
            "type": "string"
          },
          "port": {
            "maximum": 65535,
            "minimum": 1,
            "type": "integer",
            "format": "int64"
          },
          "port_4mod": {
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
          "protocol_4mod": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "proxy_enabled": {
            "type": "boolean"
          },
          "proxy_host": {
            "type": "string"
          },
          "proxy_password": {
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
          "redirect_protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "redirect_query_string": {
            "type": "string"
          },
          "service": {
            "type": "string"
          },
          "service_4mod": {
            "type": "string"
          },
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "target_host": {
            "type": "string"
          },
          "target_path": {
            "type": "string"
          },
          "target_port": {
            "type": "integer",
            "format": "int64"
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
          "version": {
            "maximum": 2,
            "minimum": 1,
            "type": "integer",
            "description": "number version",
            "format": "int64"
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
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          },
          "stations": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Station"
            }
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
          },
          "pag_const_string_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "pag_rpt_xpath_profile": {
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
          }
        }
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
          "id_bean": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "defaultForwardProcessor"
          },
          "pag_const_string_profile": {
            "maxLength": 150,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "pag_rpt_xpath_profile": {
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
      "XSDValidation": {
        "required": [
          "detail",
          "xsdCompliant",
          "xsdSchema"
        ],
        "type": "object",
        "properties": {
          "detail": {
            "type": "string",
            "example": "Invalid content was found starting with element 'idBancaSeller'. One of '{ibanAccredito}' is expected. Error at lineNumber: 10"
          },
          "xsdCompliant": {
            "type": "boolean",
            "example": false
          },
          "xsdSchema": {
            "type": "string",
            "example": "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"
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
