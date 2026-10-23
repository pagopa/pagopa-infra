{
  "openapi": "3.0.3",
  "info": {
    "title": "QA Hub API",
    "version": "0.1.0"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/api/v1/health": {
      "get": {
        "tags": [
          "health"
        ],
        "summary": "Health",
        "operationId": "health_api_v1_health_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "additionalProperties": true,
                  "type": "object",
                  "title": "Response Health Api V1 Health Get"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/settings": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "Get Settings",
        "operationId": "get_settings_api_v1_bdd_settings_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SettingsOut"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "bdd"
        ],
        "summary": "Update Settings",
        "operationId": "update_settings_api_v1_bdd_settings_put",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SettingsUpdate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SettingsOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/settings/test": {
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Test Connection",
        "operationId": "test_connection_api_v1_bdd_settings_test_post",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "additionalProperties": true,
                  "type": "object",
                  "title": "Response Test Connection Api V1 Bdd Settings Test Post"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/projects": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "List Projects",
        "operationId": "list_projects_api_v1_bdd_projects_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/ProjectOut"
                  },
                  "type": "array",
                  "title": "Response List Projects Api V1 Bdd Projects Get"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Create Project",
        "operationId": "create_project_api_v1_bdd_projects_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ProjectCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProjectOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/projects/{project_id}": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "Get Project",
        "operationId": "get_project_api_v1_bdd_projects__project_id__get",
        "parameters": [
          {
            "name": "project_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Project Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProjectOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "bdd"
        ],
        "summary": "Update Project",
        "operationId": "update_project_api_v1_bdd_projects__project_id__put",
        "parameters": [
          {
            "name": "project_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Project Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ProjectUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProjectOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "bdd"
        ],
        "summary": "Delete Project",
        "operationId": "delete_project_api_v1_bdd_projects__project_id__delete",
        "parameters": [
          {
            "name": "project_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Project Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/projects/{project_id}/scenarios": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "List Project Scenarios",
        "operationId": "list_project_scenarios_api_v1_bdd_projects__project_id__scenarios_get",
        "parameters": [
          {
            "name": "project_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Project Id"
            }
          },
          {
            "name": "status",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Status",
              "type": "string",
              "nullable": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ScenarioOut"
                  },
                  "title": "Response List Project Scenarios Api V1 Bdd Projects  Project Id  Scenarios Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/scenarios": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "List All Scenarios",
        "operationId": "list_all_scenarios_api_v1_bdd_scenarios_get",
        "parameters": [
          {
            "name": "project_id",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Project Id",
              "type": "string",
              "format": "uuid",
              "nullable": true
            }
          },
          {
            "name": "status",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Status",
              "type": "string",
              "nullable": true
            }
          },
          {
            "name": "page",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "minimum": 1,
              "default": 1,
              "title": "Page"
            }
          },
          {
            "name": "page_size",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "maximum": 100,
              "minimum": 1,
              "default": 20,
              "title": "Page Size"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaginatedResponse_ScenarioOut_"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Create Scenario",
        "operationId": "create_scenario_api_v1_bdd_scenarios_post",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ScenarioCreate"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ScenarioOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/scenarios/{scenario_id}": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "Get Scenario",
        "operationId": "get_scenario_api_v1_bdd_scenarios__scenario_id__get",
        "parameters": [
          {
            "name": "scenario_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Scenario Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ScenarioOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "bdd"
        ],
        "summary": "Update Scenario",
        "operationId": "update_scenario_api_v1_bdd_scenarios__scenario_id__put",
        "parameters": [
          {
            "name": "scenario_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Scenario Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ScenarioUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ScenarioOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "bdd"
        ],
        "summary": "Delete Scenario",
        "operationId": "delete_scenario_api_v1_bdd_scenarios__scenario_id__delete",
        "parameters": [
          {
            "name": "scenario_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Scenario Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/scenarios/{scenario_id}/export": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "Export Scenario",
        "operationId": "export_scenario_api_v1_bdd_scenarios__scenario_id__export_get",
        "parameters": [
          {
            "name": "scenario_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Scenario Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {}
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/parse": {
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Parse Requirement",
        "operationId": "parse_requirement_api_v1_bdd_parse_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ParseRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ParseResponse"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/parse/file": {
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Parse File",
        "operationId": "parse_file_api_v1_bdd_parse_file_post",
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "$ref": "#/components/schemas/Body_parse_file_api_v1_bdd_parse_file_post"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ParseResponse"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/generate": {
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Generate Scenarios",
        "operationId": "generate_scenarios_api_v1_bdd_generate_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/GenerateRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {}
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/ollama/status": {
      "get": {
        "tags": [
          "bdd"
        ],
        "summary": "Ollama Status",
        "operationId": "ollama_status_api_v1_bdd_ollama_status_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/OllamaStatusOut"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/ollama/start": {
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Ollama Start",
        "operationId": "ollama_start_api_v1_bdd_ollama_start_post",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/OllamaStatusOut"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/bdd/ollama/stop": {
      "post": {
        "tags": [
          "bdd"
        ],
        "summary": "Ollama Stop",
        "operationId": "ollama_stop_api_v1_bdd_ollama_stop_post",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/OllamaStatusOut"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/e2e/suites": {
      "get": {
        "tags": [
          "e2e"
        ],
        "summary": "List Suites",
        "operationId": "list_suites_api_v1_e2e_suites_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/SuiteWithLatestRunOut"
                  },
                  "type": "array",
                  "title": "Response List Suites Api V1 E2E Suites Get"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "e2e"
        ],
        "summary": "Create Suite",
        "operationId": "create_suite_api_v1_e2e_suites_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SuiteCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SuiteOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/e2e/suites/{suite_id}": {
      "patch": {
        "tags": [
          "e2e"
        ],
        "summary": "Update Suite",
        "operationId": "update_suite_api_v1_e2e_suites__suite_id__patch",
        "parameters": [
          {
            "name": "suite_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Suite Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SuiteUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SuiteOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/e2e/runs": {
      "get": {
        "tags": [
          "e2e"
        ],
        "summary": "List Runs",
        "operationId": "list_runs_api_v1_e2e_runs_get",
        "parameters": [
          {
            "name": "suite_id",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Suite Id",
              "type": "string",
              "format": "uuid",
              "nullable": true
            }
          },
          {
            "name": "page",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "minimum": 1,
              "default": 1,
              "title": "Page"
            }
          },
          {
            "name": "page_size",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "maximum": 100,
              "minimum": 1,
              "default": 50,
              "title": "Page Size"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaginatedResponse_RunWithSuiteOut_"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "e2e"
        ],
        "summary": "Delete Runs Bulk",
        "operationId": "delete_runs_bulk_api_v1_e2e_runs_delete",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BulkDeleteRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "additionalProperties": true,
                  "title": "Response Delete Runs Bulk Api V1 E2E Runs Delete"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/e2e/runs/{run_id}": {
      "get": {
        "tags": [
          "e2e"
        ],
        "summary": "Get Run",
        "operationId": "get_run_api_v1_e2e_runs__run_id__get",
        "parameters": [
          {
            "name": "run_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Run Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RunOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "e2e"
        ],
        "summary": "Delete Run",
        "operationId": "delete_run_api_v1_e2e_runs__run_id__delete",
        "parameters": [
          {
            "name": "run_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Run Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/e2e/sync": {
      "post": {
        "tags": [
          "e2e"
        ],
        "summary": "Trigger Sync",
        "operationId": "trigger_sync_api_v1_e2e_sync_post",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SyncResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/features": {
      "get": {
        "tags": [
          "features"
        ],
        "summary": "List Feature Visibility",
        "operationId": "list_feature_visibility_api_v1_features_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FeatureVisibilityResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/features/{feature_key}": {
      "patch": {
        "tags": [
          "features"
        ],
        "summary": "Update Feature Visibility",
        "operationId": "update_feature_visibility_api_v1_features__feature_key__patch",
        "parameters": [
          {
            "name": "feature_key",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Feature Key"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FeatureVisibilityUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FeatureVisibilityUpdateResponse"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/psp-fees": {
      "get": {
        "tags": [
          "psp-fees"
        ],
        "summary": "List Psp Fees",
        "operationId": "list_psp_fees_api_v1_psp_fees_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PspFeeListResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/psp-fees/sync": {
      "post": {
        "tags": [
          "psp-fees"
        ],
        "summary": "Trigger Sync",
        "operationId": "trigger_sync_api_v1_psp_fees_sync_post",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PspFeeSyncResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/gpd-position/snapshots": {
      "get": {
        "tags": [
          "gpd-position"
        ],
        "summary": "List Snapshots",
        "operationId": "list_snapshots_api_v1_gpd_position_snapshots_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GpdPositionsResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/gpd-position/sync": {
      "post": {
        "tags": [
          "gpd-position"
        ],
        "summary": "Trigger Sync",
        "operationId": "trigger_sync_api_v1_gpd_position_sync_post",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GpdPositionSyncResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/sanp-health/reports": {
      "get": {
        "tags": [
          "sanp-health"
        ],
        "summary": "List Reports",
        "operationId": "list_reports_api_v1_sanp_health_reports_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SanpHealthReportsResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/sanp-health/reports/latest": {
      "get": {
        "tags": [
          "sanp-health"
        ],
        "summary": "Get Latest Report",
        "operationId": "get_latest_report_api_v1_sanp_health_reports_latest_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SanpHealthLatestResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/sanp-health/reports/{run_id}": {
      "get": {
        "tags": [
          "sanp-health"
        ],
        "summary": "Get Report",
        "operationId": "get_report_api_v1_sanp_health_reports__run_id__get",
        "parameters": [
          {
            "name": "run_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Run Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SanpHealthReportDetailOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/sanp-health/sync": {
      "post": {
        "tags": [
          "sanp-health"
        ],
        "summary": "Trigger Sync",
        "operationId": "trigger_sync_api_v1_sanp_health_sync_post",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SanpHealthSyncResult"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/sanp-health/sync-status": {
      "get": {
        "tags": [
          "sanp-health"
        ],
        "summary": "Get Sync Status",
        "operationId": "get_sync_status_api_v1_sanp_health_sync_status_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "title": "Response Get Sync Status Api V1 Sanp Health Sync Status Get",
                  "$ref": "#/components/schemas/SanpHealthSyncStatusOut",
                  "nullable": true
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/kb": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Get Kb",
        "operationId": "get_kb_api_v1_ea_kb_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaKbResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/nodes/{node_id}": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Get Node",
        "operationId": "get_node_api_v1_ea_nodes__node_id__get",
        "parameters": [
          {
            "name": "node_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Node Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaNodeDetail"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "patch": {
        "tags": [
          "ea-map"
        ],
        "summary": "Update Node",
        "operationId": "update_node_api_v1_ea_nodes__node_id__patch",
        "parameters": [
          {
            "name": "node_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Node Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaNodeUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaNodeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/infra": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Get Infra",
        "description": "Infrastructure of one environment, from the Terraform of the platform.",
        "operationId": "get_infra_api_v1_ea_infra_get",
        "parameters": [
          {
            "name": "env",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string",
              "pattern": "^(prod|uat|dev)$",
              "default": "prod",
              "title": "Env"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaInfraViewOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/infra/resources/{resource_id}": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Get Infra Resource",
        "operationId": "get_infra_resource_api_v1_ea_infra_resources__resource_id__get",
        "parameters": [
          {
            "name": "resource_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Resource Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaInfraResourceDetail"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/nodes/{node_id}/impact": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Get Impact",
        "operationId": "get_impact_api_v1_ea_nodes__node_id__impact_get",
        "parameters": [
          {
            "name": "node_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Node Id"
            }
          },
          {
            "name": "depth",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "maximum": 6,
              "minimum": 1,
              "default": 3,
              "title": "Depth"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaImpactResponse"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/live": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Get Live",
        "description": "Outcomes of the test runs of the last ``days`` in ``env``, on the map nodes.",
        "operationId": "get_live_api_v1_ea_live_get",
        "parameters": [
          {
            "name": "env",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string",
              "pattern": "^(DEV|UAT|PROD)$",
              "default": "DEV",
              "title": "Env"
            }
          },
          {
            "name": "days",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "maximum": 30,
              "minimum": 1,
              "default": 7,
              "title": "Days"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaLiveOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/flows": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "List Flows",
        "description": "Curated payment flows (SANP), step by step, on the nodes of the map.",
        "operationId": "list_flows_api_v1_ea_flows_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/EaFlowOut"
                  },
                  "type": "array",
                  "title": "Response List Flows Api V1 Ea Flows Get"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/impact/release": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Release Impact",
        "operationId": "release_impact_api_v1_ea_impact_release_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaReleaseImpactRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaReleaseImpactOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/assistant/chat": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Assistant Chat",
        "operationId": "assistant_chat_api_v1_ea_assistant_chat_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaAssistantRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaAssistantOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/edges": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Create Edge",
        "operationId": "create_edge_api_v1_ea_edges_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaEdgeCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaEdgeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/edges/{edge_id}": {
      "patch": {
        "tags": [
          "ea-map"
        ],
        "summary": "Update Edge",
        "operationId": "update_edge_api_v1_ea_edges__edge_id__patch",
        "parameters": [
          {
            "name": "edge_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Edge Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaEdgeUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaEdgeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/edges/{edge_id}/verify": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Verify Edge",
        "operationId": "verify_edge_api_v1_ea_edges__edge_id__verify_post",
        "parameters": [
          {
            "name": "edge_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Edge Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaEdgeNote"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaEdgeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/edges/{edge_id}/remove": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Remove Edge",
        "operationId": "remove_edge_api_v1_ea_edges__edge_id__remove_post",
        "parameters": [
          {
            "name": "edge_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Edge Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaEdgeNote"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaEdgeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/nodes": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Create Node",
        "operationId": "create_node_api_v1_ea_nodes_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaNodeCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaNodeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/nodes/{node_id}/qa": {
      "patch": {
        "tags": [
          "ea-map"
        ],
        "summary": "Update Qa",
        "operationId": "update_qa_api_v1_ea_nodes__node_id__qa_patch",
        "parameters": [
          {
            "name": "node_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Node Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaQaUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaQaOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/nodes/{node_id}/history": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Node History",
        "operationId": "node_history_api_v1_ea_nodes__node_id__history_get",
        "parameters": [
          {
            "name": "node_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Node Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/EaHistoryItem"
                  },
                  "title": "Response Node History Api V1 Ea Nodes  Node Id  History Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/sync": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Trigger Sync",
        "operationId": "trigger_sync_api_v1_ea_sync_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaSyncRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "202": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaSyncRunOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/sync-status": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "Get Sync Status",
        "operationId": "get_sync_status_api_v1_ea_sync_status_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaSyncStatusOut"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/sync-runs": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "List Sync Runs",
        "operationId": "list_sync_runs_api_v1_ea_sync_runs_get",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "maximum": 100,
              "minimum": 1,
              "default": 10,
              "title": "Limit"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/EaSyncRunOut"
                  },
                  "title": "Response List Sync Runs Api V1 Ea Sync Runs Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/changes": {
      "get": {
        "tags": [
          "ea-map"
        ],
        "summary": "List Changes",
        "operationId": "list_changes_api_v1_ea_changes_get",
        "parameters": [
          {
            "name": "status",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string",
              "default": "pending,conflict",
              "title": "Status"
            }
          },
          {
            "name": "run_id",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Run Id",
              "type": "string",
              "format": "uuid",
              "nullable": true
            }
          },
          {
            "name": "limit",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "maximum": 2000,
              "minimum": 1,
              "default": 500,
              "title": "Limit"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/EaChangeOut"
                  },
                  "title": "Response List Changes Api V1 Ea Changes Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/changes/{change_id}/approve": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Approve Change",
        "operationId": "approve_change_api_v1_ea_changes__change_id__approve_post",
        "parameters": [
          {
            "name": "change_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Change Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaChangeDecision"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaChangeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/changes/{change_id}/reject": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Reject Change",
        "operationId": "reject_change_api_v1_ea_changes__change_id__reject_post",
        "parameters": [
          {
            "name": "change_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Change Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaChangeDecision"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EaChangeOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/ea/changes/bulk": {
      "post": {
        "tags": [
          "ea-map"
        ],
        "summary": "Bulk Decide",
        "operationId": "bulk_decide_api_v1_ea_changes_bulk_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EaChangeBulk"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "additionalProperties": {
                    "type": "string"
                  },
                  "type": "object",
                  "title": "Response Bulk Decide Api V1 Ea Changes Bulk Post"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/overview": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Overview",
        "operationId": "get_overview_api_v1_jira_overview_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraOverview"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/trend": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Trend",
        "operationId": "get_trend_api_v1_jira_trend_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraTrend"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/estimate-drift": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Estimate Drift",
        "operationId": "get_estimate_drift_api_v1_jira_estimate_drift_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraEstimateDrift"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/sanp/overview": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Sanp Overview",
        "operationId": "get_sanp_overview_api_v1_jira_sanp_overview_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraOverview"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/sanp/trend": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Sanp Trend",
        "operationId": "get_sanp_trend_api_v1_jira_sanp_trend_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraTrend"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/sanp/estimate-drift": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Sanp Estimate Drift",
        "operationId": "get_sanp_estimate_drift_api_v1_jira_sanp_estimate_drift_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraEstimateDrift"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/data/overview": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Data Overview",
        "operationId": "get_data_overview_api_v1_jira_data_overview_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraOverview"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/data/trend": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Data Trend",
        "operationId": "get_data_trend_api_v1_jira_data_trend_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraTrend"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/data/estimate-drift": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Data Estimate Drift",
        "operationId": "get_data_estimate_drift_api_v1_jira_data_estimate_drift_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JiraEstimateDrift"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/jira/issue/{issue_key}": {
      "get": {
        "tags": [
          "jira"
        ],
        "summary": "Get Issue",
        "operationId": "get_issue_api_v1_jira_issue__issue_key__get",
        "parameters": [
          {
            "name": "issue_key",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Issue Key"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "additionalProperties": true,
                  "title": "Response Get Issue Api V1 Jira Issue  Issue Key  Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/docs": {
      "get": {
        "tags": [
          "docs"
        ],
        "summary": "List Items",
        "operationId": "list_items_api_v1_docs_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/DocItemOut"
                  },
                  "type": "array",
                  "title": "Response List Items Api V1 Docs Get"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "docs"
        ],
        "summary": "Create Item",
        "operationId": "create_item_api_v1_docs_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DocItemCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DocItemOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/docs/{item_id}": {
      "put": {
        "tags": [
          "docs"
        ],
        "summary": "Update Item",
        "operationId": "update_item_api_v1_docs__item_id__put",
        "parameters": [
          {
            "name": "item_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Item Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DocItemUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DocItemOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "docs"
        ],
        "summary": "Delete Item",
        "operationId": "delete_item_api_v1_docs__item_id__delete",
        "parameters": [
          {
            "name": "item_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Item Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/docs/proxy": {
      "get": {
        "tags": [
          "docs"
        ],
        "summary": "Proxy Html",
        "operationId": "proxy_html_api_v1_docs_proxy_get",
        "parameters": [
          {
            "name": "url",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Url"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "text/html": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/dimensions": {
      "get": {
        "tags": [
          "dq"
        ],
        "summary": "List Dimensions",
        "operationId": "list_dimensions_api_v1_dq_dimensions_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/DqDimensionOut"
                  },
                  "type": "array",
                  "title": "Response List Dimensions Api V1 Dq Dimensions Get"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "dq"
        ],
        "summary": "Create Dimension",
        "operationId": "create_dimension_api_v1_dq_dimensions_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqDimensionCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqDimensionOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/dimensions/{dimension_id}": {
      "patch": {
        "tags": [
          "dq"
        ],
        "summary": "Update Dimension",
        "operationId": "update_dimension_api_v1_dq_dimensions__dimension_id__patch",
        "parameters": [
          {
            "name": "dimension_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Dimension Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqDimensionUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqDimensionOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "dq"
        ],
        "summary": "Delete Dimension",
        "operationId": "delete_dimension_api_v1_dq_dimensions__dimension_id__delete",
        "parameters": [
          {
            "name": "dimension_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Dimension Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/domains": {
      "get": {
        "tags": [
          "dq"
        ],
        "summary": "List Domains",
        "operationId": "list_domains_api_v1_dq_domains_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/DqDomainOut"
                  },
                  "type": "array",
                  "title": "Response List Domains Api V1 Dq Domains Get"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "dq"
        ],
        "summary": "Create Domain",
        "operationId": "create_domain_api_v1_dq_domains_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqDomainCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqDomainOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/domains/{domain_id}": {
      "patch": {
        "tags": [
          "dq"
        ],
        "summary": "Update Domain",
        "operationId": "update_domain_api_v1_dq_domains__domain_id__patch",
        "parameters": [
          {
            "name": "domain_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Domain Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqDomainUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqDomainOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "dq"
        ],
        "summary": "Delete Domain",
        "operationId": "delete_domain_api_v1_dq_domains__domain_id__delete",
        "parameters": [
          {
            "name": "domain_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Domain Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/catalog": {
      "get": {
        "tags": [
          "dq"
        ],
        "summary": "List Catalog Controls",
        "operationId": "list_catalog_controls_api_v1_dq_catalog_get",
        "parameters": [
          {
            "name": "category",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Category",
              "$ref": "#/components/schemas/DqCategory",
              "nullable": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DqCatalogControlOut"
                  },
                  "title": "Response List Catalog Controls Api V1 Dq Catalog Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "dq"
        ],
        "summary": "Create Catalog Control",
        "operationId": "create_catalog_control_api_v1_dq_catalog_post",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqCatalogControlCreate"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqCatalogControlOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/catalog/{control_id}": {
      "get": {
        "tags": [
          "dq"
        ],
        "summary": "Get Catalog Control",
        "operationId": "get_catalog_control_api_v1_dq_catalog__control_id__get",
        "parameters": [
          {
            "name": "control_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Control Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqCatalogControlOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "patch": {
        "tags": [
          "dq"
        ],
        "summary": "Update Catalog Control",
        "operationId": "update_catalog_control_api_v1_dq_catalog__control_id__patch",
        "parameters": [
          {
            "name": "control_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Control Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqCatalogControlUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqCatalogControlOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "dq"
        ],
        "summary": "Delete Catalog Control",
        "operationId": "delete_catalog_control_api_v1_dq_catalog__control_id__delete",
        "parameters": [
          {
            "name": "control_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Control Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/instances": {
      "get": {
        "tags": [
          "dq"
        ],
        "summary": "List Control Instances",
        "operationId": "list_control_instances_api_v1_dq_instances_get",
        "parameters": [
          {
            "name": "domain_id",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Domain Id",
              "type": "string",
              "format": "uuid",
              "nullable": true
            }
          },
          {
            "name": "category",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Category",
              "$ref": "#/components/schemas/DqCategory",
              "nullable": true
            }
          },
          {
            "name": "status",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Status",
              "$ref": "#/components/schemas/DqControlStatus",
              "nullable": true
            }
          },
          {
            "name": "table_ref",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Table Ref",
              "type": "string",
              "nullable": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DqControlInstanceOut"
                  },
                  "title": "Response List Control Instances Api V1 Dq Instances Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "dq"
        ],
        "summary": "Create Control Instance",
        "operationId": "create_control_instance_api_v1_dq_instances_post",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqControlInstanceCreate"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqControlInstanceOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/instances/tables": {
      "get": {
        "tags": [
          "dq"
        ],
        "summary": "List Control Instance Tables",
        "operationId": "list_control_instance_tables_api_v1_dq_instances_tables_get",
        "parameters": [
          {
            "name": "domain_id",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Domain Id"
            }
          },
          {
            "name": "category",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Category",
              "$ref": "#/components/schemas/DqCategory",
              "nullable": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "title": "Response List Control Instance Tables Api V1 Dq Instances Tables Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/dq/instances/{instance_id}": {
      "get": {
        "tags": [
          "dq"
        ],
        "summary": "Get Control Instance",
        "operationId": "get_control_instance_api_v1_dq_instances__instance_id__get",
        "parameters": [
          {
            "name": "instance_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Instance Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqControlInstanceOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "patch": {
        "tags": [
          "dq"
        ],
        "summary": "Update Control Instance",
        "operationId": "update_control_instance_api_v1_dq_instances__instance_id__patch",
        "parameters": [
          {
            "name": "instance_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Instance Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DqControlInstanceUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DqControlInstanceOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "dq"
        ],
        "summary": "Delete Control Instance",
        "operationId": "delete_control_instance_api_v1_dq_instances__instance_id__delete",
        "parameters": [
          {
            "name": "instance_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Instance Id"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "title": "Body",
                "$ref": "#/components/schemas/DqControlInstanceUpdate",
                "nullable": true
              }
            }
          }
        },
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/users": {
      "get": {
        "tags": [
          "users"
        ],
        "summary": "List Users",
        "operationId": "list_users_api_v1_users_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UserListResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/users/{user_id}": {
      "patch": {
        "tags": [
          "users"
        ],
        "summary": "Update User",
        "operationId": "update_user_api_v1_users__user_id__patch",
        "parameters": [
          {
            "name": "user_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "User Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UserOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/users/sync-login": {
      "post": {
        "tags": [
          "users"
        ],
        "summary": "Sync Login",
        "operationId": "sync_login_api_v1_users_sync_login_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/SyncLoginRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SyncLoginResponse"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/roles": {
      "get": {
        "tags": [
          "roles"
        ],
        "summary": "Get Role Matrix",
        "operationId": "get_role_matrix_api_v1_roles_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RoleMatrixResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/roles/{role}": {
      "patch": {
        "tags": [
          "roles"
        ],
        "summary": "Update Role Permissions",
        "operationId": "update_role_permissions_api_v1_roles__role__patch",
        "parameters": [
          {
            "name": "role",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Role"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RolePermissionUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "additionalProperties": {
                    "type": "boolean"
                  },
                  "title": "Response Update Role Permissions Api V1 Roles  Role  Patch"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/tm/resources": {
      "get": {
        "tags": [
          "tm"
        ],
        "summary": "List Resources",
        "operationId": "list_resources_api_v1_tm_resources_get",
        "parameters": [
          {
            "name": "include_inactive",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean",
              "default": false,
              "title": "Include Inactive"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ExternalResourceOut"
                  },
                  "title": "Response List Resources Api V1 Tm Resources Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "tm"
        ],
        "summary": "Create Resource",
        "operationId": "create_resource_api_v1_tm_resources_post",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ExternalResourceCreate"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ExternalResourceOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/tm/resources/{resource_id}": {
      "patch": {
        "tags": [
          "tm"
        ],
        "summary": "Update Resource",
        "operationId": "update_resource_api_v1_tm_resources__resource_id__patch",
        "parameters": [
          {
            "name": "resource_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Resource Id"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ExternalResourceUpdate"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ExternalResourceOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "tm"
        ],
        "summary": "Deactivate Resource",
        "operationId": "deactivate_resource_api_v1_tm_resources__resource_id__delete",
        "parameters": [
          {
            "name": "resource_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Resource Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/tm/absences": {
      "get": {
        "tags": [
          "tm"
        ],
        "summary": "List Absences",
        "operationId": "list_absences_api_v1_tm_absences_get",
        "parameters": [
          {
            "name": "resource_id",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Resource Id",
              "type": "string",
              "format": "uuid",
              "nullable": true
            }
          },
          {
            "name": "year",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Year",
              "type": "integer",
              "nullable": true
            }
          },
          {
            "name": "month",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Month",
              "type": "integer",
              "nullable": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ResourceAbsenceOut"
                  },
                  "title": "Response List Absences Api V1 Tm Absences Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "tm"
        ],
        "summary": "Create Absence",
        "operationId": "create_absence_api_v1_tm_absences_post",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ResourceAbsenceCreate"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResourceAbsenceOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "tm"
        ],
        "summary": "Delete All Absences",
        "operationId": "delete_all_absences_api_v1_tm_absences_delete",
        "parameters": [
          {
            "name": "confirm",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean",
              "description": "Must be true: wipes every absence",
              "default": false,
              "title": "Confirm"
            },
            "description": "Must be true: wipes every absence"
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "additionalProperties": {
                    "type": "integer"
                  },
                  "title": "Response Delete All Absences Api V1 Tm Absences Delete"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/tm/absences/{absence_id}": {
      "delete": {
        "tags": [
          "tm"
        ],
        "summary": "Delete Absence",
        "operationId": "delete_absence_api_v1_tm_absences__absence_id__delete",
        "parameters": [
          {
            "name": "absence_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "format": "uuid",
              "title": "Absence Id"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Successful Response"
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/tm/absences/import-csv": {
      "post": {
        "tags": [
          "tm"
        ],
        "summary": "Import Absences Csv",
        "operationId": "import_absences_csv_api_v1_tm_absences_import_csv_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CsvAbsenceImportRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CsvAbsenceImportResult"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/tm/absences/sync-confluence": {
      "post": {
        "tags": [
          "tm"
        ],
        "summary": "Sync Confluence",
        "description": "Without year/month syncs the whole window (last year → next year).",
        "operationId": "sync_confluence_api_v1_tm_absences_sync_confluence_post",
        "parameters": [
          {
            "name": "year",
            "in": "query",
            "required": false,
            "schema": {
              "description": "With month: sync one month only",
              "title": "Year",
              "type": "integer",
              "nullable": true
            },
            "description": "With month: sync one month only"
          },
          {
            "name": "month",
            "in": "query",
            "required": false,
            "schema": {
              "description": "With year: sync one month only",
              "title": "Month",
              "type": "integer",
              "nullable": true
            },
            "description": "With year: sync one month only"
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SyncResult"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/tm/costs": {
      "get": {
        "tags": [
          "tm"
        ],
        "summary": "Get Cost Report",
        "operationId": "get_cost_report_api_v1_tm_costs_get",
        "parameters": [
          {
            "name": "year",
            "in": "query",
            "required": true,
            "schema": {
              "type": "integer",
              "title": "Year"
            }
          },
          {
            "name": "month",
            "in": "query",
            "required": true,
            "schema": {
              "type": "integer",
              "title": "Month"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CostReport"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/test-suites": {
      "post": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Create Test Suite",
        "operationId": "create_test_suite_api_v1_test_metrics_test_suites_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TestSuiteCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TestSuiteOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/test-suites/latest/": {
      "get": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Get Latest Test Suite Version",
        "operationId": "get_latest_test_suite_version_api_v1_test_metrics_test_suites_latest__get",
        "parameters": [
          {
            "name": "test_object",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Test Object"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TestSuiteOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/test-runs": {
      "post": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Create Test Run",
        "operationId": "create_test_run_api_v1_test_metrics_test_runs_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TestRunCreate"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TestRunOut"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/test-executions": {
      "post": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Create Test Execution",
        "operationId": "create_test_execution_api_v1_test_metrics_test_executions_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "items": {
                  "$ref": "#/components/schemas/TestExecutionCreate"
                },
                "type": "array",
                "title": "Body"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/TestExecutionOut"
                  },
                  "type": "array",
                  "title": "Response Create Test Execution Api V1 Test Metrics Test Executions Post"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/nrts": {
      "get": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Get Nrts",
        "operationId": "get_nrts_api_v1_test_metrics_nrts_get",
        "parameters": [
          {
            "name": "test_object",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Test Object",
              "type": "string",
              "nullable": true
            }
          },
          {
            "name": "origin",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Origin",
              "type": "string",
              "nullable": true
            }
          },
          {
            "name": "page",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "minimum": 1,
              "default": 1,
              "title": "Page"
            }
          },
          {
            "name": "page_size",
            "in": "query",
            "required": false,
            "schema": {
              "type": "integer",
              "maximum": 100,
              "minimum": 1,
              "default": 50,
              "title": "Page Size"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaginatedResponse_NrtListObject_"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/nrt/{id}": {
      "get": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Get Nrt By Id",
        "operationId": "get_nrt_by_id_api_v1_test_metrics_nrt__id__get",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "title": "Id"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/TestExecutionOut"
                  },
                  "title": "Response Get Nrt By Id Api V1 Test Metrics Nrt  Id  Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/nrts/update": {
      "put": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Update Nrt",
        "operationId": "update_nrt_api_v1_test_metrics_nrts_update_put",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UpdateNrtsObject"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UpdateNrtsObject"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/flaky-scenarios/save": {
      "post": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Save Flaky Scenarios",
        "operationId": "save_flaky_scenarios_api_v1_test_metrics_flaky_scenarios_save_post",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "items": {
                  "$ref": "#/components/schemas/FlakyScenarioIn"
                },
                "type": "array",
                "title": "Flaky Scenarios"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "items": {
                    "$ref": "#/components/schemas/FlakyScenarioOut"
                  },
                  "type": "array",
                  "title": "Response Save Flaky Scenarios Api V1 Test Metrics Flaky Scenarios Save Post"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/test-metrics/flaky-scenarios": {
      "get": {
        "tags": [
          "test-metrics"
        ],
        "summary": "Get Flaky Scenarios",
        "operationId": "get_flaky_scenarios_api_v1_test_metrics_flaky_scenarios_get",
        "parameters": [
          {
            "name": "test_object",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Test Object",
              "type": "string",
              "format": "uuid",
              "nullable": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/FlakyScenarioOut"
                  },
                  "title": "Response Get Flaky Scenarios Api V1 Test Metrics Flaky Scenarios Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/suites/all": {
      "get": {
        "tags": [
          "suites"
        ],
        "summary": "Get Suites",
        "operationId": "get_suites_api_v1_suites_all_get",
        "parameters": [
          {
            "name": "origin",
            "in": "query",
            "required": false,
            "schema": {
              "title": "Origin",
              "type": "string",
              "nullable": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "title": "Response Get Suites Api V1 Suites All Get"
                }
              }
            }
          },
          "422": {
            "description": "Validation Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HTTPValidationError"
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
      "ActionCatalogEntry": {
        "properties": {
          "key": {
            "type": "string",
            "title": "Key"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "category": {
            "type": "string",
            "title": "Category"
          }
        },
        "type": "object",
        "required": [
          "key",
          "label",
          "category"
        ],
        "title": "ActionCatalogEntry"
      },
      "Body_parse_file_api_v1_bdd_parse_file_post": {
        "properties": {
          "source_type": {
            "type": "string",
            "title": "Source Type"
          },
          "file": {
            "type": "string",
            "contentMediaType": "application/octet-stream",
            "title": "File"
          }
        },
        "type": "object",
        "required": [
          "source_type",
          "file"
        ],
        "title": "Body_parse_file_api_v1_bdd_parse_file_post"
      },
      "BulkDeleteRequest": {
        "properties": {
          "ids": {
            "items": {
              "type": "string",
              "format": "uuid"
            },
            "type": "array",
            "title": "Ids"
          }
        },
        "type": "object",
        "required": [
          "ids"
        ],
        "title": "BulkDeleteRequest"
      },
      "CostReport": {
        "properties": {
          "year": {
            "type": "integer",
            "title": "Year"
          },
          "month": {
            "type": "integer",
            "title": "Month"
          },
          "rows": {
            "items": {
              "$ref": "#/components/schemas/ResourceCostRow"
            },
            "type": "array",
            "title": "Rows"
          },
          "grand_total": {
            "type": "number",
            "title": "Grand Total"
          }
        },
        "type": "object",
        "required": [
          "year",
          "month",
          "rows",
          "grand_total"
        ],
        "title": "CostReport"
      },
      "CsvAbsenceImportRequest": {
        "properties": {
          "rows": {
            "items": {
              "$ref": "#/components/schemas/CsvAbsenceRow"
            },
            "type": "array",
            "title": "Rows"
          }
        },
        "type": "object",
        "required": [
          "rows"
        ],
        "title": "CsvAbsenceImportRequest"
      },
      "CsvAbsenceImportResult": {
        "properties": {
          "imported": {
            "type": "integer",
            "title": "Imported"
          },
          "skipped": {
            "type": "integer",
            "title": "Skipped"
          },
          "errors": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Errors"
          }
        },
        "type": "object",
        "required": [
          "imported",
          "skipped",
          "errors"
        ],
        "title": "CsvAbsenceImportResult"
      },
      "CsvAbsenceRow": {
        "properties": {
          "email": {
            "type": "string",
            "format": "email",
            "title": "Email"
          },
          "absence_date": {
            "type": "string",
            "format": "date",
            "title": "Absence Date"
          },
          "absence_type": {
            "type": "string",
            "title": "Absence Type",
            "default": "ferie"
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "email",
          "absence_date"
        ],
        "title": "CsvAbsenceRow"
      },
      "DocItemCreate": {
        "properties": {
          "title": {
            "type": "string",
            "title": "Title"
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "url": {
            "type": "string",
            "title": "Url"
          },
          "type": {
            "type": "string",
            "enum": [
              "external",
              "embedded"
            ],
            "title": "Type",
            "default": "external"
          },
          "category": {
            "type": "string",
            "title": "Category",
            "default": "Generale"
          },
          "icon": {
            "type": "string",
            "enum": [
              "confluence",
              "page",
              "template",
              "web",
              "video"
            ],
            "title": "Icon",
            "default": "page"
          },
          "thumbnail_url": {
            "title": "Thumbnail Url",
            "type": "string",
            "nullable": true
          },
          "position": {
            "type": "integer",
            "title": "Position",
            "default": 0
          }
        },
        "type": "object",
        "required": [
          "title",
          "url"
        ],
        "title": "DocItemCreate"
      },
      "DocItemOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "title": {
            "type": "string",
            "title": "Title"
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "url": {
            "type": "string",
            "title": "Url"
          },
          "type": {
            "type": "string",
            "title": "Type"
          },
          "category": {
            "type": "string",
            "title": "Category"
          },
          "icon": {
            "type": "string",
            "title": "Icon"
          },
          "thumbnail_url": {
            "title": "Thumbnail Url",
            "type": "string",
            "nullable": true
          },
          "position": {
            "type": "integer",
            "title": "Position"
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          }
        },
        "type": "object",
        "required": [
          "id",
          "title",
          "description",
          "url",
          "type",
          "category",
          "icon",
          "thumbnail_url",
          "position",
          "created_at",
          "updated_at"
        ],
        "title": "DocItemOut"
      },
      "DocItemUpdate": {
        "properties": {
          "title": {
            "title": "Title",
            "type": "string",
            "nullable": true
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "url": {
            "title": "Url",
            "type": "string",
            "nullable": true
          },
          "type": {
            "title": "Type",
            "type": "string",
            "enum": [
              "external",
              "embedded"
            ],
            "nullable": true
          },
          "category": {
            "title": "Category",
            "type": "string",
            "nullable": true
          },
          "icon": {
            "title": "Icon",
            "type": "string",
            "enum": [
              "confluence",
              "page",
              "template",
              "web",
              "video"
            ],
            "nullable": true
          },
          "thumbnail_url": {
            "title": "Thumbnail Url",
            "type": "string",
            "nullable": true
          },
          "position": {
            "title": "Position",
            "type": "integer",
            "nullable": true
          }
        },
        "type": "object",
        "title": "DocItemUpdate"
      },
      "DqCatalogControlCreate": {
        "properties": {
          "category": {
            "type": "string",
            "title": "Category"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "description": {
            "type": "string",
            "title": "Description"
          },
          "dimension_id": {
            "type": "string",
            "format": "uuid",
            "title": "Dimension Id"
          },
          "created_by": {
            "title": "Created By",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "category",
          "name",
          "description",
          "dimension_id"
        ],
        "title": "DqCatalogControlCreate"
      },
      "DqCatalogControlOut": {
        "properties": {
          "category": {
            "type": "string",
            "title": "Category"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "description": {
            "type": "string",
            "title": "Description"
          },
          "dimension_id": {
            "type": "string",
            "format": "uuid",
            "title": "Dimension Id"
          },
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "dimension": {
            "$ref": "#/components/schemas/DqDimensionOut"
          },
          "created_by": {
            "title": "Created By",
            "type": "string",
            "nullable": true
          },
          "updated_by": {
            "title": "Updated By",
            "type": "string",
            "nullable": true
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          }
        },
        "type": "object",
        "required": [
          "category",
          "name",
          "description",
          "dimension_id",
          "id",
          "dimension",
          "created_by",
          "updated_by",
          "created_at",
          "updated_at"
        ],
        "title": "DqCatalogControlOut"
      },
      "DqCatalogControlUpdate": {
        "properties": {
          "category": {
            "title": "Category",
            "type": "string",
            "nullable": true
          },
          "name": {
            "title": "Name",
            "type": "string",
            "nullable": true
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "dimension_id": {
            "title": "Dimension Id",
            "type": "string",
            "format": "uuid",
            "nullable": true
          },
          "updated_by": {
            "title": "Updated By",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "DqCatalogControlUpdate"
      },
      "DqCategory": {
        "type": "string",
        "enum": [
          "puntuale",
          "intra_entita",
          "cross_entita"
        ],
        "title": "DqCategory"
      },
      "DqControlInstanceCreate": {
        "properties": {
          "domain_id": {
            "type": "string",
            "format": "uuid",
            "title": "Domain Id"
          },
          "catalog_control_id": {
            "type": "string",
            "format": "uuid",
            "title": "Catalog Control Id"
          },
          "table_ref": {
            "type": "string",
            "title": "Table Ref"
          },
          "field_ref": {
            "type": "string",
            "title": "Field Ref"
          },
          "owner": {
            "title": "Owner",
            "type": "string",
            "nullable": true
          },
          "risk": {
            "type": "string",
            "title": "Risk"
          },
          "impact": {
            "type": "string",
            "title": "Impact"
          },
          "status": {
            "type": "string",
            "title": "Status",
            "default": "da_implementare"
          },
          "notes": {
            "title": "Notes",
            "type": "string",
            "nullable": true
          },
          "check_name": {
            "type": "string",
            "title": "Check Name"
          },
          "soda_url": {
            "title": "Soda Url",
            "type": "string",
            "nullable": true
          },
          "created_by": {
            "title": "Created By",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "domain_id",
          "catalog_control_id",
          "table_ref",
          "field_ref",
          "risk",
          "impact",
          "check_name"
        ],
        "title": "DqControlInstanceCreate"
      },
      "DqControlInstanceOut": {
        "properties": {
          "domain_id": {
            "type": "string",
            "format": "uuid",
            "title": "Domain Id"
          },
          "catalog_control_id": {
            "type": "string",
            "format": "uuid",
            "title": "Catalog Control Id"
          },
          "table_ref": {
            "type": "string",
            "title": "Table Ref"
          },
          "field_ref": {
            "type": "string",
            "title": "Field Ref"
          },
          "owner": {
            "title": "Owner",
            "type": "string",
            "nullable": true
          },
          "risk": {
            "type": "string",
            "title": "Risk"
          },
          "impact": {
            "type": "string",
            "title": "Impact"
          },
          "status": {
            "type": "string",
            "title": "Status",
            "default": "da_implementare"
          },
          "notes": {
            "title": "Notes",
            "type": "string",
            "nullable": true
          },
          "check_name": {
            "title": "Check Name",
            "type": "string",
            "nullable": true
          },
          "soda_url": {
            "title": "Soda Url",
            "type": "string",
            "nullable": true
          },
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "catalog_control": {
            "$ref": "#/components/schemas/DqCatalogControlOut"
          },
          "created_by": {
            "title": "Created By",
            "type": "string",
            "nullable": true
          },
          "updated_by": {
            "title": "Updated By",
            "type": "string",
            "nullable": true
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          }
        },
        "type": "object",
        "required": [
          "domain_id",
          "catalog_control_id",
          "table_ref",
          "field_ref",
          "risk",
          "impact",
          "check_name",
          "soda_url",
          "id",
          "catalog_control",
          "created_by",
          "updated_by",
          "created_at",
          "updated_at"
        ],
        "title": "DqControlInstanceOut"
      },
      "DqControlInstanceUpdate": {
        "properties": {
          "table_ref": {
            "title": "Table Ref",
            "type": "string",
            "nullable": true
          },
          "field_ref": {
            "title": "Field Ref",
            "type": "string",
            "nullable": true
          },
          "owner": {
            "title": "Owner",
            "type": "string",
            "nullable": true
          },
          "risk": {
            "title": "Risk",
            "type": "string",
            "nullable": true
          },
          "impact": {
            "title": "Impact",
            "type": "string",
            "nullable": true
          },
          "status": {
            "title": "Status",
            "type": "string",
            "nullable": true
          },
          "notes": {
            "title": "Notes",
            "type": "string",
            "nullable": true
          },
          "check_name": {
            "title": "Check Name",
            "type": "string",
            "nullable": true
          },
          "soda_url": {
            "title": "Soda Url",
            "type": "string",
            "nullable": true
          },
          "updated_by": {
            "title": "Updated By",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "DqControlInstanceUpdate"
      },
      "DqControlStatus": {
        "type": "string",
        "enum": [
          "da_implementare",
          "in_sviluppo",
          "attivo",
          "non_attivo",
          "eliminato"
        ],
        "title": "DqControlStatus"
      },
      "DqDimensionCreate": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "sort_order": {
            "type": "integer",
            "title": "Sort Order",
            "default": 0
          }
        },
        "type": "object",
        "required": [
          "name"
        ],
        "title": "DqDimensionCreate"
      },
      "DqDimensionOut": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "sort_order": {
            "type": "integer",
            "title": "Sort Order",
            "default": 0
          },
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          }
        },
        "type": "object",
        "required": [
          "name",
          "id"
        ],
        "title": "DqDimensionOut"
      },
      "DqDimensionUpdate": {
        "properties": {
          "name": {
            "title": "Name",
            "type": "string",
            "nullable": true
          },
          "sort_order": {
            "title": "Sort Order",
            "type": "integer",
            "nullable": true
          }
        },
        "type": "object",
        "title": "DqDimensionUpdate"
      },
      "DqDomainCreate": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "sort_order": {
            "type": "integer",
            "title": "Sort Order",
            "default": 0
          }
        },
        "type": "object",
        "required": [
          "name"
        ],
        "title": "DqDomainCreate"
      },
      "DqDomainOut": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "sort_order": {
            "type": "integer",
            "title": "Sort Order",
            "default": 0
          },
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          }
        },
        "type": "object",
        "required": [
          "name",
          "id",
          "created_at",
          "updated_at"
        ],
        "title": "DqDomainOut"
      },
      "DqDomainUpdate": {
        "properties": {
          "name": {
            "title": "Name",
            "type": "string",
            "nullable": true
          },
          "sort_order": {
            "title": "Sort Order",
            "type": "integer",
            "nullable": true
          }
        },
        "type": "object",
        "title": "DqDomainUpdate"
      },
      "EaAssistantOut": {
        "properties": {
          "answer": {
            "type": "string",
            "title": "Answer"
          },
          "highlight": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Highlight"
          },
          "labels": {
            "additionalProperties": {
              "type": "string"
            },
            "type": "object",
            "title": "Labels"
          },
          "steps": {
            "items": {
              "additionalProperties": {
                "type": "string"
              },
              "type": "object"
            },
            "type": "array",
            "title": "Steps"
          }
        },
        "type": "object",
        "required": [
          "answer",
          "highlight",
          "labels",
          "steps"
        ],
        "title": "EaAssistantOut"
      },
      "EaAssistantRequest": {
        "properties": {
          "messages": {
            "items": {
              "$ref": "#/components/schemas/EaChatMessage"
            },
            "type": "array",
            "maxItems": 40,
            "minItems": 1,
            "title": "Messages"
          },
          "context": {
            "title": "Context",
            "additionalProperties": true,
            "type": "object",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "messages"
        ],
        "title": "EaAssistantRequest"
      },
      "EaChangeBulk": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "ids": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "maxItems": 200,
            "minItems": 1,
            "title": "Ids"
          },
          "decision": {
            "type": "string",
            "pattern": "^(approve|reject)$",
            "title": "Decision"
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "ids",
          "decision"
        ],
        "title": "EaChangeBulk"
      },
      "EaChangeDecision": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          },
          "parent_id": {
            "title": "Parent Id",
            "type": "string",
            "nullable": true
          },
          "ctype": {
            "title": "Ctype",
            "type": "string",
            "nullable": true
          },
          "name": {
            "title": "Name",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "EaChangeDecision"
      },
      "EaChangeOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "run_id": {
            "title": "Run Id",
            "type": "string",
            "nullable": true
          },
          "entity": {
            "type": "string",
            "title": "Entity"
          },
          "op": {
            "type": "string",
            "title": "Op"
          },
          "target_id": {
            "type": "string",
            "title": "Target Id"
          },
          "before": {
            "title": "Before",
            "additionalProperties": true,
            "type": "object",
            "nullable": true
          },
          "after": {
            "title": "After",
            "additionalProperties": true,
            "type": "object",
            "nullable": true
          },
          "structural": {
            "type": "boolean",
            "title": "Structural"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "reviewed_by": {
            "title": "Reviewed By",
            "type": "string",
            "nullable": true
          },
          "reviewed_at": {
            "title": "Reviewed At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "review_note": {
            "title": "Review Note",
            "type": "string",
            "nullable": true
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          }
        },
        "type": "object",
        "required": [
          "id",
          "run_id",
          "entity",
          "op",
          "target_id",
          "before",
          "after",
          "structural",
          "status",
          "reviewed_by",
          "reviewed_at",
          "review_note",
          "created_at"
        ],
        "title": "EaChangeOut"
      },
      "EaChatMessage": {
        "properties": {
          "role": {
            "type": "string",
            "pattern": "^(user|assistant)$",
            "title": "Role"
          },
          "content": {
            "type": "string",
            "maxLength": 4000,
            "minLength": 1,
            "title": "Content"
          }
        },
        "type": "object",
        "required": [
          "role",
          "content"
        ],
        "title": "EaChatMessage"
      },
      "EaEdgeCreate": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "from_id": {
            "type": "string",
            "title": "From Id"
          },
          "to_id": {
            "type": "string",
            "title": "To Id"
          },
          "type": {
            "type": "string",
            "title": "Type"
          },
          "label": {
            "title": "Label",
            "type": "string",
            "nullable": true
          },
          "note": {
            "type": "string",
            "title": "Note"
          }
        },
        "type": "object",
        "required": [
          "from_id",
          "to_id",
          "type",
          "note"
        ],
        "title": "EaEdgeCreate"
      },
      "EaEdgeNote": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "EaEdgeNote"
      },
      "EaEdgeOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "from": {
            "type": "string",
            "title": "From"
          },
          "to": {
            "type": "string",
            "title": "To"
          },
          "type": {
            "type": "string",
            "title": "Type"
          },
          "label": {
            "title": "Label",
            "type": "string",
            "nullable": true
          },
          "origin": {
            "type": "string",
            "title": "Origin"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "confidence": {
            "type": "integer",
            "title": "Confidence"
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          },
          "created_by": {
            "title": "Created By",
            "type": "string",
            "nullable": true
          },
          "verified_by": {
            "title": "Verified By",
            "type": "string",
            "nullable": true
          },
          "verified_at": {
            "title": "Verified At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "from",
          "to",
          "type",
          "label",
          "origin",
          "status",
          "confidence",
          "note",
          "created_by",
          "verified_by",
          "verified_at"
        ],
        "title": "EaEdgeOut"
      },
      "EaEdgeUpdate": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "type": {
            "title": "Type",
            "type": "string",
            "nullable": true
          },
          "label": {
            "title": "Label",
            "type": "string",
            "nullable": true
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "EaEdgeUpdate"
      },
      "EaFlowOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "subtitle": {
            "type": "string",
            "title": "Subtitle"
          },
          "process": {
            "type": "string",
            "title": "Process"
          },
          "process_name": {
            "type": "string",
            "title": "Process Name"
          },
          "services": {
            "items": {
              "additionalProperties": {
                "type": "string"
              },
              "type": "object"
            },
            "type": "array",
            "title": "Services"
          },
          "lanes": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Lanes"
          },
          "steps": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Steps"
          },
          "missing": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Missing"
          },
          "validated": {
            "type": "boolean",
            "title": "Validated"
          },
          "sanp_url": {
            "title": "Sanp Url",
            "type": "string",
            "nullable": true
          },
          "source": {
            "type": "string",
            "title": "Source"
          }
        },
        "type": "object",
        "required": [
          "id",
          "name",
          "subtitle",
          "process",
          "process_name",
          "services",
          "lanes",
          "steps",
          "missing",
          "validated",
          "source"
        ],
        "title": "EaFlowOut",
        "description": "A curated payment flow, step by step, tied to the map nodes (draft until validated)."
      },
      "EaHistoryItem": {
        "properties": {
          "action": {
            "type": "string",
            "title": "Action"
          },
          "resource_type": {
            "title": "Resource Type",
            "type": "string",
            "nullable": true
          },
          "resource_id": {
            "title": "Resource Id",
            "type": "string",
            "nullable": true
          },
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "at": {
            "type": "string",
            "format": "date-time",
            "title": "At"
          },
          "detail": {
            "additionalProperties": true,
            "type": "object",
            "title": "Detail"
          }
        },
        "type": "object",
        "required": [
          "action",
          "resource_type",
          "resource_id",
          "actor",
          "at",
          "detail"
        ],
        "title": "EaHistoryItem"
      },
      "EaImpactItem": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "kind": {
            "type": "string",
            "title": "Kind"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "depth": {
            "type": "integer",
            "title": "Depth"
          }
        },
        "type": "object",
        "required": [
          "id",
          "kind",
          "name",
          "depth"
        ],
        "title": "EaImpactItem"
      },
      "EaImpactResponse": {
        "properties": {
          "node_id": {
            "type": "string",
            "title": "Node Id"
          },
          "depth": {
            "type": "integer",
            "title": "Depth"
          },
          "upstream": {
            "items": {
              "$ref": "#/components/schemas/EaImpactItem"
            },
            "type": "array",
            "title": "Upstream"
          },
          "downstream": {
            "items": {
              "$ref": "#/components/schemas/EaImpactItem"
            },
            "type": "array",
            "title": "Downstream"
          }
        },
        "type": "object",
        "required": [
          "node_id",
          "depth",
          "upstream",
          "downstream"
        ],
        "title": "EaImpactResponse"
      },
      "EaInfraActionGroupOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "channels": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Channels"
          }
        },
        "type": "object",
        "required": [
          "id",
          "label",
          "channels"
        ],
        "title": "EaInfraActionGroupOut"
      },
      "EaInfraAlertOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "severity": {
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Severity"
          },
          "kind": {
            "title": "Kind",
            "type": "string",
            "nullable": true
          },
          "targets": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Targets"
          },
          "action_groups": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Action Groups"
          }
        },
        "type": "object",
        "required": [
          "id",
          "label",
          "severity",
          "kind",
          "targets",
          "action_groups"
        ],
        "title": "EaInfraAlertOut"
      },
      "EaInfraDashboardOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "label": {
            "type": "string",
            "title": "Label"
          }
        },
        "type": "object",
        "required": [
          "id",
          "label"
        ],
        "title": "EaInfraDashboardOut"
      },
      "EaInfraLinkOut": {
        "properties": {
          "from": {
            "type": "string",
            "title": "From"
          },
          "to": {
            "type": "string",
            "title": "To"
          },
          "kind": {
            "type": "string",
            "title": "Kind"
          },
          "origin": {
            "type": "string",
            "title": "Origin"
          },
          "evidence": {
            "additionalProperties": true,
            "type": "object",
            "title": "Evidence"
          }
        },
        "type": "object",
        "required": [
          "from",
          "to",
          "kind",
          "origin",
          "evidence"
        ],
        "title": "EaInfraLinkOut"
      },
      "EaInfraLinkSide": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "ltype": {
            "type": "string",
            "title": "Ltype"
          },
          "kind": {
            "type": "string",
            "title": "Kind"
          },
          "origin": {
            "type": "string",
            "title": "Origin"
          },
          "envs": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Envs"
          },
          "evidence": {
            "additionalProperties": true,
            "type": "object",
            "title": "Evidence"
          }
        },
        "type": "object",
        "required": [
          "id",
          "label",
          "ltype",
          "kind",
          "origin",
          "envs",
          "evidence"
        ],
        "title": "EaInfraLinkSide"
      },
      "EaInfraMonitoringOut": {
        "properties": {
          "alerts": {
            "items": {
              "$ref": "#/components/schemas/EaInfraAlertOut"
            },
            "type": "array",
            "title": "Alerts"
          },
          "action_groups": {
            "items": {
              "$ref": "#/components/schemas/EaInfraActionGroupOut"
            },
            "type": "array",
            "title": "Action Groups"
          },
          "dashboards": {
            "items": {
              "$ref": "#/components/schemas/EaInfraDashboardOut"
            },
            "type": "array",
            "title": "Dashboards"
          }
        },
        "type": "object",
        "required": [
          "alerts",
          "action_groups",
          "dashboards"
        ],
        "title": "EaInfraMonitoringOut"
      },
      "EaInfraResourceDetail": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "ltype": {
            "type": "string",
            "title": "Ltype"
          },
          "vendor": {
            "type": "string",
            "title": "Vendor"
          },
          "tf_type": {
            "type": "string",
            "title": "Tf Type"
          },
          "address": {
            "type": "string",
            "title": "Address"
          },
          "repo": {
            "type": "string",
            "title": "Repo"
          },
          "stack": {
            "type": "string",
            "title": "Stack"
          },
          "file_url": {
            "title": "File Url",
            "type": "string",
            "nullable": true
          },
          "parent": {
            "title": "Parent",
            "type": "string",
            "nullable": true
          },
          "blueprint": {
            "title": "Blueprint",
            "type": "string",
            "nullable": true
          },
          "node": {
            "title": "Node",
            "type": "string",
            "nullable": true
          },
          "external": {
            "type": "boolean",
            "title": "External"
          },
          "envs": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Envs"
          },
          "location": {
            "title": "Location",
            "type": "string",
            "nullable": true
          },
          "attrs": {
            "additionalProperties": true,
            "type": "object",
            "title": "Attrs"
          },
          "names": {
            "additionalProperties": {
              "type": "string"
            },
            "type": "object",
            "title": "Names"
          },
          "locations": {
            "additionalProperties": {
              "type": "string"
            },
            "type": "object",
            "title": "Locations"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "node_name": {
            "title": "Node Name",
            "type": "string",
            "nullable": true
          },
          "children": {
            "type": "integer",
            "title": "Children"
          },
          "out": {
            "items": {
              "$ref": "#/components/schemas/EaInfraLinkSide"
            },
            "type": "array",
            "title": "Out"
          },
          "in": {
            "items": {
              "$ref": "#/components/schemas/EaInfraLinkSide"
            },
            "type": "array",
            "title": "In"
          }
        },
        "type": "object",
        "required": [
          "id",
          "label",
          "ltype",
          "vendor",
          "tf_type",
          "address",
          "repo",
          "stack",
          "file_url",
          "parent",
          "blueprint",
          "node",
          "external",
          "envs",
          "location",
          "attrs",
          "names",
          "locations",
          "status",
          "node_name",
          "children",
          "out",
          "in"
        ],
        "title": "EaInfraResourceDetail"
      },
      "EaInfraResourceOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "ltype": {
            "type": "string",
            "title": "Ltype"
          },
          "vendor": {
            "type": "string",
            "title": "Vendor"
          },
          "tf_type": {
            "type": "string",
            "title": "Tf Type"
          },
          "address": {
            "type": "string",
            "title": "Address"
          },
          "repo": {
            "type": "string",
            "title": "Repo"
          },
          "stack": {
            "type": "string",
            "title": "Stack"
          },
          "file_url": {
            "title": "File Url",
            "type": "string",
            "nullable": true
          },
          "parent": {
            "title": "Parent",
            "type": "string",
            "nullable": true
          },
          "blueprint": {
            "title": "Blueprint",
            "type": "string",
            "nullable": true
          },
          "node": {
            "title": "Node",
            "type": "string",
            "nullable": true
          },
          "external": {
            "type": "boolean",
            "title": "External"
          },
          "envs": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Envs"
          },
          "location": {
            "title": "Location",
            "type": "string",
            "nullable": true
          },
          "attrs": {
            "additionalProperties": true,
            "type": "object",
            "title": "Attrs"
          }
        },
        "type": "object",
        "required": [
          "id",
          "label",
          "ltype",
          "vendor",
          "tf_type",
          "address",
          "repo",
          "stack",
          "file_url",
          "parent",
          "blueprint",
          "node",
          "external",
          "envs",
          "location",
          "attrs"
        ],
        "title": "EaInfraResourceOut"
      },
      "EaInfraViewOut": {
        "properties": {
          "env": {
            "type": "string",
            "title": "Env"
          },
          "envs": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Envs"
          },
          "synced_at": {
            "title": "Synced At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "resources": {
            "items": {
              "$ref": "#/components/schemas/EaInfraResourceOut"
            },
            "type": "array",
            "title": "Resources"
          },
          "links": {
            "items": {
              "$ref": "#/components/schemas/EaInfraLinkOut"
            },
            "type": "array",
            "title": "Links"
          },
          "monitoring": {
            "$ref": "#/components/schemas/EaInfraMonitoringOut"
          }
        },
        "type": "object",
        "required": [
          "env",
          "envs",
          "synced_at",
          "resources",
          "links",
          "monitoring"
        ],
        "title": "EaInfraViewOut"
      },
      "EaKbResponse": {
        "properties": {
          "meta": {
            "additionalProperties": true,
            "type": "object",
            "title": "Meta"
          },
          "nodes": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Nodes"
          },
          "edges": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Edges"
          },
          "blueprint": {
            "additionalProperties": true,
            "type": "object",
            "title": "Blueprint"
          }
        },
        "type": "object",
        "required": [
          "meta",
          "nodes",
          "edges",
          "blueprint"
        ],
        "title": "EaKbResponse",
        "description": "Knowledge base in the shape used by the map views (kept loose on purpose)."
      },
      "EaLiveOut": {
        "properties": {
          "env": {
            "type": "string",
            "title": "Env"
          },
          "days": {
            "type": "integer",
            "title": "Days"
          },
          "generated_at": {
            "type": "string",
            "title": "Generated At"
          },
          "objects": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Objects"
          },
          "nodes": {
            "additionalProperties": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "object",
            "title": "Nodes"
          },
          "unmapped": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Unmapped"
          },
          "feed": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Feed"
          },
          "counts": {
            "additionalProperties": {
              "type": "integer"
            },
            "type": "object",
            "title": "Counts"
          }
        },
        "type": "object",
        "required": [
          "env",
          "days",
          "generated_at",
          "objects",
          "nodes",
          "unmapped",
          "feed",
          "counts"
        ],
        "title": "EaLiveOut",
        "description": "Recent outcomes of the automated test runs, tied to the map nodes."
      },
      "EaNodeCreate": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "id": {
            "type": "string",
            "title": "Id"
          },
          "kind": {
            "type": "string",
            "title": "Kind"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "parent_id": {
            "title": "Parent Id",
            "type": "string",
            "nullable": true
          },
          "repo": {
            "title": "Repo",
            "type": "string",
            "nullable": true
          },
          "ctype": {
            "title": "Ctype",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "kind",
          "name"
        ],
        "title": "EaNodeCreate"
      },
      "EaNodeDetail": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "kind": {
            "type": "string",
            "title": "Kind"
          },
          "parent": {
            "title": "Parent",
            "type": "string",
            "nullable": true
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "desc": {
            "title": "Desc",
            "type": "string",
            "nullable": true
          },
          "attrs": {
            "additionalProperties": true,
            "type": "object",
            "title": "Attrs"
          },
          "source": {
            "type": "string",
            "title": "Source"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "verified_at": {
            "title": "Verified At",
            "nullable": true
          },
          "verified_by": {
            "title": "Verified By",
            "type": "string",
            "nullable": true
          },
          "qa": {
            "title": "Qa",
            "additionalProperties": true,
            "type": "object",
            "nullable": true
          },
          "docs": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Docs"
          },
          "out": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Out"
          },
          "in": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "In"
          },
          "dq": {
            "title": "Dq",
            "additionalProperties": true,
            "type": "object",
            "nullable": true
          },
          "infra": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Infra",
            "default": []
          }
        },
        "type": "object",
        "required": [
          "id",
          "kind",
          "parent",
          "name",
          "desc",
          "attrs",
          "source",
          "status",
          "verified_at",
          "qa",
          "docs",
          "out",
          "in"
        ],
        "title": "EaNodeDetail"
      },
      "EaNodeOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "kind": {
            "type": "string",
            "title": "Kind"
          },
          "parent_id": {
            "title": "Parent Id",
            "type": "string",
            "nullable": true
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "source": {
            "type": "string",
            "title": "Source"
          },
          "verified_by": {
            "title": "Verified By",
            "type": "string",
            "nullable": true
          },
          "verified_at": {
            "title": "Verified At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "kind",
          "parent_id",
          "name",
          "description",
          "source",
          "verified_by",
          "verified_at"
        ],
        "title": "EaNodeOut"
      },
      "EaNodeUpdate": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "name": {
            "title": "Name",
            "type": "string",
            "nullable": true
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "parent_id": {
            "title": "Parent Id",
            "type": "string",
            "nullable": true
          },
          "ctype": {
            "title": "Ctype",
            "type": "string",
            "nullable": true
          },
          "layer": {
            "title": "Layer",
            "type": "string",
            "nullable": true
          },
          "doc_url": {
            "title": "Doc Url",
            "type": "string",
            "nullable": true
          },
          "slack_url": {
            "title": "Slack Url",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "EaNodeUpdate"
      },
      "EaQaOut": {
        "properties": {
          "node_id": {
            "type": "string",
            "title": "Node Id"
          },
          "under_qa": {
            "title": "Under Qa",
            "type": "boolean",
            "nullable": true
          },
          "tas_ci_override": {
            "title": "Tas Ci Override",
            "type": "boolean",
            "nullable": true
          },
          "qa_owner": {
            "title": "Qa Owner",
            "type": "string",
            "nullable": true
          },
          "qa_notes": {
            "title": "Qa Notes",
            "type": "string",
            "nullable": true
          },
          "manual_updated_by": {
            "title": "Manual Updated By",
            "type": "string",
            "nullable": true
          },
          "manual_updated_at": {
            "title": "Manual Updated At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "node_id",
          "under_qa",
          "tas_ci_override",
          "qa_owner",
          "qa_notes",
          "manual_updated_by",
          "manual_updated_at"
        ],
        "title": "EaQaOut"
      },
      "EaQaUpdate": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          },
          "under_qa": {
            "title": "Under Qa",
            "type": "boolean",
            "nullable": true
          },
          "tas_ci_override": {
            "title": "Tas Ci Override",
            "type": "boolean",
            "nullable": true
          },
          "qa_owner": {
            "title": "Qa Owner",
            "type": "string",
            "nullable": true
          },
          "qa_notes": {
            "title": "Qa Notes",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "EaQaUpdate"
      },
      "EaReleaseImpactOut": {
        "properties": {
          "change": {
            "additionalProperties": true,
            "type": "object",
            "title": "Change"
          },
          "component": {
            "additionalProperties": true,
            "type": "object",
            "title": "Component"
          },
          "risk": {
            "type": "string",
            "title": "Risk"
          },
          "categories": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Categories"
          },
          "impacted": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Impacted"
          },
          "suites": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Suites"
          },
          "gaps": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Gaps"
          },
          "processes": {
            "items": {
              "additionalProperties": true,
              "type": "object"
            },
            "type": "array",
            "title": "Processes"
          },
          "highlight": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Highlight"
          }
        },
        "type": "object",
        "required": [
          "change",
          "component",
          "risk",
          "categories",
          "impacted",
          "suites",
          "gaps",
          "processes",
          "highlight"
        ],
        "title": "EaReleaseImpactOut"
      },
      "EaReleaseImpactRequest": {
        "properties": {
          "url": {
            "title": "Url",
            "type": "string",
            "maxLength": 500,
            "nullable": true
          },
          "repo": {
            "title": "Repo",
            "type": "string",
            "maxLength": 200,
            "nullable": true
          },
          "base": {
            "title": "Base",
            "type": "string",
            "maxLength": 200,
            "nullable": true
          },
          "head": {
            "title": "Head",
            "type": "string",
            "maxLength": 200,
            "nullable": true
          }
        },
        "type": "object",
        "title": "EaReleaseImpactRequest",
        "description": "A GitHub pull request or comparison link, or repository + base + head."
      },
      "EaSyncRequest": {
        "properties": {
          "actor": {
            "title": "Actor",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "EaSyncRequest"
      },
      "EaSyncRunOut": {
        "properties": {
          "id": {
            "type": "string",
            "title": "Id"
          },
          "trigger": {
            "type": "string",
            "title": "Trigger"
          },
          "triggered_by": {
            "title": "Triggered By",
            "type": "string",
            "nullable": true
          },
          "started_at": {
            "type": "string",
            "format": "date-time",
            "title": "Started At"
          },
          "finished_at": {
            "title": "Finished At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "stats": {
            "additionalProperties": true,
            "type": "object",
            "title": "Stats"
          },
          "error": {
            "title": "Error",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "trigger",
          "triggered_by",
          "started_at",
          "finished_at",
          "status",
          "stats",
          "error"
        ],
        "title": "EaSyncRunOut"
      },
      "EaSyncStatusOut": {
        "properties": {
          "running": {
            "$ref": "#/components/schemas/EaSyncRunOut",
            "nullable": true
          },
          "last": {
            "$ref": "#/components/schemas/EaSyncRunOut",
            "nullable": true
          },
          "last_success_at": {
            "title": "Last Success At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "last_error": {
            "title": "Last Error",
            "type": "string",
            "nullable": true
          },
          "open_changes": {
            "type": "integer",
            "title": "Open Changes"
          }
        },
        "type": "object",
        "required": [
          "running",
          "last",
          "last_success_at",
          "last_error",
          "open_changes"
        ],
        "title": "EaSyncStatusOut"
      },
      "EnvEnum": {
        "type": "string",
        "enum": [
          "DEV",
          "UAT",
          "PROD"
        ],
        "title": "EnvEnum"
      },
      "EstimateDriftGroup": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "original_estimate_sec": {
            "type": "integer",
            "title": "Original Estimate Sec"
          },
          "time_spent_sec": {
            "type": "integer",
            "title": "Time Spent Sec"
          }
        },
        "type": "object",
        "required": [
          "name",
          "original_estimate_sec",
          "time_spent_sec"
        ],
        "title": "EstimateDriftGroup"
      },
      "EstimateDriftItem": {
        "properties": {
          "key": {
            "type": "string",
            "title": "Key"
          },
          "summary": {
            "type": "string",
            "title": "Summary"
          },
          "issue_type": {
            "type": "string",
            "title": "Issue Type"
          },
          "assignee": {
            "type": "string",
            "title": "Assignee"
          },
          "original_estimate_sec": {
            "type": "integer",
            "title": "Original Estimate Sec"
          },
          "time_spent_sec": {
            "type": "integer",
            "title": "Time Spent Sec"
          },
          "drift_sec": {
            "type": "integer",
            "title": "Drift Sec"
          },
          "drift_pct": {
            "type": "number",
            "title": "Drift Pct"
          }
        },
        "type": "object",
        "required": [
          "key",
          "summary",
          "issue_type",
          "assignee",
          "original_estimate_sec",
          "time_spent_sec",
          "drift_sec",
          "drift_pct"
        ],
        "title": "EstimateDriftItem"
      },
      "ExternalResourceCreate": {
        "properties": {
          "first_name": {
            "type": "string",
            "maxLength": 100,
            "minLength": 1,
            "title": "First Name"
          },
          "last_name": {
            "type": "string",
            "maxLength": 100,
            "minLength": 1,
            "title": "Last Name"
          },
          "email": {
            "type": "string",
            "format": "email",
            "title": "Email"
          },
          "company": {
            "type": "string",
            "maxLength": 200,
            "minLength": 1,
            "title": "Company"
          },
          "role": {
            "type": "string",
            "maxLength": 200,
            "minLength": 1,
            "title": "Role"
          },
          "daily_rate": {
            "type": "number",
            "exclusiveMinimum": true,
            "title": "Daily Rate",
            "minimum": 0.0
          },
          "contract_start": {
            "type": "string",
            "format": "date",
            "title": "Contract Start"
          },
          "contract_end": {
            "title": "Contract End",
            "type": "string",
            "format": "date",
            "nullable": true
          },
          "notes": {
            "title": "Notes",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "first_name",
          "last_name",
          "email",
          "company",
          "role",
          "daily_rate",
          "contract_start"
        ],
        "title": "ExternalResourceCreate"
      },
      "ExternalResourceOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "first_name": {
            "type": "string",
            "title": "First Name"
          },
          "last_name": {
            "type": "string",
            "title": "Last Name"
          },
          "email": {
            "type": "string",
            "title": "Email"
          },
          "company": {
            "type": "string",
            "title": "Company"
          },
          "role": {
            "type": "string",
            "title": "Role"
          },
          "daily_rate": {
            "type": "number",
            "title": "Daily Rate"
          },
          "contract_start": {
            "type": "string",
            "format": "date",
            "title": "Contract Start"
          },
          "contract_end": {
            "title": "Contract End",
            "type": "string",
            "format": "date",
            "nullable": true
          },
          "notes": {
            "title": "Notes",
            "type": "string",
            "nullable": true
          },
          "is_active": {
            "type": "boolean",
            "title": "Is Active"
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          }
        },
        "type": "object",
        "required": [
          "id",
          "first_name",
          "last_name",
          "email",
          "company",
          "role",
          "daily_rate",
          "contract_start",
          "contract_end",
          "notes",
          "is_active",
          "created_at",
          "updated_at"
        ],
        "title": "ExternalResourceOut"
      },
      "ExternalResourceUpdate": {
        "properties": {
          "first_name": {
            "title": "First Name",
            "type": "string",
            "maxLength": 100,
            "minLength": 1,
            "nullable": true
          },
          "last_name": {
            "title": "Last Name",
            "type": "string",
            "maxLength": 100,
            "minLength": 1,
            "nullable": true
          },
          "email": {
            "title": "Email",
            "type": "string",
            "format": "email",
            "nullable": true
          },
          "company": {
            "title": "Company",
            "type": "string",
            "maxLength": 200,
            "minLength": 1,
            "nullable": true
          },
          "role": {
            "title": "Role",
            "type": "string",
            "maxLength": 200,
            "minLength": 1,
            "nullable": true
          },
          "daily_rate": {
            "title": "Daily Rate",
            "type": "number",
            "exclusiveMinimum": true,
            "minimum": 0.0,
            "nullable": true
          },
          "contract_start": {
            "title": "Contract Start",
            "type": "string",
            "format": "date",
            "nullable": true
          },
          "contract_end": {
            "title": "Contract End",
            "type": "string",
            "format": "date",
            "nullable": true
          },
          "notes": {
            "title": "Notes",
            "type": "string",
            "nullable": true
          },
          "is_active": {
            "title": "Is Active",
            "type": "boolean",
            "nullable": true
          }
        },
        "type": "object",
        "title": "ExternalResourceUpdate"
      },
      "FeatureVisibilityItem": {
        "properties": {
          "key": {
            "type": "string",
            "title": "Key"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "route": {
            "type": "string",
            "title": "Route"
          },
          "action": {
            "type": "string",
            "title": "Action"
          },
          "external": {
            "type": "boolean",
            "title": "External"
          },
          "enabled": {
            "type": "boolean",
            "title": "Enabled"
          }
        },
        "type": "object",
        "required": [
          "key",
          "label",
          "route",
          "action",
          "external",
          "enabled"
        ],
        "title": "FeatureVisibilityItem"
      },
      "FeatureVisibilityResponse": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/FeatureVisibilityItem"
            },
            "type": "array",
            "title": "Items"
          }
        },
        "type": "object",
        "required": [
          "items"
        ],
        "title": "FeatureVisibilityResponse"
      },
      "FeatureVisibilityUpdate": {
        "properties": {
          "enabled": {
            "type": "boolean",
            "title": "Enabled"
          }
        },
        "type": "object",
        "required": [
          "enabled"
        ],
        "title": "FeatureVisibilityUpdate"
      },
      "FeatureVisibilityUpdateResponse": {
        "properties": {
          "key": {
            "type": "string",
            "title": "Key"
          },
          "enabled": {
            "type": "boolean",
            "title": "Enabled"
          }
        },
        "type": "object",
        "required": [
          "key",
          "enabled"
        ],
        "title": "FeatureVisibilityUpdateResponse"
      },
      "FlakyScenarioIn": {
        "properties": {
          "id": {
            "title": "Id",
            "type": "string",
            "format": "uuid",
            "nullable": true
          },
          "suite_id": {
            "type": "string",
            "format": "uuid",
            "title": "Suite Id"
          },
          "test_object": {
            "type": "string",
            "title": "Test Object"
          },
          "scenario_name": {
            "type": "string",
            "title": "Scenario Name"
          },
          "suite_version": {
            "type": "string",
            "title": "Suite Version"
          },
          "test_version": {
            "type": "string",
            "title": "Test Version"
          },
          "inserted_at": {
            "title": "Inserted At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "is_flaky": {
            "type": "boolean",
            "title": "Is Flaky",
            "default": true
          }
        },
        "type": "object",
        "required": [
          "suite_id",
          "test_object",
          "scenario_name",
          "suite_version",
          "test_version"
        ],
        "title": "FlakyScenarioIn"
      },
      "FlakyScenarioOut": {
        "properties": {
          "id": {
            "title": "Id",
            "type": "string",
            "format": "uuid",
            "nullable": true
          },
          "suite_id": {
            "type": "string",
            "format": "uuid",
            "title": "Suite Id"
          },
          "test_object": {
            "type": "string",
            "title": "Test Object"
          },
          "scenario_name": {
            "type": "string",
            "title": "Scenario Name"
          },
          "suite_version": {
            "type": "string",
            "title": "Suite Version"
          },
          "test_version": {
            "type": "string",
            "title": "Test Version"
          },
          "inserted_at": {
            "title": "Inserted At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "is_flaky": {
            "type": "boolean",
            "title": "Is Flaky"
          }
        },
        "type": "object",
        "required": [
          "suite_id",
          "test_object",
          "scenario_name",
          "suite_version",
          "test_version",
          "is_flaky"
        ],
        "title": "FlakyScenarioOut"
      },
      "GenerateRequest": {
        "properties": {
          "requirement": {
            "type": "string",
            "title": "Requirement"
          },
          "title": {
            "type": "string",
            "title": "Title"
          },
          "language": {
            "type": "string",
            "title": "Language",
            "default": "it"
          },
          "max_scenarios": {
            "type": "integer",
            "maximum": 15.0,
            "minimum": 1.0,
            "title": "Max Scenarios",
            "default": 5
          }
        },
        "type": "object",
        "required": [
          "requirement",
          "title"
        ],
        "title": "GenerateRequest"
      },
      "GpdPositionSnapshotOut": {
        "properties": {
          "report_date": {
            "type": "string",
            "format": "date",
            "title": "Report Date"
          },
          "total": {
            "type": "integer",
            "title": "Total"
          },
          "gpd": {
            "type": "integer",
            "title": "Gpd"
          },
          "gpd_payable": {
            "type": "integer",
            "title": "Gpd Payable"
          },
          "gpd4aca": {
            "type": "integer",
            "title": "Gpd4Aca"
          },
          "gpd4aca_payable": {
            "type": "integer",
            "title": "Gpd4Aca Payable"
          },
          "wisp": {
            "type": "integer",
            "title": "Wisp"
          },
          "pa_create_position": {
            "type": "integer",
            "title": "Pa Create Position"
          },
          "pa_create_position_payable": {
            "type": "integer",
            "title": "Pa Create Position Payable"
          }
        },
        "type": "object",
        "required": [
          "report_date",
          "total",
          "gpd",
          "gpd_payable",
          "gpd4aca",
          "gpd4aca_payable",
          "wisp",
          "pa_create_position",
          "pa_create_position_payable"
        ],
        "title": "GpdPositionSnapshotOut"
      },
      "GpdPositionSyncResponse": {
        "properties": {
          "status": {
            "type": "string",
            "title": "Status"
          },
          "item_count": {
            "type": "integer",
            "title": "Item Count"
          }
        },
        "type": "object",
        "required": [
          "status",
          "item_count"
        ],
        "title": "GpdPositionSyncResponse"
      },
      "GpdPositionSyncStatusOut": {
        "properties": {
          "item_count": {
            "type": "integer",
            "title": "Item Count"
          },
          "synced_at": {
            "type": "string",
            "format": "date-time",
            "title": "Synced At"
          }
        },
        "type": "object",
        "required": [
          "item_count",
          "synced_at"
        ],
        "title": "GpdPositionSyncStatusOut"
      },
      "GpdPositionsResponse": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/GpdPositionSnapshotOut"
            },
            "type": "array",
            "title": "Items"
          },
          "sync_status": {
            "$ref": "#/components/schemas/GpdPositionSyncStatusOut",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "items",
          "sync_status"
        ],
        "title": "GpdPositionsResponse"
      },
      "HTTPValidationError": {
        "properties": {
          "detail": {
            "items": {
              "$ref": "#/components/schemas/ValidationError"
            },
            "type": "array",
            "title": "Detail"
          }
        },
        "type": "object",
        "title": "HTTPValidationError"
      },
      "JiraAlert": {
        "properties": {
          "key": {
            "type": "string",
            "title": "Key"
          },
          "summary": {
            "type": "string",
            "title": "Summary"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "days": {
            "type": "integer",
            "title": "Days"
          }
        },
        "type": "object",
        "required": [
          "key",
          "summary",
          "status",
          "days"
        ],
        "title": "JiraAlert"
      },
      "JiraEstimateDrift": {
        "properties": {
          "issues_with_estimate": {
            "type": "integer",
            "title": "Issues With Estimate"
          },
          "total_original_sec": {
            "type": "integer",
            "title": "Total Original Sec"
          },
          "total_spent_sec": {
            "type": "integer",
            "title": "Total Spent Sec"
          },
          "drift_sec": {
            "type": "integer",
            "title": "Drift Sec"
          },
          "by_assignee": {
            "items": {
              "$ref": "#/components/schemas/EstimateDriftGroup"
            },
            "type": "array",
            "title": "By Assignee"
          },
          "by_type": {
            "items": {
              "$ref": "#/components/schemas/EstimateDriftGroup"
            },
            "type": "array",
            "title": "By Type"
          },
          "items": {
            "items": {
              "$ref": "#/components/schemas/EstimateDriftItem"
            },
            "type": "array",
            "title": "Items"
          }
        },
        "type": "object",
        "required": [
          "issues_with_estimate",
          "total_original_sec",
          "total_spent_sec",
          "drift_sec",
          "by_assignee",
          "by_type",
          "items"
        ],
        "title": "JiraEstimateDrift"
      },
      "JiraOverview": {
        "properties": {
          "total": {
            "type": "integer",
            "title": "Total"
          },
          "by_status": {
            "items": {
              "$ref": "#/components/schemas/NameCount"
            },
            "type": "array",
            "title": "By Status"
          },
          "by_component": {
            "items": {
              "$ref": "#/components/schemas/NameCount"
            },
            "type": "array",
            "title": "By Component"
          },
          "by_type": {
            "items": {
              "$ref": "#/components/schemas/TypeCount"
            },
            "type": "array",
            "title": "By Type"
          },
          "by_assignee": {
            "items": {
              "$ref": "#/components/schemas/NameCount"
            },
            "type": "array",
            "title": "By Assignee"
          },
          "alerts_no_estimate": {
            "items": {
              "$ref": "#/components/schemas/JiraAlert"
            },
            "type": "array",
            "title": "Alerts No Estimate"
          },
          "alerts_backlog_old": {
            "items": {
              "$ref": "#/components/schemas/JiraAlert"
            },
            "type": "array",
            "title": "Alerts Backlog Old"
          },
          "alerts_blocked_old": {
            "items": {
              "$ref": "#/components/schemas/JiraAlert"
            },
            "type": "array",
            "title": "Alerts Blocked Old"
          },
          "alerts_open_old": {
            "items": {
              "$ref": "#/components/schemas/JiraAlert"
            },
            "type": "array",
            "title": "Alerts Open Old"
          },
          "alerts_in_progress_old": {
            "items": {
              "$ref": "#/components/schemas/JiraAlert"
            },
            "type": "array",
            "title": "Alerts In Progress Old"
          }
        },
        "type": "object",
        "required": [
          "total",
          "by_status",
          "by_component",
          "by_type",
          "by_assignee",
          "alerts_no_estimate",
          "alerts_backlog_old",
          "alerts_blocked_old",
          "alerts_open_old",
          "alerts_in_progress_old"
        ],
        "title": "JiraOverview"
      },
      "JiraTrend": {
        "properties": {
          "weeks": {
            "items": {
              "$ref": "#/components/schemas/TrendWeek"
            },
            "type": "array",
            "title": "Weeks"
          }
        },
        "type": "object",
        "required": [
          "weeks"
        ],
        "title": "JiraTrend"
      },
      "NameCount": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "count": {
            "type": "integer",
            "title": "Count"
          }
        },
        "type": "object",
        "required": [
          "name",
          "count"
        ],
        "title": "NameCount"
      },
      "NrtListObject": {
        "properties": {
          "test_run": {
            "$ref": "#/components/schemas/TestRunOut",
            "nullable": true
          },
          "test_suite": {
            "$ref": "#/components/schemas/TestSuiteOut",
            "nullable": true
          }
        },
        "type": "object",
        "title": "NrtListObject"
      },
      "OllamaStatusOut": {
        "properties": {
          "running": {
            "type": "boolean",
            "title": "Running"
          },
          "url": {
            "type": "string",
            "title": "Url"
          }
        },
        "type": "object",
        "required": [
          "running",
          "url"
        ],
        "title": "OllamaStatusOut"
      },
      "PaginatedResponse_NrtListObject_": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/NrtListObject"
            },
            "type": "array",
            "title": "Items"
          },
          "total": {
            "type": "integer",
            "title": "Total"
          },
          "page": {
            "type": "integer",
            "title": "Page"
          },
          "page_size": {
            "type": "integer",
            "title": "Page Size"
          }
        },
        "type": "object",
        "required": [
          "items",
          "total",
          "page",
          "page_size"
        ],
        "title": "PaginatedResponse[NrtListObject]"
      },
      "PaginatedResponse_RunWithSuiteOut_": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/RunWithSuiteOut"
            },
            "type": "array",
            "title": "Items"
          },
          "total": {
            "type": "integer",
            "title": "Total"
          },
          "page": {
            "type": "integer",
            "title": "Page"
          },
          "page_size": {
            "type": "integer",
            "title": "Page Size"
          }
        },
        "type": "object",
        "required": [
          "items",
          "total",
          "page",
          "page_size"
        ],
        "title": "PaginatedResponse[RunWithSuiteOut]"
      },
      "PaginatedResponse_ScenarioOut_": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/ScenarioOut"
            },
            "type": "array",
            "title": "Items"
          },
          "total": {
            "type": "integer",
            "title": "Total"
          },
          "page": {
            "type": "integer",
            "title": "Page"
          },
          "page_size": {
            "type": "integer",
            "title": "Page Size"
          }
        },
        "type": "object",
        "required": [
          "items",
          "total",
          "page",
          "page_size"
        ],
        "title": "PaginatedResponse[ScenarioOut]"
      },
      "ParseRequest": {
        "properties": {
          "source_type": {
            "type": "string",
            "title": "Source Type"
          },
          "content": {
            "title": "Content",
            "type": "string",
            "nullable": true
          },
          "url": {
            "title": "Url",
            "type": "string",
            "nullable": true
          },
          "confluence_page_id": {
            "title": "Confluence Page Id",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "source_type"
        ],
        "title": "ParseRequest"
      },
      "ParseResponse": {
        "properties": {
          "text": {
            "type": "string",
            "title": "Text"
          }
        },
        "type": "object",
        "required": [
          "text"
        ],
        "title": "ParseResponse"
      },
      "ProjectCreate": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "name"
        ],
        "title": "ProjectCreate"
      },
      "ProjectOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          },
          "scenario_count": {
            "type": "integer",
            "title": "Scenario Count",
            "default": 0
          }
        },
        "type": "object",
        "required": [
          "id",
          "name",
          "description",
          "created_at",
          "updated_at"
        ],
        "title": "ProjectOut"
      },
      "ProjectUpdate": {
        "properties": {
          "name": {
            "title": "Name",
            "type": "string",
            "nullable": true
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "ProjectUpdate"
      },
      "PspFeeListResponse": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/PspFeeServiceOut"
            },
            "type": "array",
            "title": "Items"
          },
          "sync_status": {
            "$ref": "#/components/schemas/PspFeeSyncStatusOut",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "items",
          "sync_status"
        ],
        "title": "PspFeeListResponse"
      },
      "PspFeeServiceOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "psp_id": {
            "type": "string",
            "title": "Psp Id"
          },
          "psp_rag_soc": {
            "type": "string",
            "title": "Psp Rag Soc"
          },
          "codice_abi": {
            "type": "string",
            "title": "Codice Abi"
          },
          "nome_servizio": {
            "type": "string",
            "title": "Nome Servizio"
          },
          "descrizione_canale_mod_pag": {
            "type": "string",
            "title": "Descrizione Canale Mod Pag"
          },
          "inf_desc_serv": {
            "type": "string",
            "title": "Inf Desc Serv"
          },
          "inf_url_canale": {
            "title": "Inf Url Canale",
            "type": "string",
            "nullable": true
          },
          "url_informazioni_psp": {
            "title": "Url Informazioni Psp",
            "type": "string",
            "nullable": true
          },
          "tipo_vers_cod": {
            "type": "string",
            "title": "Tipo Vers Cod"
          },
          "canale_mod_pag": {
            "type": "string",
            "title": "Canale Mod Pag"
          },
          "canale_mod_pag_code": {
            "type": "integer",
            "title": "Canale Mod Pag Code"
          },
          "importo_minimo": {
            "title": "Importo Minimo",
            "type": "number",
            "nullable": true
          },
          "importo_massimo": {
            "title": "Importo Massimo",
            "type": "number",
            "nullable": true
          },
          "costo_fisso": {
            "title": "Costo Fisso",
            "type": "number",
            "nullable": true
          },
          "on_us": {
            "type": "boolean",
            "title": "On Us"
          },
          "carte": {
            "type": "boolean",
            "title": "Carte"
          },
          "conto": {
            "type": "boolean",
            "title": "Conto"
          },
          "altri_wisp": {
            "type": "boolean",
            "title": "Altri Wisp"
          },
          "altri_io": {
            "type": "boolean",
            "title": "Altri Io"
          },
          "conto_app": {
            "type": "boolean",
            "title": "Conto App"
          },
          "carte_app": {
            "type": "boolean",
            "title": "Carte App"
          },
          "is_duplicated": {
            "type": "boolean",
            "title": "Is Duplicated"
          }
        },
        "type": "object",
        "required": [
          "id",
          "psp_id",
          "psp_rag_soc",
          "codice_abi",
          "nome_servizio",
          "descrizione_canale_mod_pag",
          "inf_desc_serv",
          "inf_url_canale",
          "url_informazioni_psp",
          "tipo_vers_cod",
          "canale_mod_pag",
          "canale_mod_pag_code",
          "importo_minimo",
          "importo_massimo",
          "costo_fisso",
          "on_us",
          "carte",
          "conto",
          "altri_wisp",
          "altri_io",
          "conto_app",
          "carte_app",
          "is_duplicated"
        ],
        "title": "PspFeeServiceOut"
      },
      "PspFeeSyncResponse": {
        "properties": {
          "status": {
            "type": "string",
            "title": "Status"
          },
          "item_count": {
            "type": "integer",
            "title": "Item Count"
          }
        },
        "type": "object",
        "required": [
          "status",
          "item_count"
        ],
        "title": "PspFeeSyncResponse"
      },
      "PspFeeSyncStatusOut": {
        "properties": {
          "last_run": {
            "type": "string",
            "title": "Last Run"
          },
          "notebook_version": {
            "type": "string",
            "title": "Notebook Version"
          },
          "item_count": {
            "type": "integer",
            "title": "Item Count"
          },
          "synced_at": {
            "type": "string",
            "format": "date-time",
            "title": "Synced At"
          }
        },
        "type": "object",
        "required": [
          "last_run",
          "notebook_version",
          "item_count",
          "synced_at"
        ],
        "title": "PspFeeSyncStatusOut"
      },
      "ResourceAbsenceCreate": {
        "properties": {
          "resource_id": {
            "type": "string",
            "format": "uuid",
            "title": "Resource Id"
          },
          "absence_date": {
            "type": "string",
            "format": "date",
            "title": "Absence Date"
          },
          "absence_type": {
            "type": "string",
            "title": "Absence Type",
            "default": "ferie"
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "resource_id",
          "absence_date"
        ],
        "title": "ResourceAbsenceCreate"
      },
      "ResourceAbsenceOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "resource_id": {
            "type": "string",
            "format": "uuid",
            "title": "Resource Id"
          },
          "absence_date": {
            "type": "string",
            "format": "date",
            "title": "Absence Date"
          },
          "absence_type": {
            "type": "string",
            "title": "Absence Type"
          },
          "source": {
            "type": "string",
            "title": "Source"
          },
          "confluence_event_id": {
            "title": "Confluence Event Id",
            "type": "string",
            "nullable": true
          },
          "note": {
            "title": "Note",
            "type": "string",
            "nullable": true
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          }
        },
        "type": "object",
        "required": [
          "id",
          "resource_id",
          "absence_date",
          "absence_type",
          "source",
          "confluence_event_id",
          "note",
          "created_at"
        ],
        "title": "ResourceAbsenceOut"
      },
      "ResourceCostRow": {
        "properties": {
          "resource_id": {
            "type": "string",
            "format": "uuid",
            "title": "Resource Id"
          },
          "full_name": {
            "type": "string",
            "title": "Full Name"
          },
          "company": {
            "type": "string",
            "title": "Company"
          },
          "role": {
            "type": "string",
            "title": "Role"
          },
          "working_days": {
            "type": "integer",
            "title": "Working Days"
          },
          "absence_days": {
            "type": "integer",
            "title": "Absence Days"
          },
          "billable_days": {
            "type": "integer",
            "title": "Billable Days"
          },
          "daily_rate": {
            "type": "number",
            "title": "Daily Rate"
          },
          "total_cost": {
            "type": "number",
            "title": "Total Cost"
          }
        },
        "type": "object",
        "required": [
          "resource_id",
          "full_name",
          "company",
          "role",
          "working_days",
          "absence_days",
          "billable_days",
          "daily_rate",
          "total_cost"
        ],
        "title": "ResourceCostRow"
      },
      "RevisionResultEnum": {
        "type": "string",
        "enum": [
          "GO",
          "NO_GO",
          "PENDING"
        ],
        "title": "RevisionResultEnum"
      },
      "RoleMatrixResponse": {
        "properties": {
          "roles": {
            "items": {
              "$ref": "#/components/schemas/RoleOut"
            },
            "type": "array",
            "title": "Roles"
          },
          "catalog": {
            "items": {
              "$ref": "#/components/schemas/ActionCatalogEntry"
            },
            "type": "array",
            "title": "Catalog"
          },
          "matrix": {
            "additionalProperties": {
              "additionalProperties": {
                "type": "boolean"
              },
              "type": "object"
            },
            "type": "object",
            "title": "Matrix"
          }
        },
        "type": "object",
        "required": [
          "roles",
          "catalog",
          "matrix"
        ],
        "title": "RoleMatrixResponse"
      },
      "RoleOut": {
        "properties": {
          "key": {
            "type": "string",
            "title": "Key"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "is_system": {
            "type": "boolean",
            "title": "Is System"
          }
        },
        "type": "object",
        "required": [
          "key",
          "label",
          "is_system"
        ],
        "title": "RoleOut"
      },
      "RolePermissionUpdate": {
        "properties": {
          "permissions": {
            "additionalProperties": {
              "type": "boolean"
            },
            "type": "object",
            "title": "Permissions"
          }
        },
        "type": "object",
        "required": [
          "permissions"
        ],
        "title": "RolePermissionUpdate"
      },
      "RunOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "suite_id": {
            "type": "string",
            "format": "uuid",
            "title": "Suite Id"
          },
          "run_at": {
            "type": "string",
            "format": "date-time",
            "title": "Run At"
          },
          "passed": {
            "type": "integer",
            "title": "Passed"
          },
          "failed": {
            "type": "integer",
            "title": "Failed"
          },
          "skipped": {
            "type": "integer",
            "title": "Skipped"
          },
          "duration_ms": {
            "type": "integer",
            "title": "Duration Ms"
          },
          "allure_url": {
            "type": "string",
            "title": "Allure Url"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "synced_at": {
            "type": "string",
            "format": "date-time",
            "title": "Synced At"
          }
        },
        "type": "object",
        "required": [
          "id",
          "suite_id",
          "run_at",
          "passed",
          "failed",
          "skipped",
          "duration_ms",
          "allure_url",
          "status",
          "synced_at"
        ],
        "title": "RunOut"
      },
      "RunWithSuiteOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "suite_id": {
            "type": "string",
            "format": "uuid",
            "title": "Suite Id"
          },
          "run_at": {
            "type": "string",
            "format": "date-time",
            "title": "Run At"
          },
          "passed": {
            "type": "integer",
            "title": "Passed"
          },
          "failed": {
            "type": "integer",
            "title": "Failed"
          },
          "skipped": {
            "type": "integer",
            "title": "Skipped"
          },
          "duration_ms": {
            "type": "integer",
            "title": "Duration Ms"
          },
          "allure_url": {
            "type": "string",
            "title": "Allure Url"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "synced_at": {
            "type": "string",
            "format": "date-time",
            "title": "Synced At"
          },
          "suite_name": {
            "type": "string",
            "title": "Suite Name"
          },
          "suite_display_name": {
            "type": "string",
            "title": "Suite Display Name"
          }
        },
        "type": "object",
        "required": [
          "id",
          "suite_id",
          "run_at",
          "passed",
          "failed",
          "skipped",
          "duration_ms",
          "allure_url",
          "status",
          "synced_at",
          "suite_name",
          "suite_display_name"
        ],
        "title": "RunWithSuiteOut"
      },
      "SanpEnvironment": {
        "type": "string",
        "enum": [
          "SANP",
          "COLLAUDO",
          "PRODUZIONE"
        ],
        "title": "SanpEnvironment"
      },
      "SanpHealthChangeOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "level": {
            "type": "integer",
            "title": "Level"
          },
          "severity": {
            "$ref": "#/components/schemas/SanpSeverity"
          },
          "rule_id": {
            "type": "string",
            "title": "Rule Id"
          },
          "message": {
            "type": "string",
            "title": "Message"
          },
          "path": {
            "title": "Path",
            "type": "string",
            "nullable": true
          },
          "operation": {
            "title": "Operation",
            "type": "string",
            "nullable": true
          },
          "section": {
            "title": "Section",
            "type": "string",
            "nullable": true
          },
          "comment": {
            "title": "Comment",
            "type": "string",
            "nullable": true
          },
          "change_order": {
            "type": "integer",
            "title": "Change Order"
          }
        },
        "type": "object",
        "required": [
          "id",
          "level",
          "severity",
          "rule_id",
          "message",
          "path",
          "operation",
          "section",
          "comment",
          "change_order"
        ],
        "title": "SanpHealthChangeOut"
      },
      "SanpHealthLatestResponse": {
        "properties": {
          "report": {
            "$ref": "#/components/schemas/SanpHealthReportDetailOut",
            "nullable": true
          },
          "is_stale": {
            "type": "boolean",
            "title": "Is Stale"
          },
          "stale_reason": {
            "title": "Stale Reason",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "report",
          "is_stale",
          "stale_reason"
        ],
        "title": "SanpHealthLatestResponse"
      },
      "SanpHealthMatrixCellOut": {
        "properties": {
          "id": {
            "title": "Id",
            "type": "string",
            "format": "uuid",
            "nullable": true
          },
          "environment": {
            "$ref": "#/components/schemas/SanpEnvironment"
          },
          "status": {
            "$ref": "#/components/schemas/SanpResultStatus"
          },
          "source_branch": {
            "title": "Source Branch",
            "type": "string",
            "nullable": true
          },
          "target_apim": {
            "title": "Target Apim",
            "type": "string",
            "nullable": true
          },
          "display_name": {
            "title": "Display Name",
            "type": "string",
            "nullable": true
          },
          "description": {
            "title": "Description",
            "type": "string",
            "nullable": true
          },
          "error_count": {
            "type": "integer",
            "title": "Error Count"
          },
          "warning_count": {
            "type": "integer",
            "title": "Warning Count"
          },
          "info_count": {
            "type": "integer",
            "title": "Info Count"
          },
          "changes": {
            "items": {
              "$ref": "#/components/schemas/SanpHealthChangeOut"
            },
            "type": "array",
            "title": "Changes"
          }
        },
        "type": "object",
        "required": [
          "id",
          "environment",
          "status",
          "source_branch",
          "target_apim",
          "display_name",
          "description",
          "error_count",
          "warning_count",
          "info_count",
          "changes"
        ],
        "title": "SanpHealthMatrixCellOut"
      },
      "SanpHealthMatrixRowOut": {
        "properties": {
          "spec_name": {
            "type": "string",
            "title": "Spec Name"
          },
          "display_name": {
            "type": "string",
            "title": "Display Name"
          },
          "description": {
            "type": "string",
            "title": "Description"
          },
          "sanp": {
            "$ref": "#/components/schemas/SanpHealthMatrixCellOut"
          },
          "collaudo": {
            "$ref": "#/components/schemas/SanpHealthMatrixCellOut"
          },
          "produzione": {
            "$ref": "#/components/schemas/SanpHealthMatrixCellOut"
          }
        },
        "type": "object",
        "required": [
          "spec_name",
          "display_name",
          "description",
          "sanp",
          "collaudo",
          "produzione"
        ],
        "title": "SanpHealthMatrixRowOut"
      },
      "SanpHealthReportDetailOut": {
        "properties": {
          "report": {
            "$ref": "#/components/schemas/SanpHealthRunOut"
          },
          "sanp_version": {
            "title": "Sanp Version",
            "type": "string",
            "nullable": true
          },
          "items": {
            "items": {
              "$ref": "#/components/schemas/SanpHealthMatrixRowOut"
            },
            "type": "array",
            "title": "Items"
          }
        },
        "type": "object",
        "required": [
          "report",
          "sanp_version",
          "items"
        ],
        "title": "SanpHealthReportDetailOut"
      },
      "SanpHealthReportsResponse": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/SanpHealthRunOut"
            },
            "type": "array",
            "title": "Items"
          }
        },
        "type": "object",
        "required": [
          "items"
        ],
        "title": "SanpHealthReportsResponse"
      },
      "SanpHealthRunOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "github_run_id": {
            "type": "integer",
            "title": "Github Run Id"
          },
          "run_number": {
            "type": "integer",
            "title": "Run Number"
          },
          "head_sha": {
            "type": "string",
            "title": "Head Sha"
          },
          "workflow_branch": {
            "type": "string",
            "title": "Workflow Branch"
          },
          "conclusion": {
            "type": "string",
            "title": "Conclusion"
          },
          "html_url": {
            "type": "string",
            "title": "Html Url"
          },
          "started_at": {
            "type": "string",
            "format": "date-time",
            "title": "Started At"
          },
          "completed_at": {
            "type": "string",
            "format": "date-time",
            "title": "Completed At"
          },
          "synced_at": {
            "type": "string",
            "format": "date-time",
            "title": "Synced At"
          },
          "import_status": {
            "$ref": "#/components/schemas/SanpImportStatus"
          },
          "error_message": {
            "title": "Error Message",
            "type": "string",
            "nullable": true
          },
          "error_count": {
            "type": "integer",
            "title": "Error Count"
          },
          "warning_count": {
            "type": "integer",
            "title": "Warning Count"
          },
          "info_count": {
            "type": "integer",
            "title": "Info Count"
          }
        },
        "type": "object",
        "required": [
          "id",
          "github_run_id",
          "run_number",
          "head_sha",
          "workflow_branch",
          "conclusion",
          "html_url",
          "started_at",
          "completed_at",
          "synced_at",
          "import_status",
          "error_message",
          "error_count",
          "warning_count",
          "info_count"
        ],
        "title": "SanpHealthRunOut"
      },
      "SanpHealthSyncResult": {
        "properties": {
          "status": {
            "$ref": "#/components/schemas/SanpImportStatus"
          },
          "imported_run_count": {
            "type": "integer",
            "title": "Imported Run Count"
          },
          "errors": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Errors"
          }
        },
        "type": "object",
        "required": [
          "status",
          "imported_run_count",
          "errors"
        ],
        "title": "SanpHealthSyncResult"
      },
      "SanpHealthSyncStatusOut": {
        "properties": {
          "last_attempt_at": {
            "type": "string",
            "format": "date-time",
            "title": "Last Attempt At"
          },
          "last_success_at": {
            "title": "Last Success At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "last_error": {
            "title": "Last Error",
            "type": "string",
            "nullable": true
          },
          "imported_run_count": {
            "type": "integer",
            "title": "Imported Run Count"
          }
        },
        "type": "object",
        "required": [
          "last_attempt_at",
          "last_success_at",
          "last_error",
          "imported_run_count"
        ],
        "title": "SanpHealthSyncStatusOut"
      },
      "SanpImportStatus": {
        "type": "string",
        "enum": [
          "complete",
          "partial",
          "failed"
        ],
        "title": "SanpImportStatus"
      },
      "SanpResultStatus": {
        "type": "string",
        "enum": [
          "KO",
          "WARNING",
          "INFO",
          "OK",
          "NOT_CONFIGURED"
        ],
        "title": "SanpResultStatus"
      },
      "SanpSeverity": {
        "type": "string",
        "enum": [
          "error",
          "warning",
          "info"
        ],
        "title": "SanpSeverity"
      },
      "ScenarioCreate": {
        "properties": {
          "project_id": {
            "type": "string",
            "format": "uuid",
            "title": "Project Id"
          },
          "title": {
            "type": "string",
            "title": "Title"
          },
          "requirement": {
            "type": "string",
            "title": "Requirement"
          },
          "source_type": {
            "type": "string",
            "title": "Source Type"
          },
          "source_ref": {
            "title": "Source Ref",
            "type": "string",
            "nullable": true
          },
          "gherkin": {
            "type": "string",
            "title": "Gherkin"
          },
          "tags": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Tags",
            "default": []
          },
          "status": {
            "type": "string",
            "title": "Status",
            "default": "draft"
          },
          "ai_provider": {
            "type": "string",
            "title": "Ai Provider"
          },
          "ai_model": {
            "type": "string",
            "title": "Ai Model"
          },
          "generation_time_ms": {
            "title": "Generation Time Ms",
            "type": "integer",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "project_id",
          "title",
          "requirement",
          "source_type",
          "gherkin",
          "ai_provider",
          "ai_model"
        ],
        "title": "ScenarioCreate"
      },
      "ScenarioOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "project_id": {
            "type": "string",
            "format": "uuid",
            "title": "Project Id"
          },
          "title": {
            "type": "string",
            "title": "Title"
          },
          "requirement": {
            "type": "string",
            "title": "Requirement"
          },
          "source_type": {
            "type": "string",
            "title": "Source Type"
          },
          "source_ref": {
            "title": "Source Ref",
            "type": "string",
            "nullable": true
          },
          "gherkin": {
            "type": "string",
            "title": "Gherkin"
          },
          "tags": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Tags"
          },
          "status": {
            "type": "string",
            "title": "Status"
          },
          "ai_provider": {
            "type": "string",
            "title": "Ai Provider"
          },
          "ai_model": {
            "type": "string",
            "title": "Ai Model"
          },
          "generation_time_ms": {
            "title": "Generation Time Ms",
            "type": "integer",
            "nullable": true
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          }
        },
        "type": "object",
        "required": [
          "id",
          "project_id",
          "title",
          "requirement",
          "source_type",
          "source_ref",
          "gherkin",
          "tags",
          "status",
          "ai_provider",
          "ai_model",
          "generation_time_ms",
          "created_at",
          "updated_at"
        ],
        "title": "ScenarioOut"
      },
      "ScenarioStatusEnum": {
        "type": "string",
        "enum": [
          "PASSED",
          "FAILED",
          "BROKEN",
          "SKIPPED"
        ],
        "title": "ScenarioStatusEnum"
      },
      "ScenarioUpdate": {
        "properties": {
          "title": {
            "title": "Title",
            "type": "string",
            "nullable": true
          },
          "gherkin": {
            "title": "Gherkin",
            "type": "string",
            "nullable": true
          },
          "tags": {
            "title": "Tags",
            "items": {
              "type": "string"
            },
            "type": "array",
            "nullable": true
          },
          "status": {
            "title": "Status",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "title": "ScenarioUpdate"
      },
      "SettingsOut": {
        "properties": {
          "ai_provider": {
            "type": "string",
            "title": "Ai Provider"
          },
          "claude_api_key_set": {
            "type": "boolean",
            "title": "Claude Api Key Set"
          },
          "claude_model": {
            "type": "string",
            "title": "Claude Model"
          },
          "ollama_base_url": {
            "type": "string",
            "title": "Ollama Base Url"
          },
          "ollama_model": {
            "type": "string",
            "title": "Ollama Model"
          },
          "confluence_email": {
            "title": "Confluence Email",
            "type": "string",
            "nullable": true
          },
          "confluence_token_set": {
            "type": "boolean",
            "title": "Confluence Token Set"
          },
          "gherkin_language": {
            "type": "string",
            "title": "Gherkin Language"
          },
          "max_scenarios": {
            "type": "integer",
            "title": "Max Scenarios"
          }
        },
        "type": "object",
        "required": [
          "ai_provider",
          "claude_api_key_set",
          "claude_model",
          "ollama_base_url",
          "ollama_model",
          "confluence_email",
          "confluence_token_set",
          "gherkin_language",
          "max_scenarios"
        ],
        "title": "SettingsOut"
      },
      "SettingsUpdate": {
        "properties": {
          "ai_provider": {
            "title": "Ai Provider",
            "type": "string",
            "nullable": true
          },
          "claude_api_key": {
            "title": "Claude Api Key",
            "type": "string",
            "nullable": true
          },
          "claude_model": {
            "title": "Claude Model",
            "type": "string",
            "nullable": true
          },
          "ollama_base_url": {
            "title": "Ollama Base Url",
            "type": "string",
            "nullable": true
          },
          "ollama_model": {
            "title": "Ollama Model",
            "type": "string",
            "nullable": true
          },
          "confluence_email": {
            "title": "Confluence Email",
            "type": "string",
            "nullable": true
          },
          "confluence_api_token": {
            "title": "Confluence Api Token",
            "type": "string",
            "nullable": true
          },
          "gherkin_language": {
            "title": "Gherkin Language",
            "type": "string",
            "nullable": true
          },
          "max_scenarios": {
            "title": "Max Scenarios",
            "type": "integer",
            "nullable": true
          }
        },
        "type": "object",
        "title": "SettingsUpdate"
      },
      "SuiteCreate": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "display_name": {
            "type": "string",
            "title": "Display Name"
          },
          "suite_path": {
            "type": "string",
            "title": "Suite Path"
          },
          "github_repo": {
            "type": "string",
            "title": "Github Repo",
            "default": "pagopa/pagopa-platform-integration-test"
          },
          "enabled": {
            "type": "boolean",
            "title": "Enabled",
            "default": true
          },
          "sync_lookback_days": {
            "title": "Sync Lookback Days",
            "type": "integer",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "name",
          "display_name",
          "suite_path"
        ],
        "title": "SuiteCreate"
      },
      "SuiteOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "display_name": {
            "type": "string",
            "title": "Display Name"
          },
          "suite_path": {
            "type": "string",
            "title": "Suite Path"
          },
          "github_repo": {
            "type": "string",
            "title": "Github Repo"
          },
          "enabled": {
            "type": "boolean",
            "title": "Enabled"
          },
          "sync_lookback_days": {
            "title": "Sync Lookback Days",
            "type": "integer",
            "nullable": true
          },
          "last_synced_at": {
            "title": "Last Synced At",
            "type": "string",
            "format": "date-time",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "name",
          "display_name",
          "suite_path",
          "github_repo",
          "enabled",
          "sync_lookback_days",
          "last_synced_at"
        ],
        "title": "SuiteOut"
      },
      "SuiteUpdate": {
        "properties": {
          "display_name": {
            "title": "Display Name",
            "type": "string",
            "nullable": true
          },
          "suite_path": {
            "title": "Suite Path",
            "type": "string",
            "nullable": true
          },
          "github_repo": {
            "title": "Github Repo",
            "type": "string",
            "nullable": true
          },
          "enabled": {
            "title": "Enabled",
            "type": "boolean",
            "nullable": true
          },
          "sync_lookback_days": {
            "title": "Sync Lookback Days",
            "type": "integer",
            "nullable": true
          }
        },
        "type": "object",
        "title": "SuiteUpdate"
      },
      "SuiteWithLatestRunOut": {
        "properties": {
          "suite": {
            "$ref": "#/components/schemas/SuiteOut"
          },
          "latest_run": {
            "$ref": "#/components/schemas/RunOut",
            "nullable": true
          },
          "trend": {
            "items": {
              "type": "number"
            },
            "type": "array",
            "title": "Trend"
          }
        },
        "type": "object",
        "required": [
          "suite",
          "latest_run",
          "trend"
        ],
        "title": "SuiteWithLatestRunOut"
      },
      "SyncLoginRequest": {
        "properties": {
          "email": {
            "type": "string",
            "title": "Email"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "idp_sub": {
            "title": "Idp Sub",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "email",
          "name"
        ],
        "title": "SyncLoginRequest"
      },
      "SyncLoginResponse": {
        "properties": {
          "role": {
            "type": "string",
            "title": "Role"
          },
          "is_active": {
            "type": "boolean",
            "title": "Is Active"
          }
        },
        "type": "object",
        "required": [
          "role",
          "is_active"
        ],
        "title": "SyncLoginResponse"
      },
      "SyncResponse": {
        "properties": {
          "status": {
            "type": "string",
            "title": "Status"
          },
          "message": {
            "type": "string",
            "title": "Message"
          }
        },
        "type": "object",
        "required": [
          "status",
          "message"
        ],
        "title": "SyncResponse"
      },
      "SyncResult": {
        "properties": {
          "synced": {
            "type": "integer",
            "title": "Synced"
          },
          "errors": {
            "items": {
              "type": "string"
            },
            "type": "array",
            "title": "Errors"
          },
          "period_start": {
            "title": "Period Start",
            "type": "string",
            "nullable": true
          },
          "period_end": {
            "title": "Period End",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "synced",
          "errors"
        ],
        "title": "SyncResult"
      },
      "TestExecutionCreate": {
        "properties": {
          "run_id": {
            "type": "string",
            "format": "uuid",
            "title": "Run Id"
          },
          "allure_id": {
            "title": "Allure Id",
            "type": "string",
            "nullable": true
          },
          "status": {
            "title": "Status",
            "type": "string",
            "nullable": true
          },
          "scenario_name": {
            "title": "Scenario Name",
            "type": "string",
            "nullable": true
          },
          "allure_report": {
            "title": "Allure Report",
            "additionalProperties": true,
            "type": "object",
            "nullable": true
          },
          "duration_ms": {
            "title": "Duration Ms",
            "type": "integer",
            "nullable": true
          },
          "error_message": {
            "title": "Error Message",
            "type": "string",
            "nullable": true
          },
          "retries": {
            "title": "Retries",
            "type": "integer",
            "nullable": true
          },
          "revision_note": {
            "title": "Revision Note",
            "type": "string",
            "nullable": true
          },
          "allure_url": {
            "title": "Allure Url",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "run_id"
        ],
        "title": "TestExecutionCreate"
      },
      "TestExecutionOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "run_id": {
            "type": "string",
            "format": "uuid",
            "title": "Run Id"
          },
          "allure_id": {
            "title": "Allure Id",
            "type": "string",
            "nullable": true
          },
          "status": {
            "$ref": "#/components/schemas/ScenarioStatusEnum",
            "nullable": true
          },
          "scenario_name": {
            "title": "Scenario Name",
            "type": "string",
            "nullable": true
          },
          "allure_report": {
            "title": "Allure Report",
            "additionalProperties": true,
            "type": "object",
            "nullable": true
          },
          "duration_ms": {
            "title": "Duration Ms",
            "type": "integer",
            "nullable": true
          },
          "error_message": {
            "title": "Error Message",
            "type": "string",
            "nullable": true
          },
          "retries": {
            "title": "Retries",
            "type": "integer",
            "nullable": true
          },
          "revision_note": {
            "title": "Revision Note",
            "type": "string",
            "nullable": true
          },
          "allure_url": {
            "title": "Allure Url",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "run_id"
        ],
        "title": "TestExecutionOut"
      },
      "TestRunCreate": {
        "properties": {
          "suite_id": {
            "type": "string",
            "title": "Suite Id"
          },
          "scenario_qty": {
            "title": "Scenario Qty",
            "type": "integer",
            "nullable": true
          },
          "passed_scenario": {
            "title": "Passed Scenario",
            "type": "integer",
            "nullable": true
          },
          "failed_scenario": {
            "title": "Failed Scenario",
            "type": "integer",
            "nullable": true
          },
          "broken_scenario": {
            "title": "Broken Scenario",
            "type": "integer",
            "nullable": true
          },
          "skipped_scenario": {
            "title": "Skipped Scenario",
            "type": "integer",
            "nullable": true
          },
          "timestamp_start": {
            "title": "Timestamp Start",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "timestamp_end": {
            "title": "Timestamp End",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "duration_ms": {
            "title": "Duration Ms",
            "type": "integer",
            "nullable": true
          },
          "env": {
            "title": "Env",
            "type": "string",
            "nullable": true
          },
          "trigger_type": {
            "title": "Trigger Type",
            "type": "string",
            "nullable": true
          },
          "test_version": {
            "title": "Test Version",
            "type": "string",
            "nullable": true
          },
          "test_origin": {
            "title": "Test Origin",
            "type": "string",
            "nullable": true
          },
          "revisioned": {
            "title": "Revisioned",
            "default": false,
            "type": "boolean",
            "nullable": true
          },
          "revision_date": {
            "title": "Revision Date",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "revisioned_by": {
            "title": "Revisioned By",
            "type": "string",
            "nullable": true
          },
          "revision_result": {
            "$ref": "#/components/schemas/RevisionResultEnum",
            "nullable": true
          },
          "allure_url": {
            "title": "Allure Url",
            "type": "string",
            "nullable": true
          },
          "product_issue": {
            "title": "Product Issue",
            "type": "string",
            "nullable": true
          },
          "product_issue_status": {
            "title": "Product Issue Status",
            "type": "string",
            "nullable": true
          },
          "qa_issue": {
            "title": "Qa Issue",
            "type": "string",
            "nullable": true
          },
          "qa_issue_status": {
            "title": "Qa Issue Status",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "suite_id"
        ],
        "title": "TestRunCreate"
      },
      "TestRunOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "suite_id": {
            "type": "string",
            "format": "uuid",
            "title": "Suite Id"
          },
          "scenario_qty": {
            "title": "Scenario Qty",
            "type": "integer",
            "nullable": true
          },
          "passed_scenario": {
            "title": "Passed Scenario",
            "type": "integer",
            "nullable": true
          },
          "failed_scenario": {
            "title": "Failed Scenario",
            "type": "integer",
            "nullable": true
          },
          "broken_scenario": {
            "title": "Broken Scenario",
            "type": "integer",
            "nullable": true
          },
          "skipped_scenario": {
            "title": "Skipped Scenario",
            "type": "integer",
            "nullable": true
          },
          "timestamp_start": {
            "title": "Timestamp Start",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "timestamp_end": {
            "title": "Timestamp End",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "duration_ms": {
            "title": "Duration Ms",
            "type": "integer",
            "nullable": true
          },
          "env": {
            "$ref": "#/components/schemas/EnvEnum",
            "nullable": true
          },
          "trigger_type": {
            "$ref": "#/components/schemas/TriggerTypeEnum",
            "nullable": true
          },
          "test_version": {
            "title": "Test Version",
            "type": "string",
            "nullable": true
          },
          "test_origin": {
            "title": "Test Origin",
            "type": "string",
            "nullable": true
          },
          "revisioned": {
            "title": "Revisioned",
            "default": false,
            "type": "boolean",
            "nullable": true
          },
          "revision_date": {
            "title": "Revision Date",
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "revisioned_by": {
            "title": "Revisioned By",
            "type": "string",
            "nullable": true
          },
          "revision_result": {
            "$ref": "#/components/schemas/RevisionResultEnum",
            "nullable": true
          },
          "allure_url": {
            "title": "Allure Url",
            "type": "string",
            "nullable": true
          },
          "product_issue": {
            "title": "Product Issue",
            "type": "string",
            "nullable": true
          },
          "product_issue_status": {
            "title": "Product Issue Status",
            "type": "string",
            "nullable": true
          },
          "qa_issue": {
            "title": "Qa Issue",
            "type": "string",
            "nullable": true
          },
          "qa_issue_status": {
            "title": "Qa Issue Status",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "suite_id"
        ],
        "title": "TestRunOut"
      },
      "TestSuiteCreate": {
        "properties": {
          "test_object": {
            "type": "string",
            "title": "Test Object"
          },
          "test_type": {
            "type": "string",
            "title": "Test Type"
          },
          "suite_version": {
            "type": "string",
            "title": "Suite Version"
          },
          "owner_team": {
            "title": "Owner Team",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "test_object",
          "test_type",
          "suite_version"
        ],
        "title": "TestSuiteCreate"
      },
      "TestSuiteOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "test_object": {
            "type": "string",
            "title": "Test Object"
          },
          "test_type": {
            "type": "string",
            "title": "Test Type"
          },
          "suite_version": {
            "type": "string",
            "title": "Suite Version"
          },
          "owner_team": {
            "title": "Owner Team",
            "type": "string",
            "nullable": true
          }
        },
        "type": "object",
        "required": [
          "id",
          "test_object",
          "test_type",
          "suite_version"
        ],
        "title": "TestSuiteOut"
      },
      "TrendWeek": {
        "properties": {
          "week": {
            "type": "string",
            "title": "Week"
          },
          "label": {
            "type": "string",
            "title": "Label"
          },
          "created": {
            "type": "integer",
            "title": "Created"
          },
          "closed": {
            "type": "integer",
            "title": "Closed"
          }
        },
        "type": "object",
        "required": [
          "week",
          "label",
          "created",
          "closed"
        ],
        "title": "TrendWeek"
      },
      "TriggerTypeEnum": {
        "type": "string",
        "enum": [
          "MANUAL",
          "CRON",
          "CI_PIPELINE",
          "TAS",
          "QA_GATE"
        ],
        "title": "TriggerTypeEnum"
      },
      "TypeCount": {
        "properties": {
          "name": {
            "type": "string",
            "title": "Name"
          },
          "count": {
            "type": "integer",
            "title": "Count"
          },
          "phase": {
            "type": "string",
            "title": "Phase"
          }
        },
        "type": "object",
        "required": [
          "name",
          "count",
          "phase"
        ],
        "title": "TypeCount"
      },
      "UpdateNrtsObject": {
        "properties": {
          "test_suite": {
            "$ref": "#/components/schemas/TestSuiteOut",
            "nullable": true
          },
          "test_runs": {
            "title": "Test Runs",
            "items": {
              "$ref": "#/components/schemas/TestRunOut",
              "nullable": true
            },
            "type": "array",
            "nullable": true
          },
          "scenarios": {
            "title": "Scenarios",
            "items": {
              "$ref": "#/components/schemas/TestExecutionOut"
            },
            "type": "array",
            "nullable": true
          }
        },
        "type": "object",
        "title": "UpdateNrtsObject"
      },
      "UserListResponse": {
        "properties": {
          "items": {
            "items": {
              "$ref": "#/components/schemas/UserOut"
            },
            "type": "array",
            "title": "Items"
          }
        },
        "type": "object",
        "required": [
          "items"
        ],
        "title": "UserListResponse"
      },
      "UserOut": {
        "properties": {
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "email": {
            "type": "string",
            "title": "Email"
          },
          "name": {
            "type": "string",
            "title": "Name"
          },
          "role": {
            "type": "string",
            "title": "Role"
          },
          "is_active": {
            "type": "boolean",
            "title": "Is Active"
          },
          "created_at": {
            "type": "string",
            "format": "date-time",
            "title": "Created At"
          },
          "updated_at": {
            "type": "string",
            "format": "date-time",
            "title": "Updated At"
          }
        },
        "type": "object",
        "required": [
          "id",
          "email",
          "name",
          "role",
          "is_active",
          "created_at",
          "updated_at"
        ],
        "title": "UserOut"
      },
      "UserUpdate": {
        "properties": {
          "role": {
            "title": "Role",
            "type": "string",
            "nullable": true
          },
          "is_active": {
            "title": "Is Active",
            "type": "boolean",
            "nullable": true
          }
        },
        "type": "object",
        "title": "UserUpdate"
      },
      "ValidationError": {
        "properties": {
          "loc": {
            "items": {
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "integer"
                }
              ]
            },
            "type": "array",
            "title": "Location"
          },
          "msg": {
            "type": "string",
            "title": "Message"
          },
          "type": {
            "type": "string",
            "title": "Error Type"
          },
          "input": {
            "title": "Input"
          },
          "ctx": {
            "type": "object",
            "title": "Context"
          }
        },
        "type": "object",
        "required": [
          "loc",
          "msg",
          "type"
        ],
        "title": "ValidationError"
      }
    }
  }
}
