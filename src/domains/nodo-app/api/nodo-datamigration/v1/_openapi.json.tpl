{
  "openapi" : "3.0.1",
  "info" : {
    "description" : "A microservice that permits the migration from Nexi's Oracle database to PagoPA's PostgreSQL database",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "title" : "data-migration",
    "version" : "0.0.0"
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
    "/restart" : {
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
        }],
        "summary" : "Start again the migration in case it was interrupted",
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
    "/start" : {
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
      "MigrationExecutionMessage" : {
        "type" : "object",
        "properties" : {
          "message" : {
            "type" : "string"
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
