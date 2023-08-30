{
  "openapi" : "3.0.3",
  "info" : {
    "title" : "FDR - XML to JSON API REST ${service}",
    "description" : "Manage FDR - XML to JSON API REST ( aka \"StService\" ) ${service}",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.0.0-SNAPSHOT"
  },
  "servers" : [ {
    "url" : "${host}/fdr-xml-to-json/api/v1 - APIM"
  } ],
  "security" : [ {
    "api_key" : [ ]
  } ],
  "tags" : [ {
    "name" : "XML to JSON",
    "description" : "Function for convert XML to REST API"
  } ],
  "paths" : {
    "/xmlerror" : {
      "get" : {
        "tags" : [ "XML to JSON" ],
        "summary" : "Retry to send",
        "description" : "Retry to send all error fdr",
        "operationId" : "xmlerror",
        "parameters" : [ {
          "name" : "partitionKey",
          "in" : "query",
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "rowKey",
          "in" : "query",
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "deleteOnlyByKey",
          "in" : "query",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/GenericResponse"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/GenericResponse"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/GenericResponse"
                }
              }
            }
          },
          "404" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/GenericResponse"
                }
              }
            }
          }
        }
      }
    }
  },
  "components" : {
    "schemas" : {
      "GenericResponse" : {
        "type" : "object",
        "properties" : {
          "message" : {
            "type" : "string",
            "example" : "Success"
          }
        }
      }
    },
    "securitySchemes" : {
      "api_key" : {
        "type" : "apiKey",
        "name" : "Ocp-Apim-Subscription-Key",
        "in" : "header"
      },
      "SecurityScheme" : {
        "type" : "http",
        "description" : "Authentication",
        "scheme" : "basic"
      }
    }
  }
}