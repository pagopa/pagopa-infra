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
    "/api/v1/openapi.json": {
      "get": {
        "tags": [
          "openapi"
        ],
        "summary": "Openapi",
        "operationId": "openapi_api_v1_openapi_json_get",
        "responses": {
          "200": {
            "description": "Successful Response",
            "content": {
              "application/json": {
                "schema": {
                  "additionalProperties": true,
                  "type": "object",
                  "title": "Response Openapi Api V1 Openapi Json Get"
                }
              }
            }
          }
        }
      }
    },
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
              "allOf": [
                {
                  "$ref": "#/components/schemas/DqCategory"
                }
              ],
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
              "allOf": [
                {
                  "$ref": "#/components/schemas/DqCategory"
                }
              ],
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
        "operationId": "sync_confluence_api_v1_tm_absences_sync_confluence_post",
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
            "title": "File",
            "format": "binary"
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
            "nullable": true,
            "minimum": 0.0
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
            "allOf": [
              {
                "$ref": "#/components/schemas/GpdPositionSyncStatusOut"
              }
            ],
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
            "allOf": [
              {
                "$ref": "#/components/schemas/PspFeeSyncStatusOut"
              }
            ],
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
            "allOf": [
              {
                "$ref": "#/components/schemas/RunOut"
              }
            ],
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
          }
        },
        "type": "object",
        "required": [
          "synced",
          "errors"
        ],
        "title": "SyncResult"
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