{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "core",
    "description" : "Spring application exposes APIs to manage configuration for CI/PSP on the Nodo dei Pagamenti",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.58.16"
  },
  "servers" : [ {
    "url": "${host}/apiconfig/api/v1"
  }, {
    "url" : "https://{host}{basePath}",
    "variables" : {
      "basePath" : {
        "default" : "/apiconfig/auth/api/v1",
        "enum" : [ "/apiconfig/auth/api/v1", "/apiconfig/api/v1" ]
      },
      "host" : {
        "default" : "api.dev.platform.pagopa.it",
        "enum" : [ "api.dev.platform.pagopa.it", "api.uat.platform.pagopa.it", "api.platform.pagopa.it" ]
      }
    }
  } ],
  "tags" : [ {
    "description" : "Everything about Iban",
    "name" : "Ibans"
  }, {
    "description" : "Everything about Utilities",
    "name" : "Utilities"
  } ],
  "paths" : {
    "/creditorinstitutions/{creditorinstitutioncode}/ibans" : {
      "get" : {
        "operationId" : "getCreditorInstitutionsIbans",
        "parameters" : [ {
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "in" : "path",
          "name" : "creditorinstitutioncode",
          "required" : true,
          "schema" : {
            "maxLength" : 50,
            "minLength" : 0,
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Ibans"
                }
              }
            },
            "description" : "OK"
          },
          "400" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Bad Request"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "404" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Not Found"
          },
          "429" : {
            "description" : "Too many requests"
          },
          "500" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get creditor institution ibans",
        "tags" : [ "Ibans" ]
      },
      "post" : {
        "operationId" : "createCreditorInstitutionsIbans",
        "parameters" : [ {
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "in" : "path",
          "name" : "creditorinstitutioncode",
          "required" : true,
          "schema" : {
            "maxLength" : 50,
            "minLength" : 0,
            "type" : "string"
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/IbanEnhanced"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "201" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/IbanEnhanced"
                }
              }
            },
            "description" : "Created"
          },
          "400" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Bad Request"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "404" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Not Found"
          },
          "409" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Conflict"
          },
          "422" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Unprocessable Entity"
          },
          "429" : {
            "description" : "Too many requests"
          },
          "500" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Create creditor institution ibans",
        "tags" : [ "Ibans" ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/ibans/enhanced" : {
      "get" : {
        "operationId" : "getCreditorInstitutionsIbansEnhanced",
        "parameters" : [ {
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "in" : "path",
          "name" : "creditorinstitutioncode",
          "required" : true,
          "schema" : {
            "maxLength" : 50,
            "minLength" : 0,
            "type" : "string"
          }
        }, {
          "description" : "Filter by label",
          "in" : "query",
          "name" : "label",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/IbansEnhanced"
                }
              }
            },
            "description" : "OK"
          },
          "400" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Bad Request"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "404" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Not Found"
          },
          "429" : {
            "description" : "Too many requests"
          },
          "500" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get creditor institution ibans enhanced",
        "tags" : [ "Ibans" ]
      }
    },
    "/creditorinstitutions/{creditorinstitutioncode}/ibans/list" : {
      "get" : {
        "operationId" : "getIbans",
        "parameters" : [ {
          "description" : "The fiscal code of the Organization.",
          "in" : "path",
          "name" : "creditorinstitutioncode",
          "required" : true,
          "schema" : {
            "maxLength" : 50,
            "minLength" : 0,
            "pattern" : "\\d{11}",
            "type" : "string"
          }
        }, {
          "description" : "Filter by label",
          "in" : "query",
          "name" : "label",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/IbansEnhanced"
                }
              }
            },
            "description" : "OK"
          },
          "400" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Bad Request"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "404" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Not Found"
          },
          "429" : {
            "description" : "Too many requests"
          },
          "500" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get creditor institution ibans list",
        "tags" : [ "Ibans" ]
      }
    },
    "/ibans/{iban}" : {
      "get" : {
        "operationId" : "getCreditorInstitutionsByIban",
        "parameters" : [ {
          "description" : "Iban to find",
          "in" : "path",
          "name" : "iban",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/CreditorInstitutionList"
                }
              }
            },
            "description" : "OK"
          },
          "400" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Bad Request"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "429" : {
            "description" : "Too many requests"
          },
          "500" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Get list of creditor institutions having IBAN",
        "tags" : [ "Utilities" ]
      }
    },
    "/info" : {
      "get" : {
        "operationId" : "healthCheck",
        "responses" : {
          "200" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/AppInfo"
                }
              }
            },
            "description" : "OK"
          },
          "400" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Bad Request"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "403" : {
            "description" : "Forbidden"
          },
          "429" : {
            "description" : "Too many requests"
          },
          "500" : {
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            },
            "description" : "Service unavailable"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        }, {
          "Authorization" : [ ]
        } ],
        "summary" : "Return OK if application is started",
        "tags" : [ "Home" ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "AppInfo" : {
        "required" : [ "environment", "name", "version" ],
        "type" : "object",
        "properties" : {
          "dbConnection" : {
            "type" : "string"
          },
          "environment" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          }
        }
      },
      "CreditorInstitution" : {
        "required" : [ "business_name", "creditor_institution_code", "enabled" ],
        "type" : "object",
        "properties" : {
          "business_name" : {
            "maxLength" : 70,
            "minLength" : 0,
            "type" : "string",
            "example" : "Comune di Lorem Ipsum"
          },
          "creditor_institution_code" : {
            "maxLength" : 35,
            "minLength" : 0,
            "type" : "string",
            "example" : "1234567890100"
          },
          "enabled" : {
            "type" : "boolean",
            "description" : "creditor institution enabled",
            "default" : true
          }
        }
      },
      "CreditorInstitutionList" : {
        "required" : [ "creditor_institutions" ],
        "type" : "object",
        "properties" : {
          "creditor_institutions" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/CreditorInstitution"
            }
          }
        }
      },
      "Iban" : {
        "required" : [ "iban", "validity_date" ],
        "type" : "object",
        "properties" : {
          "iban" : {
            "maxLength" : 35,
            "minLength" : 0,
            "type" : "string",
            "description" : "The iban code value",
            "example" : "IT99C0222211111000000000000"
          },
          "publication_date" : {
            "type" : "string",
            "description" : "The publication date of the iban",
            "format" : "date-time"
          },
          "validity_date" : {
            "type" : "string",
            "description" : "The date until which the iban is valid",
            "format" : "date-time"
          }
        }
      },
      "IbanEnhanced" : {
        "required" : [ "ci_owner", "due_date", "iban", "is_active", "publication_date", "validity_date" ],
        "type" : "object",
        "properties" : {
          "ci_owner" : {
            "maxLength" : 11,
            "minLength" : 0,
            "type" : "string",
            "description" : "Fiscal code of the Creditor Institution who owns the iban",
            "readOnly" : true,
            "example" : "77777777777"
          },
          "company_name" : {
            "maxLength" : 100,
            "minLength" : 0,
            "type" : "string",
            "description" : "The Creditor Institution company name",
            "readOnly" : true,
            "example" : "Comune di Firenze"
          },
          "description" : {
            "maxLength" : 300,
            "minLength" : 0,
            "type" : "string",
            "description" : "The description the Creditor Institution gives to the iban about its usage",
            "example" : "Riscossione Tributi"
          },
          "due_date" : {
            "type" : "string",
            "description" : "The date on which the iban will expire",
            "format" : "date-time",
            "example" : "2023-12-31T23:59:59.999Z"
          },
          "iban" : {
            "maxLength" : 35,
            "minLength" : 0,
            "pattern" : "[a-zA-Z]{2}\\d{2}[a-zA-Z0-9]{1,30}",
            "type" : "string",
            "description" : "The iban code",
            "example" : "IT99C0222211111000000000000"
          },
          "is_active" : {
            "type" : "boolean",
            "description" : "True if the iban is active",
            "example" : true
          },
          "labels" : {
            "type" : "array",
            "description" : "The labels array associated with the iban",
            "items" : {
              "$ref" : "#/components/schemas/IbanLabel"
            }
          },
          "publication_date" : {
            "type" : "string",
            "description" : "The date on which the iban has been inserted in the system",
            "format" : "date-time",
            "readOnly" : true,
            "example" : "2023-06-01T23:59:59.999Z"
          },
          "validity_date" : {
            "type" : "string",
            "description" : "The date the Creditor Institution wants the iban to be used for its payments",
            "format" : "date-time",
            "example" : "2023-04-01T13:49:19.897Z"
          }
        }
      },
      "IbanLabel" : {
        "required" : [ "description", "name" ],
        "type" : "object",
        "properties" : {
          "description" : {
            "type" : "string",
            "example" : "The IBAN to use for CUP payments"
          },
          "name" : {
            "type" : "string",
            "example" : "CUP"
          }
        },
        "description" : "The labels array associated with the iban"
      },
      "Ibans" : {
        "required" : [ "ibans" ],
        "type" : "object",
        "properties" : {
          "ibans" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/Iban"
            }
          }
        }
      },
      "IbansEnhanced" : {
        "required" : [ "ibans_enhanced" ],
        "type" : "object",
        "properties" : {
          "ibans_enhanced" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/IbanEnhanced"
            }
          }
        }
      },
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "type" : "apiKey",
        "description" : "The API key to access this function app.",
        "name" : "Ocp-Apim-Subscription-Key",
        "in" : "header"
      },
      "Authorization" : {
        "type" : "http",
        "description" : "JWT token get after Azure Login",
        "scheme" : "bearer",
        "bearerFormat" : "JWT"
      }
    }
  }
}