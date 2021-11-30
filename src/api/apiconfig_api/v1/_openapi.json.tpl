{
  "swagger": "2.0",
  "info": {
    "description": "Spring Application exposes Api to manage configuration for EC/PSP on the Nodo dei Pagamenti",
    "termsOfService": "https://www.pagopa.gov.it/",
    "title": "PagoPA API configuration",
    "version": "0.2.23"
  },
  "host": "localhost:8080",
  "basePath": "/apiconfig/api/v1",
  "schemes": [
    "http"
  ],
  "paths": {
    "/brokers": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "default": 50,
            "description": "Number of elements on one page. Default = 50",
            "format": "int32",
            "in": "query",
            "name": "limit",
            "required": false,
            "type": "integer"
          },
          {
            "description": "Page number. Page value starts from 0",
            "format": "int32",
            "in": "query",
            "name": "page",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/Brokers"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getBrokers",
        "summary": "Get paginated list of creditor brokers"
      },
      "post": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/BrokerDetails"
            }
          }
        ],
        "responses": {
          "201": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/BrokerDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "createBroker",
        "summary": "Create a broker"
      }
    },
    "/brokers/{brokercode}": {
      "delete": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "broker code",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "brokercode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK."
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "deleteBroker",
        "summary": "Delete a broker"
      },
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "broker code.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "brokercode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/BrokerDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getBroker",
        "summary": "Get creditor broker details "
      },
      "put": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "broker code",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "brokercode",
            "required": true,
            "type": "string"
          },
          {
            "description": "The values to update of the broker",
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/BrokerDetails"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/BrokerDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "updateBroker",
        "summary": "Update a broker"
      }
    },
    "/brokerspsp": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "default": 50,
            "description": "Number of elements on one page. Default = 50",
            "format": "int32",
            "in": "query",
            "name": "limit",
            "required": false,
            "type": "integer"
          },
          {
            "description": "Page number. Page value starts from 0",
            "format": "int32",
            "in": "query",
            "name": "page",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/BrokersPsp"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Payment Service Providers"
        ],
        "operationId": "getBrokersPsp",
        "summary": "Get paginated list of PSP brokers"
      }
    },
    "/brokerspsp/{brokerpspcode}": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Broker code of a PSP.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "brokerpspcode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/BrokerPspDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Payment Service Providers"
        ],
        "operationId": "getBrokerPsp",
        "summary": "Get creditor broker details "
      }
    },
    "/counterparttables": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "default": 50,
            "description": "Number of elements on one page. Default = 50",
            "format": "int32",
            "in": "query",
            "name": "limit",
            "required": false,
            "type": "integer"
          },
          {
            "description": "Page number. Page value starts from 0",
            "format": "int32",
            "in": "query",
            "name": "page",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CounterpartTables"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getCounterpartTables",
        "summary": "Get the counterparties table"
      }
    },
    "/counterparttables/{idcounterparttable}": {
      "get": {
        "produces": [
          "application/xml",
          "application/json"
        ],
        "parameters": [
          {
            "description": "Id counterpart table",
            "in": "path",
            "name": "idcounterparttable",
            "required": true,
            "type": "string"
          },
          {
            "description": "Creditor institution code",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "format": "binary",
              "type": "string"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getCounterpartTable",
        "summary": "Download a XML file containing the details of a counterpart table"
      }
    },
    "/creditorinstitutions": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "default": 50,
            "description": "Number of elements on one page. Default = 50",
            "format": "int32",
            "in": "query",
            "name": "limit",
            "required": false,
            "type": "integer"
          },
          {
            "description": "Page number. Page value starts from 0",
            "format": "int32",
            "in": "query",
            "name": "page",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutions"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getCreditorInstitutions",
        "summary": "Get paginated list of creditor institutions"
      },
      "post": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionDetails"
            }
          }
        ],
        "responses": {
          "201": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "createCreditorInstitution",
        "summary": "Create creditor institution"
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}": {
      "delete": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 1,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK."
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "deleteCreditorInstitution",
        "summary": "Delete creditor institution"
      },
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 1,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getCreditorInstitution",
        "summary": "Get creditor institution details"
      },
      "put": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "The fiscal code of the Organization to update",
            "in": "path",
            "maxLength": 50,
            "minLength": 1,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          },
          {
            "description": "The values to update of the organization",
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionDetails"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "updateCreditorInstitution",
        "summary": "Update creditor institution"
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/encodings": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionEncodings"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getCreditorInstitutionEncodings",
        "summary": "Get creditor institution encodings"
      },
      "post": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/Encoding"
            }
          }
        ],
        "responses": {
          "201": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/Encoding"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "createCreditorInstitutionEncoding",
        "summary": "Delete a creditor institution encoding"
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/encodings/{encodingcode}": {
      "delete": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          },
          {
            "description": "Code of the Encoding",
            "in": "path",
            "name": "encodingcode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK."
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "deleteCreditorInstitutionEncoding",
        "summary": "Delete a creditor institution encoding"
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/ibans": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/Ibans"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getCreditorInstitutionsIbans",
        "summary": "Get creditor institution ibans"
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/stations": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionStationList"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getCreditorInstitutionStations",
        "summary": "Get station details and relation info with creditor institution"
      },
      "post": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionStationEdit"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionStationEdit"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "createCreditorInstitutionStation",
        "summary": "Create station details and relation info with creditor institution"
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/stations/{stationcode}": {
      "delete": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "in": "path",
            "maxLength": 50,
            "minLength": 1,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          },
          {
            "description": "station code.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "stationcode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK."
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "deleteCreditorInstitutionStation",
        "summary": "Delete a relation between creditor institution and station"
      },
      "put": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "The fiscal code of the Organization to update",
            "in": "path",
            "maxLength": 50,
            "minLength": 1,
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          },
          {
            "description": "station code.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "stationcode",
            "required": true,
            "type": "string"
          },
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionStationEdit"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/CreditorInstitutionStationEdit"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "updateCreditorInstitutionStation",
        "summary": "Update a relation between creditor institution and station"
      }
    },
    "/icas": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "default": 50,
            "description": "Number of elements on one page. Default = 50",
            "format": "int32",
            "in": "query",
            "name": "limit",
            "required": false,
            "type": "integer"
          },
          {
            "description": "Page number. Page value starts from 0",
            "format": "int32",
            "in": "query",
            "name": "page",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/Icas"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getIcas",
        "summary": "Get the list of ICAs"
      }
    },
    "/icas/{idica}": {
      "get": {
        "produces": [
          "application/xml",
          "application/json"
        ],
        "parameters": [
          {
            "description": "Id ICA",
            "in": "path",
            "name": "idica",
            "required": true,
            "type": "string"
          },
          {
            "description": "Creditor institution code",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "format": "binary",
              "type": "string"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getIca",
        "summary": "Download a XML file containing the details of an ICA"
      }
    },
    "/info": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [],
        "responses": {
          "200": {
            "description": "OK."
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Home"
        ],
        "operationId": "healthCheck",
        "summary": "Return OK if application is started"
      }
    },
    "/paymentserviceproviders": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "default": 50,
            "description": "Number of elements on one page. Default = 50",
            "format": "int32",
            "in": "query",
            "name": "limit",
            "required": false,
            "type": "integer"
          },
          {
            "description": "Page number. Page value starts from 0",
            "format": "int32",
            "in": "query",
            "name": "page",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/PaymentServiceProviders"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Payment Service Providers"
        ],
        "operationId": "getPaymentServiceProviders",
        "summary": "Get paginated list of Payment Service Providers"
      }
    },
    "/paymentserviceproviders/{pspcode}": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "Code of the payment service provider",
            "in": "path",
            "maxLength": 50,
            "minLength": 1,
            "name": "pspcode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/PaymentServiceProviderDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Payment Service Providers"
        ],
        "operationId": "getPaymentServiceProvider",
        "summary": "Get payment service provider details"
      }
    },
    "/stations": {
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "default": 50,
            "description": "Number of elements on one page. Default = 50",
            "format": "int32",
            "in": "query",
            "name": "limit",
            "required": false,
            "type": "integer"
          },
          {
            "description": "Page number. Page value starts from 0",
            "format": "int32",
            "in": "query",
            "name": "page",
            "required": true,
            "type": "integer"
          },
          {
            "description": "Filter by broker",
            "in": "query",
            "name": "brokercode",
            "required": false,
            "type": "string"
          },
          {
            "description": "Filter by creditor institution",
            "in": "query",
            "name": "creditorinstitutioncode",
            "required": false,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/Stations"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getStations",
        "summary": "Get paginated list of stations"
      },
      "post": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/StationDetails"
            }
          }
        ],
        "responses": {
          "201": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/StationDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "createStation",
        "summary": "Create a station"
      }
    },
    "/stations/{stationcode}": {
      "delete": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "station code",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "stationcode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK."
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "409": {
            "description": "Conflict",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "deleteStation",
        "summary": "Delete a station"
      },
      "get": {
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "station code.",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "stationcode",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/StationDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "getStation",
        "summary": "Get station details"
      },
      "put": {
        "consumes": [
          "application/json"
        ],
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "description": "station code",
            "in": "path",
            "maxLength": 50,
            "minLength": 0,
            "name": "stationcode",
            "required": true,
            "type": "string"
          },
          {
            "description": "The values to update of the station",
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/StationDetails"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "schema": {
              "$ref": "#/definitions/StationDetails"
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "404": {
            "description": "Not Found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ],
        "tags": [
          "Creditor Institutions"
        ],
        "operationId": "updateStation",
        "summary": "Update a station"
      }
    }
  },
  "definitions": {
    "Broker": {
      "properties": {
        "broker_code": {
          "example": "223344556677889900",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "description": {
          "example": "Lorem ipsum dolor sit amet",
          "maxLength": 255,
          "minLength": 0,
          "type": "string"
        },
        "enabled": {
          "type": "boolean"
        }
      },
      "required": [
        "broker_code",
        "description",
        "enabled"
      ],
      "type": "object"
    },
    "BrokerDetails": {
      "properties": {
        "broker_code": {
          "example": "223344556677889900",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "description": {
          "example": "Lorem ipsum dolor sit amet",
          "maxLength": 255,
          "minLength": 0,
          "type": "string"
        },
        "enabled": {
          "type": "boolean"
        },
        "extended_fault_bean": {
          "type": "boolean"
        }
      },
      "required": [
        "broker_code",
        "description",
        "enabled",
        "extended_fault_bean"
      ],
      "type": "object"
    },
    "BrokerPsp": {
      "properties": {
        "broker_psp_code": {
          "example": "223344556677889900",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "description": {
          "type": "string"
        },
        "enabled": {
          "type": "boolean"
        }
      },
      "required": [
        "broker_psp_code",
        "description",
        "enabled"
      ],
      "type": "object"
    },
    "BrokerPspDetails": {
      "properties": {
        "broker_psp_code": {
          "example": "223344556677889900",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "description": {
          "type": "string"
        },
        "enabled": {
          "type": "boolean"
        },
        "extended_fault_bean": {
          "type": "boolean"
        }
      },
      "required": [
        "broker_psp_code",
        "description",
        "enabled",
        "extended_fault_bean"
      ],
      "type": "object"
    },
    "Brokers": {
      "properties": {
        "brokers_list": {
          "items": {
            "$ref": "#/definitions/Broker"
          },
          "type": "array"
        },
        "page_info": {
          "$ref": "#/definitions/PageInfo"
        }
      },
      "required": [
        "brokers_list",
        "page_info"
      ],
      "type": "object"
    },
    "BrokersPsp": {
      "properties": {
        "brokers_psp_list": {
          "items": {
            "$ref": "#/definitions/BrokerPsp"
          },
          "type": "array"
        },
        "page_info": {
          "$ref": "#/definitions/PageInfo"
        }
      },
      "required": [
        "brokers_psp_list",
        "page_info"
      ],
      "type": "object"
    },
    "CounterpartTable": {
      "properties": {
        "business_name": {
          "example": "Comune di Lorem Ipsum",
          "type": "string"
        },
        "creditor_institution_code": {
          "example": "1234567890100",
          "type": "string"
        },
        "id_counterpart_table": {
          "example": "123456789",
          "type": "string"
        },
        "publication_date": {
          "format": "date-time",
          "type": "string"
        },
        "validity_date": {
          "format": "date-time",
          "type": "string"
        }
      },
      "required": [
        "business_name",
        "creditor_institution_code",
        "id_counterpart_table",
        "publication_date",
        "validity_date"
      ],
      "type": "object"
    },
    "CounterpartTables": {
      "properties": {
        "counterpart_tables": {
          "items": {
            "$ref": "#/definitions/CounterpartTable"
          },
          "type": "array"
        },
        "page_info": {
          "$ref": "#/definitions/PageInfo"
        }
      },
      "required": [
        "counterpart_tables",
        "page_info"
      ],
      "type": "object"
    },
    "CreditorInstitution": {
      "properties": {
        "business_name": {
          "example": "Comune di Lorem Ipsum",
          "maxLength": 70,
          "minLength": 0,
          "type": "string"
        },
        "creditor_institution_code": {
          "example": "1234567890100",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "enabled": {
          "default": true,
          "description": "creditor institution enabled",
          "type": "boolean"
        }
      },
      "required": [
        "business_name",
        "creditor_institution_code",
        "enabled"
      ],
      "type": "object"
    },
    "CreditorInstitutionAddress": {
      "properties": {
        "city": {
          "example": "Lorem",
          "type": "string"
        },
        "country_code": {
          "example": "RM",
          "pattern": "^\\w{2}$",
          "type": "string"
        },
        "location": {
          "example": "Via delle vie 3",
          "type": "string"
        },
        "tax_domicile": {
          "type": "string"
        },
        "zip_code": {
          "example": "00187",
          "pattern": "^\\d{5}$",
          "type": "string"
        }
      },
      "type": "object"
    },
    "CreditorInstitutionDetails": {
      "properties": {
        "address": {
          "$ref": "#/definitions/CreditorInstitutionAddress"
        },
        "business_name": {
          "example": "Comune di Lorem Ipsum",
          "maxLength": 70,
          "minLength": 0,
          "type": "string"
        },
        "creditor_institution_code": {
          "example": "1234567890100",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "enabled": {
          "default": true,
          "description": "creditor institution enabled",
          "type": "boolean"
        },
        "psp_payment": {
          "default": true,
          "type": "boolean"
        },
        "reporting_ftp": {
          "default": false,
          "type": "boolean"
        },
        "reporting_zip": {
          "default": false,
          "type": "boolean"
        }
      },
      "required": [
        "address",
        "business_name",
        "creditor_institution_code",
        "enabled",
        "psp_payment",
        "reporting_ftp",
        "reporting_zip"
      ],
      "type": "object"
    },
    "CreditorInstitutionEncodings": {
      "properties": {
        "encodings": {
          "items": {
            "$ref": "#/definitions/Encoding"
          },
          "type": "array"
        }
      },
      "required": [
        "encodings"
      ],
      "type": "object"
    },
    "CreditorInstitutionStation": {
      "properties": {
        "application_code": {
          "format": "int64",
          "type": "integer"
        },
        "aux_digit": {
          "format": "int64",
          "type": "integer"
        },
        "broadcast": {
          "type": "boolean"
        },
        "enabled": {
          "default": true,
          "description": "station enabled",
          "type": "boolean"
        },
        "mod4": {
          "type": "boolean"
        },
        "segregation_code": {
          "format": "int64",
          "type": "integer"
        },
        "station_code": {
          "example": "1234567890100",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "version": {
          "description": "number version",
          "format": "int64",
          "type": "integer"
        }
      },
      "required": [
        "enabled",
        "station_code",
        "version"
      ],
      "type": "object"
    },
    "CreditorInstitutionStationEdit": {
      "properties": {
        "application_code": {
          "format": "int64",
          "type": "integer"
        },
        "aux_digit": {
          "format": "int64",
          "type": "integer"
        },
        "broadcast": {
          "type": "boolean"
        },
        "mod4": {
          "type": "boolean"
        },
        "segregation_code": {
          "format": "int64",
          "type": "integer"
        },
        "station_code": {
          "example": "1234567890100",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        }
      },
      "required": [
        "station_code"
      ],
      "type": "object"
    },
    "CreditorInstitutionStationList": {
      "properties": {
        "stations_list": {
          "items": {
            "$ref": "#/definitions/CreditorInstitutionStation"
          },
          "type": "array"
        }
      },
      "required": [
        "stations_list"
      ],
      "type": "object"
    },
    "CreditorInstitutions": {
      "properties": {
        "creditor_institutions": {
          "items": {
            "$ref": "#/definitions/CreditorInstitution"
          },
          "type": "array"
        },
        "page_info": {
          "$ref": "#/definitions/PageInfo"
        }
      },
      "required": [
        "creditor_institutions",
        "page_info"
      ],
      "type": "object"
    },
    "Encoding": {
      "properties": {
        "code_type": {
          "enum": [
            "BARCODE_GS1_128",
            "QR_CODE",
            "BARCODE_128_AIM"
          ],
          "type": "string"
        },
        "encoding_code": {
          "example": "0000111",
          "type": "string"
        }
      },
      "required": [
        "code_type",
        "encoding_code"
      ],
      "type": "object"
    },
    "Iban": {
      "properties": {
        "iban": {
          "example": "IT99C0222211111000000000000",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "publication_date": {
          "format": "date-time",
          "type": "string"
        },
        "validity_date": {
          "format": "date-time",
          "type": "string"
        }
      },
      "required": [
        "iban",
        "publication_date",
        "validity_date"
      ],
      "type": "object"
    },
    "Ibans": {
      "properties": {
        "ibans": {
          "items": {
            "$ref": "#/definitions/Iban"
          },
          "type": "array"
        }
      },
      "required": [
        "ibans"
      ],
      "type": "object"
    },
    "Ica": {
      "properties": {
        "business_name": {
          "example": "Comune di Lorem Ipsum",
          "type": "string"
        },
        "creditor_institution_code": {
          "example": "1234567890100",
          "type": "string"
        },
        "id_ica": {
          "example": "123456789",
          "type": "string"
        },
        "publication_date": {
          "format": "date-time",
          "type": "string"
        },
        "validity_date": {
          "format": "date-time",
          "type": "string"
        }
      },
      "required": [
        "business_name",
        "creditor_institution_code",
        "id_ica",
        "publication_date",
        "validity_date"
      ],
      "type": "object"
    },
    "Icas": {
      "properties": {
        "icas": {
          "items": {
            "$ref": "#/definitions/Ica"
          },
          "type": "array"
        },
        "page_info": {
          "$ref": "#/definitions/PageInfo"
        }
      },
      "required": [
        "icas",
        "page_info"
      ],
      "type": "object"
    },
    "PageInfo": {
      "properties": {
        "items_found": {
          "description": "Number of items found. (The last page may have fewer elements than required)",
          "format": "int32",
          "type": "integer"
        },
        "limit": {
          "description": "Required number of items per page",
          "format": "int32",
          "type": "integer"
        },
        "page": {
          "description": "Page number",
          "format": "int32",
          "type": "integer"
        },
        "total_pages": {
          "description": "Total number of pages",
          "format": "int32",
          "type": "integer"
        }
      },
      "required": [
        "items_found",
        "limit",
        "page",
        "total_pages"
      ],
      "type": "object"
    },
    "PaymentServiceProvider": {
      "properties": {
        "business_name": {
          "type": "string"
        },
        "enabled": {
          "type": "boolean"
        },
        "psp_code": {
          "type": "string"
        }
      },
      "required": [
        "business_name",
        "enabled",
        "psp_code"
      ],
      "type": "object"
    },
    "PaymentServiceProviderDetails": {
      "properties": {
        "abi": {
          "type": "string"
        },
        "agid_psp": {
          "description": "True if the PSP is internal",
          "type": "boolean"
        },
        "bic": {
          "type": "string"
        },
        "business_name": {
          "type": "string"
        },
        "enabled": {
          "type": "boolean"
        },
        "my_bank_code": {
          "description": "MyBank code",
          "type": "string"
        },
        "psp_code": {
          "type": "string"
        },
        "stamp": {
          "format": "int64",
          "type": "integer"
        },
        "tax_code": {
          "type": "string"
        },
        "transfer": {
          "format": "int64",
          "type": "integer"
        },
        "vat_number": {
          "type": "string"
        }
      },
      "required": [
        "business_name",
        "enabled",
        "psp_code"
      ],
      "type": "object"
    },
    "PaymentServiceProviders": {
      "properties": {
        "page_info": {
          "$ref": "#/definitions/PageInfo"
        },
        "payment_service_providers": {
          "items": {
            "$ref": "#/definitions/PaymentServiceProvider"
          },
          "type": "array"
        }
      },
      "required": [
        "page_info",
        "payment_service_providers"
      ],
      "type": "object"
    },
    "ProblemJson": {
      "properties": {
        "detail": {
          "description": "A human readable explanation specific to this occurrence of the problem.",
          "example": "There was an error processing the request",
          "type": "string"
        },
        "instance": {
          "description": "An absolute URI that identifies the specific occurrence of the problem. It may or may not yield further information if dereferenced.",
          "format": "uri",
          "type": "string"
        },
        "status": {
          "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
          "example": 200,
          "format": "int32",
          "maximum": 600,
          "minimum": 100,
          "type": "integer"
        },
        "title": {
          "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable",
          "type": "string"
        },
        "type": {
          "description": "An absolute URI that identifies the problem type. When dereferenced, it SHOULD provide human-readable documentation for the problem type (e.g., using HTML).",
          "example": "https://example.com/problem/constraint-violation",
          "format": "uri",
          "type": "string"
        }
      },
      "type": "object"
    },
    "Station": {
      "properties": {
        "enabled": {
          "default": true,
          "description": "station enabled",
          "type": "boolean"
        },
        "station_code": {
          "example": "1234567890100",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "version": {
          "description": "number version",
          "format": "int64",
          "type": "integer"
        }
      },
      "required": [
        "enabled",
        "station_code",
        "version"
      ],
      "type": "object"
    },
    "StationDetails": {
      "properties": {
        "broker_code": {
          "type": "string"
        },
        "enabled": {
          "default": true,
          "description": "station enabled",
          "type": "boolean"
        },
        "flag_online": {
          "type": "boolean"
        },
        "ip": {
          "type": "string"
        },
        "ip_4mod": {
          "type": "string"
        },
        "new_password": {
          "type": "string"
        },
        "password": {
          "type": "string"
        },
        "port": {
          "format": "int64",
          "type": "integer"
        },
        "port_4mod": {
          "format": "int64",
          "type": "integer"
        },
        "protocol": {
          "type": "string"
        },
        "protocol_4mod": {
          "type": "string"
        },
        "proxy_enabled": {
          "type": "boolean"
        },
        "proxy_host": {
          "type": "string"
        },
        "proxy_password": {
          "type": "string"
        },
        "proxy_port": {
          "format": "int64",
          "type": "integer"
        },
        "proxy_username": {
          "type": "string"
        },
        "redirect_ip": {
          "type": "string"
        },
        "redirect_path": {
          "type": "string"
        },
        "redirect_port": {
          "format": "int64",
          "type": "integer"
        },
        "redirect_protocol": {
          "type": "string"
        },
        "redirect_query_string": {
          "type": "string"
        },
        "service": {
          "type": "string"
        },
        "service_4mod": {
          "type": "string"
        },
        "station_code": {
          "example": "1234567890100",
          "maxLength": 35,
          "minLength": 0,
          "type": "string"
        },
        "thread_number": {
          "format": "int64",
          "type": "integer"
        },
        "timeout_a": {
          "format": "int64",
          "type": "integer"
        },
        "timeout_b": {
          "format": "int64",
          "type": "integer"
        },
        "timeout_c": {
          "format": "int64",
          "type": "integer"
        },
        "version": {
          "description": "number version",
          "format": "int64",
          "type": "integer"
        }
      },
      "required": [
        "broker_code",
        "enabled",
        "ip",
        "password",
        "port",
        "protocol",
        "service",
        "station_code",
        "thread_number",
        "timeout_a",
        "timeout_b",
        "timeout_c",
        "version"
      ],
      "type": "object"
    },
    "Stations": {
      "properties": {
        "page_info": {
          "$ref": "#/definitions/PageInfo"
        },
        "stations": {
          "items": {
            "$ref": "#/definitions/Station"
          },
          "type": "array"
        }
      },
      "required": [
        "page_info",
        "stations"
      ],
      "type": "object"
    }
  },
  "securityDefinitions": {
    "ApiKey": {
      "description": "The API key to access this function app.",
      "in": "header",
      "name": "Ocp-Apim-Subscription-Key",
      "type": "apiKey"
    },
    "Authorization": {
      "bearerFormat": "JWT",
      "description": "JWT token get after Azure B2C Login",
      "in": "header",
      "name": "Authorization",
      "scheme": "Bearer",
      "type": "apiKey"
    }
  },
  "tags": [
    {
      "description": "Everything about Payment Service Providers",
      "name": "Payment Service Providers"
    },
    {
      "description": "Everything about Creditor Institution",
      "name": "Creditor Institutions"
    }
  ],
  "x-components": {}
}
