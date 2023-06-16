{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition - Enrolled EC",
    "version": "0.0.1"
  },
  "servers": [
    {
      "url": "${host}",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/organizations/domains/{domain}": {
      "get": {
        "tags": [
          "Enrolled EC API"
        ],
        "summary": "Get EC list enrolled to a domain.",
        "operationId": "getEnrolledEC",
        "parameters": [
          {
            "name": "domain",
            "in": "path",
            "description": "The subscribing domain.",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Operation executed successfully.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EnrolledCreditorInstitutions"
                }
              }
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
      "EnrolledCreditorInstitutions": {
        "type": "object",
        "properties": {
          "creditor_institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/EnrolledCreditorInstitution"
            }
          }
        }
      },
      "EnrolledCreditorInstitution": {
        "type": "object",
        "properties": {
          "organization_fiscal_code": {
            "type": "string"
          },
          "segregation_codes": {
            "type": "string"
          }
        }
      }
    }
  }
}