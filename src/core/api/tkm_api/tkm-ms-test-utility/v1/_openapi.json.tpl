{
  "openapi": "3.0.1",
  "info": {
    "title": "tkm-ms-test-utility",
    "description": "RESTful APIs provided for test utility",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${host}/tkmtestutility"
    }
  ],
  "tags": [
    {
      "name": "authenticated",
      "description": "exposed via APIM"
    },
    {
      "name": "restricted",
      "description": "only for internal use"
    }
  ],
  "paths": {
    "/read/write-queue": {
      "get": {
        "tags": [
          "authenticated"
        ],
        "summary": "API to read last messages from write queue",
        "operationId": "readFromWriteQueue",
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/QueueMessage"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request"
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    },
    "/read/delete-queue": {
      "get": {
        "tags": [
          "authenticated"
        ],
        "summary": "API to read last messages from delete queue",
        "operationId": "readFromDeleteQueue",
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/QueueMessage"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request"
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    },
    "/send/read-queue": {
      "post": {
        "tags": [
          "authenticated"
        ],
        "summary": "API to send messages to read queue",
        "operationId": "sendToReadQueue",
        "requestBody": {
          "content": {
            "text/plain": {
              "schema": {
                "type": "string"
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
                  "$ref": "#/components/schemas/QueueMessage"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request"
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    },
    "/send/delete-queue": {
      "post": {
        "tags": [
          "authenticated"
        ],
        "summary": "API to send messages to delete queue",
        "operationId": "sendToDeleteQueue",
        "requestBody": {
          "content": {
            "text/plain": {
              "schema": {
                "type": "string"
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
                  "$ref": "#/components/schemas/QueueMessage"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request"
          },
          "500": {
            "description": "Internal Server Error"
          }
        }
      }
    },
    "/par": {
      "post": {
        "tags": [
          "authenticated"
        ],
        "summary": "update or create card with a new set of par and tokens",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ParCreationRequest"
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
                  "$ref": "#/components/schemas/ParCreationResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "Internal server error"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "QueueMessage": {
        "type": "object",
        "properties": {
          "plainMessage": {
            "type": "string"
          },
          "encryptedMessage": {
            "type": "string"
          }
        }
      },
      "ParCreationRequest": {
        "type": "object",
        "properties": {
          "pan": {
            "type": "string",
            "minLength": 8,
            "maxLength": 19
          },
          "circuit": {
            "type": "string",
            "enum": [
              "VISA",
              "MASTERCARD",
              "AMEX"
            ]
          },
          "tokenNumber": {
            "type": "integer",
            "description": "Number of tokens to generate"
          }
        },
        "required": [
          "pan",
          "circuit"
        ]
      },
      "ParCreationResponse": {
        "type": "object",
        "properties": {
          "pan": {
            "type": "string"
          },
          "par": {
            "type": "string"
          },
          "circuit": {
            "type": "string",
            "enum": [
              "VISA",
              "MASTERCARD",
              "AMEX"
            ]
          },
          "tokens": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        },
        "required": [
          "pan",
          "par",
          "tokens"
        ]
      }
    }
  }
}