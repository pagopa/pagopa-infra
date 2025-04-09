{
  "openapi": "3.0.1",
  "info": {
    "title": "pagopa-fdr-2-event-hub API",
    "description": "A Microservice for the ingestion of FDR data flows into FdR QI",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "${hostname}/fdr-2-event-hub/api/v1 - APIM",
      "description": "Default server url"
    }
  ],
  "tags": [
    {
      "description": "Application info APIs",
      "name": "Home"
    },
    {
      "description": "Recover one or more unprocessed FDR data flows",
      "name": "Recovery"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "summary": "Return OK if application is started",
        "operationId": "Info",
        "responses": {
          "200": {
            "description": "Successful response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ],
        "tags": [
          "Home"
        ]
      }
    },
    "/notify/fdr": {
      "post": {
        "summary": "Blob recovery notification",
        "operationId": "HTTPBlobRecovery",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "string"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Request processed successfully"
          },
          "207": {
            "description": "Multi-Status"
          },
          "400": {
            "description": "Bad Request"
          },
          "404": {
            "description": "Not Found"
          },
          "422": {
            "description": "Unprocessable Entity"
          },
          "503": {
            "description": "Service Unavailable"
          },
          "500": {
            "description": "Internal Server Error"
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ],
        "tags": [
          "Recovery"
        ]
      }
    }
  },
  "components": {
    "securitySchemes": {
      "ApiKey": {
        "description": "The API key to access this function app.",
        "in": "header",
        "name": "Ocp-Apim-Subscription-Key",
        "type": "apiKey"
      }
    }
  }
}