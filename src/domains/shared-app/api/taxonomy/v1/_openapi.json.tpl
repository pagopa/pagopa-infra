{
  "openapi" : "3.0.3",
  "info" : {
    "title" : "Taxonomy ${service}",
    "description" : "Taxonomy ${service}",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.0.0-SNAPSHOT"
  },
  "servers" : [ {
    "url" : "${host}/taxonomy/api/v1 - APIM"
  } ],
  "security" : [ {
    "api_key" : [ ]
  } ],
  "tags" : [ {
    "name" : "Taxonomy",
    "description" : "Taxonomy operations"
  } ],
  "paths" : {
    "/generate" : {
      "get" : {
        "tags" : [ "Taxonomy" ],
        "summary" : "Generate taxonomy",
        "description" : "Generate taxonomy",
        "operationId" : "generate",
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Message"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ErrorMessage"
                }
              }
            }
          },
          "404" : {
            "description" : "Not found",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ErrorMessage"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ErrorMessage"
                }
              }
            }
          }
        }
      }
    },
    "/taxonomy" : {
      "get" : {
        "tags" : [ "Taxonomy" ],
        "summary" : "Get taxonomy",
        "description" : "Get taxonomy",
        "operationId" : "taxonomy",
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "type" : "array",
                  "items" : {
                    "$ref" : "#/components/schemas/Taxonomy"
                  }
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ErrorMessage"
                }
              }
            }
          },
          "404" : {
            "description" : "Not found",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ErrorMessage"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ErrorMessage"
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
      "ErrorMessage" : {
        "type" : "object",
        "properties" : {
          "message" : {
            "type" : "string"
          },
          "error" : {
            "type" : "string"
          }
        }
      },
      "Message" : {
        "type" : "object",
        "properties" : {
          "message" : {
            "type" : "string"
          }
        }
      },
      "Taxonomy" : {
        "type" : "object",
        "properties" : {
          "CODICE TIPO ENTE CREDITORE" : {
            "type" : "string"
          },
          "TIPO ENTE CREDITORE" : {
            "type" : "string"
          },
          "Progressivo Macro Area per Ente Creditore" : {
            "type" : "string"
          },
          "NOME MACRO AREA" : {
            "type" : "string"
          },
          "DESCRIZIONE MACRO AREA" : {
            "type" : "string"
          },
          "CODICE TIPOLOGIA SERVIZIO" : {
            "type" : "string"
          },
          "TIPO SERVIZIO" : {
            "type" : "string"
          },
          "Motivo Giuridico della riscossione" : {
            "type" : "string"
          },
          "DESCRIZIONE TIPO SERVIZIO" : {
            "type" : "string"
          },
          "VERSIONE TASSONOMIA" : {
            "type" : "string"
          },
          "DATI SPECIFICI INCASSO" : {
            "type" : "string"
          },
          "DATA INIZIO VALIDITA" : {
            "type" : "string"
          },
          "DATA FINE VALIDITA" : {
            "type" : "string"
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