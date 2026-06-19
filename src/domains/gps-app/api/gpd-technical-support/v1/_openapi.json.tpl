{
  "openapi" : "3.1.0",
  "info" : {
    "description" : "Technical support APIs for GPD",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "title" : "GPD Technical Support",
    "version" : "0.0.1-SNAPSHOT"
  },
  "servers" : [ {
    "url" : "http://localhost:8080"
  }, {
    "url" : "https://api.{environment}.platform.pagopa.it/gpd-technical-support",
    "variables" : {
      "environment" : {
        "default" : "dev",
        "enum" : [ "dev", "uat" ]
      }
    }
  }, {
    "url" : "https://api.platform.pagopa.it/gpd-technical-support"
  } ],
  "paths" : {
    "/internal/position-status-reconciliation" : {
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ],
      "post" : {
        "description" : "Starts an asynchronous reconciliation process for the requested date interval and service types.",
        "operationId" : "start",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PositionStatusReconciliationRequest"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "202" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PositionStatusReconciliationResponse"
                }
              }
            },
            "description" : "Reconciliation request accepted",
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
                  "$ref" : "#/components/schemas/PositionStatusReconciliationResponse"
                }
              }
            },
            "description" : "Invalid reconciliation request",
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
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PositionStatusReconciliationResponse"
                }
              }
            },
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
          "500" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PositionStatusReconciliationResponse"
                }
              }
            },
            "description" : "Internal server error",
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
        "summary" : "Start payment position status reconciliation",
        "tags" : [ "position-status-reconciliation-controller" ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "PositionStatusReconciliationRequest" : {
        "type" : "object",
        "properties" : {
          "force" : {
            "type" : "boolean"
          },
          "from" : {
            "type" : "string",
            "format" : "date"
          },
          "serviceTypes" : {
            "type" : "array",
            "items" : {
              "type" : "string",
              "enum" : [ "ACA", "GPD", "WISP" ]
            },
            "minItems" : 1
          },
          "to" : {
            "type" : "string",
            "format" : "date"
          }
        },
        "required" : [ "from", "serviceTypes", "to" ]
      },
      "PositionStatusReconciliationResponse" : {
        "type" : "object",
        "properties" : {
          "accepted" : {
            "type" : "boolean"
          },
          "runs" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/ReconciliationRunResponse"
            }
          }
        }
      },
      "ReconciliationRunResponse" : {
        "type" : "object",
        "properties" : {
          "day" : {
            "type" : "string",
            "format" : "date"
          },
          "executionId" : {
            "type" : "string"
          },
          "logicalRunKey" : {
            "type" : "string"
          },
          "serviceTypes" : {
            "type" : "array",
            "items" : {
              "type" : "string",
              "enum" : [ "ACA", "GPD", "WISP" ]
            }
          },
          "status" : {
            "type" : "string",
            "enum" : [ "CREATED", "RUNNING", "DONE", "FAILED", "SKIPPED" ]
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "description" : "API key required to access the service.",
        "in" : "header",
        "name" : "Ocp-Apim-Subscription-Key",
        "type" : "apiKey"
      }
    }
  }
}