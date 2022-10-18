{
  "openapi": "3.0.1",
  "info": {
    "title": "Pagopa Circuit Mock",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/par/visa": {
      "post": {
        "summary": "get par of given Visa pan",
        "parameters": [
          {
            "in": "header",
            "name": "keyId",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "security": [
          {
            "basicAuth": []
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/VisaParRequestEnc"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/VisaParResponseEnc"
                }
              }
            }
          }
        }
      }
    },
    "/bin/visa": {
      "post": {
        "summary": "get paginated list of Visa bin ranges",
        "parameters": [
          {
            "in": "header",
            "name": "keyId",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "security": [
          {
            "basicAuth": []
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/VisaBinRangeRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/VisaBinRangeResponse"
                }
              }
            }
          },
          "300": {
            "description": "Requesting Client IP is invalid"
          },
          "400": {
            "description": "Bad request"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/VisaBinRangeResponse"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "basicAuth": {
        "type": "http",
        "scheme": "basic"
      }
    },
    "schemas": {
      "VisaParRequestEnc": {
        "type": "object",
        "properties": {
          "encData": {
            "type": "string"
          }
        },
        "required": [
          "encData"
        ]
      },
      "VisaParResponseEnc": {
        "type": "object",
        "properties": {
          "encData": {
            "type": "string"
          }
        },
        "required": [
          "encData"
        ]
      },
      "VisaBinRangeRequestHeader": {
        "type": "object",
        "properties": {
          "requestTS": {
            "type": "string",
            "format": "date-time"
          },
          "requestMessageID": {
            "type": "string"
          }
        },
        "required": [
          "requestTS",
          "requestMessageID"
        ]
      },
      "VisaBinRangeRequestData": {
        "type": "object",
        "properties": {
          "binRangeSearchIndex": {
            "type": "string",
            "format": "integer"
          },
          "binRangeCount": {
            "type": "string",
            "format": "integer"
          }
        },
        "required": [
          "binRangeSearchIndex",
          "binRangeCount"
        ]
      },
      "VisaBinRangeRequest": {
        "type": "object",
        "properties": {
          "requestHeader": {
            "$ref": "#/components/schemas/VisaBinRangeRequestHeader"
          },
          "requestData": {
            "$ref": "#/components/schemas/VisaBinRangeRequestData"
          }
        },
        "required": [
          "requestHeader",
          "requestData"
        ]
      },
      "VisaBinRangeResponseHeader": {
        "type": "object",
        "properties": {
          "responseMessageID": {
            "type": "string"
          }
        },
        "required": [
          "responseMessageID"
        ]
      },
      "VisaBinRangeResponseData": {
        "type": "object",
        "properties": {
          "binRangeMinNum": {
            "type": "string"
          },
          "binRangeMaxNum": {
            "type": "string"
          },
          "binRangePaymentAccountType": {
            "type": "string",
            "enum": [
              "P",
              "T"
            ],
            "description": "indicates whether a bin range is used for pans or tokens (always T for this mock)"
          },
          "productID": {
            "type": "string"
          },
          "productIDName": {
            "type": "string"
          },
          "accountFundingSourceCd": {
            "type": "string"
          },
          "platformCd": {
            "type": "string"
          },
          "accountRegionCode": {
            "type": "string"
          },
          "issuerBin": {
            "type": "string"
          },
          "issuerBillingCurrCd": {
            "type": "string"
          },
          "accountCtryAlpha2Code": {
            "type": "string"
          }
        },
        "required": [
          "binRangeMinNum",
          "binRangeMaxNum",
          "binRangePaymentAccountType",
          "productID",
          "productIDName",
          "accountFundingSourceCd",
          "platformCd",
          "accountRegionCode",
          "issuerBin",
          "issuerBillingCurrCd",
          "accountCtryAlpha2Code"
        ]
      },
      "VisaBinRangeResponseStatus": {
        "type": "object",
        "properties": {
          "statusCode": {
            "type": "string",
            "enum": [
              "CDI000",
              "CDI001",
              "CDI002",
              "CDI012",
              "CDI052",
              "CDI071",
              "CDI246",
              "CDI247",
              "CDI249",
              "CDI250"
            ],
            "description": "CDI000 is for 200 OK, other codes are for 500 Internal server error"
          },
          "statusDescription": {
            "type": "string"
          }
        },
        "required": [
          "statusCode",
          "statusDescription"
        ]
      },
      "VisaBinRangeResponse": {
        "type": "object",
        "properties": {
          "numRecordsReturned": {
            "type": "string",
            "format": "integer"
          },
          "areNextOffsetRecordsAvailable": {
            "type": "string",
            "enum": [
              "Y",
              "N"
            ]
          },
          "responseHeader": {
            "$ref": "#/components/schemas/VisaBinRangeResponseHeader"
          },
          "responseData": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/VisaBinRangeResponseData"
            }
          },
          "responseStatus": {
            "$ref": "#/components/schemas/VisaBinRangeResponseStatus"
          },
          "totalRecordsCount": {
            "type": "string",
            "format": "integer"
          }
        },
        "required": [
          "numRecordsReturned",
          "areNextOffsetRecordsAvailable",
          "responseHeader",
          "responseData",
          "responseStatus",
          "totalRecordsCount"
        ]
      }
    }
  }
}