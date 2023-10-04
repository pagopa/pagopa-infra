{
  "openapi" : "3.0.1",
  "info" : {
    "description" : "A microservice that permits the migration from Nexi's Oracle database to PagoPA's PostgreSQL database",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "title" : "data-migration",
    "version" : "1.0.0"
  },
  "servers" : [ {
    "description" : "Generated server url",
    "url": "https://${host}"
  } ],
  "tags" : [ {
    "description" : "Everything about DB Migration",
    "name" : "DB Migration"
  } ],
  "paths" : {
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
    },
    "/restart" : {
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ],
      "post" : {
        "operationId" : "restart",
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
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
          "404" : {
            "content" : {
              "*/*" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
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
          "409" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
                }
              }
            },
            "description" : "Conflict",
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
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ],
        "summary" : "Start again the migration, if interrupted",
        "tags" : [ "DB Migration" ]
      }
    },
    "/start" : {
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ],
      "post" : {
        "operationId" : "start",
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
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
          "409" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
                }
              }
            },
            "description" : "Conflict",
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
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ],
        "summary" : "Start the migration",
        "tags" : [ "DB Migration" ]
      }
    },
    "/status" : {
      "get" : {
        "operationId" : "status",
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
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
          "409" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
                }
              }
            },
            "description" : "Conflict",
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
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
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
        } ],
        "summary" : "Get the status of the migration",
        "tags" : [ "DB Migration" ]
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
    "/stop" : {
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ],
      "post" : {
        "operationId" : "stop",
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
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
          "409" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/MigrationExecutionMessage"
                }
              }
            },
            "description" : "Conflict",
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
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ],
        "summary" : "Stop the migration",
        "tags" : [ "DB Migration" ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "AppInfo" : {
        "type" : "object",
        "properties" : {
          "environment" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "oracleDBStatus" : {
            "type" : "string"
          },
          "postgresDBStatus" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          }
        }
      },
      "MigrationExecutionMessage" : {
        "type" : "object",
        "properties" : {
          "message" : {
            "type" : "string"
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
