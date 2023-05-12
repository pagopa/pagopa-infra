{
  "openapi" : "3.0.1",
  "info" : {
    "title": "API-Config Cacher ${service}",
    "description": "Generate cache for ${service} configuration",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.3.2"
  },
  "servers" : [ {
    "url" : "${host}",
    "description" : "Generated server url"
  } ],
  "paths" : {
    "/info" : {
      "get" : {
        "tags" : [ "Home" ],
        "summary" : "Return OK if application is started",
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
    "/stakeholders/fdr/cache/schemas/v1" : {
      "get" : {
        "tags" : [ "FdrCache" ],
        "summary" : "Get selected key of fdr v1 config",
        "operationId" : "cache_2",
        "parameters" : [ {
          "name" : "keys",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "array",
            "items" : {
              "type" : "string",
              "enum" : [ "creditorInstitutions", "creditorInstitutionBrokers", "stations", "creditorInstitutionStations", "encodings", "creditorInstitutionEncodings", "ibans", "creditorInstitutionInformations", "psps", "pspBrokers", "paymentTypes", "pspChannelPaymentTypes", "plugins", "pspInformationTemplates", "pspInformations", "channels", "cdsServices", "cdsSubjects", "cdsSubjectServices", "cdsCategories", "configurations", "ftpServers", "languages", "gdeConfigurations", "metadataDict" ]
            }
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
                  "$ref" : "#/components/schemas/ConfigDataV1"
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
    "/stakeholders/fdr/cache/schemas/v1/id" : {
      "get" : {
        "tags" : [ "FdrCache" ],
        "summary" : "Get last fdr v1 cache version",
        "operationId" : "idV1_1",
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
                  "$ref" : "#/components/schemas/CacheVersion"
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
          "404" : {
            "description" : "Not Found",
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
    "/stakeholders/node/cache/schemas/v1" : {
      "get" : {
        "tags" : [ "NodeCache" ],
        "summary" : "Get full node v1 config",
        "operationId" : "cache_1",
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
                  "$ref" : "#/components/schemas/ConfigDataV1"
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
    "/stakeholders/node/cache/schemas/v1/id" : {
      "get" : {
        "tags" : [ "NodeCache" ],
        "summary" : "Get last node v1 cache version",
        "operationId" : "idV1",
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
                  "$ref" : "#/components/schemas/CacheVersion"
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
          "404" : {
            "description" : "Not Found",
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
    "/stakeholders/verifier/cache/schemas/v1" : {
      "get" : {
        "tags" : [ "VerifierCache" ],
        "summary" : "Get Creditor Institution list with Station v2",
        "operationId" : "cache",
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
                  "type" : "string"
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
    }
  },
  "components" : {
    "schemas" : {
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
      "BrokerCreditorInstitution" : {
        "required" : [ "broker_code", "enabled", "extended_fault_bean" ],
        "type" : "object",
        "properties" : {
          "broker_code" : {
            "type" : "string"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "description" : {
            "type" : "string"
          },
          "extended_fault_bean" : {
            "type" : "boolean"
          }
        }
      },
      "BrokerPsp" : {
        "required" : [ "broker_psp_code", "enabled", "extended_fault_bean" ],
        "type" : "object",
        "properties" : {
          "broker_psp_code" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "extended_fault_bean" : {
            "type" : "boolean"
          }
        }
      },
      "CdsCategory" : {
        "required" : [ "description" ],
        "type" : "object",
        "properties" : {
          "description" : {
            "type" : "string"
          }
        }
      },
      "CdsService" : {
        "required" : [ "category", "description", "id", "reference_xsd", "version" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "reference_xsd" : {
            "type" : "string"
          },
          "version" : {
            "type" : "integer",
            "format" : "int64"
          },
          "category" : {
            "type" : "string"
          }
        }
      },
      "CdsSubject" : {
        "required" : [ "creditor_institution_code", "creditor_institution_description" ],
        "type" : "object",
        "properties" : {
          "creditor_institution_code" : {
            "type" : "string"
          },
          "creditor_institution_description" : {
            "type" : "string"
          }
        }
      },
      "CdsSubjectService" : {
        "required" : [ "fee", "service", "start_date", "subject", "subject_service_id" ],
        "type" : "object",
        "properties" : {
          "subject" : {
            "type" : "string"
          },
          "service" : {
            "type" : "string"
          },
          "subject_service_id" : {
            "type" : "string"
          },
          "start_date" : {
            "type" : "string",
            "format" : "date-time"
          },
          "end_date" : {
            "type" : "string",
            "format" : "date-time"
          },
          "fee" : {
            "type" : "boolean"
          },
          "station_code" : {
            "type" : "string"
          },
          "service_description" : {
            "type" : "string"
          }
        }
      },
      "Channel" : {
        "required" : [ "agid", "broker_psp_code", "channel_code", "connection", "digital_stamp", "enabled", "flag_io", "flag_psp_cp", "new_fault_code", "password", "payment_model", "primitive_version", "recovery", "redirect", "rt_push", "thread_number", "timeouts" ],
        "type" : "object",
        "properties" : {
          "channel_code" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "password" : {
            "type" : "string"
          },
          "connection" : {
            "$ref" : "#/components/schemas/Connection"
          },
          "broker_psp_code" : {
            "type" : "string"
          },
          "proxy" : {
            "$ref" : "#/components/schemas/Proxy"
          },
          "service" : {
            "$ref" : "#/components/schemas/Service"
          },
          "service_nmp" : {
            "$ref" : "#/components/schemas/Service"
          },
          "thread_number" : {
            "type" : "integer",
            "format" : "int64"
          },
          "timeouts" : {
            "$ref" : "#/components/schemas/Timeouts"
          },
          "new_fault_code" : {
            "type" : "boolean"
          },
          "redirect" : {
            "$ref" : "#/components/schemas/Redirect"
          },
          "payment_model" : {
            "type" : "string"
          },
          "serv_plugin" : {
            "type" : "string"
          },
          "rt_push" : {
            "type" : "boolean"
          },
          "recovery" : {
            "type" : "boolean"
          },
          "digital_stamp" : {
            "type" : "boolean"
          },
          "flag_io" : {
            "type" : "boolean"
          },
          "agid" : {
            "type" : "boolean"
          },
          "primitive_version" : {
            "type" : "integer",
            "format" : "int32"
          },
          "flag_psp_cp" : {
            "type" : "boolean"
          }
        }
      },
      "ConfigDataV1" : {
        "required" : [ "cdsCategories", "cdsServices", "cdsSubjectServices", "cdsSubjects", "channels", "configurations", "creditorInstitutionBrokers", "creditorInstitutionEncodings", "creditorInstitutionInformations", "creditorInstitutionStations", "creditorInstitutions", "encodings", "ftpServers", "gdeConfigurations", "ibans", "languages", "metadataDict", "paymentTypes", "plugins", "pspBrokers", "pspChannelPaymentTypes", "pspInformationTemplates", "pspInformations", "psps", "stations", "version" ],
        "type" : "object",
        "properties" : {
          "version" : {
            "type" : "string"
          },
          "creditorInstitutions" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/CreditorInstitution"
            }
          },
          "creditorInstitutionBrokers" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/BrokerCreditorInstitution"
            }
          },
          "stations" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/Station"
            }
          },
          "creditorInstitutionStations" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/StationCreditorInstitution"
            }
          },
          "encodings" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/Encoding"
            }
          },
          "creditorInstitutionEncodings" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/CreditorInstitutionEncoding"
            }
          },
          "ibans" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/Iban"
            }
          },
          "creditorInstitutionInformations" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/CreditorInstitutionInformation"
            }
          },
          "psps" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/PaymentServiceProvider"
            }
          },
          "pspBrokers" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/BrokerPsp"
            }
          },
          "paymentTypes" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/PaymentType"
            }
          },
          "pspChannelPaymentTypes" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/PspChannelPaymentType"
            }
          },
          "plugins" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/Plugin"
            }
          },
          "pspInformationTemplates" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/PspInformation"
            }
          },
          "pspInformations" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/PspInformation"
            }
          },
          "channels" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/Channel"
            }
          },
          "cdsServices" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/CdsService"
            }
          },
          "cdsSubjects" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/CdsSubject"
            }
          },
          "cdsSubjectServices" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/CdsSubjectService"
            }
          },
          "cdsCategories" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/CdsCategory"
            }
          },
          "configurations" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/ConfigurationKey"
            }
          },
          "ftpServers" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/FtpServer"
            }
          },
          "languages" : {
            "type" : "object",
            "additionalProperties" : {
              "type" : "string"
            }
          },
          "gdeConfigurations" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/GdeConfiguration"
            }
          },
          "metadataDict" : {
            "type" : "object",
            "additionalProperties" : {
              "$ref" : "#/components/schemas/MetadataDict"
            }
          }
        }
      },
      "ConfigurationKey" : {
        "required" : [ "category", "key", "value" ],
        "type" : "object",
        "properties" : {
          "category" : {
            "type" : "string"
          },
          "key" : {
            "type" : "string"
          },
          "value" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          }
        }
      },
      "Connection" : {
        "required" : [ "ip", "port", "protocol" ],
        "type" : "object",
        "properties" : {
          "protocol" : {
            "type" : "string",
            "enum" : [ "HTTPS", "HTTP" ]
          },
          "ip" : {
            "type" : "string"
          },
          "port" : {
            "type" : "integer",
            "format" : "int64"
          }
        }
      },
      "CreditorInstitution" : {
        "required" : [ "creditor_institution_code", "enabled", "psp_payment", "reporting_ftp", "reporting_zip" ],
        "type" : "object",
        "properties" : {
          "creditor_institution_code" : {
            "type" : "string"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "business_name" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "address" : {
            "$ref" : "#/components/schemas/CreditorInstitutionAddress"
          },
          "psp_payment" : {
            "type" : "boolean"
          },
          "reporting_ftp" : {
            "type" : "boolean"
          },
          "reporting_zip" : {
            "type" : "boolean"
          }
        }
      },
      "CreditorInstitutionAddress" : {
        "type" : "object",
        "properties" : {
          "location" : {
            "type" : "string"
          },
          "city" : {
            "type" : "string"
          },
          "zip_code" : {
            "type" : "string"
          },
          "country_code" : {
            "type" : "string"
          },
          "tax_domicile" : {
            "type" : "string"
          }
        }
      },
      "CreditorInstitutionEncoding" : {
        "required" : [ "code_type", "creditor_institution_code", "encoding_code" ],
        "type" : "object",
        "properties" : {
          "code_type" : {
            "type" : "string"
          },
          "encoding_code" : {
            "type" : "string"
          },
          "creditor_institution_code" : {
            "type" : "string"
          }
        }
      },
      "CreditorInstitutionInformation" : {
        "required" : [ "informativa" ],
        "type" : "object",
        "properties" : {
          "informativa" : {
            "type" : "string"
          }
        }
      },
      "Encoding" : {
        "required" : [ "code_type", "description" ],
        "type" : "object",
        "properties" : {
          "code_type" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          }
        }
      },
      "FtpServer" : {
        "required" : [ "enabled", "history_path", "host", "id", "in_path", "out_path", "password", "port", "root_path", "service", "type", "username" ],
        "type" : "object",
        "properties" : {
          "host" : {
            "type" : "string"
          },
          "port" : {
            "type" : "integer",
            "format" : "int32"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "username" : {
            "type" : "string"
          },
          "password" : {
            "type" : "string"
          },
          "root_path" : {
            "type" : "string"
          },
          "service" : {
            "type" : "string"
          },
          "type" : {
            "type" : "string"
          },
          "in_path" : {
            "type" : "string"
          },
          "out_path" : {
            "type" : "string"
          },
          "history_path" : {
            "type" : "string"
          },
          "id" : {
            "type" : "integer",
            "format" : "int64"
          }
        }
      },
      "GdeConfiguration" : {
        "required" : [ "event_hub_enabled", "event_hub_payload_enabled", "primitive", "type" ],
        "type" : "object",
        "properties" : {
          "primitive" : {
            "type" : "string"
          },
          "type" : {
            "type" : "string"
          },
          "event_hub_enabled" : {
            "type" : "boolean"
          },
          "event_hub_payload_enabled" : {
            "type" : "boolean"
          }
        }
      },
      "Iban" : {
        "required" : [ "creditor_institution_code", "iban", "publication_date", "validity_date" ],
        "type" : "object",
        "properties" : {
          "iban" : {
            "type" : "string"
          },
          "creditor_institution_code" : {
            "type" : "string"
          },
          "validity_date" : {
            "type" : "string",
            "format" : "date-time"
          },
          "publication_date" : {
            "type" : "string",
            "format" : "date-time"
          },
          "shop_id" : {
            "type" : "string"
          },
          "seller_bank_id" : {
            "type" : "string"
          },
          "avvio_key" : {
            "type" : "string"
          },
          "esito_key" : {
            "type" : "string"
          }
        }
      },
      "MetadataDict" : {
        "required" : [ "key", "start_date" ],
        "type" : "object",
        "properties" : {
          "key" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "start_date" : {
            "type" : "string",
            "format" : "date-time"
          },
          "end_date" : {
            "type" : "string",
            "format" : "date-time"
          }
        }
      },
      "PaymentServiceProvider" : {
        "required" : [ "agid_psp", "digital_stamp", "enabled", "psp_code" ],
        "type" : "object",
        "properties" : {
          "psp_code" : {
            "type" : "string"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "description" : {
            "type" : "string"
          },
          "business_name" : {
            "type" : "string"
          },
          "abi" : {
            "type" : "string"
          },
          "bic" : {
            "type" : "string"
          },
          "my_bank_code" : {
            "type" : "string"
          },
          "digital_stamp" : {
            "type" : "boolean"
          },
          "agid_psp" : {
            "type" : "boolean"
          },
          "tax_code" : {
            "type" : "string"
          },
          "vat_number" : {
            "type" : "string"
          }
        }
      },
      "PaymentType" : {
        "required" : [ "payment_type" ],
        "type" : "object",
        "properties" : {
          "payment_type" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          }
        }
      },
      "Plugin" : {
        "required" : [ "id_serv_plugin" ],
        "type" : "object",
        "properties" : {
          "id_serv_plugin" : {
            "type" : "string"
          },
          "pag_const_string_profile" : {
            "type" : "string"
          },
          "pag_soap_rule_profile" : {
            "type" : "string"
          },
          "pag_rpt_xpath_profile" : {
            "type" : "string"
          },
          "id_bean" : {
            "type" : "string"
          }
        }
      },
      "Proxy" : {
        "type" : "object",
        "properties" : {
          "proxy_host" : {
            "type" : "string"
          },
          "proxy_port" : {
            "type" : "integer",
            "format" : "int64"
          },
          "proxy_username" : {
            "type" : "string"
          },
          "proxy_password" : {
            "type" : "string"
          }
        }
      },
      "PspChannelPaymentType" : {
        "required" : [ "channel_code", "payment_type", "psp_code" ],
        "type" : "object",
        "properties" : {
          "psp_code" : {
            "type" : "string"
          },
          "channel_code" : {
            "type" : "string"
          },
          "payment_type" : {
            "type" : "string"
          }
        }
      },
      "PspInformation" : {
        "required" : [ "informativa" ],
        "type" : "object",
        "properties" : {
          "informativa" : {
            "type" : "string"
          }
        }
      },
      "Redirect" : {
        "type" : "object",
        "properties" : {
          "protocol" : {
            "type" : "string",
            "enum" : [ "HTTPS", "HTTP" ]
          },
          "ip" : {
            "type" : "string"
          },
          "path" : {
            "type" : "string"
          },
          "port" : {
            "type" : "integer",
            "format" : "int64"
          },
          "query_string" : {
            "type" : "string"
          }
        }
      },
      "Service" : {
        "type" : "object",
        "properties" : {
          "path" : {
            "type" : "string"
          },
          "target_host" : {
            "type" : "string"
          },
          "target_port" : {
            "type" : "integer",
            "format" : "int64"
          },
          "target_path" : {
            "type" : "string"
          }
        }
      },
      "Station" : {
        "required" : [ "broker_code", "connection", "enabled", "invio_rt_istantaneo", "password", "primitive_version", "redirect", "station_code", "thread_number", "timeouts", "version" ],
        "type" : "object",
        "properties" : {
          "station_code" : {
            "type" : "string"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "version" : {
            "type" : "integer",
            "format" : "int64"
          },
          "connection" : {
            "$ref" : "#/components/schemas/Connection"
          },
          "connection_mod4" : {
            "$ref" : "#/components/schemas/Connection"
          },
          "password" : {
            "type" : "string"
          },
          "redirect" : {
            "$ref" : "#/components/schemas/Redirect"
          },
          "service" : {
            "$ref" : "#/components/schemas/Service"
          },
          "service_pof" : {
            "$ref" : "#/components/schemas/Service"
          },
          "service_mod4" : {
            "$ref" : "#/components/schemas/Service"
          },
          "broker_code" : {
            "type" : "string"
          },
          "proxy" : {
            "$ref" : "#/components/schemas/Proxy"
          },
          "thread_number" : {
            "type" : "integer",
            "format" : "int64"
          },
          "timeouts" : {
            "$ref" : "#/components/schemas/Timeouts"
          },
          "invio_rt_istantaneo" : {
            "type" : "boolean"
          },
          "primitive_version" : {
            "type" : "integer",
            "format" : "int32"
          }
        }
      },
      "StationCreditorInstitution" : {
        "required" : [ "broadcast", "creditor_institution_code", "mod4", "primitive_version", "spontaneous_payment", "station_code" ],
        "type" : "object",
        "properties" : {
          "creditor_institution_code" : {
            "type" : "string"
          },
          "station_code" : {
            "type" : "string"
          },
          "application_code" : {
            "type" : "integer",
            "format" : "int64"
          },
          "aux_digit" : {
            "type" : "integer",
            "format" : "int64"
          },
          "segregation_code" : {
            "type" : "integer",
            "format" : "int64"
          },
          "mod4" : {
            "type" : "boolean"
          },
          "broadcast" : {
            "type" : "boolean"
          },
          "primitive_version" : {
            "type" : "integer",
            "format" : "int32"
          },
          "spontaneous_payment" : {
            "type" : "boolean"
          }
        }
      },
      "Timeouts" : {
        "required" : [ "timeout_a", "timeout_b", "timeout_c" ],
        "type" : "object",
        "properties" : {
          "timeout_a" : {
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_b" : {
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_c" : {
            "type" : "integer",
            "format" : "int64"
          }
        }
      },
      "CacheVersion" : {
        "required" : [ "version" ],
        "type" : "object",
        "properties" : {
          "version" : {
            "type" : "string"
          }
        }
      },
      "AppInfo" : {
        "required" : [ "environment", "name", "version" ],
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
          },
          "dbConnection" : {
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
