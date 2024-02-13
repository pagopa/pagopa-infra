{
    "openapi": "3.0.1",
    "info": {
        "title": "PagoPA API Calculator Logic",
        "description": "Calculator Logic microservice for pagoPA AFM",
        "termsOfService": "https://www.pagopa.gov.it/",
        "version": "2.6.4"
    },
    "servers": [
        {
            "url": "${host}",
            "description": "Generated server url"
        }
    ],
    "tags": [
        {
            "name": "Calculator",
            "description": "Everything about Calculator business logic"
        }
    ],
    "paths" : {
        "/psps/{idPsp}/fees" : {
        "post" : {
            "tags" : [ "Calculator" ],
            "summary" : "Get taxpayer fees of the specified idPSP with ECs contributions",
            "operationId" : "getFeesByPspMulti",
            "parameters" : [ {
            "name" : "idPsp",
            "in" : "path",
            "description" : "PSP identifier",
            "required" : true,
            "schema" : {
                "type" : "string"
            }
            }, {
            "name" : "maxOccurrences",
            "in" : "query",
            "required" : false,
            "schema" : {
                "type" : "integer",
                "format" : "int32",
                "default" : 10
            }
            }, {
            "name" : "allCcp",
            "in" : "query",
            "description" : "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
            "required" : false,
            "schema" : {
                "type" : "string",
                "default" : "true"
            }
            } ],
            "requestBody" : {
            "content" : {
                "application/json" : {
                "schema" : {
                    "$ref" : "#/components/schemas/PaymentOptionByPsp"
                }
                }
            },
            "required" : true
            },
            "responses" : {
            "200" : {
                "description" : "Ok",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/BundleOption"
                    }
                }
                }
            },
            "500" : {
                "description" : "Service unavailable",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/ProblemJson"
                    }
                }
                }
            },
            "401" : {
                "description" : "Unauthorized"
            },
            "429" : {
                "description" : "Too many requests"
            },
            "404" : {
                "description" : "Not Found",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/ProblemJson"
                    }
                }
                }
            },
            "422" : {
                "description" : "Unable to process the request",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/ProblemJson"
                    }
                }
                }
            },
            "400" : {
                "description" : "Bad Request",
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
        }
        },
        "/fees" : {
        "post" : {
            "tags" : [ "Calculator" ],
            "summary" : "Get taxpayer fees of all or specified idPSP with ECs contributions",
            "operationId" : "getFeesMulti",
            "parameters" : [ {
            "name" : "maxOccurrences",
            "in" : "query",
            "required" : false,
            "schema" : {
                "type" : "integer",
                "format" : "int32",
                "default" : 10
            }
            }, {
            "name" : "allCcp",
            "in" : "query",
            "description" : "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
            "required" : false,
            "schema" : {
                "type" : "string",
                "default" : "true"
            }
            } ],
            "requestBody" : {
            "content" : {
                "application/json" : {
                "schema" : {
                    "$ref" : "#/components/schemas/PaymentOption"
                }
                }
            },
            "required" : true
            },
            "responses" : {
            "200" : {
                "description" : "Ok",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/BundleOption"
                    }
                }
                }
            },
            "500" : {
                "description" : "Service unavailable",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/ProblemJson"
                    }
                }
                }
            },
            "401" : {
                "description" : "Unauthorized"
            },
            "429" : {
                "description" : "Too many requests"
            },
            "404" : {
                "description" : "Not Found",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/ProblemJson"
                    }
                }
                }
            },
            "422" : {
                "description" : "Unable to process the request",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/ProblemJson"
                    }
                }
                }
            },
            "400" : {
                "description" : "Bad Request",
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
        }
        },
        "/info" : {
        "get" : {
            "tags" : [ "Home" ],
            "summary" : "health check",
            "description" : "Return OK if application is started",
            "operationId" : "healthCheck",
            "responses" : {
            "403" : {
                "description" : "Forbidden"
            },
            "500" : {
                "description" : "Service unavailable",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/ProblemJson"
                    }
                }
                }
            },
            "401" : {
                "description" : "Unauthorized"
            },
            "200" : {
                "description" : "OK",
                "content" : {
                "application/json" : {
                    "schema" : {
                    "$ref" : "#/components/schemas/AppInfo"
                    }
                }
                }
            },
            "429" : {
                "description" : "Too many requests"
            },
            "400" : {
                "description" : "Bad Request",
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
        }
        }
    },
    "components" : {
        "schemas" : {
        "PaymentOptionByPsp" : {
            "type" : "object",
            "properties" : {
            "idChannel" : {
                "type" : "string"
            },
            "idBrokerPsp" : {
                "type" : "string"
            },
            "paymentAmount" : {
                "type" : "integer",
                "format" : "int64"
            },
            "primaryCreditorInstitution" : {
                "type" : "string"
            },
            "paymentMethod" : {
                "type" : "string"
            },
            "touchpoint" : {
                "type" : "string"
            },
            "bin" : {
                "type" : "string"
            },
            "transferList" : {
                "type" : "array",
                "items" : {
                "$ref" : "#/components/schemas/TransferListItem"
                }
            }
            }
        },
        "TransferListItem" : {
            "type" : "object",
            "properties" : {
            "creditorInstitution" : {
                "type" : "string"
            },
            "transferCategory" : {
                "type" : "string"
            },
            "digitalStamp" : {
                "type" : "boolean"
            }
            }
        },
        "BundleOption" : {
            "type" : "object",
            "properties" : {
            "belowThreshold" : {
                "type" : "boolean",
                "description" : "if true (the payment amount is lower than the threshold value) the bundles onus is not calculated (always false)"
            },
            "bundleOptions" : {
                "type" : "array",
                "items" : {
                "$ref" : "#/components/schemas/Transfer"
                }
            }
            }
        },
        "Transfer" : {
            "type" : "object",
            "properties" : {
            "taxPayerFee" : {
                "type" : "integer",
                "format" : "int64"
            },
            "primaryCiIncurredFee" : {
                "type" : "integer",
                "format" : "int64"
            },
            "paymentMethod" : {
                "type" : "string"
            },
            "touchpoint" : {
                "type" : "string"
            },
            "idBundle" : {
                "type" : "string"
            },
            "bundleName" : {
                "type" : "string"
            },
            "bundleDescription" : {
                "type" : "string"
            },
            "idCiBundle" : {
                "type" : "string"
            },
            "idPsp" : {
                "type" : "string"
            },
            "idChannel" : {
                "type" : "string"
            },
            "idBrokerPsp" : {
                "type" : "string"
            },
            "onUs" : {
                "type" : "boolean"
            },
            "abi" : {
                "type" : "string"
            },
            "pspBusinessName" : {
                "type" : "string"
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
        "PaymentOption" : {
            "required" : [ "paymentAmount", "primaryCreditorInstitution", "transferList" ],
            "type" : "object",
            "properties" : {
            "paymentAmount" : {
                "type" : "integer",
                "format" : "int64"
            },
            "primaryCreditorInstitution" : {
                "type" : "string"
            },
            "bin" : {
                "type" : "string"
            },
            "paymentMethod" : {
                "type" : "string"
            },
            "touchpoint" : {
                "type" : "string"
            },
            "idPspList" : {
                "type" : "array",
                "items" : {
                "$ref" : "#/components/schemas/PspSearchCriteria"
                }
            },
            "transferList" : {
                "type" : "array",
                "items" : {
                "$ref" : "#/components/schemas/TransferListItem"
                }
            }
            }
        },
        "PspSearchCriteria" : {
            "required" : [ "idPsp" ],
            "type" : "object",
            "properties" : {
            "idPsp" : {
                "type" : "string"
            },
            "idChannel" : {
                "type" : "string"
            },
            "idBrokerPsp" : {
                "type" : "string"
            }
            }
        },
        "AppInfo" : {
            "type" : "object",
            "properties" : {
                "name" : {
                    "type" : "string"
                },
                "version" : {
                    "type" : "string"
                },
                "environment" : {
                    "type" : "string"
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
