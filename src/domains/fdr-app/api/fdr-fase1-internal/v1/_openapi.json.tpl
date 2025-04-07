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
    "/convert/fdr3": {
      "post": {
        "tags": [
          "Fdr fase 1"
        ],
        "summary": "Convert FdR 3 flow to FdR 1 flow",
        "description": "Convert FdR 3 flow to FdR 1 flow and persist it on DB and Blob storage",
        "operationId": "convertFlussoRendicontazione",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ConvertRequest"
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
            "ConvertRequest": {
        "required": [
          "payload"
        ],
        "type": "object",
        "properties": {
          "payload": {
            "description": "Payload with the encoded flow from FdR3",
            "type": "string",
            "example": "YWJjZGVmZw=="
          },
          "encoding": {
            "type": "string",
            "example": "base64"
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
