{
    "openapi": "3.0.0",
    "info": {
        "version": "0.0.1",
        "title": "Pagopa eCommerce payment methods handler",
        "description": "This microservice handles payment methods.",
        "contact": {
            "name": "pagoPA - Touchpoints team"
        }
    },
    "tags": [
        {
            "name": "payment-methods-handler",
            "description": "Api's for handle payment methods",
            "externalDocs": {
                "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/2003402841/DR+IPG-147+Integrazione+GMP+su+checkout+e+eCommerce",
                "description": "Technical specifications"
            }
        }
    ],
    "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/2003402841/DR+IPG-147+Integrazione+GMP+su+checkout+e+eCommerce",
        "description": "Design review"
    },
    "servers": [
        {
            "url": "https://api.platform.pagopa.it/"
        }
    ],
    "security": [
        {
            "ApiKeyAuth": []
        }
    ],
    "paths": {
        "/payment-methods": {
            "post": {
                "tags": [
                    "payment-methods-handler"
                ],
                "operationId": "getAllPaymentMethods",
                "summary": "Retrieve all Payment Methods (by filter)",
                "description": "GET with request body, no resource will be created: API for retrieve payment method using the request query parameter filters",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/PaymentMethodsRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "Payment method successfully retrieved",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PaymentMethodsResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Bad request",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "500": {
                        "description": "Service unavailable",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/payment-methods/{id}": {
            "get": {
                "tags": [
                    "payment-methods-handler"
                ],
                "operationId": "getPaymentMethod",
                "summary": "Get payment method by ID",
                "description": "API for retrieve payment method information for a given payment method ID",
                "parameters": [
                    {
                        "name": "id",
                        "in": "path",
                        "description": "Payment Method ID",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "x-client-id",
                        "in": "header",
                        "description": "client id related to a given touchpoint",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "enum": [
                                "IO",
                                "CHECKOUT",
                                "CHECKOUT_CART"
                            ]
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Payment method successfully retrieved",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PaymentMethodResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Bad request",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Payment method not found",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "500": {
                        "description": "Service unavailable",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/payment-methods/{id}/fees": {
            "post": {
                "tags": [
                    "payment-methods-handler"
                ],
                "operationId": "calculateFees",
                "summary": "Calculate payment method fees",
                "description": "GET with body payload - no resources created: Return the fees for the choosen payment method based on transaction amount etc.",
                "parameters": [
                    {
                        "name": "id",
                        "in": "path",
                        "description": "Payment Method ID",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "maxOccurrences",
                        "in": "query",
                        "description": "max occurrences",
                        "required": false,
                        "schema": {
                            "type": "integer"
                        }
                    },
                    {
                        "name": "x-client-id",
                        "in": "header",
                        "description": "client id related to a given touchpoint",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "enum": [
                                "IO",
                                "CHECKOUT",
                                "CHECKOUT_CART"
                            ]
                        }
                    },
                    {
                        "name": "x-language",
                        "in": "header",
                        "description": "The user language",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "enum": [
                                "IT",
                                "EN",
                                "FR",
                                "DE",
                                "SL"
                            ]
                        }
                    }
                ],
                "requestBody": {
                    "required": true,
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/CalculateFeeRequest"
                            }
                        }
                    }
                },
                "responses": {
                    "200": {
                        "description": "Return list of psp ordered by fee.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/CalculateFeeResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Bad request",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Resource not found",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "500": {
                        "description": "Service unavailable",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
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
            "PaymentMethodsRequest": {
                "required": [
                    "paymentNotice",
                    "totalAmount",
                    "userTouchpoint"
                ],
                "type": "object",
                "properties": {
                    "userTouchpoint": {
                        "type": "string",
                        "enum": [
                            "IO",
                            "CHECKOUT",
                            "CHECKOUT_CART"
                        ]
                    },
                    "userDevice": {
                        "type": "string",
                        "enum": [
                            "IOS",
                            "ANDROID",
                            "WEB",
                            "SAFARI"
                        ]
                    },
                    "totalAmount": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "paymentNotice": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/PaymentNoticeItem"
                        }
                    },
                    "allCCp": {
                        "type": "boolean"
                    },
                    "targetKey": {
                        "type": "string"
                    },
                    "deviceVersion": {
                        "type": "string",
                        "description": "The user device version"
                    },
                    "language": {
                        "type": "string",
                        "description": "The user language",
                        "enum": [
                            "IT",
                            "EN",
                            "FR",
                            "DE",
                            "SL"
                        ]
                    },
                    "sortBy": {
                        "type": "string",
                        "enum": [
                            "NAME",
                            "DESCRIPTION",
                            "FEE"
                        ]
                    },
                    "sortOrder": {
                        "type": "string",
                        "enum": [
                            "ASC",
                            "DESC"
                        ]
                    },
                    "priorityGroups": {
                        "type": "array",
                        "items": {
                            "type": "string",
                            "enum": [
                                "CP",
                                "MYBK",
                                "BPAY",
                                "PPAL",
                                "RPIC",
                                "RBPS",
                                "SATY",
                                "APPL",
                                "RICO",
                                "RBPB",
                                "RBPP",
                                "RBPR",
                                "GOOG",
                                "KLRN"
                            ]
                        }
                    }
                }
            },
            "PaymentNoticeItem": {
                "required": [
                    "paymentAmount"
                ],
                "type": "object",
                "properties": {
                    "paymentAmount": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "primaryCreditorInstitution": {
                        "type": "string"
                    },
                    "transferList": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/TransferListItem"
                        }
                    }
                }
            },
            "TransferListItem": {
                "required": [
                    "creditorInstitution"
                ],
                "type": "object",
                "properties": {
                    "creditorInstitution": {
                        "type": "string"
                    },
                    "transferCategory": {
                        "type": "string"
                    },
                    "digitalStamp": {
                        "type": "boolean"
                    }
                }
            },
            "FeeRange": {
                "required": [
                    "max",
                    "min"
                ],
                "type": "object",
                "properties": {
                    "min": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "max": {
                        "type": "integer",
                        "format": "int64"
                    }
                }
            },
            "PaymentMethodResponse": {
                "required": [
                    "description",
                    "paymentTypeCode",
                    "methodManagement",
                    "name",
                    "paymentMethodAsset",
                    "id",
                    "paymentMethodTypes",
                    "status",
                    "validityDateFrom"
                ],
                "type": "object",
                "properties": {
                    "id": {
                        "type": "string"
                    },
                    "name": {
                        "type": "object",
                        "additionalProperties": {
                            "type": "string"
                        }
                    },
                    "description": {
                        "type": "object",
                        "additionalProperties": {
                            "type": "string"
                        }
                    },
                    "status": {
                        "type": "string",
                        "enum": [
                            "ENABLED",
                            "DISABLED",
                            "MAINTENANCE"
                        ]
                    },
                    "validityDateFrom": {
                        "type": "string",
                        "format": "date"
                    },
                    "paymentTypeCode": {
                        "type": "string"
                    },
                    "paymentMethodTypes": {
                        "type": "array",
                        "items": {
                            "type": "string",
                            "enum": [
                                "CARTE",
                                "CONTO",
                                "APP"
                            ]
                        }
                    },
                    "feeRange": {
                        "$ref": "#/components/schemas/FeeRange"
                    },
                    "paymentMethodAsset": {
                        "type": "string"
                    },
                    "methodManagement": {
                        "type": "string",
                        "enum": [
                            "ONBOARDABLE",
                            "ONBOARDABLE_ONLY",
                            "NOT_ONBOARDABLE",
                            "REDIRECT"
                        ]
                    },
                    "disabledReason": {
                        "type": "string",
                        "enum": [
                            "AMOUNT_OUT_OF_BOUND",
                            "MAINTENANCE_IN_PROGRESS",
                            "METHOD_DISABLED",
                            "NOT_YET_VALID",
                            "TARGET_PREVIEW",
                            "NO_BUNDLE_AVAILABLE"
                        ]
                    },
                    "paymentMethodsBrandAssets": {
                        "type": "object",
                        "additionalProperties": {
                            "type": "string"
                        }
                    },
                    "metadata": {
                        "type": "object",
                        "additionalProperties": {
                            "type": "string"
                        }
                    }
                }
            },
            "PaymentMethodsResponse": {
                "required": [
                    "paymentMethods"
                ],
                "type": "object",
                "properties": {
                    "paymentMethods": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/PaymentMethodResponse"
                        }
                    }
                }
            },
            "ProblemJson": {
                "type": "object",
                "description": "Problem json structure",
                "properties": {
                    "detail": {
                        "description": "Problem detail",
                        "type": "string"
                    },
                    "status": {
                        "description": "Error status code",
                        "maximum": 600,
                        "minimum": 100,
                        "type": "integer",
                        "format": "int32",
                        "example": 200
                    },
                    "title": {
                        "description": "Problem title",
                        "type": "string"
                    }
                }
            },
            "CalculateFeeRequest": {
                "description": "Calculate fee request",
                "type": "object",
                "required": [
                    "paymentNotices",
                    "touchpoint",
                    "isAllCCP"
                ],
                "properties": {
                    "touchpoint": {
                        "type": "string",
                        "description": "The touchpoint name"
                    },
                    "bin": {
                        "type": "string",
                        "description": "The user card bin"
                    },
                    "idPspList": {
                        "description": "List of psps",
                        "type": "array",
                        "items": {
                            "type": "string"
                        }
                    },
                    "paymentNotices": {
                        "type": "array",
                        "minItems": 1,
                        "maxItems": 5,
                        "items": {
                            "$ref": "#/components/schemas/PaymentNotice"
                        }
                    },
                    "isAllCCP": {
                        "description": "Flag for the inclusion of Poste bundles. false -> excluded, true -> included",
                        "type": "boolean"
                    }
                }
            },
            "PaymentNotice": {
                "description": "Payment notice data",
                "type": "object",
                "required": [
                    "paymentAmount",
                    "primaryCreditorInstitution",
                    "transferList"
                ],
                "properties": {
                    "paymentAmount": {
                        "description": "The transaction payment amount",
                        "type": "integer",
                        "format": "int64"
                    },
                    "primaryCreditorInstitution": {
                        "description": "The primary creditor institution",
                        "type": "string"
                    },
                    "transferList": {
                        "description": "Transfer list",
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/TransferListItem"
                        }
                    }
                }
            },
            "CalculateFeeResponse": {
                "description": "Calculate fee response",
                "type": "object",
                "required": [
                    "bundles",
                    "paymentMethodName",
                    "paymentMethodDescription",
                    "paymentMethodStatus",
                    "asset"
                ],
                "properties": {
                    "paymentMethodName": {
                        "description": "Payment method name",
                        "type": "string"
                    },
                    "paymentMethodDescription": {
                        "description": "Payment method description",
                        "type": "string"
                    },
                    "paymentMethodStatus": {
                        "type": "string",
                        "description": "Payment method status",
                        "enum": [
                            "ENABLED",
                            "DISABLED",
                            "MAINTENANCE"
                        ]
                    },
                    "belowThreshold": {
                        "description": "Boolean value indicating if the payment is below the configured threshold",
                        "type": "boolean"
                    },
                    "bundles": {
                        "description": "Bundle list",
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/Bundle"
                        }
                    },
                    "asset": {
                        "description": "Payment method asset",
                        "type": "string"
                    },
                    "brandAssets": {
                        "description": "Brand assets map associated to the selected payment method",
                        "type": "object",
                        "additionalProperties": {
                            "type": "string"
                        }
                    }
                }
            },
            "Bundle": {
                "description": "Bundle object",
                "type": "object",
                "properties": {
                    "abi": {
                        "description": "Bundle ABI code",
                        "type": "string"
                    },
                    "bundleDescription": {
                        "description": "Bundle description",
                        "type": "string"
                    },
                    "idBrokerPsp": {
                        "description": "Bundle PSP broker id",
                        "type": "string"
                    },
                    "idBundle": {
                        "description": "Bundle id",
                        "type": "string"
                    },
                    "idChannel": {
                        "description": "Channel id",
                        "type": "string"
                    },
                    "idPsp": {
                        "description": "PSP id",
                        "type": "string"
                    },
                    "onUs": {
                        "description": "Boolean value indicating if this bundle is an on-us ones",
                        "type": "boolean"
                    },
                    "paymentMethod": {
                        "description": "Payment method",
                        "type": "string"
                    },
                    "taxPayerFee": {
                        "description": "Tax payer fee",
                        "type": "integer",
                        "format": "int64"
                    },
                    "touchpoint": {
                        "description": "The touchpoint name",
                        "type": "string"
                    },
                    "pspBusinessName": {
                        "description": "The psp business name",
                        "type": "string"
                    }
                }
            }
        },
        "requestBodies": {
            "PaymentMethodsRequest": {
                "required": true,
                "content": {
                    "application/json": {
                        "schema": {
                            "$ref": "#/components/schemas/PaymentMethodsRequest"
                        }
                    }
                }
            }
        },
        "securitySchemes": {
            "ApiKeyAuth": {
                "type": "apiKey",
                "in": "header",
                "name": "Ocp-Apim-Subscription-Key"
            }
        }
    }
}
