{
  "openapi" : "3.0.3",
  "info" : {
    "title" : "Taxonomy ${service}",
    "description" : "Taxonomy Azure Function. This function has the role of converting a CSV file to JSON and then to retrieve it from a blob storage whenever needed. ${service}",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version": "1.1.1"
  },
  "servers" : [ {
    "url" : "${host}/taxonomy/api/v1"
  } ],
  "paths" : {
    "/info": {
      "get": {
        "operationId": "Info",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoMessage"
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "summary": "Healthcheck"
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/generate": {
      "get": {
        "operationId": "TaxonomyUpdate",
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Message"
                }
              }
            },
            "description": "OK, Taxonomy updated successfully",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorMessage"
                }
              }
            },
            "description": "Not Found, cannot access CSV file.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorMessage"
                }
              }
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "summary": "Generates taxonomy JSON file"
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/taxonomy": {
      "get": {
        "operationId": "getTaxonomy",
        "parameters": [
          {
            "in": "query",
            "name": "extension",
            "required": false,
            "schema": {
              "type": "string",
              "default": "json"
            }
          },
          {
            "in": "query",
            "name": "version",
            "required": false,
            "schema": {
              "type": "string",
              "default": "standard"
            }
          }
        ],
        "responses": {
          "200": {
            "content": {
              "application/json": {
                "schema": {
                  "oneOf": [
                    {
                      "$ref": "#/components/schemas/TaxonomyStandardVersion"
                    },
                    {
                      "$ref": "#/components/schemas/TaxonomyTopicFlagVersion"
                    }
                  ]
                }
              }
            },
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "content": {
              "application/json": {}
            },
            "description": "Bad Request, file extension or version do not exist.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "$ref": "#/components/schemas/ErrorMessage"
                }
              }
            }
          },
          "404": {
            "content": {
              "application/json": {}
            },
            "description": "Not Found, JSON OR CSV file were not found.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "$ref": "#/components/schemas/ErrorMessage"
                }
              }
            }
          },
          "500": {
            "content": {
              "application/json": {}
            },
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "$ref": "#/components/schemas/ErrorMessage"
                }
              }
            }
          }
        },
        "summary": "Get Taxonomy"
      },
      "parameters": [
        {
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "in": "header",
          "name": "X-Request-Id",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  },
  "components" : {
    "schemas": {
      "Message": {
        "type": "object",
        "properties": {
          "message": {
            "type": "string"
          }
        }
      },
      "ErrorMessage": {
        "type": "object",
        "properties": {
          "message": {
            "type": "string"
          },
          "error": {
            "type": "string"
          }
        }
      },
      "InfoMessage": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string"
          }
        }
      },
      "TaxonomyTopicFlagVersion": {
        "type": "object",
        "properties": {
          "CODICE TIPO ENTE CREDITORE": {
            "type": "string"
          },
          "TIPO ENTE CREDITORE": {
            "type": "string"
          },
          "PROGRESSIVO MACRO AREA PER ENTE CREDITORE": {
            "type": "string"
          },
          "NOME MACRO AREA": {
            "type": "string"
          },
          "DESCRIZIONE MACRO AREA": {
            "type": "string"
          },
          "CODICE TIPOLOGIA SERVIZIO": {
            "type": "string"
          },
          "TIPO SERVIZIO": {
            "type": "string"
          },
          "MOTIVO GIURIDICO DELLA RISCOSSIONE": {
            "type": "string"
          },
          "DESCRIZIONE TIPO SERVIZIO": {
            "type": "string"
          },
          "VERSIONE TASSONOMIA": {
            "type": "string"
          },
          "DATI SPECIFICI INCASSO": {
            "type": "string"
          },
          "DATA INIZIO VALIDITA": {
            "type": "string"
          },
          "DATA FINE VALIDITA": {
            "type": "string"
          },
          "COMBINAZIONE TOPIC E SUBTOPIC": {
            "type": "string"
          }
        }
      },
      "TaxonomyStandardVersion": {
        "type": "object",
        "properties": {
          "CODICE TIPO ENTE CREDITORE": {
            "type": "string"
          },
          "TIPO ENTE CREDITORE": {
            "type": "string"
          },
          "PROGRESSIVO MACRO AREA PER ENTE CREDITORE": {
            "type": "string"
          },
          "NOME MACRO AREA": {
            "type": "string"
          },
          "DESCRIZIONE MACRO AREA": {
            "type": "string"
          },
          "CODICE TIPOLOGIA SERVIZIO": {
            "type": "string"
          },
          "TIPO SERVIZIO": {
            "type": "string"
          },
          "MOTIVO GIURIDICO DELLA RISCOSSIONE": {
            "type": "string"
          },
          "DESCRIZIONE TIPO SERVIZIO": {
            "type": "string"
          },
          "VERSIONE TASSONOMIA": {
            "type": "string"
          },
          "DATI SPECIFICI INCASSO": {
            "type": "string"
          },
          "DATA INIZIO VALIDITA": {
            "type": "string"
          },
          "DATA FINE VALIDITA": {
            "type": "string"
          }
        }
      }
    }
  }
}
