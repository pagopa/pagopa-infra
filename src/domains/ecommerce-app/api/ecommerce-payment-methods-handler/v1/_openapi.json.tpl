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
                    }
                }
            },
            "PaymentNoticeItem": {
                "required": [
                    "paymentAmount",
                    "primaryCreditorInstitution"
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
                            "KLRN",
                            "RFPB"
                        ]
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
                "name": "ocp-apim-subscription-key"
            }
        }
    }
}