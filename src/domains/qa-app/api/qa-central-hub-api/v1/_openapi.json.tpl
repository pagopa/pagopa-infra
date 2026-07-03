{
  "openapi": "3.1.0",
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
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Status"
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
              "anyOf": [
                {
                  "type": "string",
                  "format": "uuid"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Project Id"
            }
          },
          {
            "name": "status",
            "in": "query",
            "required": false,
            "schema": {
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Status"
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
              "anyOf": [
                {
                  "type": "string",
                  "format": "uuid"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Suite Id"
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
              "anyOf": [
                {
                  "$ref": "#/components/schemas/DqCategory"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Category"
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
              "anyOf": [
                {
                  "type": "string",
                  "format": "uuid"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Domain Id"
            }
          },
          {
            "name": "category",
            "in": "query",
            "required": false,
            "schema": {
              "anyOf": [
                {
                  "$ref": "#/components/schemas/DqCategory"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Category"
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
      "DocItemCreate": {
        "properties": {
          "title": {
            "type": "string",
            "title": "Title"
          },
          "description": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Description"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Thumbnail Url"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Description"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Thumbnail Url"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Title"
          },
          "description": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Description"
          },
          "url": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Url"
          },
          "type": {
            "anyOf": [
              {
                "type": "string",
                "enum": [
                  "external",
                  "embedded"
                ]
              },
              {
                "type": "null"
              }
            ],
            "title": "Type"
          },
          "category": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Category"
          },
          "icon": {
            "anyOf": [
              {
                "type": "string",
                "enum": [
                  "confluence",
                  "page",
                  "template",
                  "web",
                  "video"
                ]
              },
              {
                "type": "null"
              }
            ],
            "title": "Icon"
          },
          "thumbnail_url": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Thumbnail Url"
          },
          "position": {
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Position"
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
          "created_at",
          "updated_at"
        ],
        "title": "DqCatalogControlOut"
      },
      "DqCatalogControlUpdate": {
        "properties": {
          "category": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Category"
          },
          "name": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Name"
          },
          "description": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Description"
          },
          "dimension_id": {
            "anyOf": [
              {
                "type": "string",
                "format": "uuid"
              },
              {
                "type": "null"
              }
            ],
            "title": "Dimension Id"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Owner"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Notes"
          }
        },
        "type": "object",
        "required": [
          "domain_id",
          "catalog_control_id",
          "table_ref",
          "field_ref",
          "risk",
          "impact"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Owner"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Notes"
          },
          "id": {
            "type": "string",
            "format": "uuid",
            "title": "Id"
          },
          "catalog_control": {
            "$ref": "#/components/schemas/DqCatalogControlOut"
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
          "id",
          "catalog_control",
          "created_at",
          "updated_at"
        ],
        "title": "DqControlInstanceOut"
      },
      "DqControlInstanceUpdate": {
        "properties": {
          "table_ref": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Table Ref"
          },
          "field_ref": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Field Ref"
          },
          "owner": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Owner"
          },
          "risk": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Risk"
          },
          "impact": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Impact"
          },
          "status": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Status"
          },
          "notes": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Notes"
          }
        },
        "type": "object",
        "title": "DqControlInstanceUpdate"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Name"
          },
          "sort_order": {
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Sort Order"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Name"
          },
          "sort_order": {
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Sort Order"
          }
        },
        "type": "object",
        "title": "DqDomainUpdate"
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
            "anyOf": [
              {
                "$ref": "#/components/schemas/GpdPositionSyncStatusOut"
              },
              {
                "type": "null"
              }
            ]
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Content"
          },
          "url": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Url"
          },
          "confluence_page_id": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Confluence Page Id"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Description"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Description"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Name"
          },
          "description": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Description"
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
            "anyOf": [
              {
                "$ref": "#/components/schemas/PspFeeSyncStatusOut"
              },
              {
                "type": "null"
              }
            ]
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Inf Url Canale"
          },
          "url_informazioni_psp": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Url Informazioni Psp"
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
            "anyOf": [
              {
                "type": "number"
              },
              {
                "type": "null"
              }
            ],
            "title": "Importo Minimo"
          },
          "importo_massimo": {
            "anyOf": [
              {
                "type": "number"
              },
              {
                "type": "null"
              }
            ],
            "title": "Importo Massimo"
          },
          "costo_fisso": {
            "anyOf": [
              {
                "type": "number"
              },
              {
                "type": "null"
              }
            ],
            "title": "Costo Fisso"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Source Ref"
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
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Generation Time Ms"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Source Ref"
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
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Generation Time Ms"
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
      "ScenarioUpdate": {
        "properties": {
          "title": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Title"
          },
          "gherkin": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Gherkin"
          },
          "tags": {
            "anyOf": [
              {
                "items": {
                  "type": "string"
                },
                "type": "array"
              },
              {
                "type": "null"
              }
            ],
            "title": "Tags"
          },
          "status": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Status"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Confluence Email"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Ai Provider"
          },
          "claude_api_key": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Claude Api Key"
          },
          "claude_model": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Claude Model"
          },
          "ollama_base_url": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Ollama Base Url"
          },
          "ollama_model": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Ollama Model"
          },
          "confluence_email": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Confluence Email"
          },
          "confluence_api_token": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Confluence Api Token"
          },
          "gherkin_language": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Gherkin Language"
          },
          "max_scenarios": {
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Max Scenarios"
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
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Sync Lookback Days"
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
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Sync Lookback Days"
          },
          "last_synced_at": {
            "anyOf": [
              {
                "type": "string",
                "format": "date-time"
              },
              {
                "type": "null"
              }
            ],
            "title": "Last Synced At"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Display Name"
          },
          "suite_path": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Suite Path"
          },
          "github_repo": {
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Github Repo"
          },
          "enabled": {
            "anyOf": [
              {
                "type": "boolean"
              },
              {
                "type": "null"
              }
            ],
            "title": "Enabled"
          },
          "sync_lookback_days": {
            "anyOf": [
              {
                "type": "integer"
              },
              {
                "type": "null"
              }
            ],
            "title": "Sync Lookback Days"
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
            "anyOf": [
              {
                "$ref": "#/components/schemas/RunOut"
              },
              {
                "type": "null"
              }
            ]
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Idp Sub"
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
            "anyOf": [
              {
                "type": "string"
              },
              {
                "type": "null"
              }
            ],
            "title": "Role"
          },
          "is_active": {
            "anyOf": [
              {
                "type": "boolean"
              },
              {
                "type": "null"
              }
            ],
            "title": "Is Active"
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
