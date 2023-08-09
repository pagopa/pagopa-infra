{
  "openapi" : "3.0.3",
  "info" : {
    "title" : "Fdr technical support - Api (local) ${service}",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.0.1"
  },
  "servers" : [ {
    "url" : "${host}/tenchinal-support/api/v1 - APIM"
  } ],
  "tags" : [ {
    "name" : "Info",
    "description" : "Info operations"
  } ],
  "paths" : {
    "/info" : {
      "get" : {
        "tags" : [ "Info" ],
        "summary" : "Get info of FDR",
        "responses" : {
          "default" : {
            "$ref" : "#/components/responses/InternalServerError"
          },
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
    "/organizations/{organizationId}/flows/{flowName}" : {
      "get" : {
        "tags" : [ "Org Resource" ],
        "parameters" : [ {
          "name" : "flowName",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "organizationId",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "required" : true,
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "required" : true,
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
                  "$ref" : "#/components/schemas/FrResponse"
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
          "404" : {
            "description" : "Not Found",
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
    "/organizations/{organizationId}/flows/{flowName}/psps/{psp}/revisions/{revision}" : {
      "get" : {
        "tags" : [ "Org Resource" ],
        "parameters" : [ {
          "name" : "flowName",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "organizationId",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "psp",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "revision",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "required" : true,
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "required" : true,
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
                  "$ref" : "#/components/schemas/FrResponse"
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
          "404" : {
            "description" : "Not Found",
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
    "/psps/{pspId}" : {
      "get" : {
        "tags" : [ "Psp Resource" ],
        "parameters" : [ {
          "name" : "pspId",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "required" : true,
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "required" : true,
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "flowName",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "organizationId",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/FrResponse"
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
    "/psps/{pspId}/flows/{flowName}" : {
      "get" : {
        "tags" : [ "Psp Resource" ],
        "parameters" : [ {
          "name" : "flowName",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "pspId",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "dateFrom",
          "in" : "query",
          "required" : true,
          "schema" : {
            "$ref" : "#/components/schemas/LocalDate"
          }
        }, {
          "name" : "dateTo",
          "in" : "query",
          "required" : true,
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
                  "$ref" : "#/components/schemas/FrResponse"
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
      "ErrorCode" : {
        "type" : "object",
        "properties" : {
          "code" : {
            "type" : "string",
            "example" : "FDR-0500"
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
      "FdrBaseInfo" : {
        "type" : "object",
        "properties" : {
          "flowName" : {
            "type" : "string"
          },
          "created" : {
            "type" : "string"
          },
          "organizationId" : {
            "type" : "string"
          }
        }
      },
      "FrResponse" : {
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
              "$ref" : "#/components/schemas/FdrBaseInfo"
            }
          }
        }
      },
      "InfoResponse" : {
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string",
            "example" : "pagopa-fdr"
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
            "example" : "FDR - Flussi di rendicontazione"
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
