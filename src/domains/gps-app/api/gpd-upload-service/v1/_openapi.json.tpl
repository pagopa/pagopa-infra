{
  "openapi": "3.0.1",
  "info": {
    "title": "pagopa-gpd-upload",
    "version": "0.0.1"
  },
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Base"
        ],
        "summary": "health check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AppInfo"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "allOf": [],
                  "anyOf": [],
                  "oneOf": []
                }
              }
            }
          },
          "403": {
            "description": "Forbidden",
            "content": {
              "application/json": {
                "schema": {
                  "allOf": [],
                  "anyOf": [],
                  "oneOf": []
                }
              }
            }
          },
          "429": {
            "description": "Too many requests",
            "content": {
              "application/json": {
                "schema": {
                  "allOf": [],
                  "anyOf": [],
                  "oneOf": []
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{organizationFiscalCode}/debtpositions/file": {
      "post": {
        "tags": [
          "Massive Upload"
        ],
        "summary": "The Organization creates the debt positions listed in the file.",
        "operationId": "createMassivePositions",
        "parameters": [
          {
            "name": "organizationFiscalCode",
            "in": "path",
            "description": "The organization fiscal code",
            "required": true,
            "schema": {
              "minLength": 1,
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              },
              "encoding": {
                "file": {
                  "contentType": "application/octet-stream"
                }
              }
            }
          },
          "required": true
        },
        "responses": {
          "202": {
            "description": "Request accepted."
          },
          "400": {
            "description": "Malformed request.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "content": {
              "application/json": {
                "schema": {
                  "allOf": [],
                  "anyOf": [],
                  "oneOf": []
                }
              }
            }
          },
          "409": {
            "description": "Conflict: duplicate file found.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/organizations/{organizationFiscalCode}/debtpositions/file/{fileId}/status": {
      "get": {
        "tags": [
          "Massive Upload"
        ],
        "summary": "Returns the upload status of debt positions uploaded via file.",
        "operationId": "createMassivePositions_1",
        "parameters": [
          {
            "name": "organizationFiscalCode",
            "in": "path",
            "description": "The organization fiscal code",
            "required": true,
            "schema": {
              "minLength": 1,
              "type": "string"
            }
          },
          {
            "name": "fileId",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "minLength": 1,
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Upload found.",
            "content": {
              "application/json": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "Malformed request.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "content": {
              "application/json": {
                "schema": {
                  "allOf": [],
                  "anyOf": [],
                  "oneOf": []
                }
              }
            }
          },
          "404": {
            "description": "Upload not found.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
      "AppInfo": {
        "type": "object"
      },
      "ProblemJson": {
        "type": "object",
        "description": "Object returned as response in case of an error."
      }
    }
  }
}
