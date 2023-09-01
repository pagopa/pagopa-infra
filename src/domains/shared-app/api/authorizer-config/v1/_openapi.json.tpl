{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "platform-authorizer-config-crud",
    "description" : "A microservice that provides a set of APIs to manage authorization records for the Authorizer system.",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.0.2"
  },
  "servers" : [ {
    "url" : "{host}",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "name" : "Cached Authorizations",
    "description" : "Everything about cached authorizations"
  }, {
    "name" : "Authorizations",
    "description" : "Everything about authorizations"
  } ],
  "paths" : {
    "/authorizations/{authorizationId}" : {
      "get" : {
        "tags" : [ "Authorizations" ],
        "summary" : "Get authorization by identifier",
        "operationId" : "getAuthorization",
        "parameters" : [ {
          "name" : "authorizationId",
          "in" : "path",
          "description" : "The identifier of the stored authorization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "404" : {
            "description" : "Not found",
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
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Authorizations"
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
      },
      "put" : {
        "tags" : [ "Authorizations" ],
        "summary" : "Update existing authorization",
        "operationId" : "updateAuthorization",
        "parameters" : [ {
          "name" : "authorizationId",
          "in" : "path",
          "description" : "The identifier of the stored authorization.",
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
          "404" : {
            "description" : "Not found",
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
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Authorizations"
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
      },
      "delete" : {
        "tags" : [ "Authorizations" ],
        "summary" : "Delete existing authorization",
        "operationId" : "deleteAuthorization",
        "parameters" : [ {
          "name" : "authorizationId",
          "in" : "path",
          "description" : "The identifier of the stored authorization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "404" : {
            "description" : "Not found",
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
          "200" : {
            "description" : "OK"
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
    },
    "/cachedauthorizations/{domain}/refresh" : {
      "post" : {
        "tags" : [ "Cached Authorizations" ],
        "summary" : "Refresh cached authorizations by domain",
        "operationId" : "refreshCachedAuthorizations",
        "parameters" : [ {
          "name" : "domain",
          "in" : "path",
          "description" : "The domain on which the authorizations will be filtered.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "ownerId",
          "in" : "query",
          "description" : "The identifier of the authorizations' owner.",
          "required" : false,
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
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : { }
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
    },
    "/authorizations" : {
      "get" : {
        "tags" : [ "Authorizations" ],
        "summary" : "Get authorization list",
        "operationId" : "getAuthorizations_1",
        "parameters" : [ {
          "name" : "domain",
          "in" : "query",
          "description" : "The domain on which the authorizations will be filtered.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "ownerId",
          "in" : "query",
          "description" : "The identifier of the authorizations' owner.",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "limit",
          "in" : "query",
          "description" : "The number of elements to be included in the page.",
          "required" : true,
          "schema" : {
            "maximum" : 999,
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "name" : "page",
          "in" : "query",
          "description" : "The index of the page, starting from 0.",
          "required" : true,
          "schema" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int32",
            "default" : 0
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
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Authorizations"
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
      },
      "post" : {
        "tags" : [ "Authorizations" ],
        "summary" : "Create new authorization",
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
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Authorizations"
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
          "409" : {
            "description" : "Conflict",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
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
    },
    "/cachedauthorizations" : {
      "get" : {
        "tags" : [ "Cached Authorizations" ],
        "summary" : "Get cached authorizations",
        "operationId" : "getAuthorizations",
        "parameters" : [ {
          "name" : "domain",
          "in" : "query",
          "description" : "The domain on which the authorizations will be filtered.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "ownerId",
          "in" : "query",
          "description" : "The identifier of the authorizations' owner.",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "formatTTL",
          "in" : "query",
          "description" : "The identifier of the authorizations' owner.",
          "required" : false,
          "schema" : {
            "type" : "boolean",
            "default" : true
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
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/CachedAuthorizations"
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
      "Authorization" : {
        "required" : [ "authorized_entities", "domain", "other_metadata", "owner", "subscription_key" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "domain" : {
            "type" : "string"
          },
          "subscription_key" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "owner" : {
            "$ref" : "#/components/schemas/AuthorizationOwner"
          },
          "authorized_entities" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/AuthorizationEntity"
            }
          },
          "other_metadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/AuthorizationMetadata"
            }
          },
          "inserted_at" : {
            "type" : "string"
          },
          "last_update" : {
            "type" : "string"
          },
          "last_forced_refresh" : {
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
          "name" : {
            "type" : "string"
          },
          "short_key" : {
            "pattern" : "_[a-zA-Z0-9]{1,3}",
            "type" : "string"
          },
          "content" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/AuthorizationGenericKeyValue"
            }
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
      "PageInfo" : {
        "required" : [ "items_found", "limit", "page", "total_pages" ],
        "type" : "object",
        "properties" : {
          "page" : {
            "type" : "integer",
            "description" : "Page number",
            "format" : "int32"
          },
          "limit" : {
            "type" : "integer",
            "description" : "Required number of items per page",
            "format" : "int32"
          },
          "items_found" : {
            "type" : "integer",
            "description" : "Number of items found. (The last page may have fewer elements than required)",
            "format" : "int32"
          },
          "total_pages" : {
            "type" : "integer",
            "description" : "Total number of pages",
            "format" : "int32"
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
