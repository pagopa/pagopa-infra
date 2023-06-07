{
  "openapi": "3.0.3",
  "info": {
    "title": "FDR - Flussi di Rendicontazione",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "1.0.0-SNAPSHOT"
  },
  "servers": [
    {
      "url": "${host}/fdr/api/v1 - APIM"
    }
  ],
  "tags": [
    {
      "name": "Info",
      "description": "Info operations"
    },
    {
      "name": "Organizations",
      "description": "Get reporting flow operations"
    },
    {
      "name": "PSP",
      "description": "Psp operations"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Info"
        ],
        "summary": "Get info of FDR",
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoResponse"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{ec}/flows": {
      "get": {
        "tags": [
          "Organizations"
        ],
        "summary": "Get all published reporting flow",
        "description": "Get all published reporting flow by ec and idPsp(optional param)",
        "parameters": [
          {
            "name": "ec",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "idPsp",
            "in": "query",
            "schema": {
              "pattern": "^\\w{1,35}$",
              "type": "string"
            }
          },
          {
            "name": "page",
            "in": "query",
            "schema": {
              "format": "int64",
              "default": 1,
              "minimum": 1,
              "type": "integer"
            }
          },
          {
            "name": "size",
            "in": "query",
            "schema": {
              "format": "int64",
              "default": 50,
              "minimum": 1,
              "type": "integer"
            }
          }
        ],
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GetAllResponse"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{ec}/flows/{fdr}": {
      "get": {
        "tags": [
          "Organizations"
        ],
        "summary": "Get reporting flow",
        "description": "Get reporting flow by id but not payments",
        "parameters": [
          {
            "name": "ec",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "fdr",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GetIdResponse"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{ec}/flows/{fdr}/payments": {
      "get": {
        "tags": [
          "Organizations"
        ],
        "summary": "Get payments of reporting flow",
        "description": "Get only payments of reporting flow by id paginated",
        "parameters": [
          {
            "name": "ec",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "fdr",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "page",
            "in": "query",
            "schema": {
              "format": "int64",
              "default": 1,
              "minimum": 1,
              "type": "integer"
            }
          },
          {
            "name": "size",
            "in": "query",
            "schema": {
              "format": "int64",
              "default": 50,
              "minimum": 1,
              "type": "integer"
            }
          }
        ],
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GetPaymentResponse"
                }
              }
            }
          }
        }
      }
    },
    "/psps/{psps}/flows": {
      "post": {
        "tags": [
          "PSP"
        ],
        "summary": "Create reporting flow",
        "description": "Create new reporting flow",
        "parameters": [
          {
            "name": "psps",
            "in": "path",
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
                "$ref": "#/components/schemas/CreateFlowRequest"
              }
            }
          }
        },
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {}
              }
            }
          }
        }
      }
    },
    "/psps/{psps}/flows/{fdr}": {
      "delete": {
        "tags": [
          "PSP"
        ],
        "summary": "Delete reporting flow",
        "description": "Delete reporting flow",
        "parameters": [
          {
            "name": "fdr",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "psps",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {}
              }
            }
          }
        }
      }
    },
    "/psps/{psps}/flows/{fdr}/payments": {
      "put": {
        "tags": [
          "PSP"
        ],
        "summary": "Add payments to reporting flow",
        "description": "Add payments to reporting flow",
        "parameters": [
          {
            "name": "fdr",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "psps",
            "in": "path",
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
                "$ref": "#/components/schemas/AddPaymentRequest"
              }
            }
          }
        },
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {}
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "PSP"
        ],
        "summary": "Delete payments to reporting flow",
        "description": "Delete payments to reporting flow",
        "parameters": [
          {
            "name": "fdr",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "psps",
            "in": "path",
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
                "$ref": "#/components/schemas/DeletePaymentRequest"
              }
            }
          }
        },
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {}
              }
            }
          }
        }
      }
    },
    "/psps/{psps}/flows/{fdr}/publish": {
      "post": {
        "tags": [
          "PSP"
        ],
        "summary": "Publish reporting flow",
        "description": "Publish reporting flow",
        "parameters": [
          {
            "name": "fdr",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "psps",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "500": {
            "$ref": "#/components/responses/InternalServerError"
          },
          "400": {
            "$ref": "#/components/responses/AppException400"
          },
          "404": {
            "$ref": "#/components/responses/AppException404"
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {}
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "AddPaymentRequest": {
        "required": [
          "payments"
        ],
        "type": "object",
        "properties": {
          "payments": {
            "maxItems": 100,
            "minItems": 1,
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Payment"
            }
          }
        }
      },
      "CreateFlowRequest": {
        "required": [
          "reportingFlowName",
          "reportingFlowDate",
          "sender",
          "receiver",
          "regulation",
          "regulationDate"
        ],
        "type": "object",
        "properties": {
          "reportingFlowName": {
            "pattern": "^\\S+$",
            "type": "string",
            "example": "60000000001-1173"
          },
          "reportingFlowDate": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/Instant"
              }
            ],
            "example": "2023-04-05T09:21:37.810000Z"
          },
          "sender": {
            "$ref": "#/components/schemas/Sender"
          },
          "receiver": {
            "$ref": "#/components/schemas/Receiver"
          },
          "regulation": {
            "type": "string",
            "example": "SEPA - Bonifico xzy"
          },
          "regulationDate": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/Instant"
              }
            ],
            "example": "2023-04-03T12:00:30.900000Z"
          },
          "bicCodePouringBank": {
            "pattern": "^(\\w{8}|\\w{11})$",
            "type": "string",
            "example": "UNCRITMMXXX"
          }
        }
      },
      "DeletePaymentRequest": {
        "required": [
          "indexPayments"
        ],
        "type": "object",
        "properties": {
          "indexPayments": {
            "maxItems": 100,
            "minItems": 1,
            "type": "array",
            "items": {
              "format": "int64",
              "type": "integer"
            }
          }
        }
      },
      "ErrorCode": {
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "example": "FDR-0500"
          },
          "description": {
            "type": "string",
            "example": "An unexpected error has occurred. Please contact support."
          },
          "statusCode": {
            "format": "int32",
            "type": "integer",
            "example": 500
          }
        }
      },
      "ErrorMessage": {
        "type": "object",
        "properties": {
          "path": {
            "type": "string",
            "example": "demo.test"
          },
          "message": {
            "type": "string",
            "example": "An unexpected error has occurred. Please contact support."
          }
        }
      },
      "ErrorResponse": {
        "type": "object",
        "properties": {
          "errorId": {
            "type": "string",
            "example": "50905466-1881-457b-b42f-fb7b2bfb1610"
          },
          "httpStatusCode": {
            "format": "int32",
            "type": "integer",
            "example": 500
          },
          "httpStatusDescription": {
            "type": "string",
            "example": "Internal Server Error"
          },
          "appErrorCode": {
            "type": "string",
            "example": "FDR-500"
          },
          "errors": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ErrorMessage"
            }
          }
        }
      },
      "GetAllResponse": {
        "type": "object",
        "properties": {
          "metadata": {
            "$ref": "#/components/schemas/Metadata"
          },
          "count": {
            "format": "int64",
            "type": "integer",
            "example": 100
          },
          "data": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "GetIdResponse": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/ReportingFlowStatusEnum"
              }
            ],
            "example": "643accaa4733f71aea4c71bf"
          },
          "revision": {
            "format": "int64",
            "type": "integer",
            "example": "2023-04-05T09:21:37.810000Z"
          },
          "created": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/Instant"
              }
            ],
            "example": "2023-04-03T12:00:30.900000Z"
          },
          "updated": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/Instant"
              }
            ],
            "example": "2023-04-03T12:00:30.900000Z"
          },
          "reportingFlowName": {
            "type": "string",
            "example": "60000000001-1173"
          },
          "reportingFlowDate": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/Instant"
              }
            ],
            "example": "2023-04-05T09:21:37.810000Z"
          },
          "regulation": {
            "type": "string",
            "example": "SEPA - Bonifico xzy"
          },
          "regulationDate": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/Instant"
              }
            ],
            "example": "2023-04-03T12:00:30.900000Z"
          },
          "bicCodePouringBank": {
            "type": "string",
            "example": "UNCRITMMXXX"
          },
          "sender": {
            "$ref": "#/components/schemas/Sender"
          },
          "receiver": {
            "$ref": "#/components/schemas/Receiver"
          },
          "totPayments": {
            "format": "int64",
            "type": "integer",
            "example": 100
          },
          "sumPaymnents": {
            "format": "double",
            "type": "number",
            "example": 100.9
          }
        }
      },
      "GetPaymentResponse": {
        "type": "object",
        "properties": {
          "metadata": {
            "$ref": "#/components/schemas/Metadata"
          },
          "count": {
            "format": "int64",
            "type": "integer",
            "example": 100
          },
          "data": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Payment"
            }
          }
        }
      },
      "InfoResponse": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "example": "pagopa-fdr"
          },
          "version": {
            "type": "string",
            "example": "1.2.3"
          },
          "environment": {
            "type": "string",
            "example": "dev"
          },
          "description": {
            "type": "string",
            "example": "FDR - Flussi di rendicontazione"
          },
          "errorCodes": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ErrorCode"
            }
          }
        }
      },
      "Instant": {
        "format": "date-time",
        "type": "string",
        "example": "2022-03-10T16:15:50Z"
      },
      "Metadata": {
        "type": "object",
        "properties": {
          "pageSize": {
            "format": "int32",
            "type": "integer",
            "example": 25
          },
          "pageNumber": {
            "format": "int32",
            "type": "integer",
            "example": 1
          },
          "totPage": {
            "format": "int32",
            "type": "integer",
            "example": 3
          }
        }
      },
      "Payment": {
        "required": [
          "iuv",
          "iur",
          "index",
          "pay",
          "payStatus",
          "payDate"
        ],
        "type": "object",
        "properties": {
          "iuv": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "abcdefg"
          },
          "iur": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "abcdefg"
          },
          "index": {
            "format": "int64",
            "type": "integer",
            "example": 1
          },
          "pay": {
            "format": "double",
            "minimum": 0,
            "exclusiveMinimum": true,
            "pattern": "^\\d{1,2147483647}([.]\\d{1,2})?$",
            "type": "number",
            "example": 0.01
          },
          "payStatus": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/PaymentStatusEnum"
              }
            ],
            "example": "PAGAMENTO_ESEGUITO"
          },
          "payDate": {
            "type": "string",
            "allOf": [
              {
                "$ref": "#/components/schemas/Instant"
              }
            ],
            "example": "2023-02-03T12:00:30.900000Z"
          }
        }
      },
      "PaymentStatusEnum": {
        "enum": [
          "EXECUTED",
          "REVOKED",
          "NO_RPT"
        ],
        "type": "string"
      },
      "Receiver": {
        "required": [
          "id",
          "ecId",
          "ecName"
        ],
        "type": "object",
        "properties": {
          "id": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "APPBIT2B"
          },
          "ecId": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "20000000001"
          },
          "ecName": {
            "type": "string",
            "example": "Comune di xyz"
          }
        }
      },
      "ReportingFlowStatusEnum": {
        "enum": [
          "CREATED",
          "INSERTED",
          "PUBLISHED"
        ],
        "type": "string"
      },
      "Sender": {
        "required": [
          "type",
          "id",
          "pspId",
          "pspName",
          "brokerId",
          "channelId"
        ],
        "type": "object",
        "properties": {
          "type": {
            "$ref": "#/components/schemas/SenderTypeEnum"
          },
          "id": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "SELBIT2B"
          },
          "pspId": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "60000000001"
          },
          "pspName": {
            "pattern": "^\\S+$",
            "type": "string",
            "example": "Bank"
          },
          "brokerId": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "70000000001"
          },
          "channelId": {
            "pattern": "^\\w+$",
            "type": "string",
            "example": "80000000001"
          },
          "password": {
            "pattern": "^\\S+$",
            "type": "string",
            "example": "1234567890",
            "deprecated": true
          }
        }
      },
      "SenderTypeEnum": {
        "enum": [
          "LEGAL_PERSON",
          "ABI_CODE",
          "BIC_CODE"
        ],
        "type": "string"
      }
    },
    "responses": {
      "AppException400": {
        "description": "Default app exception for status 400",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            },
            "example": {
              "httpStatusCode": 400,
              "httpStatusDescription": "Bad Request",
              "appErrorCode": "FDR-0702",
              "errors": [
                {
                  "message": "Reporting Flow id [<flow-id>] is invalid found"
                }
              ]
            }
          }
        }
      },
      "AppException404": {
        "description": "Default app exception for status 404",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            },
            "example": {
              "httpStatusCode": 404,
              "httpStatusDescription": "Not Found",
              "appErrorCode": "FDR-0701",
              "errors": [
                {
                  "message": "Reporting Flow id [<flow-id>] not found"
                }
              ]
            }
          }
        }
      },
      "InternalServerError": {
        "description": "Internal Server Error",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            },
            "example": {
              "errorId": "50905466-1881-457b-b42f-fb7b2bfb1610",
              "httpStatusCode": 500,
              "httpStatusDescription": "Internal Server Error",
              "appErrorCode": "FDR-0500",
              "errors": [
                {
                  "message": "An unexpected error has occurred. Please contact support."
                }
              ]
            }
          }
        }
      },
      "ValidationBadRequest": {
        "description": "Bad Request",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ErrorResponse"
            },
            "example": {
              "httpStatusCode": 400,
              "httpStatusDescription": "Bad Request",
              "appErrorCode": "FDR-0400",
              "errors": [
                {
                  "path": "<detail.path.if-exist>",
                  "message": "<detail.message>"
                }
              ]
            }
          }
        }
      }
    }
  }
}