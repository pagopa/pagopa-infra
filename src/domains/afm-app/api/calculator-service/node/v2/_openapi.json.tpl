{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "PagoPA API Calculator Logic ${service}",
    "description" : "Calculator Logic microservice for pagoPA AFM",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "2.10.19"
  },
  "servers" : [ {
    "url": "${host}",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "name" : "Calculator",
    "description" : "Everything about Calculator business logic"
  } ],
  "paths" : {
    "/psps/{idPsp}/fees" : {
      "post" : {
        "tags" : [ "Calculator" ],
        "summary" : "Get taxpayer fees of the specified idPSP with ECs contributions",
        "operationId" : "getFeesByPspMulti",
        "parameters" : [ {
          "name" : "idPsp",
          "in" : "path",
          "description" : "PSP identifier",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "maxOccurrences",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "name" : "allCcp",
          "in" : "query",
          "description" : "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "true"
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PaymentOptionByPspMulti"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "429" : {
            "description" : "Too many requests"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "200" : {
            "description" : "Ok",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/BundleOption"
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
          "422" : {
            "description" : "Unable to process the request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
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
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    },
    "/fees" : {
      "post" : {
        "tags" : [ "Calculator" ],
        "summary" : "Get taxpayer fees of all or specified idPSP with ECs contributions",
        "operationId" : "getFeesMulti",
        "parameters" : [ {
          "name" : "maxOccurrences",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "name" : "allCcp",
          "in" : "query",
          "description" : "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "true"
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PaymentOptionMulti"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "429" : {
            "description" : "Too many requests"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "200" : {
            "description" : "Ok",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/BundleOption"
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
          "422" : {
            "description" : "Unable to process the request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
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
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    },
    "/info" : {
      "get" : {
        "tags" : [ "Home" ],
        "summary" : "health check",
        "description" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
          "429" : {
            "description" : "Too many requests"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/AppInfo"
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
            "description" : "Service unavailable",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "PaymentNoticeItem" : {
        "required" : [ "paymentAmount", "primaryCreditorInstitution", "transferList" ],
        "type" : "object",
        "properties" : {
          "paymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "primaryCreditorInstitution" : {
            "type" : "string"
          },
          "transferList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferListItem"
            }
          }
        }
      },
      "PaymentOptionByPspMulti" : {
        "required" : [ "paymentNotice" ],
        "type" : "object",
        "properties" : {
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "bin" : {
            "type" : "string"
          },
          "paymentNotice" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentNoticeItem"
            }
          }
        }
      },
      "TransferListItem" : {
        "type" : "object",
        "properties" : {
          "creditorInstitution" : {
            "type" : "string"
          },
          "transferCategory" : {
            "type" : "string"
          },
          "digitalStamp" : {
            "type" : "boolean"
          }
        }
      },
      "BundleOption" : {
        "type" : "object",
        "properties" : {
          "belowThreshold" : {
            "type" : "boolean",
            "description" : "if true (the payment amount is lower than the threshold value) the bundles onus is not calculated (always false)"
          },
          "bundleOptions" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/Transfer"
            }
          }
        }
      },
      "Fee" : {
        "type" : "object",
        "properties" : {
          "creditorInstitution" : {
            "type" : "string"
          },
          "primaryCiIncurredFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "actualCiIncurredFee" : {
            "type" : "integer",
            "format" : "int64"
          }
        }
      },
      "Transfer" : {
        "required" : [ "fees" ],
        "type" : "object",
        "properties" : {
          "taxPayerFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "actualPayerFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "idBundle" : {
            "type" : "string"
          },
          "bundleName" : {
            "type" : "string"
          },
          "bundleDescription" : {
            "type" : "string"
          },
          "idsCiBundle" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          },
          "idPsp" : {
            "type" : "string"
          },
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          },
          "onUs" : {
            "type" : "boolean"
          },
          "abi" : {
            "type" : "string"
          },
          "pspBusinessName" : {
            "type" : "string"
          },
          "fees" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/Fee"
            }
          }
        }
      },
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          }
        }
      },
      "PaymentOptionMulti" : {
        "required" : [ "paymentNotice" ],
        "type" : "object",
        "properties" : {
          "bin" : {
            "type" : "string"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "idPspList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PspSearchCriteria"
            }
          },
          "paymentNotice" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentNoticeItem"
            }
          }
        }
      },
      "PspSearchCriteria" : {
        "required" : [ "idPsp" ],
        "type" : "object",
        "properties" : {
          "idPsp" : {
            "type" : "string"
          },
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          }
        }
      },
      "AppInfo" : {
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          },
          "environment" : {
            "type" : "string"
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "type" : "apiKey",
        "description" : "The API key to access this function app.",
        "name" : "Ocp-Apim-Subscription-Key",
        "in" : "header"
      }
    }
  }
}