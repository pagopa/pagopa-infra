{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API configuration",
    "description": "Spring application to manage configuration Api for EC/PSP on the Nodo component.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.2.8"
  },
  "servers": [
    {
      "url": "http://127.0.0.1:8080/apiconfig/api/v1",
      "description": "Generated server url"
    }
  ],
  "tags": [
    {
      "name": "Creditor Institutions",
      "description": "Everything about Creditor Institution"
    }
  ],
  "paths": {
    "/stations": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get paginated list of stations",
        "operationId": "getStations",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "brokercode",
            "in": "query",
            "description": "Filter by broker",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "creditorinstitutioncode",
            "in": "query",
            "description": "Filter by creditor institution",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Stations"
                }
              }
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/stations/{stationcode}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get station details",
        "operationId": "getStation",
        "parameters": [
          {
            "name": "stationcode",
            "in": "path",
            "description": "station code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "responses": {
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "404": {
            "description": "Not Found"
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/StationDetails"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "description": "OK."
          },
          "403": {
            "description": "Forbidden client error status.",
            "content": {
              "application/json": {}
            }
          },
          "429": {
            "description": "Too many requests",
            "content": {
              "application/json": {}
            }
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/creditorinstitutions": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get paginated list of creditor institutions",
        "operationId": "getCreditorInstitutions",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutions"
                }
              }
            }
          },
          "403": {
            "description": "Forbidden client error status.",
            "content": {
              "application/json": {}
            }
          },
          "429": {
            "description": "Too many requests",
            "content": {
              "application/json": {}
            }
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get creditor institution details",
        "operationId": "getCreditorInstitution",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "responses": {
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {}
            }
          },
          "403": {
            "description": "Forbidden client error status.",
            "content": {
              "application/json": {}
            }
          },
          "429": {
            "description": "Too many requests",
            "content": {
              "application/json": {}
            }
          },
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionDetails"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/stations": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get station details and relation info with creditor institution",
        "operationId": "getCreditorInstitutionStations",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionStationList"
                }
              }
            }
          },
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "404": {
            "description": "Not Found"
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/ibans": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get creditor institution ibans",
        "operationId": "getCreditorInstitutionsIbans",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "responses": {
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "404": {
            "description": "Not Found"
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Ibans"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/encodings": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get creditor institution encodings",
        "operationId": "getCreditorInstitutionEncodings",
        "parameters": [
          {
            "name": "creditorinstitutioncode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "responses": {
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "404": {
            "description": "Not Found"
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreditorInstitutionEncodings"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/brokers": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get paginated list of creditor brokers",
        "operationId": "getBrokers",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "Number of elements on one page. Default = 50",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "Page number. Page value starts from 0",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "403": {
            "description": "Forbidden client error status."
          },
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Brokers"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    },
    "/brokers/{brokercode}": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get creditor broker details ",
        "operationId": "getBroker",
        "parameters": [
          {
            "name": "brokercode",
            "in": "path",
            "description": "broker code.",
            "required": true,
            "schema": {
              "maxLength": 50,
              "minLength": 0,
              "type": "string"
            }
          }
        ],
        "responses": {
          "403": {
            "description": "Forbidden client error status."
          },
          "429": {
            "description": "Too many requests"
          },
          "404": {
            "description": "Not Found"
          },
          "200": {
            "description": "OK.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BrokerDetails"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      }
    }
  },
  "components": {
    "schemas": {
      "PageInfo": {
        "required": [
          "items_found",
          "limit",
          "page",
          "total_pages"
        ],
        "type": "object",
        "properties": {
          "page": {
            "type": "integer",
            "description": "Page number",
            "format": "int32"
          },
          "limit": {
            "type": "integer",
            "description": "Required number of items per page",
            "format": "int32"
          },
          "items_found": {
            "type": "integer",
            "description": "Number of items found. (The last page may have fewer elements than required)",
            "format": "int32"
          },
          "total_pages": {
            "type": "integer",
            "description": "Total number of pages",
            "format": "int32"
          }
        }
      },
      "Station": {
        "required": [
          "enabled",
          "station_code",
          "version"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "version": {
            "type": "integer",
            "description": "number version",
            "format": "int64"
          }
        }
      },
      "Stations": {
        "required": [
          "page_info",
          "stations"
        ],
        "type": "object",
        "properties": {
          "stations": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Station"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "description": "An absolute URI that identifies the problem type. When dereferenced, it SHOULD provide human-readable documentation for the problem type (e.g., using HTML).",
            "format": "uri",
            "example": "https://example.com/problem/constraint-violation"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 200
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "There was an error processing the request"
          },
          "instance": {
            "type": "string",
            "description": "An absolute URI that identifies the specific occurrence of the problem. It may or may not yield further information if dereferenced.",
            "format": "uri"
          }
        }
      },
      "StationDetails": {
        "required": [
          "enabled",
          "station_code",
          "version"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "version": {
            "type": "integer",
            "description": "number version",
            "format": "int64"
          },
          "ip": {
            "type": "string"
          },
          "new_password": {
            "type": "string"
          },
          "password": {
            "type": "string"
          },
          "port": {
            "type": "integer",
            "format": "int64"
          },
          "redirect_ip": {
            "type": "string"
          },
          "redirect_path": {
            "type": "string"
          },
          "redirect_port": {
            "type": "integer",
            "format": "int64"
          },
          "redirect_query_string": {
            "type": "string"
          },
          "service": {
            "type": "string"
          },
          "redirect_protocol": {
            "type": "string"
          },
          "protocol_4mod": {
            "type": "string"
          },
          "ip_4mod": {
            "type": "string"
          },
          "port_4mod": {
            "type": "integer",
            "format": "int64"
          },
          "service_4mod": {
            "type": "string"
          },
          "proxy_enabled": {
            "type": "boolean"
          },
          "proxy_host": {
            "type": "string"
          },
          "proxy_port": {
            "type": "integer",
            "format": "int64"
          },
          "proxy_username": {
            "type": "string"
          },
          "proxy_password": {
            "type": "string"
          },
          "protocol": {
            "type": "string"
          },
          "thread_number": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_a": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_b": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_c": {
            "type": "integer",
            "format": "int64"
          },
          "flag_online": {
            "type": "boolean"
          }
        }
      },
      "CreditorInstitution": {
        "required": [
          "business_name",
          "creditor_institution_code",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "creditor institution enabled",
            "default": true
          },
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          }
        }
      },
      "CreditorInstitutions": {
        "required": [
          "creditor_institutions",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "creditor_institutions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CreditorInstitution"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "CreditorInstitutionAddress": {
        "type": "object",
        "properties": {
          "location": {
            "type": "string",
            "example": "Via delle vie 3"
          },
          "city": {
            "type": "string",
            "example": "Lorem"
          },
          "zip_code": {
            "pattern": "^\\d{5}$",
            "type": "string",
            "example": "00187"
          },
          "country_code": {
            "pattern": "^\\w{2}$",
            "type": "string",
            "example": "RM"
          },
          "tax_domicile": {
            "type": "string"
          }
        }
      },
      "CreditorInstitutionDetails": {
        "required": [
          "address",
          "business_name",
          "creditor_institution_code",
          "enabled",
          "fk_int_quadrature",
          "psp_payment",
          "reporting_ftp",
          "reporting_zip"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "creditor institution enabled",
            "default": true
          },
          "business_name": {
            "maxLength": 70,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Lorem Ipsum"
          },
          "address": {
            "$ref": "#/components/schemas/CreditorInstitutionAddress"
          },
          "fk_int_quadrature": {
            "type": "integer",
            "format": "int64"
          },
          "psp_payment": {
            "type": "boolean",
            "default": true
          },
          "reporting_ftp": {
            "type": "boolean",
            "default": false
          },
          "reporting_zip": {
            "type": "boolean",
            "default": false
          }
        }
      },
      "CreditorInstitutionStation": {
        "required": [
          "enabled",
          "station_code",
          "version"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "1234567890100"
          },
          "enabled": {
            "type": "boolean",
            "description": "station enabled",
            "default": true
          },
          "version": {
            "type": "integer",
            "description": "number version",
            "format": "int64"
          },
          "application_code": {
            "type": "integer",
            "format": "int64"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "segregation_code": {
            "type": "integer",
            "format": "int64"
          },
          "mod4": {
            "type": "boolean"
          },
          "broadcast": {
            "type": "boolean"
          }
        }
      },
      "CreditorInstitutionStationList": {
        "required": [
          "stations_list"
        ],
        "type": "object",
        "properties": {
          "stations_list": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/CreditorInstitutionStation"
            }
          }
        }
      },
      "Iban": {
        "required": [
          "iban",
          "publication_date",
          "validity_date"
        ],
        "type": "object",
        "properties": {
          "iban": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "IT99C0222211111000000000000"
          },
          "validity_date": {
            "type": "string",
            "format": "date-time"
          },
          "publication_date": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "Ibans": {
        "required": [
          "ibans"
        ],
        "type": "object",
        "properties": {
          "ibans": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Iban"
            }
          }
        }
      },
      "CreditorInstitutionEncodings": {
        "required": [
          "encodings"
        ],
        "type": "object",
        "properties": {
          "encodings": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Encoding"
            }
          }
        }
      },
      "Encoding": {
        "required": [
          "code",
          "code_type"
        ],
        "type": "object",
        "properties": {
          "code_type": {
            "type": "string",
            "enum": [
              "BARCODE_GS1_128",
              "QR_CODE",
              "BARCODE_128_AIM"
            ]
          },
          "code": {
            "type": "string"
          }
        }
      },
      "Broker": {
        "required": [
          "broker_code",
          "description",
          "enabled"
        ],
        "type": "object",
        "properties": {
          "broker_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "enabled": {
            "type": "boolean"
          },
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          }
        }
      },
      "Brokers": {
        "required": [
          "brokers_list",
          "page_info"
        ],
        "type": "object",
        "properties": {
          "brokers_list": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Broker"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        }
      },
      "BrokerDetails": {
        "required": [
          "broker_code",
          "description",
          "enabled",
          "extended_fault_bean"
        ],
        "type": "object",
        "properties": {
          "broker_code": {
            "maxLength": 35,
            "minLength": 0,
            "type": "string",
            "example": "223344556677889900"
          },
          "enabled": {
            "type": "boolean"
          },
          "description": {
            "maxLength": 255,
            "minLength": 0,
            "type": "string",
            "example": "Lorem ipsum dolor sit amet"
          },
          "extended_fault_bean": {
            "type": "boolean"
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "X-Functions-Key",
        "in": "header"
      }
    }
  }
}
