{
  "openapi": "3.0.3",
  "info": {
    "title" : "FDR INTERNAL - Flussi di rendicontazione ${service}",
    "description" : "Manage FDR INTERNAL ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC ${service}",
    "version": "1.0.0-SNAPSHOT"
  },
  "servers": [
    {
      "url": "${host}/fdr-nodo/api/v1 - APIM"
    }
  ],
  "tags": [],
  "paths": {
    "/notify/fdr": {
      "post": {
        "tags": [
          "Fdr fase 1"
        ],
        "summary": "Notify fdr to convert",
        "description": "Notify fdr to convert",
        "operationId": "notifyFdrToConvert",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/NotifyFdr"
              }
            }
          }
        },
        "responses" : {
          "200" : {
            "description" : "Success",
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
    },
    "/register-for-validation/fdr": {
      "post": {
        "tags": [
          "Fdr fase 1"
        ],
        "summary": "Register flow for name validation",
        "description": "Register Nexi flow for flow name validation",
        "operationId": "RegisterFdrForValidationRequest",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RegisterFdrForValidationRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GenericResponse"
                }
              }
            }
          }
        }
      }
    },
    "/internal/organizations/{organizationId}/fdrs/{fdr}": {
      "get": {
        "tags": [
          "Info"
        ],
        "summary": "Get xml of FDR",
        "parameters": [
          {
            "name": "organizationId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "fdr",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GetXmlRendicontazioneResponse"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "NotifyFdr": {
        "type": "object",
        "required": [
          "fdr",
          "pspId",
          "retry",
          "revision"
        ],
        "properties": {
          "fdr": {
            "type": "string"
          },
          "pspId": {
            "type": "string"
          },
          "retry": {
            "type": "integer"
          },
          "revision": {
            "type": "integer"
          }
        },
        "additionalProperties": false
      },
      "GenericResponse": {
        "type": "object",
        "required": [
          "outcome"
        ],
        "properties": {
          "outcome": {
            "type": "string",
            "example": "OK"
          },
          "description": {
            "type": "string",
            "example": "error description"
          }
        }
      },
      "GetXmlRendicontazioneResponse": {
        "type": "object",
        "properties": {
          "xmlRendicontazione": {
            "type": "string",
            "example": "Y2lhbwo="
          }
        }
      },
      "RegisterFdrForValidationRequest": {
        "required": [
          "flowId",
          "pspId",
          "organizationId",
          "flowTimestamp"
        ],
        "type": "object",
        "properties": {
          "flowId": {
            "description": "[XML NodoInviaFlussoRendicontazione]=[identificativoFlusso]",
            "pattern": "[a-zA-Z0-9\\-_]{1,35}",
            "type": "string",
            "example": "2016-08-16pspTest-1178"
          },
          "pspId": {
            "type": "string",
            "example": "1"
          },
          "organizationId": {
            "type": "string",
            "example": "1"
          },
          "flowTimestamp": {
            "type": "string",
            "example": "2025-01-01T12:00:00"
          }
        }
      },
      "Error": {
        "type": "object",
        "properties": {
          "error": {
            "type": "string",
            "example": "Si è verificato un errore"
          }
        }
      }
    },
    "securitySchemes": {
      "SecurityScheme": {
        "type": "http",
        "description": "Authentication",
        "scheme": "basic"
      }
    }
  }
}
