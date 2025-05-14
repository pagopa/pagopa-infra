{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa jwt token issuer service api",
    "description": "Microservice that handle JWT token creation and method to verify those tokens"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "tags": [
    {
      "name": "jwtIssuer",
      "description": "Api's used to generate new token and retrieve key to verify those generated tokens",
      "externalDocs": {
        "url": "https://TODO",
        "description": "Technical specifications"
      }
    }
  ],
  "paths": {
    "/.well-known/openid-configuration": {
      "get": {
        "tags": [
          "jwtIssuer"
        ],
        "operationId": "getOpenidInfo",
        "summary": "Openid configuration info",
        "description": "Return openId well-known configuration info (used to provide azure api management policy configuration endpoint https://learn.microsoft.com/en-us/azure/api-management/validate-jwt-policy#elements)",
        "responses": {
          "200": {
            "description": "Token created successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/OpenIDDiscoveryResponse"
                }
              }
            }
          },
          "404": {
            "description": "Configuration not found",
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
    "/tokens/keys": {
      "get": {
        "tags": [
          "jwtIssuer"
        ],
        "operationId": "getTokenPublicKeys",
        "summary": "Retrieve jwt public signature verifier keys",
        "description": "Retrieve jwt public signature verifier keys in jwks format",
        "responses": {
          "200": {
            "description": "Keys retrieved successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JWKSResponse"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
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
      "JWKSResponse": {
        "type": "object",
        "description": "JSON Web Key Set response properties, see here https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-key-set-properties",
        "properties": {
          "keys": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/JWKResponse"
            }
          }
        }
      },
      "JWKResponse": {
        "type": "object",
        "description": "JSON Web Key response object",
        "oneOf": [
          {
            "$ref": "#/components/schemas/RsaJwkResponse"
          }
        ]
      },
      "RsaJwkResponse": {
        "type": "object",
        "properties": {
          "alg": {
            "type": "string",
            "description": "cryptographic algorithm used with the key"
          },
          "kty": {
            "type": "string",
            "description": "the family of cryptographic used with the key. fixed value `RSA`",
            "enum": [
              "RSA"
            ]
          },
          "use": {
            "type": "string",
            "description": "how the key was meant to be used"
          },
          "n": {
            "type": "string",
            "description": "Modulus of RSA key"
          },
          "e": {
            "type": "string",
            "description": "Exponent for RSA key"
          },
          "kid": {
            "type": "string",
            "description": "unique identifier for the key"
          }
        },
        "required": [
          "alg",
          "kty",
          "use",
          "n",
          "e",
          "kid"
        ]
      },
      "OpenIDDiscoveryResponse": {
        "type": "object",
        "description": "The OpenID configuration document as defined by the specification: http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata (used to configure this service with openid validators)",
        "properties": {
          "userinfo_endpoint": {
            "type": "string",
            "example": "https://example.org/oidc/v1/userinfo",
            "description": "URL of the user info endpoint"
          },
          "jwks_uri": {
            "type": "string",
            "example": "https://example.org/oidc/v1/keys",
            "description": "URL of JSON Web Key Set document"
          },
          "scopes_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "openid"
            ],
            "description": "list of the OAuth 2.0 scope values that this server supports"
          },
          "subject_types_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "pairwise"
            ],
            "description": "list of the Subject Identifier types that this OP supports"
          },
          "token_endpoint": {
            "type": "string",
            "example": "https://example.org/oidc/v1/token",
            "description": "URL of the OAuth 2.0 token endpoint"
          },
          "id_token_signing_alg_values_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "RS256",
              "HS256"
            ],
            "description": "list of the JWS signing algorithms (alg values) supported by the OP for the ID Token to encode the Claims in a JWT"
          },
          "response_types_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "code",
              "token_id_token"
            ],
            "description": "ist of the OAuth 2.0 response_type values that this OP supports"
          },
          "claims_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "sub",
              "iss",
              "auth_time",
              "acr"
            ],
            "description": "list of the Claim Names of the Claims that the OpenID Provider MAY be able to supply values for"
          },
          "authorization_endpoint": {
            "type": "string",
            "example": "https://example.org/oidc/v1/authorize",
            "description": "URL of the OAuth 2.0 authorization endpoint"
          },
          "issuer": {
            "type": "string",
            "example": "https://example.org",
            "description": "the identifier of the token's issuer. This is identical to the 'iss' Claim value in ID Tokens"
          },
          "grant_types_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "authorization_code",
              "implicit"
            ],
            "description": "list of the OAuth 2.0 Grant Type values that this OP supports"
          },
          "acr_values_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "urn:mace:incommon:iap:silver"
            ],
            "description": "list of the Authentication Context Class References that this OP supports"
          },
          "token_endpoint_auth_methods_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "client_secret_basic"
            ],
            "description": "list of Client Authentication methods supported by this Token Endpoint"
          },
          "token_endpoint_auth_signing_alg_values_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "RS256"
            ],
            "description": "list of the JWS signing algorithms (alg values) supported by the Token Endpoint for the signature on the JWT used to authenticate the Client at the Token Endpoint for the private_key_jwt and client_secret_jwt authentication methods. Servers SHOULD support RS256. The value none MUST NOT be used."
          },
          "display_values_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "page",
              "popup"
            ],
            "description": "list of the display parameter values that the OpenID Provider supports"
          },
          "claim_types_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "normal"
            ],
            "description": "list of the Claim Types that the OpenID Provider supports"
          },
          "service_documentation": {
            "type": "string",
            "example": "https://openid.net/specs/openid-connect-core-1_0.html#CodeFlowAuth",
            "description": "URL of a page containing human-readable information that developers might want or need to know when using the OpenID Provider"
          },
          "ui_locales_supported": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "example": [
              "en-US",
              "en-GB"
            ],
            "description": "Languages and scripts supported for the user interface"
          }
        },
        "required": [
          "authorization_endpoint",
          "id_token_signing_alg_values_supported",
          "issuer",
          "jwks_uri",
          "response_types_supported",
          "subject_types_supported",
          "token_endpoint"
        ]
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
            "default": "about:blank",
            "example": "https://example.com/problem/constraint-violation"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "status": {
            "$ref": "#/components/schemas/HttpStatusCode"
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the\nproblem.",
            "example": "There was an error processing the request"
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 200
      }
    }
  }
}