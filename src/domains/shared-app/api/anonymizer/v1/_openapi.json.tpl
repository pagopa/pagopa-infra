{
  "openapi": "3.1.0",
  "info": {
    "title": "Anonymizer API",
    "version": "1.0.0"
  },
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Info"
        ],
        "summary": "Get application info",
        "description": "Liveness & readiness endpoint. Returns application name, version, and environment.",
        "operationId": "info_info_get",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoResponse"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      }
    },
    "/anonymize": {
      "post": {
        "tags": [
          "Anonymize"
        ],
        "summary": "Anonymize text",
        "description": "Anonymizes the provided text using Presidio.",
        "operationId": "anonymize_endpoint_anonymize_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/AnonymizeRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AnonymizeResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "422": {
            "description": "Unprocessable Content",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ValidationErrorModel"
                  }
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
      "InfoResponse": {
        "title": "InfoResponse",
        "required": [
          "name",
          "version",
          "environment"
        ],
        "type": "object",
        "properties": {
          "name": {
            "title": "Name",
            "type": "string"
          },
          "version": {
            "title": "Version",
            "type": "string"
          },
          "environment": {
            "title": "Environment",
            "type": "string"
          }
        }
      },
      "ErrorResponse": {
        "title": "ErrorResponse",
        "required": [
          "error"
        ],
        "type": "object",
        "properties": {
          "error": {
            "title": "Error",
            "type": "string"
          }
        }
      },
      "AnonymizeResponse": {
        "title": "AnonymizeResponse",
        "required": [
          "text"
        ],
        "type": "object",
        "properties": {
          "text": {
            "title": "Text",
            "type": "string",
            "description": "Anonymized text"
          }
        }
      },
      "AnonymizeRequest": {
        "title": "AnonymizeRequest",
        "required": [
          "text"
        ],
        "type": "object",
        "properties": {
          "text": {
            "title": "Text",
            "type": "string",
            "description": "Text to be anonymized"
          }
        }
      },
      "ValidationErrorModel": {
        "title": "ValidationErrorModel",
        "type": "object",
        "properties": {
          "loc": {
            "title": "Location",
            "anyOf": [
              {
                "type": "array",
                "items": {
                  "type": "string"
                }
              },
              {
                "type": "null"
              }
            ],
            "description": "the error's location as a list. ",
            "default": null
          },
          "msg": {
            "title": "Message",
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "description": "a computer-readable identifier of the error type.",
            "default": null
          },
          "type_": {
            "title": "Error Type",
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "description": "a human readable explanation of the error.",
            "default": null
          },
          "ctx": {
            "title": "Error context",
            "anyOf": [
              {
                "type": "object",
                "additionalProperties": true
              },
              {
                "type": "null"
              }
            ],
            "description": "an optional object which contains values required to render the error message.",
            "default": null
          }
        }
      }
    },
    "securitySchemes": null
  },
  "tags": [
    {
      "name": "Info",
      "description": "Liveness & readiness endpoints"
    },
    {
      "name": "Anonymize",
      "description": "Text anonymization endpoints"
    }
  ]
}