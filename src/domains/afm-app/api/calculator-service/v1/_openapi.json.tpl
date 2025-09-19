{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "PagoPA API Calculator Logic - API AFM-Calculator v1",
    "description" : "Calculator Logic microservice for pagoPA AFM",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "2.11.25"
  },
  "servers" : [ {
    "url" : "http://localhost:8080"
  }, {
    "url" : "https://{host}{basePath}",
    "variables" : {
      "host" : {
        "default" : "api.dev.platform.pagopa.it",
        "enum" : [ "api.dev.platform.pagopa.it", "api.uat.platform.pagopa.it", "api.platform.pagopa.it" ]
      },
      "basePath" : {
        "default" : "afm/calculator-service",
        "enum" : [ "afm/calculator-service" ]
      }
    }
  } ],
  "tags" : [ {
    "name" : "Calculator",
    "description" : "Everything about Calculator business logic"
  }, {
    "name" : "Payment Methods",
    "description" : "Everything about the payment methods"
  }, {
    "name" : "Configuration",
    "description" : "Utility Services"
  } ],
  "paths" : {
    "/configuration/bundles/add" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "addValidBundles",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/ValidBundle"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        }
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/configuration/bundles/delete" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "deleteValidBundles",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/ValidBundle"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        }
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/configuration/paymenttypes/add" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "addPaymentTypes",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/PaymentType"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        }
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/configuration/paymenttypes/delete" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "deletePaymentTypes",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/PaymentType"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        }
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/configuration/touchpoint/add" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "addTouchpoints",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/Touchpoint"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        }
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/configuration/touchpoint/delete" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "deleteTouchpoints",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/Touchpoint"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        }
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/fees" : {
      "post" : {
        "tags" : [ "Calculator" ],
        "summary" : "Get taxpayer fees of all or specified idPSP",
        "operationId" : "getFees",
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
                "$ref" : "#/components/schemas/PaymentOption"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "Ok",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/info" : {
      "get" : {
        "tags" : [ "Home" ],
        "summary" : "health check",
        "description" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/payment-methods/search" : {
      "post" : {
        "tags" : [ "Payment Methods" ],
        "summary" : "Advanced search of payment methods",
        "operationId" : "searchPaymentMethods",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PaymentMethodRequest"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentMethodsResponse"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "422" : {
            "description" : "Unable to process the request",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/payment-methods/{paymentMethodId}" : {
      "get" : {
        "tags" : [ "Payment Methods" ],
        "summary" : "Find payment method by id",
        "operationId" : "getPaymentMethod",
        "parameters" : [ {
          "name" : "paymentMethodId",
          "in" : "path",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentMethod"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/psps/{idPsp}/fees" : {
      "post" : {
        "tags" : [ "Calculator" ],
        "summary" : "Get taxpayer fees of the specified idPSP",
        "operationId" : "getFeesByPsp",
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
                "$ref" : "#/components/schemas/PaymentOptionByPsp"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "Ok",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
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
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    }
  },
  "components" : {
    "schemas" : {
      "PaymentOptionByPsp" : {
        "type" : "object",
        "properties" : {
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          },
          "paymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "primaryCreditorInstitution" : {
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
          "transferList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferListItem"
            }
          }
        }
      },
      "TransferListItem" : {
        "required" : [ "creditorInstitution" ],
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
      "Transfer" : {
        "type" : "object",
        "properties" : {
          "taxPayerFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "primaryCiIncurredFee" : {
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
          "idCiBundle" : {
            "type" : "string"
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
          }
        }
      },
      "PaymentMethodRequest" : {
        "required" : [ "paymentNotice", "totalAmount", "userTouchpoint" ],
        "type" : "object",
        "properties" : {
          "userTouchpoint" : {
            "type" : "string",
            "enum" : [ "IO", "CHECKOUT", "CHECKOUT_CART" ]
          },
          "userDevice" : {
            "type" : "string",
            "enum" : [ "IOS", "ANDROID", "WEB", "SAFARI" ]
          },
          "totalAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "paymentNotice" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentNoticeItemOptionalTransferList"
            }
          },
          "allCCp" : {
            "type" : "boolean"
          },
          "targetKey" : {
            "type" : "string"
          }
        }
      },
      "PaymentNoticeItemOptionalTransferList" : {
        "required" : [ "paymentAmount", "primaryCreditorInstitution" ],
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
      "FeeRange" : {
        "required" : [ "max", "min" ],
        "type" : "object",
        "properties" : {
          "min" : {
            "type" : "integer",
            "format" : "int64"
          },
          "max" : {
            "type" : "integer",
            "format" : "int64"
          }
        }
      },
      "PaymentMethodsItem" : {
        "required" : [ "description", "group", "methodManagement", "name", "paymentMethodAsset", "paymentMethodId", "paymentMethodTypes", "status", "validityDateFrom" ],
        "type" : "object",
        "properties" : {
          "paymentMethodId" : {
            "type" : "string"
          },
          "name" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          },
          "description" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          },
          "status" : {
            "type" : "string",
            "enum" : [ "ENABLED", "DISABLED", "MAINTENANCE" ]
          },
          "validityDateFrom" : {
            "type" : "string",
            "format" : "date"
          },
          "group" : {
            "type" : "string",
            "enum" : [ "CP", "MYBK", "BPAY", "PPAL", "RPIC", "RBPS", "SATY", "APPL", "RICO", "RBPB", "RBPP", "RBPR", "GOOG", "KLRN" ]
          },
          "paymentMethodTypes" : {
            "type" : "array",
            "items" : {
              "type" : "string",
              "enum" : [ "CARTE", "CONTO", "APP" ]
            }
          },
          "feeRange" : {
            "$ref" : "#/components/schemas/FeeRange"
          },
          "paymentMethodAsset" : {
            "type" : "string"
          },
          "methodManagement" : {
            "type" : "string",
            "enum" : [ "ONBOARDABLE", "ONBOARDABLE_ONLY", "NOT_ONBOARDABLE", "REDIRECT" ]
          },
          "disabledReason" : {
            "type" : "string",
            "enum" : [ "AMOUNT_OUT_OF_BOUND", "MAINTENANCE_IN_PROGRESS", "METHOD_DISABLED", "NOT_YET_VALID", "TARGET_PREVIEW", "NO_BUNDLE_AVAILABLE" ]
          },
          "paymentMethodsBrandAssets" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          },
          "metadata" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          }
        }
      },
      "PaymentMethodsResponse" : {
        "required" : [ "paymentMethods" ],
        "type" : "object",
        "properties" : {
          "paymentMethods" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentMethodsItem"
            }
          }
        }
      },
      "PaymentOption" : {
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
          "transferList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferListItem"
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
      "Touchpoint" : {
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "creationDate" : {
            "type" : "string",
            "format" : "date-time"
          }
        }
      },
      "PaymentType" : {
        "required" : [ "id", "name" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "createdDate" : {
            "type" : "string",
            "format" : "date-time"
          }
        }
      },
      "CiBundle" : {
        "required" : [ "ciFiscalCode", "id" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "ciFiscalCode" : {
            "type" : "string"
          },
          "attributes" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/CiBundleAttribute"
            }
          }
        }
      },
      "CiBundleAttribute" : {
        "required" : [ "id" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "maxPaymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "transferCategory" : {
            "type" : "string"
          },
          "transferCategoryRelation" : {
            "type" : "string",
            "enum" : [ "EQUAL", "NOT_EQUAL" ]
          }
        }
      },
      "ValidBundle" : {
        "required" : [ "digitalStamp", "digitalStampRestriction" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "idPsp" : {
            "type" : "string"
          },
          "abi" : {
            "type" : "string"
          },
          "pspBusinessName" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "paymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "minPaymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "maxPaymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "paymentType" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "type" : {
            "type" : "string",
            "enum" : [ "GLOBAL", "PUBLIC", "PRIVATE" ]
          },
          "transferCategoryList" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          },
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          },
          "digitalStamp" : {
            "type" : "boolean"
          },
          "digitalStampRestriction" : {
            "type" : "boolean"
          },
          "onUs" : {
            "type" : "boolean"
          },
          "cart" : {
            "type" : "boolean"
          },
          "ciBundleList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/CiBundle"
            }
          }
        }
      },
      "PaymentMethod" : {
        "required" : [ "description", "group", "method_management", "name", "payment_method_asset", "payment_method_id", "payment_method_types", "range_amount", "status", "user_device", "user_touchpoint", "validity_date_from" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "group" : {
            "type" : "string",
            "enum" : [ "CP", "MYBK", "BPAY", "PPAL", "RPIC", "RBPS", "SATY", "APPL", "RICO", "RBPB", "RBPP", "RBPR", "GOOG", "KLRN" ]
          },
          "name" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          },
          "description" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          },
          "status" : {
            "type" : "string",
            "enum" : [ "ENABLED", "DISABLED", "MAINTENANCE" ]
          },
          "target" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          },
          "metadata" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          },
          "payment_method_id" : {
            "type" : "string"
          },
          "user_touchpoint" : {
            "type" : "array",
            "items" : {
              "type" : "string",
              "enum" : [ "IO", "CHECKOUT", "CHECKOUT_CART" ]
            }
          },
          "user_device" : {
            "type" : "array",
            "items" : {
              "type" : "string",
              "enum" : [ "IOS", "ANDROID", "WEB", "SAFARI" ]
            }
          },
          "payment_method_types" : {
            "type" : "array",
            "items" : {
              "type" : "string",
              "enum" : [ "CARTE", "CONTO", "APP" ]
            }
          },
          "validity_date_from" : {
            "type" : "string",
            "format" : "date"
          },
          "range_amount" : {
            "$ref" : "#/components/schemas/FeeRange"
          },
          "payment_method_asset" : {
            "type" : "string"
          },
          "method_management" : {
            "type" : "string",
            "enum" : [ "ONBOARDABLE", "ONBOARDABLE_ONLY", "NOT_ONBOARDABLE", "REDIRECT" ]
          },
          "payment_methods_brand_assets" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
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
