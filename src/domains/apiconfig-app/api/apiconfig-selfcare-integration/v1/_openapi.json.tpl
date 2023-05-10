{
  "openapi" : "3.0.1",
  "info" : {
    "description" : "Spring application exposes APIs for SelfCare",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "title" : "API-Config - SelfCare Integration",
    "version" : "0.0.1"
  },
  "servers" : [ {
    "url" : "http://127.0.0.1:8080",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "description" : "Everything about Creditor Institution",
    "name" : "Creditor Institutions"
  }, {
    "description" : "Everything about creditor institution's broker",
    "name" : "CI Brokers"
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
            "type" : "integer",
            "format" : "int32"
          }
        }, {
          "description" : "The index of the page, starting from 0.",
          "in" : "query",
          "name" : "pageNumber",
          "required" : true,
          "schema" : {
            "type" : "integer",
            "format" : "int32"
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/BrokerStationDetailsList"
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
        "tags" : [ "CI Brokers" ]
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
    "/creditorinstitutions/{creditorInstitutionCode}/stationsdetails" : {
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
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/CreditorInstitutionStationDetailsList"
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
      "BrokerStationDetailsList" : {
        "required" : [ "stations" ],
        "type" : "object",
        "properties" : {
          "stations" : {
            "type" : "array",
            "description" : "List of stations associated to the same broker",
            "items" : {
              "$ref" : "#/components/schemas/StationDetails"
            }
          }
        }
      },
      "CreditorInstitutionStationDetailsList" : {
        "required" : [ "stations" ],
        "type" : "object",
        "properties" : {
          "stations" : {
            "type" : "array",
            "description" : "List of stations associated to the same EC",
            "items" : {
              "$ref" : "#/components/schemas/StationDetails"
            }
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
        "description" : "List of stations associated to the same broker"
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "description" : "The API key to access this function app.",
        "in" : "header",
        "name" : "Ocp-Apim-Subscription-Key",
        "type" : "apiKey"
      }
    }
  }
}
