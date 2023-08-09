{
  "openapi" : "3.0.1",
  "info" : {
    "description" : "A microservice that provides a set of APIs to manage authorization records for the Authorizer system.",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "title" : "platform-authorizer-config",
    "version" : "0.0.1"
  },
  "servers" : [ {
    "url": "${host}",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "description" : "Everything about enrolled organizations",
    "name" : "Enrolled Orgs"
  }, {
    "description" : "Everything about cached authorizations",
    "name" : "Cached Authorizations"
  }, {
    "description" : "Everything about authorizations",
    "name" : "Authorizations"
  } ],
  "paths" : {
    "/authorizations" : {
      "get" : {
        "operationId" : "getAuthorizations_2",
        "parameters" : [ {
          "description" : "The domain on which the authorizations will be filtered.",
          "in" : "query",
          "name" : "domain",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The identifier of the authorizations' owner.",
          "in" : "query",
          "name" : "ownerId",
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
                  "$ref" : "#/components/schemas/Authorizations"
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
        "summary" : "Get authorization list",
        "tags" : [ "Authorizations" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ],
      "post" : {
        "operationId" : "createAuthorization",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/Authorization"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Authorizations"
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
          "409" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
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
        "summary" : "Create new authorization",
        "tags" : [ "Authorizations" ]
      }
    },
    "/authorizations/{authorizationId}" : {
      "delete" : {
        "operationId" : "deleteAuthorization",
        "parameters" : [ {
          "description" : "The identifier of the stored authorization.",
          "in" : "path",
          "name" : "authorizationId",
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
            "description" : "Not found",
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
        "summary" : "Delete existing authorization",
        "tags" : [ "Authorizations" ]
      },
      "get" : {
        "operationId" : "getAuthorization",
        "parameters" : [ {
          "description" : "The identifier of the stored authorization.",
          "in" : "path",
          "name" : "authorizationId",
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
                  "$ref" : "#/components/schemas/Authorizations"
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
            "description" : "Not found",
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
        "summary" : "Get authorization by identifier",
        "tags" : [ "Authorizations" ]
      },
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ],
      "put" : {
        "operationId" : "updateAuthorization",
        "parameters" : [ {
          "description" : "The identifier of the stored authorization.",
          "in" : "path",
          "name" : "authorizationId",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/Authorization"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Authorizations"
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
            "description" : "Not found",
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
        "summary" : "Update existing authorization",
        "tags" : [ "Authorizations" ]
      }
    },
    "/cachedauthorizations" : {
      "get" : {
        "operationId" : "getAuthorizations_1",
        "parameters" : [ {
          "description" : "The domain on which the authorizations will be filtered.",
          "in" : "query",
          "name" : "domain",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The identifier of the authorizations' owner.",
          "in" : "query",
          "name" : "ownerId",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The identifier of the authorizations' owner.",
          "in" : "query",
          "name" : "formatTTL",
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
                  "$ref" : "#/components/schemas/CachedAuthorizations"
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
        "summary" : "Get cached authorizations",
        "tags" : [ "Cached Authorizations" ]
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
    "/cachedauthorizations/{domain}/refresh" : {
      "parameters" : [ {
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "in" : "header",
        "name" : "X-Request-Id",
        "schema" : {
          "type" : "string"
        }
      } ],
      "post" : {
        "operationId" : "refreshCachedAuthorizations",
        "parameters" : [ {
          "description" : "The domain on which the authorizations will be filtered.",
          "in" : "path",
          "name" : "domain",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "description" : "The identifier of the authorizations' owner.",
          "in" : "query",
          "name" : "ownerId",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : { }
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
        "summary" : "Refresh cached authorizations by domain",
        "tags" : [ "Cached Authorizations" ]
      }
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
    "/organizations/domains/{domain}" : {
      "get" : {
        "operationId" : "getAuthorizations",
        "parameters" : [ {
          "description" : "The domain on which the authorizations will be filtered.",
          "in" : "path",
          "name" : "domain",
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
                  "$ref" : "#/components/schemas/EnrolledCreditorInstitutions"
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
        "summary" : "Get list of enrolled organizations",
        "tags" : [ "Enrolled Orgs" ]
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
      "Authorization" : {
        "required" : [ "authorized_entities", "domain", "other_metadata", "owner", "subscription_key" ],
        "type" : "object",
        "properties" : {
          "authorized_entities" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/AuthorizationEntity"
            }
          },
          "description" : {
            "type" : "string"
          },
          "domain" : {
            "type" : "string"
          },
          "id" : {
            "type" : "string"
          },
          "inserted_at" : {
            "type" : "string"
          },
          "last_forced_refresh" : {
            "type" : "string"
          },
          "last_update" : {
            "type" : "string"
          },
          "other_metadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/AuthorizationMetadata"
            }
          },
          "owner" : {
            "$ref" : "#/components/schemas/AuthorizationOwner"
          },
          "subscription_key" : {
            "type" : "string"
          }
        }
      },
      "AuthorizationEntity" : {
        "required" : [ "name" ],
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string"
          },
          "value" : {
            "type" : "string"
          },
          "values" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          }
        }
      },
      "AuthorizationGenericKeyValue" : {
        "required" : [ "key" ],
        "type" : "object",
        "properties" : {
          "key" : {
            "type" : "string"
          },
          "value" : {
            "type" : "string"
          },
          "values" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          }
        }
      },
      "AuthorizationMetadata" : {
        "required" : [ "content", "name", "short_key" ],
        "type" : "object",
        "properties" : {
          "content" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/AuthorizationGenericKeyValue"
            }
          },
          "name" : {
            "type" : "string"
          },
          "short_key" : {
            "pattern" : "_[a-zA-Z0-9]{1,3}",
            "type" : "string"
          }
        }
      },
      "AuthorizationOwner" : {
        "required" : [ "id", "name", "type" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "type" : {
            "type" : "string",
            "enum" : [ "BROKER", "CI", "OTHER", "PSP" ]
          }
        }
      },
      "Authorizations" : {
        "required" : [ "authorizations", "page_info" ],
        "type" : "object",
        "properties" : {
          "authorizations" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/Authorization"
            }
          },
          "page_info" : {
            "$ref" : "#/components/schemas/PageInfo"
          }
        }
      },
      "CachedAuthorization" : {
        "type" : "object",
        "properties" : {
          "description" : {
            "type" : "string"
          },
          "owner" : {
            "type" : "string"
          },
          "subscription_key" : {
            "type" : "string"
          },
          "ttl" : {
            "type" : "string"
          }
        }
      },
      "CachedAuthorizations" : {
        "required" : [ "cached_authorizations" ],
        "type" : "object",
        "properties" : {
          "cached_authorizations" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/CachedAuthorization"
            }
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
      "PageInfo" : {
        "required" : [ "items_found", "limit", "page", "total_pages" ],
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
