{
  "openapi": "3.0.1",
  "info": {
    "title": "tkm-ms-card-manager",
    "description": "RESTful API provided for parless cards retrieval",
    "version": "1.2.0"
  },
  "servers": [
    {
      "url": "https://${host}"
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
    "/parless-cards": {
      "get": {
        "tags": [
          "restricted"
        ],
        "summary": "Returns a number of parless cards",
        "operationId": "getParlessCards",
        "parameters": [
          {
            "name": "maxNumberOfCards",
            "in": "query",
            "description": "The number of cards to be returned",
            "required": true,
            "style": "form",
            "explode": true,
            "schema": {
              "type": "integer"
            }
          }
        ],
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
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ParlessCardListResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
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
                  "$ref": "#/components/schemas/CardError"
                }
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
    "/known-hashes": {
      "get": {
        "tags": [
          "restricted"
        ],
        "summary": "Returns a set of known hpans and htokens",
        "operationId": "getKnownHashes",
        "parameters": [
          {
            "name": "maxNumberOfRecord",
            "in": "query",
            "description": "The number of records to be returned",
            "required": false,
            "schema": {
              "type": "integer",
              "minimum": 10,
              "maximum": 1000000,
              "default": 100000
            }
          },
          {
            "name": "hpanOffset",
            "in": "query",
            "description": "The offset from which to retrieve hpans",
            "required": false,
            "schema": {
              "type": "integer",
              "minimum": 0,
              "default": 0
            }
          },
          {
            "name": "htokenOffset",
            "in": "query",
            "description": "The offset from which to retrieve htokens",
            "required": false,
            "schema": {
              "type": "integer",
              "minimum": 0,
              "default": 0
            }
          }
        ],
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
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/KnownHashesResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
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
                  "$ref": "#/components/schemas/CardError"
                }
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
    "/update-consent": {
      "put": {
        "tags": [
          "restricted"
        ],
        "summary": "Writes a message on write queue on consent changes",
        "operationId": "updateConsent",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ConsentUpdate"
              }
            }
          }
        },
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
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ParlessCardListResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
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
                  "$ref": "#/components/schemas/CardError"
                }
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
      "ParlessCardListResponse": {
        "type": "array",
        "items": {
          "$ref": "#/components/schemas/ParlessCardResponse"
        }
      },
      "ParlessCardResponse": {
        "type": "object",
        "properties": {
          "pan": {
            "type": "string"
          },
          "hpan": {
            "type": "string"
          },
          "circuit": {
            "type": "string"
          },
          "tokens": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ParlessCardToken"
            }
          }
        }
      },
      "ParlessCardToken": {
        "type": "object",
        "properties": {
          "token": {
            "type": "string"
          },
          "htoken": {
            "type": "string"
          }
        }
      },
      "CardError": {
        "required": [
          "errorCode",
          "description"
        ],
        "type": "object",
        "properties": {
          "errorCode": {
            "type": "string",
            "description": "The code identifies the error"
          },
          "description": {
            "type": "string",
            "description": "Error description",
            "example": [
              "maxNumberOfCards required"
            ]
          }
        }
      },
      "ConsentUpdate": {
        "required": [
          "consent",
          "taxCode"
        ],
        "type": "object",
        "properties": {
          "consent": {
            "$ref": "#/components/schemas/ConsentResponseEnum"
          },
          "details": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CardServiceConsent"
            },
            "description": "List of services with assigned consent type, divided by card. Only present if consent type is Partial"
          }
        }
      },
      "CardServiceConsent": {
        "required": [
          "hpan",
          "serviceConsents"
        ],
        "type": "object",
        "properties": {
          "hpan": {
            "type": "string",
            "minLength": 64,
            "maxLength": 64,
            "description": "Pan hash to specify a single card. If blank the changes is referred to all cards linked to tax code"
          },
          "serviceConsents": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ServiceConsent"
            },
            "description": "List of services with assigned consent type for the given card"
          }
        }
      },
      "ServiceConsent": {
        "required": [
          "consent",
          "service"
        ],
        "type": "object",
        "properties": {
          "consent": {
            "$ref": "#/components/schemas/ConsentRequestEnum"
          },
          "service": {
            "$ref": "#/components/schemas/ServiceEnum"
          }
        }
      },
      "KnownHashesResponse": {
        "required": [
          "hpans",
          "htokens"
        ],
        "type": "object",
        "properties": {
          "hpans": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "htokens": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "nextHpanOffset": {
            "type": "integer"
          },
          "nextHtokenOffset": {
            "type": "integer"
          }
        }
      },
      "ConsentRequestEnum": {
        "description": "Type of consent",
        "type": "string",
        "enum": [
          "Allow",
          "Deny"
        ]
      },
      "ConsentResponseEnum": {
        "description": "Allow and Deny are applied to all hpans. Partial indicates to check in the details",
        "type": "string",
        "enum": [
          "Allow",
          "Deny",
          "Partial"
        ]
      },
      "ServiceEnum": {
        "type": "string",
        "enum": [
          "FA",
          "BPD"
        ]
      }
    }
  }
}