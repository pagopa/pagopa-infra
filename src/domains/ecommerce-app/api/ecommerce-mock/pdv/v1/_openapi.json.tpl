{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "tokenizer-u-tokenizer-api",
    "description" : "Tokenizer API documentation",
    "version" : "1.0-SNAPSHOT"
  },
  "servers" : [ {
    "url" : "https://api.uat.tokenizer.pdv.pagopa.it/{basePath}",
    "variables" : {
      "basePath" : {
        "default" : "/tokenizer/v1"
      }
    }
  } ],
  "tags" : [ {
    "name" : "token",
    "description" : "Token operations"
  } ],
  "paths" : {
    "/tokens/search" : {
      "post" : {
        "tags" : [ "token" ],
        "summary" : "Search token",
        "description" : "Search a token given a PII and Namespace",
        "operationId" : "searchUsingPOST",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PiiResource"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/TokenResource"
                }
              }
            }
          },
          "429" : {
            "description" : "Too Many Requests",
            "content" : { }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "content" : { }
          }
        },
        "security" : [ {
          "api_key" : [ ]
        } ]
      }
    },
    "/tokens/{token}/pii" : {
      "get" : {
        "tags" : [ "token" ],
        "summary" : "Find PII",
        "description" : "Find a PII given a token",
        "operationId" : "findPiiUsingGET",
        "parameters" : [ {
          "name" : "token",
          "in" : "path",
          "description" : "Token related to the PII",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PiiResource"
                }
              }
            }
          },
          "429" : {
            "description" : "Too Many Requests",
            "content" : { }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "content" : { }
          }
        },
        "security" : [ {
          "api_key" : [ ]
        } ]
      }
    },
    "/tokens" : {
      "put" : {
        "tags" : [ "token" ],
        "summary" : "Upsert token",
        "description" : "Create a new token given a PII and Namespace, if already exists do nothing",
        "operationId" : "saveUsingPUT",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PiiResource"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "404" : {
            "description" : "Not Found",
            "content" : { }
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/TokenResource"
                }
              }
            }
          },
          "429" : {
            "description" : "Too Many Requests",
            "content" : { }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "content" : { }
          }
        },
        "security" : [ {
          "api_key" : [ ]
        } ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "PiiResource" : {
        "title" : "PiiResource",
        "required" : [ "pii" ],
        "type" : "object",
        "properties" : {
          "pii" : {
            "type" : "string",
            "description" : "Personal Identifiable Information"
          }
        }
      },
      "TokenResource" : {
        "title" : "TokenResource",
        "required" : [ "token" ],
        "type" : "object",
        "properties" : {
          "token" : {
            "type" : "string",
            "description" : "Namespaced token related to the PII",
            "format" : "uuid"
          }
        }
      },
      "Problem" : {
        "title" : "Problem",
        "required" : [ "status", "title" ],
        "type" : "object",
        "properties" : {
          "detail" : {
            "type" : "string",
            "description" : "Human-readable description of this specific problem."
          },
          "instance" : {
            "type" : "string",
            "description" : "A URI that describes where the problem occurred."
          },
          "invalidParams" : {
            "type" : "array",
            "description" : "A list of invalid parameters details.",
            "items" : {
              "$ref" : "#/components/schemas/InvalidParam"
            }
          },
          "status" : {
            "type" : "integer",
            "description" : "The HTTP status code.",
            "format" : "int32"
          },
          "title" : {
            "type" : "string",
            "description" : "Short human-readable summary of the problem."
          },
          "type" : {
            "type" : "string",
            "description" : "A URL to a page with more details regarding the problem."
          }
        },
        "description" : "A \"problem detail\" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)"
      },
      "InvalidParam" : {
        "title" : "InvalidParam",
        "required" : [ "name", "reason" ],
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string",
            "description" : "Invalid parameter name."
          },
          "reason" : {
            "type" : "string",
            "description" : "Invalid parameter reason."
          }
        }
      }
    },
    "securitySchemes" : {
      "api_key" : {
        "type" : "apiKey",
        "name" : "x-api-key",
        "in" : "header"
      }
    }
  }
}