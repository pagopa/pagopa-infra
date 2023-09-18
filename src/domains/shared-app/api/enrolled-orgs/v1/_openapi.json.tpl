{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "platform-authorizer-config-enrolled-ec",
    "description" : "A microservice that provides a set of APIs to manage authorization records for the Authorizer system.",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.0.1-16-PAGOPA-1143-sviluppo-gestione-autorizzazioni-per-authorizer"
  },
  "servers" : [ {
    "url" : "{host}",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "name" : "Enrolled Orgs",
    "description" : "Everything about enrolled organizations"
  } ],
  "paths" : {
    "/organizations/{organizationfiscalcode}/domains/{domain}" : {
      "get" : {
        "tags" : [ "Enrolled Orgs" ],
        "summary" : "Get list of stations associated to organizations enrolled to a specific domain",
        "operationId" : "getStationsForEnrolledOrganizations",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "The enrolled organization on which the stations will be extracted.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "domain",
          "in" : "path",
          "description" : "The domain on which the stations will be filtered.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
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
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/EnrolledCreditorInstitutions"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    },
    "/organizations/domains/{domain}" : {
      "get" : {
        "tags" : [ "Enrolled Orgs" ],
        "summary" : "Get list of organizations enrolled to a specific domain",
        "operationId" : "getEnrolledOrganizations",
        "parameters" : [ {
          "name" : "domain",
          "in" : "path",
          "description" : "The domain on which the organizations will be filtered.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
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
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/EnrolledCreditorInstitutions"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests"
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
        "summary" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
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
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "429" : {
            "description" : "Too many requests"
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
      "EnrolledCreditorInstitution" : {
        "type" : "object",
        "properties" : {
          "organization_fiscal_code" : {
            "type" : "string"
          },
          "segregation_codes" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          }
        }
      },
      "EnrolledCreditorInstitutions" : {
        "required" : [ "creditor_institutions" ],
        "type" : "object",
        "properties" : {
          "creditor_institutions" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/EnrolledCreditorInstitution"
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
