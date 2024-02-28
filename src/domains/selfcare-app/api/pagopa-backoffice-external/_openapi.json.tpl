{
  "openapi" : "3.0.1",
  "info" : {
    "description" : "Microservice to expose REST API to contact PagoPA Backoffice",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "title" : "Backoffice External",
    "version" : "0.0.1"
  },
  "servers" : [ {
    "url" : "http://localhost:8080"
  }, {
    "url" : "https://{host}{basePath}",
    "variables" : {
      "basePath" : {
        "default" : "/backoffice/external/v1"
      },
      "host" : {
        "default" : "api.dev.platform.pagopa.it",
        "enum" : [ "api.dev.platform.pagopa.it", "api.uat.platform.pagopa.it", "api.platform.pagopa.it" ]
      }
    }
  } ],
  "paths" : {
    "/brokers/ibans" : {
      "get" : {
        "description" : "Internal | External | Synchronous | Authorization | Authentication | TPS | Idempotency | Stateless | Read/Write Intense | Cacheable\n-|-|-|-|-|-|-|-|-|-\nY | N | Y | ApiKey | ApiKey | 1.0/sec | Y | Y | Read | Y\nReturn merged Broker Ibans List",
        "operationId" : "getBrokerIbans",
        "parameters" : [ {
          "in" : "query",
          "name" : "limit",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "in" : "query",
          "name" : "page",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 0
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "*/*" : {
                "schema" : {
                  "$ref" : "#/components/schemas/BrokerIbansResponse"
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
          }
        },
        "summary" : "getBrokerIbans",
        "tags" : [ "broker-controller" ]
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
    "/brokers/{brokerCode}/creditor_institutions" : {
      "get" : {
        "description" : "Internal | External | Synchronous | Authorization | Authentication | TPS | Idempotency | Stateless | Read/Write Intense | Cacheable\n-|-|-|-|-|-|-|-|-|-\nY | N | Y | ApiKey | ApiKey | 1.0/sec | Y | Y | Read | Y\nReturn Broker Creditor Institution List",
        "operationId" : "getCreditorInstitutions",
        "parameters" : [ {
          "in" : "path",
          "name" : "brokerCode",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "in" : "query",
          "name" : "limit",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "in" : "query",
          "name" : "page",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 0
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "*/*" : {
                "schema" : {
                  "$ref" : "#/components/schemas/BrokerInstitutionsResponse"
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
          }
        },
        "summary" : "getBrokerInstitutions",
        "tags" : [ "broker-controller" ]
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
        "description" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
          "200" : {
            "content" : {
              "*/*" : {
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
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ],
        "summary" : "health check",
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
      "BrokerIbansResource" : {
        "type" : "object",
        "properties" : {
          "codiceFiscale" : {
            "type" : "string"
          },
          "dataAttivazioneIban" : {
            "type" : "string",
            "format" : "date-time"
          },
          "denominazioneEnte" : {
            "type" : "string"
          },
          "descrizione" : {
            "type" : "string"
          },
          "etichetta" : {
            "type" : "string"
          },
          "iban" : {
            "type" : "string"
          },
          "stato" : {
            "type" : "string"
          }
        }
      },
      "BrokerIbansResponse" : {
        "type" : "object",
        "properties" : {
          "ibans" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/BrokerIbansResource"
            }
          },
          "pageInfo" : {
            "$ref" : "#/components/schemas/PageInfo"
          }
        }
      },
      "BrokerInstitutionResource" : {
        "type" : "object",
        "properties" : {
          "activationDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "applicationCode" : {
            "type" : "string"
          },
          "auxDigit" : {
            "type" : "string"
          },
          "broadcast" : {
            "type" : "boolean"
          },
          "brokerCompanyName" : {
            "type" : "string"
          },
          "brokerTaxCode" : {
            "type" : "string"
          },
          "cbillCode" : {
            "type" : "string"
          },
          "companyName" : {
            "type" : "string"
          },
          "intermediated" : {
            "type" : "boolean"
          },
          "model" : {
            "type" : "integer",
            "format" : "int32"
          },
          "segregationCode" : {
            "type" : "string"
          },
          "stationId" : {
            "type" : "string"
          },
          "stationState" : {
            "type" : "string"
          },
          "taxCode" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          }
        }
      },
      "BrokerInstitutionsResponse" : {
        "required" : [ "creditorInstitutions", "pageInfo" ],
        "type" : "object",
        "properties" : {
          "creditorInstitutions" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/BrokerInstitutionResource"
            }
          },
          "pageInfo" : {
            "$ref" : "#/components/schemas/PageInfo"
          }
        }
      },
      "PageInfo" : {
        "type" : "object",
        "properties" : {
          "limit" : {
            "type" : "integer",
            "format" : "int32"
          },
          "page" : {
            "type" : "integer",
            "format" : "int32"
          }
        }
      }
    },
    "securitySchemes" : {
      "SubKey" : {
        "description" : "The Azure Subscription Key to access this API.",
        "in" : "header",
        "name" : "Ocp-Apim-Subscription-Key",
        "type" : "apiKey"
      }
    }
  }
}
