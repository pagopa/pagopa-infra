{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition - Iuv Generator",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "http://localhost:7071",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/organizations/{organizationfiscalcode}/iuv": {
      "post": {
        "tags": [
          "Iuv Generator API"
        ],
        "summary": "Generate a unique IUV.",
        "operationId": "generateIUV",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "The fiscal code of the organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/IuvGenerationModel"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created a valid iuv.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/IuvGenerationModelResponse"
                }
              }
            }
          },
          "400": {
            "description": "Malformed request.",
            "content": {
              "application/json": {}
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {}
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "IuvGenerationModel": {
        "required": [
          "auxDigit",
          "segregationCode"
        ],
        "type": "object",
        "properties": {
          "segregationCode": {
            "type": "integer",
            "format": "int64"
          },
          "auxDigit": {
            "type": "integer",
            "format": "int64"
          }
        }
      },
      "IuvGenerationModelResponse": {
        "type": "object",
        "properties": {
          "iuv": {
            "type": "string"
          }
        }
      }
    }
  }
}
