{
  "openapi" : "3.0.3",
  "info" : {
    "title" : "Node technical support - API (local) ${service}",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "1.0.2-1-NOD-357-deploy"
  },
  "servers" : [ {
    "url" : "${host}/technical-support/nodo/api/v1"
  } ],
  "tags" : [ {
    "name" : "Info",
    "description" : "Info operations"
  } ],
  "paths" : {
    "/info" : {
      "get" : {
        "tags" : [ "Info" ],
        "summary" : "Get info of Node tech support API",
        "responses" : {
          "200" : {
            "description" : "Success",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/InfoResponse"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{organizationFiscalCode}/iuv/{iuv}" : {
      "get" : {
        "tags" : [ "Worker Resource" ],
        "parameters" : [ {
          "name" : "iuv",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "organizationFiscalCode",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/TransactionResponse"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{organizationFiscalCode}/iuv/{iuv}/ccp/{ccp}" : {
      "get" : {
        "tags" : [ "Worker Resource" ],
        "parameters" : [ {
          "name" : "ccp",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "iuv",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "organizationFiscalCode",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/TransactionResponse"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{organizationFiscalCode}/noticeNumber/{noticeNumber}" : {
      "get" : {
        "tags" : [ "Worker Resource" ],
        "parameters" : [ {
          "name" : "noticeNumber",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "organizationFiscalCode",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/TransactionResponse"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{organizationFiscalCode}/noticeNumber/{noticeNumber}/paymentToken/{paymentToken}" : {
      "get" : {
        "tags" : [ "Worker Resource" ],
        "parameters" : [ {
          "name" : "noticeNumber",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "organizationFiscalCode",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "paymentToken",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/TransactionResponse"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    }
  },
  "components" : {
    "schemas" : {
      "BasePaymentInfo" : {
        "type" : "object",
        "properties" : {
          "organizationFiscalCode" : {
            "type" : "string"
          },
          "noticeNumber" : {
            "type" : "string"
          },
          "iuv" : {
            "type" : "string"
          },
          "pspId" : {
            "type" : "string"
          },
          "brokerPspId" : {
            "type" : "string"
          },
          "channelId" : {
            "type" : "string"
          },
          "outcome" : {
            "type" : "string"
          },
          "status" : {
            "type" : "string"
          },
          "insertedTimestamp" : {
            "type" : "string"
          },
          "updatedTimestamp" : {
            "type" : "string"
          },
          "isOldPaymentModel" : {
            "type" : "boolean"
          },
          "serviceIdentifier" : {
            "type" : "string"
          },
          "positiveBizEvtId" : {
            "type" : "string"
          },
          "negativeBizEvtId" : {
            "type" : "string"
          }
        }
      },
      "ErrorCode" : {
        "type" : "object",
        "properties" : {
          "code" : {
            "type" : "string",
            "example" : "0500"
          },
          "description" : {
            "type" : "string",
            "example" : "An unexpected error has occurred. Please contact support."
          },
          "statusCode" : {
            "format" : "int32",
            "type" : "integer",
            "example" : 500
          }
        }
      },
      "InfoResponse" : {
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string",
            "example" : "pagopa-node-tech-support"
          },
          "version" : {
            "type" : "string",
            "example" : "1.2.3"
          },
          "environment" : {
            "type" : "string",
            "example" : "dev"
          },
          "description" : {
            "type" : "string",
            "example" : "Node tech support API"
          },
          "errorCodes" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/ErrorCode"
            }
          }
        }
      },
      "LocalDate" : {
        "format" : "date",
        "type" : "string",
        "example" : "2022-03-10"
      },
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable",
            "type" : "string"
          },
          "status" : {
            "format" : "int32",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "example" : 200
          },
          "details" : {
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "type" : "string",
            "example" : "There was an error processing the request"
          }
        }
      },
      "TransactionResponse" : {
        "type" : "object",
        "properties" : {
          "dateFrom" : {
            "$ref" : "#/components/schemas/LocalDate"
          },
          "dateTo" : {
            "$ref" : "#/components/schemas/LocalDate"
          },
          "data" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/BasePaymentInfo"
            }
          }
        }
      }
    },
    "securitySchemes" : {
      "SecurityScheme" : {
        "type" : "http",
        "description" : "Authentication",
        "scheme" : "basic"
      }
    }
  }
}
