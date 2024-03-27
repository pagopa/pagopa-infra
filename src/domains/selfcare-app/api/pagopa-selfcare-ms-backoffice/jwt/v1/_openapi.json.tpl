{
  "openapi" : "3.0.3",
  "info" : {
    "title" : "pagopa-selfcare-ms-backoffice",
    "description" : "PagoPa backoffice API documentation",
    "version" : "0.4.0"
  },
  "servers" : [ {
    "url" : "https://${host}/${basePath}",
    "description" : "Inferred Url"
  } ],
  "tags" : [ {
    "name" : "channels",
    "description" : "Api config channels operations"
  }, {
    "name" : "creditor-institutions",
    "description" : "Api Config creditor institution's operations"
  }, {
    "name" : "institution",
    "description" : "Institution operations"
  }, {
    "name" : "stations",
    "description" : "Api config stations operations"
  } ],
  "paths" : {
    "/institutions" : {
      "get" : {
        "tags" : [ "institution" ],
        "summary" : "getInstitutions",
        "description" : "Retrieves all the onboarded institutions related to the logged user",
        "operationId" : "getInstitutionsUsingGET",
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "type" : "array",
                  "items" : {
                    "$ref" : "#/components/schemas/InstitutionResource"
                  }
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      }
    },
    "/institutions/delegations" : {
      "get" : {
        "tags" : [ "institution" ],
        "summary" : "getBrokerDelegation",
        "description" : "retrieve all active products for given institution and logged user",
        "operationId" : "getBrokerDelegationUsingGET",
        "parameters" : [ {
          "name" : "institutionId",
          "in" : "query",
          "description" : "Institution's unique internal identifier",
          "required" : false,
          "style" : "form",
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "brokerId",
          "in" : "query",
          "description" : "Broker's unique id",
          "required" : false,
          "style" : "form",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "type" : "array",
                  "items" : {
                    "$ref" : "#/components/schemas/DelegationResource"
                  }
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      }
    },
    "/institutions/{institutionId}" : {
      "get" : {
        "tags" : [ "institution" ],
        "summary" : "getInstitution",
        "description" : "Retrieves an institution's details",
        "operationId" : "getInstitutionUsingGET",
        "parameters" : [ {
          "name" : "institutionId",
          "in" : "path",
          "description" : "Institution's unique internal identifier",
          "required" : true,
          "style" : "simple",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/InstitutionDetailResource"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      }
    },
    "/institutions/{institutionId}/api-keys" : {
      "get" : {
        "tags" : [ "institution" ],
        "summary" : "getInstitutionApiKeys",
        "description" : "Retrieve an institution's primary and secondary keys",
        "operationId" : "getInstitutionApiKeysUsingGET",
        "parameters" : [ {
          "name" : "institutionId",
          "in" : "path",
          "description" : "Institution's unique internal identifier",
          "required" : true,
          "style" : "simple",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "type" : "array",
                  "items" : {
                    "$ref" : "#/components/schemas/ApiKeysResource"
                  }
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      },
      "post" : {
        "tags" : [ "institution" ],
        "summary" : "createInstitutionApiKeys",
        "description" : "Creates a new subscription for a given Institution and returns its primary and secondary keys",
        "operationId" : "createInstitutionApiKeysUsingPOST",
        "parameters" : [ {
          "name" : "institutionId",
          "in" : "path",
          "description" : "Institution's unique internal identifier",
          "required" : true,
          "style" : "simple",
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "subscriptionCode",
          "in" : "query",
          "description" : "subscription's unique internal identifier",
          "required" : true,
          "style" : "form",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "201" : {
            "description" : "Created",
            "content" : {
              "application/json" : {
                "schema" : {
                  "type" : "array",
                  "items" : {
                    "$ref" : "#/components/schemas/ApiKeysResource"
                  }
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      }
    },
    "/institutions/{institutionId}/products" : {
      "get" : {
        "tags" : [ "institution" ],
        "summary" : "getInstitutionProducts",
        "description" : "retrieve all active products for given institution and logged user",
        "operationId" : "getInstitutionProductsUsingGET",
        "parameters" : [ {
          "name" : "institutionId",
          "in" : "path",
          "description" : "Institution's unique internal identifier",
          "required" : true,
          "style" : "simple",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "type" : "array",
                  "items" : {
                    "$ref" : "#/components/schemas/ProductsResource"
                  }
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      }
    },
    "/institutions/{subscriptionid}/api-keys/primary/regenerate" : {
      "post" : {
        "tags" : [ "institution" ],
        "summary" : "regeneratePrimaryKey",
        "description" : "Regenerates the subscription's primary key",
        "operationId" : "regeneratePrimaryKeyUsingPOST",
        "parameters" : [ {
          "name" : "subscriptionid",
          "in" : "path",
          "description" : "Institution's subscription id",
          "required" : true,
          "style" : "simple",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "204" : {
            "description" : "No Content"
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      }
    },
    "/institutions/{subscriptionid}/api-keys/secondary/regenerate" : {
      "post" : {
        "tags" : [ "institution" ],
        "summary" : "regenerateSecondaryKey",
        "description" : "Regenerates the subscription's secondary key",
        "operationId" : "regenerateSecondaryKeyUsingPOST",
        "parameters" : [ {
          "name" : "subscriptionid",
          "in" : "path",
          "description" : "Institution's subscription id",
          "required" : true,
          "style" : "simple",
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "204" : {
            "description" : "No Content"
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          },
          "500" : {
            "description" : "Internal Server Error",
            "content" : {
              "application/problem+json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/Problem"
                }
              }
            }
          }
        },
        "security" : [ {
          "bearerAuth" : [ "global" ]
        } ]
      }
    }
  },
  "components" : {
    "schemas" : {
      "ApiKeysResource" : {
        "title" : "ApiKeysResource",
        "required" : [ "displayName", "id", "primaryKey", "secondaryKey" ],
        "type" : "object",
        "properties" : {
          "displayName" : {
            "type" : "string",
            "description" : "Institution's name Api Key"
          },
          "id" : {
            "type" : "string",
            "description" : "Institution's subscription id"
          },
          "primaryKey" : {
            "type" : "string",
            "description" : "Institution's primary Api Key"
          },
          "secondaryKey" : {
            "type" : "string",
            "description" : "Institution's secondary Api Key"
          }
        }
      },
      "AssistanceContactsResource" : {
        "title" : "AssistanceContactsResource",
        "type" : "object",
        "properties" : {
          "supportEmail" : {
            "type" : "string",
            "description" : "Institution's support email contact"
          },
          "supportPhone" : {
            "type" : "string",
            "description" : "Institution's support phone contact"
          }
        }
      },
      "AttributeResource" : {
        "title" : "AttributeResource",
        "required" : [ "code", "description", "origin" ],
        "type" : "object",
        "properties" : {
          "code" : {
            "type" : "string",
            "description" : "Institution's code"
          },
          "description" : {
            "type" : "string",
            "description" : "Institution's name"
          },
          "origin" : {
            "type" : "string",
            "description" : "Institution data origin"
          }
        }
      },
      "CompanyInformationsResource" : {
        "title" : "CompanyInformationsResource",
        "type" : "object",
        "properties" : {
          "businessRegisterPlace" : {
            "type" : "string",
            "description" : "Institution's business register place"
          },
          "rea" : {
            "type" : "string",
            "description" : "Institution's REA"
          },
          "shareCapital" : {
            "type" : "string",
            "description" : "Institution's share capital value"
          }
        }
      },
      "DelegationResource" : {
        "title" : "DelegationResource",
        "type" : "object",
        "properties" : {
          "brokerId" : {
            "type" : "string",
            "description" : "id borker"
          },
          "brokerName" : {
            "type" : "string",
            "description" : "broker's name"
          },
          "id" : {
            "type" : "string",
            "description" : "delegation Id"
          },
          "institutionId" : {
            "type" : "string",
            "description" : "institution Id"
          },
          "institutionName" : {
            "type" : "string",
            "description" : "institution name"
          },
          "institutionRootName" : {
            "type" : "string",
            "description" : "institution root name"
          },
          "productId" : {
            "type" : "string",
            "description" : "id product"
          },
          "type" : {
            "type" : "string",
            "description" : "delegation type"
          }
        }
      },
      "DpoDataResource" : {
        "title" : "DpoDataResource",
        "required" : [ "address", "email", "pec" ],
        "type" : "object",
        "properties" : {
          "address" : {
            "type" : "string",
            "description" : "DPO's address"
          },
          "email" : {
            "type" : "string",
            "description" : "DPO's email"
          },
          "pec" : {
            "type" : "string",
            "description" : "DPO's PEC"
          }
        }
      },
      "InstitutionDetailResource" : {
        "title" : "InstitutionDetailResource",
        "required" : [ "address", "attributes", "description", "digitalAddress", "externalId", "id", "institutionType", "origin", "originId", "taxCode", "zipCode" ],
        "type" : "object",
        "properties" : {
          "address" : {
            "type" : "string",
            "description" : "Institution's physical address"
          },
          "attributes" : {
            "type" : "array",
            "description" : "Institution's attributes",
            "items" : {
              "$ref" : "#/components/schemas/AttributeResource"
            }
          },
          "description" : {
            "type" : "string",
            "description" : "Institution's name"
          },
          "digitalAddress" : {
            "type" : "string",
            "description" : "Institution's digitalAddress"
          },
          "externalId" : {
            "type" : "string",
            "description" : "Institution's unique external identifier"
          },
          "id" : {
            "type" : "string",
            "description" : "Institution's unique internal identifier"
          },
          "institutionType" : {
            "type" : "string",
            "description" : "Institution's type",
            "enum" : [ "GSP", "PA", "PSP", "PT", "SCP" ]
          },
          "origin" : {
            "type" : "string",
            "description" : "Institution data origin"
          },
          "originId" : {
            "type" : "string",
            "description" : "Institution's details origin Id"
          },
          "taxCode" : {
            "type" : "string",
            "description" : "Institution's taxCode"
          },
          "zipCode" : {
            "type" : "string",
            "description" : "Institution's zipCode"
          }
        }
      },
      "InstitutionResource" : {
        "title" : "InstitutionResource",
        "required" : [ "address", "externalId", "fiscalCode", "id", "mailAddress", "name", "origin", "originId", "status", "userProductRoles" ],
        "type" : "object",
        "properties" : {
          "address" : {
            "type" : "string",
            "description" : "Institution's physical address"
          },
          "assistanceContacts" : {
            "description" : "Institution's assistance contacts",
            "$ref" : "#/components/schemas/AssistanceContactsResource"
          },
          "companyInformations" : {
            "description" : "GPS, SCP, PT optional data",
            "$ref" : "#/components/schemas/CompanyInformationsResource"
          },
          "dpoData" : {
            "description" : "Data Protection Officer (DPO) specific data",
            "$ref" : "#/components/schemas/DpoDataResource"
          },
          "externalId" : {
            "type" : "string",
            "description" : "Institution's unique external identifier"
          },
          "fiscalCode" : {
            "type" : "string",
            "description" : "Institution's taxCode"
          },
          "id" : {
            "type" : "string",
            "description" : "Institution's unique internal identifier"
          },
          "institutionType" : {
            "type" : "string",
            "description" : "Institution's type",
            "enum" : [ "GSP", "PA", "PSP", "PT", "SCP" ]
          },
          "mailAddress" : {
            "type" : "string",
            "description" : "Institution's digitalAddress"
          },
          "name" : {
            "type" : "string",
            "description" : "Institution's name"
          },
          "origin" : {
            "type" : "string",
            "description" : "Institution data origin"
          },
          "originId" : {
            "type" : "string",
            "description" : "Institution's details origin Id"
          },
          "pspData" : {
            "description" : "Payment Service Provider (PSP) specific data",
            "$ref" : "#/components/schemas/PspDataResource"
          },
          "recipientCode" : {
            "type" : "string",
            "description" : "Billing recipient code"
          },
          "status" : {
            "type" : "string",
            "description" : "Institution onboarding status"
          },
          "userProductRoles" : {
            "type" : "array",
            "description" : "Logged user's roles on product",
            "items" : {
              "type" : "string"
            }
          }
        }
      },
      "InvalidParam" : {
        "title" : "InvalidParam",
        "required" : [ "name", "reason" ],
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string",
            "description" : "Invalid parameter name."
          },
          "reason" : {
            "type" : "string",
            "description" : "Invalid parameter reason."
          }
        }
      },
      "Problem" : {
        "title" : "Problem",
        "required" : [ "status", "title" ],
        "type" : "object",
        "properties" : {
          "detail" : {
            "type" : "string",
            "description" : "Human-readable description of this specific problem."
          },
          "instance" : {
            "type" : "string",
            "description" : "A URI that describes where the problem occurred."
          },
          "invalidParams" : {
            "type" : "array",
            "description" : "A list of invalid parameters details.",
            "items" : {
              "$ref" : "#/components/schemas/InvalidParam"
            }
          },
          "status" : {
            "type" : "integer",
            "description" : "The HTTP status code.",
            "format" : "int32",
            "example" : 500
          },
          "title" : {
            "type" : "string",
            "description" : "Short human-readable summary of the problem."
          },
          "type" : {
            "type" : "string",
            "description" : "A URL to a page with more details regarding the problem."
          }
        },
        "description" : "A \"problem detail\" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)"
      },
      "ProductsResource" : {
        "title" : "ProductsResource",
        "required" : [ "description", "id", "title", "urlBO" ],
        "type" : "object",
        "properties" : {
          "description" : {
            "type" : "string",
            "description" : "Product's description"
          },
          "id" : {
            "type" : "string",
            "description" : "Product's unique identifier"
          },
          "title" : {
            "type" : "string",
            "description" : "Product's title"
          },
          "urlBO" : {
            "type" : "string",
            "description" : "URL that redirects to the back-office section, where is possible to manage the product"
          },
          "urlPublic" : {
            "type" : "string",
            "description" : "URL that redirects to the public information webpage of the product"
          }
        }
      },
      "PspDataResource" : {
        "title" : "PspDataResource",
        "required" : [ "abiCode", "businessRegisterNumber", "legalRegisterName", "legalRegisterNumber", "vatNumberGroup" ],
        "type" : "object",
        "properties" : {
          "abiCode" : {
            "type" : "string",
            "description" : "PSP's ABI code"
          },
          "businessRegisterNumber" : {
            "type" : "string",
            "description" : "PSP's Business Register number"
          },
          "legalRegisterName" : {
            "type" : "string",
            "description" : "PSP's legal register name"
          },
          "legalRegisterNumber" : {
            "type" : "string",
            "description" : "PSP's legal register number"
          },
          "vatNumberGroup" : {
            "type" : "boolean",
            "description" : "PSP's Vat Number group",
            "example" : false
          }
        }
      }
    },
    "securitySchemes" : {
      "bearerAuth" : {
        "type" : "http",
        "description" : "A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)",
        "scheme" : "bearer",
        "bearerFormat" : "JWT"
      }
    }
  }
}
