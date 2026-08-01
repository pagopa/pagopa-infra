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
      "azureAd": []
    }
  ],
  "tags": [
    {
      "name": "health"
    },
    {
      "name": "skills"
    },
    {
      "name": "prompts"
    },
    {
      "name": "agents"
    },
    {
      "name": "install"
    },
    {
      "name": "tenants"
    },
    {
      "name": "metrics"
    }
  ],
  "paths": {
    "/health": {
      "get": {
        "tags": [
          "health"
        ],
        "summary": "Liveness/readiness probe",
        "security": [],
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
    "/metrics": {
      "get": {
        "tags": [
          "metrics"
        ],
        "summary": "Prometheus-style metrics (also exported to App Insights)",
        "responses": {
          "200": {
            "description": "Metrics exposition",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "/skills": {
      "get": {
        "tags": [
          "skills"
        ],
        "summary": "List skills visible to the caller's tenant",
        "parameters": [
          {
            "in": "query",
            "name": "visibility",
            "schema": {
              "type": "string",
              "enum": [
                "public",
                "private",
                "all"
              ]
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Skill catalog",
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
          }
        }
      }
    },
    "/skills/{skillId}": {
      "get": {
        "tags": [
          "skills"
        ],
        "summary": "Get skill manifest (active version)",
        "parameters": [
          {
            "$ref": "#/components/parameters/AssetId"
          },
          {
            "in": "query",
            "name": "version",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Skill manifest",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SkillManifest"
                }
              }
            }
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/skills/{skillId}/install": {
      "get": {
        "tags": [
          "install"
        ],
        "summary": "Get the INSTALL DESCRIPTOR for a skill (hard install)",
        "description": "Returns the descriptor the client uses to **materialize** the skill as a local file (e.g. `.github/skills/<id>/SKILL.md`), including target path, content, `source_version`, and `source_digest` for later drift detection. The server executes nothing.\n",
        "parameters": [
          {
            "$ref": "#/components/parameters/AssetId"
          },
          {
            "in": "query",
            "name": "version",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Install descriptor",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InstallDescriptor"
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
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/prompts": {
      "get": {
        "tags": [
          "prompts"
        ],
        "summary": "List prompt templates visible to the tenant",
        "responses": {
          "200": {
            "description": "Prompt catalog",
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
          }
        }
      }
    },
    "/prompts/{promptId}": {
      "get": {
        "tags": [
          "prompts"
        ],
        "summary": "Resolve a prompt template (base + tenant + request overrides)",
        "description": "Returns the resolved prompt text. The client feeds it to its LOCAL model; the server never runs the prompt.\n",
        "parameters": [
          {
            "in": "path",
            "name": "promptId",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Resolved prompt",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PromptResolveResponse"
                }
              }
            }
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/agents": {
      "get": {
        "tags": [
          "agents"
        ],
        "summary": "List agent definitions visible to the tenant",
        "responses": {
          "200": {
            "description": "Agent catalog",
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
          }
        }
      }
    },
    "/agents/{agentId}": {
      "get": {
        "tags": [
          "agents"
        ],
        "summary": "Get an agent DEFINITION (orchestrated client-side by the local model)",
        "description": "The server returns the agent definition as a versioned resource. It does NOT execute the agent. Orchestration and reasoning are performed by the client using its local model.\n",
        "parameters": [
          {
            "in": "path",
            "name": "agentId",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "query",
            "name": "version",
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Agent definition",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AgentDefinition"
                }
              }
            }
          },
          "404": {
            "$ref": "#/components/responses/NotFound"
          }
        }
      }
    },
    "/tenants/{tenantId}/overrides": {
      "get": {
        "tags": [
          "tenants"
        ],
        "summary": "Get tenant overrides (customization)",
        "parameters": [
          {
            "$ref": "#/components/parameters/TenantId"
          }
        ],
        "responses": {
          "200": {
            "description": "Overrides",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TenantOverrides"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "tenants"
        ],
        "summary": "Upsert tenant overrides (admin role required)",
        "parameters": [
          {
            "$ref": "#/components/parameters/TenantId"
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TenantOverrides"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TenantOverrides"
                }
              }
            }
          },
          "403": {
            "$ref": "#/components/responses/Forbidden"
          }
        }
      }
    },
    "/v1/assets/check-updates": {
      "post": {
        "tags": [
          "install"
        ],
        "summary": "Check installed assets for updates",
        "description": "Compare a list of installed assets (id, optional version and optional digest) against the catalog and return only entries that are not up-to-date. Each returned entry has a `status` of `outdated` or `not_found` and includes helpful fields for the client to present and act on.\n",
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
            "description": "Assets requiring attention (outdated / not_found)",
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
          "400": {
            "$ref": "#/components/responses/BadRequest"
          },
          "401": {
            "$ref": "#/components/responses/Unauthorized"
          },
          "403": {
            "$ref": "#/components/responses/Forbidden"
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "azureAd": {
        "type": "oauth2",
        "description": "Azure AD (Entra ID) OAuth2 / OIDC",
        "flows": {
          "clientCredentials": {
            "tokenUrl": "https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token",
            "scopes": {
              "api://pagopa-platform-mcp/.default": "Default access scope"
            }
          }
        }
      }
    },
    "parameters": {
      "AssetId": {
        "in": "path",
        "name": "skillId",
        "required": true,
        "schema": {
          "type": "string"
        }
      },
      "TenantId": {
        "in": "path",
        "name": "tenantId",
        "required": true,
        "schema": {
          "type": "string",
          "format": "uuid"
        }
      }
    },
    "responses": {
      "BadRequest": {
        "description": "Invalid request",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/Error"
            }
          }
        }
      },
      "Unauthorized": {
        "description": "Missing or invalid token",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/Error"
            }
          }
        }
      },
      "Forbidden": {
        "description": "Authenticated but not authorized (RBAC)",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/Error"
            }
          }
        }
      },
      "NotFound": {
        "description": "Asset not found",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/Error"
            }
          }
        }
      },
      "RateLimited": {
        "description": "Too many requests (per-tenant quota)",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/Error"
            }
          }
        }
      }
    },
    "schemas": {
      "Health": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "example": "ok"
          },
          "version": {
            "type": "string",
            "example": "0.1.0"
          },
          "uptime_s": {
            "type": "integer",
            "example": 12345
          }
        }
      },
      "AssetSummary": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "kind": {
            "type": "string",
            "enum": [
              "agent",
              "skill",
              "prompt",
              "policy",
              "plugin"
            ]
          },
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string",
            "example": "1.2.0"
          },
          "visibility": {
            "type": "string",
            "enum": [
              "public",
              "private"
            ]
          },
          "description": {
            "type": "string"
          }
        }
      },
      "SkillManifest": {
        "type": "object",
        "description": "Manifest of a DISTRIBUTED skill asset. The catalog delivers it (load or install); the client's LOCAL model executes it. There is NO model field and NO server-side execution field (no entrypoint, isolation, resource_limits, or timeout).\n",
        "properties": {
          "id": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "digest": {
            "type": "string",
            "example": "sha256:…"
          },
          "inputs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ParamSpec"
            }
          },
          "outputs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ParamSpec"
            }
          },
          "body_ref": {
            "type": "string",
            "description": "Resource ref to the SKILL.md content"
          },
          "install": {
            "$ref": "#/components/schemas/InstallSpec"
          },
          "custom_params": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ParamSpec"
            }
          }
        }
      },
      "AgentDefinition": {
        "type": "object",
        "description": "Versioned agent definition served as a resource. Orchestrated client-side by the local model; the server does not run it.\n",
        "properties": {
          "id": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "role": {
            "type": "string"
          },
          "instructions": {
            "type": "string",
            "description": "Behavioural rules (Markdown)"
          },
          "handoffs": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "allowed_tools": {
            "type": "array",
            "items": {
              "type": "string"
            }
          }
        }
      },
      "ParamSpec": {
        "type": "object",
        "required": [
          "name",
          "type"
        ],
        "properties": {
          "name": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "string",
              "integer",
              "number",
              "boolean",
              "object",
              "array"
            ]
          },
          "required": {
            "type": "boolean",
            "default": false
          },
          "description": {
            "type": "string"
          },
          "default": {}
        }
      },
      "ResourceLimits": {
        "type": "object",
        "deprecated": true,
        "description": "Retained only for backward compatibility of old clients. The catalog runs nothing, so resource limits are not applied server-side.\n",
        "properties": {
          "cpu": {
            "type": "string",
            "example": "0.5"
          },
          "memory_mb": {
            "type": "integer",
            "example": 256
          },
          "max_output_bytes": {
            "type": "integer",
            "example": 1048576
          }
        }
      },
      "InstallSpec": {
        "type": "object",
        "description": "How the client materializes the asset on hard install.",
        "properties": {
          "target_path": {
            "type": "string",
            "example": ".github/skills/mermaid-flow/SKILL.md"
          },
          "files": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "frontmatter_anchor": {
            "type": "boolean",
            "default": true
          }
        }
      },
      "InstallDescriptor": {
        "type": "object",
        "description": "Everything the client needs to install an asset as a local file and later detect drift against the catalog.\n",
        "properties": {
          "id": {
            "type": "string"
          },
          "kind": {
            "type": "string",
            "enum": [
              "agent",
              "skill",
              "prompt",
              "policy",
              "plugin"
            ]
          },
          "source_version": {
            "type": "string",
            "example": "1.2.0"
          },
          "source_digest": {
            "type": "string",
            "example": "sha256:…"
          },
          "target_path": {
            "type": "string",
            "example": ".github/skills/mermaid-flow/SKILL.md"
          },
          "content": {
            "type": "string",
            "description": "File content to write locally"
          },
          "files": {
            "type": "array",
            "description": "Additional attachments (path + content)",
            "items": {
              "type": "object",
              "properties": {
                "path": {
                  "type": "string"
                },
                "content": {
                  "type": "string"
                }
              }
            }
          }
        }
      },
      "PromptResolveRequest": {
        "type": "object",
        "properties": {
          "arguments": {
            "type": "object",
            "additionalProperties": true
          },
          "overrides": {
            "type": "object",
            "additionalProperties": true
          }
        }
      },
      "PromptResolveResponse": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "content": {
            "type": "string"
          },
          "target_agent": {
            "type": "string",
            "nullable": true
          }
        }
      },
      "TenantOverrides": {
        "type": "object",
        "description": "Tenant customization. There is NO preferred_model and NO token quota, because the server performs no inference.\n",
        "properties": {
          "tenant_id": {
            "type": "string",
            "format": "uuid"
          },
          "style": {
            "type": "object",
            "additionalProperties": true
          },
          "skill_params": {
            "type": "object",
            "additionalProperties": true
          },
          "quotas": {
            "type": "object",
            "properties": {
              "requests_per_min": {
                "type": "integer"
              }
            }
          }
        }
      },
      "Error": {
        "type": "object",
        "properties": {
          "code": {
            "type": "string",
            "example": "forbidden"
          },
          "message": {
            "type": "string"
          },
          "request_id": {
            "type": "string"
          }
        }
      },
      "InstalledAssetRef": {
        "type": "object",
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
        },
        "required": [
          "id"
        ]
      },
      "CheckUpdatesRequest": {
        "type": "object",
        "properties": {
          "installed": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InstalledAssetRef"
            }
          }
        },
        "required": [
          "installed"
        ]
      },
      "CheckUpdatesResult": {
        "type": "object",
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
            "type": "string",
            "nullable": true
          },
          "name": {
            "type": "string",
            "nullable": true
          },
          "installed_version": {
            "type": "string",
            "nullable": true
          },
          "current_version": {
            "type": "string",
            "nullable": true
          },
          "installed_digest": {
            "type": "string",
            "nullable": true
          },
          "current_digest": {
            "type": "string",
            "nullable": true
          }
        }
      }
    }
  }
}
