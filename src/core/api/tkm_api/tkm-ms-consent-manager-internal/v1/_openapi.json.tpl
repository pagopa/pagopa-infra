{
  "openapi": "3.0.1",
  "info": {
    "title": "tkm-ms-consent-manager-internal",
    "description": "RESTful APIs provided for consent management exposed to the issuers",
    "version": "1.2.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/consent": {
      "get": {
        "summary": "Get consent",
        "operationId": "getConsent",
        "parameters": [
          {
            "in": "header",
            "name": "Tax-Code",
            "schema": {
              "type": "string",
              "minLength": 16,
              "maxLength": 16
            },
            "required": true,
            "description": "User tax code"
          },
          {
            "in": "header",
            "name": "Pgp-Pan",
            "description": "Pan crypted with PGP",
            "schema": {
              "type": "string",
              "minLength": 64,
              "maxLength": 64
            },
            "required": false
          },
          {
            "in": "query",
            "name": "services",
            "schema": {
              "type": "array",
              "items": {
                "$ref": "#/components/schemas/ServiceEnum"
              }
            },
            "required": false,
            "description": "List of the service involved by the modified. If blank the changes is referred to all services",
            "example": "Service1,Service2,Service3"
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
                  "$ref": "#/components/schemas/ConsentResponse"
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
                  "$ref": "#/components/schemas/ConsentError"
                }
              }
            }
          },
          "401": {
            "description": "Access Denied",
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
                  "$ref": "#/components/schemas/ConsentError"
                }
              }
            }
          },
          "404": {
            "description": "Tax Code or Hpan not found",
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
      "Consent": {
        "required": [
          "consent"
        ],
        "type": "object",
        "properties": {
          "consent": {
            "$ref": "#/components/schemas/ConsentNoPartialEnum"
          },
          "pgpPan": {
            "type": "string",
            "description": "Pan crypted with PGP"
          },
          "services": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ServiceEnum"
            },
            "description": "List of the service involved by the modified. If blank the changes is referred to all services. This field is allowed only the the pan."
          }
        }
      },
      "ItemsResponse": {
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
            }
          }
        }
      },
      "ServiceConsent": {
        "type": "object",
        "required": [
          "consent",
          "service"
        ],
        "properties": {
          "consent": {
            "$ref": "#/components/schemas/ConsentNoPartialEnum"
          },
          "service": {
            "$ref": "#/components/schemas/ServiceEnum"
          }
        }
      },
      "ConsentError": {
        "required": [
          "statusCode",
          "message"
        ],
        "type": "object",
        "properties": {
          "statusCode": {
            "type": "integer",
            "description": "The code identifies the error",
            "example": 1002
          },
          "message": {
            "type": "string",
            "description": "Error description",
            "example": "Cannot give a partial consent after a global consent"
          }
        }
      },
      "ConsentResponse": {
        "required": [
          "consent",
          "lastUpdateDate"
        ],
        "type": "object",
        "properties": {
          "consent": {
            "$ref": "#/components/schemas/ConsentResponseEnum"
          },
          "lastUpdateDate": {
            "type": "string",
            "format": "date-time",
            "pattern": "dd/MM/yyyy HH:mm:ss"
          },
          "details": {
            "type": "array",
            "description": "Details of hash pan. Blank if consent is Allow or Deny",
            "items": {
              "$ref": "#/components/schemas/ItemsResponse"
            }
          }
        }
      },
      "ConsentNoPartialEnum": {
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
    },
    "securitySchemes": {
      "azureApiKey": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  },
  "security": [
    {
      "azureApiKey": []
    }
  ]
}