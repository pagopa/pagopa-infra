{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "PagoPA API Debt Position ${service}",
    "description" : "Progetto Gestione Posizioni Debitorie",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version": "0.15.0"
  },
  "servers" : [ {
    "url" : "https://api.uat.platform.pagopa.it/gpd/debt-positions-service/v3",
    "description" : "GPD Test environment"
  }, {
    "url" : "https://api.platform.pagopa.it/gpd/debt-positions-service/v3",
    "description" : "GPD Production Environment"
  } ],
  "paths" : {
    "/organizations/{organizationfiscalcode}/debtpositions" : {
      "get" : {
        "tags" : [ "Debt Positions API: Installments and Payment Options Manager" ],
        "summary" : "Return the list of the organization debt positions. The due dates interval is mutually exclusive with the payment dates interval.",
        "operationId" : "getOrganizationDebtPositions",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "limit",
          "in" : "query",
          "description" : "Number of elements on one page. Default = 50",
          "required" : false,
          "schema" : {
            "maximum" : 50,
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "name" : "page",
          "in" : "query",
          "description" : "Page number. Page value starts from 0",
          "required" : false,
          "schema" : {
            "minimum" : 0,
            "type" : "integer",
            "format" : "int32",
            "default" : 0
          }
        }, {
          "name" : "due_date_from",
          "in" : "query",
          "description" : "Filter from due_date (if provided use the format yyyy-MM-dd). If not provided will be set to 30 days before the due_date_to.",
          "required" : false,
          "schema" : {
            "type" : "string",
            "format" : "date"
          }
        }, {
          "name" : "due_date_to",
          "in" : "query",
          "description" : "Filter to due_date (if provided use the format yyyy-MM-dd). If not provided will be set to 30 days after the due_date_from.",
          "required" : false,
          "schema" : {
            "type" : "string",
            "format" : "date"
          }
        }, {
          "name" : "payment_date_from",
          "in" : "query",
          "description" : "Filter from payment_date (if provided use the format yyyy-MM-dd). If not provided will be set to 30 days before the payment_date_to.",
          "required" : false,
          "schema" : {
            "type" : "string",
            "format" : "date"
          }
        }, {
          "name" : "payment_date_to",
          "in" : "query",
          "description" : "Filter to payment_date (if provided use the format yyyy-MM-dd). If not provided will be set to 30 days after the payment_date_from",
          "required" : false,
          "schema" : {
            "type" : "string",
            "format" : "date"
          }
        }, {
          "name" : "status",
          "in" : "query",
          "description" : "Filter by debt position status",
          "required" : false,
          "schema" : {
            "type" : "string",
            "enum" : [ "DRAFT", "PUBLISHED", "VALID", "UNPAYABLE", "PARTIALLY_PAID", "PAID" ]
          }
        }, {
          "name" : "orderby",
          "in" : "query",
          "description" : "Order by INSERTED_DATE, COMPANY_NAME, IUPD or STATUS",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "INSERTED_DATE",
            "enum" : [ "INSERTED_DATE", "IUPD", "STATUS", "COMPANY_NAME" ]
          }
        }, {
          "name" : "ordering",
          "in" : "query",
          "description" : "Direction of ordering",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "DESC",
            "enum" : [ "ASC", "DESC" ]
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Obtained all organization payment positions.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentPositionsInfoV3"
                }
              }
            }
          },
          "400" : {
            "description" : "Malformed request.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "example" : {
                  "statusCode" : 403,
                  "message" : "You are not allowed to access this resource."
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "post" : {
        "tags" : [ "Debt Positions API: Installments and Payment Options Manager" ],
        "summary" : "The Organization creates a debt Position.",
        "operationId" : "createPosition",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "toPublish",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "boolean",
            "default" : false
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PaymentPositionModelV3"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "201" : {
            "description" : "Request created.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentPositionModelV3"
                }
              }
            }
          },
          "400" : {
            "description" : "Malformed request.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "example" : {
                  "statusCode" : 403,
                  "message" : "You are not allowed to access this resource."
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict: duplicate debt position found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/organizations/{organizationfiscalcode}/debtpositions/{iupd}" : {
      "get" : {
        "tags" : [ "Debt Positions API: Installments and Payment Options Manager" ],
        "summary" : "Return the details of a specific debt position.",
        "operationId" : "getOrganizationDebtPositionByIUPD",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "pattern" : "[\\w*\\h-]+",
            "type" : "string"
          }
        }, {
          "name" : "iupd",
          "in" : "path",
          "description" : "IUPD (Unique identifier of the debt position). Format could be `<Organization fiscal code + UUID>` this would make it unique within the new PD management system. It's the responsibility of the EC to guarantee uniqueness. The pagoPa system shall verify that this is `true` and if not, notify the EC.",
          "required" : true,
          "schema" : {
            "pattern" : "[\\w*\\h-]+",
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Obtained debt position details.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentPositionModelResponseV3"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "example" : {
                  "statusCode" : 403,
                  "message" : "You are not allowed to access this resource."
                }
              }
            }
          },
          "404" : {
            "description" : "No debt position found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "put" : {
        "tags" : [ "Debt Positions API: Installments and Payment Options Manager" ],
        "summary" : "The Organization updates a debt position ",
        "operationId" : "updatePosition",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "iupd",
          "in" : "path",
          "description" : "IUPD (Unique identifier of the debt position). Format could be `<Organization fiscal code + UUID>` this would make it unique within the new PD management system. It's the responsibility of the EC to guarantee uniqueness. The pagoPa system shall verify that this is `true` and if not, notify the EC.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "toPublish",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "boolean",
            "default" : false
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PaymentPositionModelV3"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "Debt Position updated.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentPositionModelV3"
                }
              }
            }
          },
          "400" : {
            "description" : "Malformed request.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "example" : {
                  "statusCode" : 403,
                  "message" : "You are not allowed to access this resource."
                }
              }
            }
          },
          "404" : {
            "description" : "No debt position found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict: existing related payment found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "delete" : {
        "tags" : [ "Debt Positions API: Installments and Payment Options Manager" ],
        "summary" : "The Organization deletes a debt position",
        "operationId" : "deletePosition",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "pattern" : "[\\w*\\h-]+",
            "type" : "string"
          }
        }, {
          "name" : "iupd",
          "in" : "path",
          "description" : "IUPD (Unique identifier of the debt position). Format could be `<Organization fiscal code + UUID>` this would make it unique within the new PD management system. It's the responsibility of the EC to guarantee uniqueness. The pagoPa system shall verify that this is `true` and if not, notify the EC.",
          "required" : true,
          "schema" : {
            "pattern" : "[\\w*\\h-]+",
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Operation completed successfully.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "example" : {
                  "statusCode" : 403,
                  "message" : "You are not allowed to access this resource."
                }
              }
            }
          },
          "404" : {
            "description" : "No debt position position found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict: existing related payment found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/organizations/{organizationfiscalcode}/debtpositions/{iupd}/publish" : {
      "post" : {
        "tags" : [ "Debt Position Actions API" ],
        "summary" : "The Organization publish a debt Position.",
        "operationId" : "publishPosition",
        "parameters" : [ {
          "name" : "organizationfiscalcode",
          "in" : "path",
          "description" : "Organization fiscal code, the fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "iupd",
          "in" : "path",
          "description" : "IUPD (Unique identifier of the debt position). Format could be `<Organization fiscal code + UUID>` this would make it unique within the new PD management system. It's the responsibility of the EC to guarantee uniqueness. The pagoPa system shall verify that this is `true` and if not, notify the EC.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Request published.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/PaymentPositionModelV3"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "example" : {
                  "statusCode" : 403,
                  "message" : "You are not allowed to access this resource."
                }
              }
            }
          },
          "404" : {
            "description" : "No debt position found.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict: debt position is not in publishable state.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "schema" : {
          "type" : "string"
        }
      } ]
    }
  },
  "components" : {
    "schemas" : {
      "DebtorModel" : {
        "required" : [ "fiscalCode", "fullName", "type" ],
        "type" : "object",
        "properties" : {
          "type" : {
            "type" : "string",
            "enum" : [ "F", "G" ]
          },
          "fiscalCode" : {
            "type" : "string"
          },
          "fullName" : {
            "type" : "string"
          },
          "streetName" : {
            "type" : "string"
          },
          "civicNumber" : {
            "type" : "string"
          },
          "postalCode" : {
            "type" : "string"
          },
          "city" : {
            "type" : "string"
          },
          "province" : {
            "type" : "string"
          },
          "region" : {
            "type" : "string"
          },
          "country" : {
            "pattern" : "[A-Z]{2}",
            "type" : "string",
            "example" : "IT"
          },
          "email" : {
            "type" : "string",
            "example" : "email@domain.com"
          },
          "phone" : {
            "type" : "string"
          }
        }
      },
      "InstallmentMetadataModel" : {
        "required" : [ "key" ],
        "type" : "object",
        "properties" : {
          "key" : {
            "type" : "string"
          },
          "value" : {
            "type" : "string"
          }
        }
      },
      "InstallmentModel" : {
        "required" : [ "amount", "description", "dueDate", "iuv" ],
        "type" : "object",
        "properties" : {
          "nav" : {
            "type" : "string"
          },
          "iuv" : {
            "type" : "string"
          },
          "amount" : {
            "minimum" : 1,
            "type" : "integer",
            "format" : "int64"
          },
          "description" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string"
          },
          "dueDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "fee" : {
            "type" : "integer",
            "format" : "int64",
            "readOnly" : true
          },
          "notificationFee" : {
            "type" : "integer",
            "format" : "int64",
            "readOnly" : true
          },
          "status" : {
            "type" : "string",
            "readOnly" : true,
            "enum" : [ "UNPAID", "PAID", "PARTIALLY_REPORTED", "REPORTED", "UNPAYABLE", "EXPIRED" ]
          },
          "transfer" : {
            "maxItems" : 2147483647,
            "minItems" : 1,
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferModel"
            }
          },
          "installmentMetadata" : {
            "maxItems" : 10,
            "minItems" : 0,
            "type" : "array",
            "description" : "it can added a maximum of 10 key-value pairs for metadata",
            "items" : {
              "$ref" : "#/components/schemas/InstallmentMetadataModel"
            }
          }
        }
      },
      "PaymentOptionModelV3" : {
        "required" : [ "debtor", "installments", "switchToExpired" ],
        "type" : "object",
        "properties" : {
          "description" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string",
            "writeOnly" : true
          },
          "validityDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "retentionDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "switchToExpired" : {
            "type" : "boolean",
            "description" : "feature flag to enable the payment option to expire after the due date",
            "example" : false,
            "default" : false
          },
          "debtor" : {
            "$ref" : "#/components/schemas/DebtorModel"
          },
          "installments" : {
            "maxItems" : 100,
            "minItems" : 1,
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/InstallmentModel"
            }
          }
        }
      },
      "PaymentPositionModelV3" : {
        "required" : [ "companyName", "iupd", "paymentOption" ],
        "type" : "object",
        "properties" : {
          "iupd" : {
            "type" : "string"
          },
          "payStandIn" : {
            "type" : "boolean",
            "description" : "feature flag to enable a debt position in stand-in mode",
            "example" : true,
            "default" : true
          },
          "companyName" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string"
          },
          "officeName" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string"
          },
          "paymentDate" : {
            "type" : "string",
            "format" : "date-time",
            "readOnly" : true
          },
          "status" : {
            "type" : "string",
            "readOnly" : true,
            "enum" : [ "DRAFT", "PUBLISHED", "VALID", "UNPAYABLE", "PARTIALLY_PAID", "PAID" ]
          },
          "paymentOption" : {
            "maxItems" : 100,
            "minItems" : 1,
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentOptionModelV3"
            }
          }
        }
      },
      "Stamp" : {
        "required" : [ "hashDocument", "provincialResidence", "stampType" ],
        "type" : "object",
        "properties" : {
          "hashDocument" : {
            "maxLength" : 72,
            "minLength" : 0,
            "type" : "string",
            "description" : "Document hash type is stBase64Binary72 as described in https://github.com/pagopa/pagopa-api."
          },
          "stampType" : {
            "maxLength" : 2,
            "minLength" : 2,
            "type" : "string",
            "description" : "The type of the stamp"
          },
          "provincialResidence" : {
            "pattern" : "[A-Z]{2}",
            "type" : "string",
            "description" : "The provincial of the residence",
            "example" : "RM"
          }
        }
      },
      "TransferMetadataModel" : {
        "required" : [ "key", "value" ],
        "type" : "object",
        "properties" : {
          "key" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string"
          },
          "value" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string"
          }
        },
        "description" : "it can added a maximum of 10 key-value pairs for metadata"
      },
      "TransferModel" : {
        "required" : [ "amount", "category", "idTransfer", "remittanceInformation" ],
        "type" : "object",
        "properties" : {
          "idTransfer" : {
            "type" : "string",
            "enum" : [ "1", "2", "3", "4", "5" ]
          },
          "amount" : {
            "minimum" : 1,
            "type" : "integer",
            "format" : "int64"
          },
          "organizationFiscalCode" : {
            "type" : "string",
            "description" : "Fiscal code related to the organization targeted by this transfer.",
            "example" : "00000000000"
          },
          "remittanceInformation" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string"
          },
          "category" : {
            "type" : "string"
          },
          "iban" : {
            "maxLength" : 35,
            "minLength" : 1,
            "pattern" : "^[A-Za-z0-9]{1,35}$",
            "type" : "string",
            "description" : "mutual exclusive with stamp",
            "example" : "IT0000000000000000000000000"
          },
          "postalIban" : {
            "maxLength" : 35,
            "minLength" : 1,
            "pattern" : "^$|^[A-Za-z0-9]{1,35}$",
            "type" : "string",
            "description" : "optional - can be combined with iban but not with stamp",
            "example" : "IT0000000000000000000000000"
          },
          "stamp" : {
            "$ref" : "#/components/schemas/Stamp"
          },
          "companyName" : {
            "maxLength" : 140,
            "minLength" : 0,
            "type" : "string"
          },
          "transferMetadata" : {
            "maxItems" : 10,
            "minItems" : 0,
            "type" : "array",
            "description" : "it can added a maximum of 10 key-value pairs for metadata",
            "items" : {
              "$ref" : "#/components/schemas/TransferMetadataModel"
            }
          }
        }
      },
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          }
        }
      },
      "InstallmentModelResponse" : {
        "type" : "object",
        "properties" : {
          "nav" : {
            "type" : "string"
          },
          "iuv" : {
            "type" : "string"
          },
          "organizationFiscalCode" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "description" : {
            "type" : "string"
          },
          "dueDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "reportingDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "pspCompany" : {
            "type" : "string"
          },
          "fee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "notificationFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "idReceipt" : {
            "type" : "string"
          },
          "idFlowReporting" : {
            "type" : "string"
          },
          "status" : {
            "type" : "string",
            "enum" : [ "UNPAID", "PAID", "PARTIALLY_REPORTED", "REPORTED", "UNPAYABLE", "EXPIRED" ]
          },
          "lastUpdatedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "installmentMetadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/InstallmentMetadataModel"
            }
          },
          "transfer" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferModelResponse"
            }
          }
        }
      },
      "PageInfo" : {
        "required" : [ "items_found", "limit", "page", "total_pages" ],
        "type" : "object",
        "properties" : {
          "page" : {
            "type" : "integer",
            "description" : "Page number",
            "format" : "int32"
          },
          "limit" : {
            "type" : "integer",
            "description" : "Required number of items per page",
            "format" : "int32"
          },
          "items_found" : {
            "type" : "integer",
            "description" : "Number of items found. (The last page may have fewer elements than required)",
            "format" : "int32"
          },
          "total_pages" : {
            "type" : "integer",
            "description" : "Total number of pages",
            "format" : "int32"
          }
        }
      },
      "PaymentOptionModelResponseV3" : {
        "type" : "object",
        "properties" : {
          "switchToExpired" : {
            "type" : "boolean"
          },
          "retentionDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "insertedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "validityDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "debtor" : {
            "$ref" : "#/components/schemas/DebtorModel"
          },
          "installments" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/InstallmentModelResponse"
            }
          }
        }
      },
      "PaymentPositionModelResponseV3" : {
        "type" : "object",
        "properties" : {
          "iupd" : {
            "type" : "string"
          },
          "organizationFiscalCode" : {
            "type" : "string"
          },
          "companyName" : {
            "type" : "string"
          },
          "officeName" : {
            "type" : "string"
          },
          "insertedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "publishDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "status" : {
            "type" : "string",
            "enum" : [ "DRAFT", "PUBLISHED", "VALID", "UNPAYABLE", "PARTIALLY_PAID", "PAID" ]
          },
          "lastUpdatedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "paymentOption" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentOptionModelResponseV3"
            }
          }
        }
      },
      "PaymentPositionsInfoV3" : {
        "required" : [ "page_info", "payment_position_list" ],
        "type" : "object",
        "properties" : {
          "payment_position_list" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PaymentPositionModelResponseV3"
            }
          },
          "page_info" : {
            "$ref" : "#/components/schemas/PageInfo"
          }
        }
      },
      "TransferMetadataModelResponse" : {
        "type" : "object",
        "properties" : {
          "key" : {
            "type" : "string"
          },
          "value" : {
            "type" : "string"
          }
        }
      },
      "TransferModelResponse" : {
        "type" : "object",
        "properties" : {
          "organizationFiscalCode" : {
            "type" : "string"
          },
          "companyName" : {
            "type" : "string"
          },
          "idTransfer" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "remittanceInformation" : {
            "type" : "string"
          },
          "category" : {
            "type" : "string"
          },
          "iban" : {
            "type" : "string"
          },
          "postalIban" : {
            "type" : "string"
          },
          "stamp" : {
            "$ref" : "#/components/schemas/Stamp"
          },
          "insertedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "status" : {
            "type" : "string",
            "enum" : [ "T_UNREPORTED", "T_REPORTED" ]
          },
          "lastUpdatedDate" : {
            "type" : "string",
            "format" : "date-time"
          },
          "transferMetadata" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferMetadataModelResponse"
            }
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
      }
    }
  }
}
