{
  "openapi": "3.0.1",
  "info": {
    "title": "tkm-acquirer-apis",
    "description": "RESTful APIs provided to acquirers",
    "version": "1.1.1"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/bin-ranges/links": {
      "get": {
        "summary": "Get Temporary link to download bin range details",
        "operationId": "getBinRangeLink",
        "responses": {
          "200": {
            "description": "Success",
            "headers": {
              "Request-Id": {
                "schema": {
                  "type": "string",
                  "minLength": 16,
                  "maxLength": 16,
                  "example": "937aee55bbabd29b"
                },
                "required": true
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/LinksResponse"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "headers": {
              "Request-Id": {
                "schema": {
                  "type": "string",
                  "minLength": 16,
                  "maxLength": 16,
                  "example": "937aee55bbabd29b"
                },
                "required": true
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "headers": {
              "Request-Id": {
                "schema": {
                  "type": "string",
                  "minLength": 16,
                  "maxLength": 16,
                  "example": "937aee55bbabd29b"
                },
                "required": true
              }
            }
          }
        }
      }
    },
    "/known-hashes/links": {
      "get": {
        "summary": "Get temporary links to download known hpans and htokens",
        "operationId": "getKnownHashes",
        "responses": {
          "200": {
            "description": "Success",
            "headers": {
              "Request-Id": {
                "schema": {
                  "type": "string",
                  "minLength": 16,
                  "maxLength": 16,
                  "example": "937aee55bbabd29b"
                },
                "required": true
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/LinksResponse"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "headers": {
              "Request-Id": {
                "schema": {
                  "type": "string",
                  "minLength": 16,
                  "maxLength": 16,
                  "example": "937aee55bbabd29b"
                },
                "required": true
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "headers": {
              "Request-Id": {
                "schema": {
                  "type": "string",
                  "minLength": 16,
                  "maxLength": 16,
                  "example": "937aee55bbabd29b"
                },
                "required": true
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "LinksResponse": {
        "required": [
          "fileLinks"
        ],
        "type": "object",
        "properties": {
          "fileLinks": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "List of links needed to download file"
          },
          "numberOfFiles": {
            "type": "integer"
          },
          "availableUntil": {
            "type": "string",
            "format": "date-time",
            "pattern": "dd/MM/yyyy HH:mm:ss"
          },
          "generationDate": {
            "type": "string",
            "format": "date-time",
            "pattern": "dd/MM/yyyy HH:mm:ss"
          },
          "expiredIn": {
            "type": "number",
            "description": "link expiration in second"
          }
        }
      }
    }
  }
}