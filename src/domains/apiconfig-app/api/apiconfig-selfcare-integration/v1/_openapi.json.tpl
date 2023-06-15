{
  "openapi" : "3.0.1",
  "info" : {
    "description" : "Spring application exposes APIs for SelfCare",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "title": "API-Config - ${service}",
    "version" : "1.4.0"
  },
  "servers" : [ {
    "url": "${host}",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "description" : "Everything about PSP's brokers",
    "name" : "PSP Brokers"
  }, {
    "description" : "Everything about Creditor Institution",
    "name" : "Creditor Institutions"
  }, {
    "description" : "Everything about brokers",
    "name" : "Brokers"
  } ],
  "paths" : {
    "/brokers/{brokerId}/stations" : {
      "get" : {
        "operationId" : "getStationsDetailsFromBroker",
        "parameters" : [ {
          "description" : "The identifier of the broker.",
          "in" : "path",
          "name" : "brokerId",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The identifier of the station.",
          "in" : "query",
          "name" : "stationId",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The number of elements to be included in the page.",
          "in" : "query",
          "name" : "limit",
          "required" : true,
          "schema" : {
            "maximum" : 999,
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "description" : "The index of the page, starting from 0.",
          "in" : "query",
          "name" : "page",
          "required" : true,
          "schema" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int32",
            "default" : 0
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/StationDetailsList"
                }
              }
            },
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get broker's station list",
        "tags" : [ "Brokers" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/brokerspsp/{brokerId}/channels" : {
      "get" : {
        "operationId" : "getChannelDetailsFromPSPBroker",
        "parameters" : [ {
          "description" : "The identifier of the PSP broker.",
          "in" : "path",
          "name" : "brokerId",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The identifier of the channel.",
          "in" : "query",
          "name" : "channelId",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The number of elements to be included in the page.",
          "in" : "query",
          "name" : "limit",
          "required" : true,
          "schema" : {
            "maximum" : 999,
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "description" : "The index of the page, starting from 0.",
          "in" : "query",
          "name" : "page",
          "required" : true,
          "schema" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int32",
            "default" : 0
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ChannelDetailsList"
                }
              }
            },
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get PSP broker's channel list",
        "tags" : [ "PSP Brokers" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/creditorinstitutions/{creditorInstitutionCode}/applicationcodes" : {
      "get" : {
        "operationId" : "getApplicationCodesFromCreditorInstitution",
        "parameters" : [ {
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "in" : "path",
          "name" : "creditorInstitutionCode",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The flag that permits to show the codes already used. Default: true",
          "in" : "query",
          "name" : "showUsedCodes",
          "required" : false,
          "schema" : {
            "type" : "boolean",
            "default" : true
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/CIAssociatedCodeList"
                }
              }
            },
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get application code associations with creditor institution",
        "tags" : [ "Creditor Institutions" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/creditorinstitutions/{creditorInstitutionCode}/segregationcodes" : {
      "get" : {
        "operationId" : "getSegregationCodesFromCreditorInstitution",
        "parameters" : [ {
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "in" : "path",
          "name" : "creditorInstitutionCode",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The flag that permits to show the codes already used. Default: true",
          "in" : "query",
          "name" : "showUsedCodes",
          "required" : false,
          "schema" : {
            "type" : "boolean",
            "default" : true
          }
        }, {
          "description" : "The service endpoint, to be used as a search filter to obtain only the segregation codes used by the CI for stations using same endpoint service. Default: null",
          "in" : "query",
          "name" : "service",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/CIAssociatedCodeList"
                }
              }
            },
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get segregation code associations with creditor institution",
        "tags" : [ "Creditor Institutions" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/creditorinstitutions/{creditorInstitutionCode}/stations" : {
      "get" : {
        "operationId" : "getStationsDetailsFromCreditorInstitution",
        "parameters" : [ {
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "in" : "path",
          "name" : "creditorInstitutionCode",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The number of elements to be included in the page.",
          "in" : "query",
          "name" : "limit",
          "required" : true,
          "schema" : {
            "maximum" : 999,
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "description" : "The index of the page, starting from 0.",
          "in" : "query",
          "name" : "page",
          "required" : true,
          "schema" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int32",
            "default" : 0
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/StationDetailsList"
                }
              }
            },
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get creditor institution station list",
        "tags" : [ "Creditor Institutions" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/info" : {
      "get" : {
        "operationId" : "healthCheck",
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/AppInfo"
                }
              }
            },
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "400" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Bad Request",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Return OK if application is started",
        "tags" : [ "Home" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ]
    }
  },
  "components" : {
    "schemas" : {
      "AppInfo" : {
        "type" : "object",
        "properties" : {
          "dbConnection" : {
            "type" : "string"
          },
          "environment" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          }
        }
      },
      "BrokerDetails" : {
        "required" : [ "broker_code", "broker_details", "enabled", "extended_fault_bean" ],
        "type" : "object",
        "properties" : {
          "broker_code" : {
            "maxLength" : 35,
            "minLength" : 0,
            "type" : "string",
            "description" : "Code used to identify the intermediate EC",
            "example" : "223344556677889900"
          },
          "broker_details" : {
            "type" : "string",
            "description" : "Name and generic details of the intermediate EC",
            "example" : "Regione Veneto"
          },
          "enabled" : {
            "type" : "boolean",
            "description" : "Parameter to find out whether or not the intermediate has been enabled"
          },
          "extended_fault_bean" : {
            "type" : "boolean",
            "description" : "Parameter to find out whether or not the extended fault bean has been enabled"
          }
        },
        "description" : "Details of the intermediate EC of the station"
      },
      "CIAssociatedCode" : {
        "required" : [ "code" ],
        "type" : "object",
        "properties" : {
          "code" : {
            "maxLength" : 2,
            "minLength" : 2,
            "type" : "string",
            "description" : "The code that bound uniquely a creditor institution to a station"
          },
          "name" : {
            "type" : "string",
            "description" : "The name of the station associated to the creditor institution, if exists"
          }
        },
        "description" : "List of codes not used for existing associations"
      },
      "CIAssociatedCodeList" : {
        "required" : [ "unused" ],
        "type" : "object",
        "properties" : {
          "unused" : {
            "type" : "array",
            "description" : "List of codes not used for existing associations",
            "items" : {
              "$ref" : "#/components/schemas/CIAssociatedCode"
            }
          },
          "used" : {
            "type" : "array",
            "description" : "List of codes already used for existing associations",
            "items" : {
              "$ref" : "#/components/schemas/CIAssociatedCode"
            }
          }
        }
      },
      "ChannelDetails" : {
        "required" : [ "agid", "broker_psp_code", "card_chart", "channel_code", "digital_stamp_brand", "enabled", "on_us", "payment_model", "port", "primitive_version", "protocol", "recovery", "rt_push", "thread_number", "timeout_a", "timeout_b", "timeout_c" ],
        "type" : "object",
        "properties" : {
          "agid" : {
            "type" : "boolean"
          },
          "broker_description" : {
            "type" : "string",
            "description" : "Broker description. Read only field",
            "example" : "Lorem ipsum dolor sit amet"
          },
          "broker_psp_code" : {
            "type" : "string"
          },
          "card_chart" : {
            "type" : "boolean"
          },
          "channel_code" : {
            "type" : "string",
            "example" : "223344556677889900"
          },
          "digital_stamp_brand" : {
            "type" : "boolean"
          },
          "enabled" : {
            "type" : "boolean"
          },
          "flag_io" : {
            "type" : "boolean"
          },
          "flag_psp_cp" : {
            "type" : "boolean"
          },
          "ip" : {
            "type" : "string"
          },
          "new_fault_code" : {
            "type" : "boolean"
          },
          "new_password" : {
            "type" : "string"
          },
          "nmp_service" : {
            "type" : "string"
          },
          "on_us" : {
            "type" : "boolean"
          },
          "password" : {
            "type" : "string"
          },
          "payment_model" : {
            "type" : "string",
            "enum" : [ "IMMEDIATE", "IMMEDIATE_MULTIBENEFICIARY", "DEFERRED", "ACTIVATED_AT_PSP" ]
          },
          "port" : {
            "maximum" : 65535,
            "minimum" : 1,
            "type" : "integer",
            "format" : "int64"
          },
          "primitive_version" : {
            "maximum" : 2,
            "minimum" : 1,
            "type" : "integer",
            "description" : "Primitive number version",
            "format" : "int32"
          },
          "protocol" : {
            "type" : "string",
            "enum" : [ "HTTPS", "HTTP" ]
          },
          "proxy_enabled" : {
            "type" : "boolean"
          },
          "proxy_host" : {
            "type" : "string"
          },
          "proxy_password" : {
            "type" : "string"
          },
          "proxy_port" : {
            "maximum" : 65535,
            "minimum" : 1,
            "type" : "integer",
            "format" : "int64"
          },
          "proxy_username" : {
            "type" : "string"
          },
          "recovery" : {
            "type" : "boolean"
          },
          "redirect_ip" : {
            "type" : "string"
          },
          "redirect_path" : {
            "type" : "string"
          },
          "redirect_port" : {
            "maximum" : 65535,
            "minimum" : 1,
            "type" : "integer",
            "format" : "int64"
          },
          "redirect_protocol" : {
            "type" : "string",
            "enum" : [ "HTTPS", "HTTP" ]
          },
          "redirect_query_string" : {
            "type" : "string"
          },
          "rt_push" : {
            "type" : "boolean"
          },
          "serv_plugin" : {
            "type" : "string"
          },
          "service" : {
            "type" : "string"
          },
          "target_host" : {
            "type" : "string"
          },
          "target_host_nmp" : {
            "type" : "string"
          },
          "target_path" : {
            "type" : "string"
          },
          "target_path_nmp" : {
            "type" : "string"
          },
          "target_port" : {
            "type" : "integer",
            "format" : "int64"
          },
          "target_port_nmp" : {
            "type" : "integer",
            "format" : "int64"
          },
          "thread_number" : {
            "minimum" : 1,
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_a" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_b" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_c" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int64"
          }
        },
        "description" : "List of stations associated to the same entity"
      },
      "ChannelDetailsList" : {
        "required" : [ "channels", "page_info" ],
        "type" : "object",
        "properties" : {
          "channels" : {
            "type" : "array",
            "description" : "List of stations associated to the same entity",
            "items" : {
              "$ref" : "#/components/schemas/ChannelDetails"
            }
          },
          "page_info" : {
            "$ref" : "#/components/schemas/PageInfo"
          }
        }
      },
      "PageInfo" : {
        "type" : "object",
        "properties" : {
          "items_found" : {
            "type" : "integer",
            "description" : "Number of items found. (The last page may have fewer elements than required)",
            "format" : "int32"
          },
          "limit" : {
            "type" : "integer",
            "description" : "Required number of items per page",
            "format" : "int32"
          },
          "page" : {
            "type" : "integer",
            "description" : "Page number",
            "format" : "int32"
          },
          "total_pages" : {
            "type" : "integer",
            "description" : "Total number of pages",
            "format" : "int32"
          }
        }
      },
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          }
        }
      },
      "StationDetails" : {
        "required" : [ "broker_details", "enabled", "port", "primitive_version", "protocol", "station_code", "thread_number", "timeout_a", "timeout_b", "timeout_c", "version" ],
        "type" : "object",
        "properties" : {
          "broker_description" : {
            "type" : "string",
            "description" : "A description of the intermediate EC",
            "example" : "Regione Lazio"
          },
          "broker_details" : {
            "$ref" : "#/components/schemas/BrokerDetails"
          },
          "enabled" : {
            "type" : "boolean",
            "description" : "Parameter to find out whether or not the station has been enabled",
            "default" : true
          },
          "flag_online" : {
            "type" : "boolean"
          },
          "invio_rt_istantaneo" : {
            "type" : "boolean",
            "description" : "Parameter useful to find out if the instantaneous rt has been enabled"
          },
          "ip" : {
            "type" : "string",
            "description" : "Ip address of the station"
          },
          "ip_4mod" : {
            "type" : "string",
            "description" : "Ip address 4mod associated to the station"
          },
          "new_password" : {
            "type" : "string",
            "description" : "New password of the station"
          },
          "password" : {
            "type" : "string",
            "description" : "Password of the station"
          },
          "pof_service" : {
            "type" : "string"
          },
          "port" : {
            "maximum" : 65535,
            "minimum" : 1,
            "type" : "integer",
            "description" : "Port address of the station",
            "format" : "int64"
          },
          "port_4mod" : {
            "maximum" : 65535,
            "minimum" : 1,
            "type" : "integer",
            "description" : "Port address 4mod associated to the station",
            "format" : "int64"
          },
          "primitive_version" : {
            "maximum" : 2,
            "minimum" : 1,
            "type" : "integer",
            "description" : "Primitive number version",
            "format" : "int32",
            "enum" : [ 1, 2 ]
          },
          "protocol" : {
            "type" : "string",
            "description" : "Protocol associated to the station",
            "enum" : [ "HTTPS", "HTTP" ]
          },
          "protocol_4mod" : {
            "type" : "string",
            "description" : "Protocol 4mod associated to the station",
            "enum" : [ "HTTPS", "HTTP" ]
          },
          "proxy_enabled" : {
            "type" : "boolean",
            "description" : "Parameter to inspect if the proxy has been enabled for this station"
          },
          "proxy_host" : {
            "type" : "string",
            "description" : "Proxy host"
          },
          "proxy_password" : {
            "type" : "string"
          },
          "proxy_port" : {
            "maximum" : 65535,
            "minimum" : 1,
            "type" : "integer",
            "description" : "Proxy port address",
            "format" : "int64"
          },
          "proxy_username" : {
            "type" : "string"
          },
          "redirect_ip" : {
            "type" : "string",
            "description" : "Redirect ip address of the station"
          },
          "redirect_path" : {
            "type" : "string",
            "description" : "Redirect path of the station"
          },
          "redirect_port" : {
            "maximum" : 65535,
            "minimum" : 1,
            "type" : "integer",
            "description" : "Redirect port address of the station",
            "format" : "int64"
          },
          "redirect_protocol" : {
            "type" : "string",
            "description" : "Redirect protocol associated to the station",
            "enum" : [ "HTTPS", "HTTP" ]
          },
          "redirect_query_string" : {
            "type" : "string",
            "description" : "Redirect query string of the station"
          },
          "service" : {
            "type" : "string"
          },
          "service_4mod" : {
            "type" : "string"
          },
          "station_code" : {
            "maxLength" : 35,
            "minLength" : 0,
            "type" : "string",
            "description" : "Unique code to identify the station",
            "example" : "1234567890100"
          },
          "target_host" : {
            "type" : "string",
            "description" : "Target address of the station"
          },
          "target_host_pof" : {
            "type" : "string",
            "description" : "Pof address associated to the station"
          },
          "target_path" : {
            "type" : "string",
            "description" : "Target path of the station"
          },
          "target_path_pof" : {
            "type" : "string",
            "description" : "Pof path associated to the station"
          },
          "target_port" : {
            "type" : "integer",
            "description" : "Port address target associated to the station",
            "format" : "int64"
          },
          "target_port_pof" : {
            "type" : "integer",
            "description" : "Port address pof associated to the station",
            "format" : "int64"
          },
          "thread_number" : {
            "minimum" : 1,
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_a" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_b" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int64"
          },
          "timeout_c" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int64"
          },
          "version" : {
            "maximum" : 2,
            "minimum" : 1,
            "type" : "integer",
            "description" : "The version of the station",
            "format" : "int64"
          }
        },
        "description" : "List of stations associated to the same entity"
      },
      "StationDetailsList" : {
        "required" : [ "page_info", "stations" ],
        "type" : "object",
        "properties" : {
          "page_info" : {
            "$ref" : "#/components/schemas/PageInfo"
          },
          "stations" : {
            "type" : "array",
            "description" : "List of stations associated to the same entity",
            "items" : {
              "$ref" : "#/components/schemas/StationDetails"
            }
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "description" : "The API key to access this function app.",
        "in" : "header",
        "name" : "Ocp-Apim-Subscription-Key",
        "type" : "apiKey"
      },
      "Authorization" : {
        "bearerFormat" : "JWT",
        "description" : "JWT token get after Azure Login",
        "scheme" : "bearer",
        "type" : "http"
      }
    }
  }
}