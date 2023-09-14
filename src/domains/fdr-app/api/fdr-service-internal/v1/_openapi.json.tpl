{
  "openapi": "3.0.3",
  "info": {
    "title" : "FDR INTERNAL - Flussi di rendicontazione ${service}",
    "description" : "Manage FDR INTERNAL ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC ${service}",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "${host}/fdr-nodo/api/v1 - APIM"
    }
  ],
  "tags": [],
  "paths": {
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
      "GetXmlRendicontazioneResponse": {
        "type": "object",
        "properties": {
          "xmlRendicontazione": {
            "type": "string",
            "example": "Y2lhbwo="
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
