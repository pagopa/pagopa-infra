{
  "openapi": "3.0.3",
  "info": {
    "title": "pagopa-platform-mcp — Control Plane API (modelless)",
    "version": "0.1.0",
    "description": "REST control-plane API for the QA MCP **catalog** (modelless variant). This complements the MCP protocol surface (JSON-RPC over Streamable HTTP). It exposes catalog browsing, tenant configuration, asset manifests, and **install descriptors** for the `hard install` flow. The catalog **distributes** assets and **executes nothing**: it hosts no model, performs no inference, and runs no skills. All reasoning and skill execution happen in the CLIENT's local model. Authentication is Azure AD / OIDC (OAuth2). All endpoints except /health require a valid Bearer token.\n",
    "contact": {
      "name": "QA Platform Team"
    },
    "license": {
      "name": "Proprietary"
    }
  },
  "servers": [
    {
      "url": "https://${hostname}",
      "description": "Corporate internal endpoint (behind API Management)"
    }
  ],
  "security": [
    {
      "bearerAuth": [
      ]
    }
  ],
  "tags": [
    {
      "name": "health"
    },
    {
      "name": "assets"
    },
    {
      "name": "backoffice"
    },
    {
      "name": "mcp"
    }
  ],
  "paths": {
    "/health": {
      "get": {
        "tags": [
          "health"
        ],
        "summary": "Liveness and readiness probe",
        "security": [

        ],
        "responses": {
          "200": {
            "description": "Service healthy",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Health"
                }
              }
            }
          }
        }
      }
    },
    "/assets": {
      "get": {
        "tags": [
          "assets"
        ],
        "summary": "List or search catalog assets",
        "parameters": [
          {
            "in": "query",
            "name": "kind",
            "schema": {
              "type": "string"
            },
            "description": "Restrict results to an asset kind."
          },
          {
            "in": "query",
            "name": "q",
            "schema": {
              "type": "string"
            },
            "description": "Case-insensitive search across id, name, and description."
          }
        ],
        "responses": {
          "200": {
            "description": "Matching catalog assets",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/AssetSummary"
                  }
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          }
        }
      }
    },
    "/assets/install": {
      "get": {
        "tags": [
          "assets"
        ],
        "summary": "Get install descriptors for one or more assets",
        "parameters": [
          {
            "in": "query",
            "name": "asset_ids",
            "required": true,
            "style": "form",
            "explode": true,
            "schema": {
              "type": "array",
              "items": {
                "type": "string"
              }
            },
            "description": "Asset IDs. Dependencies are included transitively."
          }
        ],
        "responses": {
          "200": {
            "description": "Install descriptors in dependency resolution order",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/InstallDescriptor"
                  }
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/assets/{asset_id}": {
      "get": {
        "tags": [
          "assets"
        ],
        "summary": "Get an asset manifest",
        "parameters": [
          {
            "$ref": "#/components/parameters/AssetId"
          }
        ],
        "responses": {
          "200": {
            "description": "Asset manifest",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AssetManifest"
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/assets/{asset_id}/install": {
      "get": {
        "tags": [
          "assets"
        ],
        "summary": "Get install descriptors for an asset and its dependencies",
        "parameters": [
          {
            "$ref": "#/components/parameters/AssetId"
          }
        ],
        "responses": {
          "200": {
            "description": "Install descriptors in dependency resolution order",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/InstallDescriptor"
                  }
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/assets/{asset_id}/ephemeral": {
      "get": {
        "tags": [
          "assets"
        ],
        "summary": "Get ephemeral load descriptors for an asset and its dependencies",
        "parameters": [
          {
            "$ref": "#/components/parameters/AssetId"
          }
        ],
        "responses": {
          "200": {
            "description": "Ephemeral descriptors in dependency resolution order",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/EphemeralDescriptor"
                  }
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/assets/check-updates": {
      "post": {
        "tags": [
          "assets"
        ],
        "summary": "Find installed assets that are outdated or missing",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CheckUpdatesRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Assets requiring attention",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/CheckUpdatesResult"
                  }
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          },
          "500": {
            "$ref": "#/components/responses/InternalError"
          }
        }
      }
    },
    "/admin/reload": {
      "post": {
        "tags": [
          "backoffice"
        ],
        "summary": "Reload catalog manifests and publish changed-asset events",
        "description": "Requires the `admin` role.",
        "responses": {
          "200": {
            "description": "Catalog reloaded",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ReloadResult"
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          },
          "403": {
            "$ref": "#/components/responses/Forbidden"
          },
          "422": {
            "$ref": "#/components/responses/UnprocessableEntity"
          }
        }
      }
    },
    "/events/publish": {
      "post": {
        "tags": [
          "backoffice"
        ],
        "summary": "Publish an event to connected SSE clients",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PublishEventRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Event published",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "required": [
                    "delivered"
                  ],
                  "properties": {
                    "delivered": {
                      "type": "integer"
                    }
                  }
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          }
        }
      }
    },
    "/events": {
      "get": {
        "tags": [
          "backoffice"
        ],
        "summary": "Subscribe to catalog events over Server-Sent Events",
        "responses": {
          "200": {
            "description": "SSE stream of event envelopes, with periodic keepalive comments.",
            "content": {
              "text/event-stream": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          }
        }
      }
    },
    "/mcp": {
      "post": {
        "tags": [
          "mcp"
        ],
        "summary": "Handle an MCP JSON-RPC request",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/JSONRPCRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "JSON-RPC response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object"
                }
              }
            }
          },
          "204": {
            "description": "JSON-RPC notification processed without a response"
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "JWT",
        "description": "Required unless MCP_AUTH_DISABLED=1. The current implementation accepts development tokens in the form dev.<tenant_id>.<subject>.<role>.\n"
      }
    },
    "parameters": {
      "AssetId": {
        "in": "path",
        "name": "asset_id",
        "required": true,
        "schema": {
          "type": "string"
        }
      }
    },
    "responses": {
      "Unauthorized": {
        "description": "Missing Bearer token"
      },
      "Forbidden": {
        "description": "Authenticated caller lacks the required role"
      },
      "NotFound": {
        "description": "Asset not found"
      },
      "UnprocessableEntity": {
        "description": "Catalog reload failed; the active catalog is unchanged"
      },
      "InternalError": {
        "description": "Internal server error"
      }
    },
    "schemas": {
      "Health": {
        "type": "object",
        "required": [
          "status",
          "version",
          "uptime_s"
        ],
        "properties": {
          "status": {
            "type": "string",
            "example": "ok"
          },
          "version": {
            "type": "string"
          },
          "uptime_s": {
            "type": "integer"
          }
        }
      },
      "AssetSummary": {
        "type": "object",
        "required": [
          "id",
          "kind",
          "name",
          "version",
          "visibility",
          "description",
          "dependencies"
        ],
        "properties": {
          "id": {
            "type": "string"
          },
          "kind": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "visibility": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "dependencies": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "AssetManifest": {
        "allOf": [
          {
            "$ref": "#/components/schemas/AssetSummary"
          },
          {
            "type": "object",
            "required": [
              "digest",
              "body_ref",
              "install"
            ],
            "properties": {
              "digest": {
                "type": "string",
                "example": "sha256:abcd1234"
              },
              "body_ref": {
                "type": "string"
              },
              "install": {
                "$ref": "#/components/schemas/InstallSpec"
              }
            }
          }
        ]
      },
      "InstallSpec": {
        "type": "object",
        "required": [
          "target_path",
          "files",
          "frontmatter_anchor"
        ],
        "properties": {
          "target_path": {
            "type": "string"
          },
          "files": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "frontmatter_anchor": {
            "type": "boolean"
          }
        }
      },
      "EphemeralDescriptor": {
        "type": "object",
        "required": [
          "id",
          "kind",
          "source_version",
          "source_digest",
          "target_path",
          "content",
          "files"
        ],
        "properties": {
          "id": {
            "type": "string"
          },
          "kind": {
            "type": "string"
          },
          "source_version": {
            "type": "string"
          },
          "source_digest": {
            "type": "string"
          },
          "target_path": {
            "type": "string"
          },
          "content": {
            "type": "string"
          },
          "files": {
            "type": "array",
            "items": {
            }
          }
        }
      },
      "InstallDescriptor": {
        "allOf": [
          {
            "$ref": "#/components/schemas/EphemeralDescriptor"
          },
          {
            "type": "object",
            "required": [
              "encoding",
              "bom",
              "replace_existing"
            ],
            "properties": {
              "encoding": {
                "type": "string",
                "example": "utf-8"
              },
              "bom": {
                "type": "boolean"
              },
              "replace_existing": {
                "type": "boolean"
              }
            }
          }
        ]
      },
      "InstalledAssetRef": {
        "type": "object",
        "required": [
          "id"
        ],
        "properties": {
          "id": {
            "type": "string"
          },
          "version": {
            "type": "string",
            "nullable": true
          },
          "digest": {
            "type": "string",
            "nullable": true
          }
        }
      },
      "CheckUpdatesRequest": {
        "type": "object",
        "required": [
          "installed"
        ],
        "properties": {
          "installed": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstalledAssetRef"
            }
          }
        }
      },
      "CheckUpdatesResult": {
        "type": "object",
        "required": [
          "id",
          "status"
        ],
        "properties": {
          "id": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "outdated",
              "not_found"
            ]
          },
          "kind": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "installed_version": {
            "type": "string",
            "nullable": true
          },
          "current_version": {
            "type": "string"
          },
          "installed_digest": {
            "type": "string",
            "nullable": true
          },
          "current_digest": {
            "type": "string"
          }
        }
      },
      "ReloadResult": {
        "type": "object",
        "required": [
          "status",
          "previous_count",
          "asset_count",
          "updated_assets",
          "notified"
        ],
        "properties": {
          "status": {
            "type": "string",
            "example": "ok"
          },
          "previous_count": {
            "type": "integer"
          },
          "asset_count": {
            "type": "integer"
          },
          "updated_assets": {
            "type": "integer"
          },
          "notified": {
            "type": "integer"
          }
        }
      },
      "PublishEventRequest": {
        "type": "object",
        "required": [
          "event_type"
        ],
        "properties": {
          "event_type": {
            "type": "string"
          },
          "payload": {
            "nullable": true,
            "oneOf": [
              {
                "type": "object"
              },
              {
                "type": "array"
              },
              {
                "type": "string"
              }
            ]
          }
        }
      },
      "JSONRPCRequest": {
        "type": "object",
        "required": [
          "jsonrpc",
          "method"
        ],
        "properties": {
          "jsonrpc": {
            "type": "string",
            "enum": [
              "2.0"
            ]
          },
          "id": {
            "oneOf": [
              {
                "type": "integer"
              },
              {
                "type": "string"
              }
            ],
            "nullable": true
          },
          "method": {
            "type": "string"
          },
          "params": {
            "nullable": true
          }
        }
      }
    }
  }
}
