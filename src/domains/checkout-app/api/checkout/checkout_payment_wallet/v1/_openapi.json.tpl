{
    "openapi": "3.0.3",
    "info": {
        "title": "pagoPA Checkout Payment Wallet API",
        "version": "0.0.1",
        "description": "API to handle payment wallets PagoPA for checkout, where a wallet is tuple between user identifier and payment instrument",
        "termsOfService": "https://pagopa.it/terms/"
    },
    "tags": [
        {
            "name": "wallets",
            "description": "Api's to handle a wallet",
            "externalDocs": {
                "url": "https://pagopa.atlassian.net/wiki/spaces/WA/overview?homepageId=622658099",
                "description": "Documentation"
            }
        }
    ],
    "servers": [
        {
            "url": "https://${hostname}"
        }
    ],
    "paths": {
        "/users/wallets": {
            "get": {
                "tags": [
                    "wallets"
                ],
                "summary": "Get wallets by user fiscal code",
                "description": "Returns an array of wallets related to user identified by fiscal code",
                "operationId": "getCheckoutPaymentWalletsByIdUser",
                "security": [
                    {
                        "bearerAuth": []
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Wallet retrieved successfully",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/Wallets"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid input id",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized: the provided token is not valid or expired."
                    },
                    "404": {
                        "description": "Wallet not found"
                    },
                    "502": {
                        "description": "Bad gateway"
                    },
                    "504": {
                        "description": "Timeout serving request"
                    }
                }
            }
        }
    },
    "components": {
        "schemas": {
            "WalletId": {
                "description": "Wallet identifier",
                "type": "string",
                "format": "uuid"
            },
            "WalletStatus": {
                "type": "string",
                "description": "Enumeration of wallet statuses",
                "enum": [
                    "VALIDATED"
                ]
            },
            "WalletApplicationId": {
                "type": "string",
                "description": "Id of wallet application"
            },
            "WalletApplicationStatus": {
                "type": "string",
                "description": "Enumeration of wallet statuses",
                "enum": [
                    "ENABLED",
                    "DISABLED"
                ]
            },
            "WalletApplicationInfo": {
                "type": "object",
                "properties": {
                    "name": {
                        "$ref": "#/components/schemas/WalletApplicationId"
                    },
                    "status": {
                        "$ref": "#/components/schemas/WalletApplicationStatus"
                    }
                },
                "required": [
                    "name",
                    "status"
                ]
            },
            "WalletClientStatus": {
                "type": "string",
                "description": "Enumeration of wallet client statuses",
                "enum": [
                    "ENABLED",
                    "DISABLED"
                ]
            },
            "WalletClient": {
                "type": "object",
                "properties": {
                    "status": {
                        "$ref": "#/components/schemas/WalletClientStatus"
                    },
                    "lastUsage": {
                        "type": "string",
                        "description": "(DEPRECATED\\: to be implemented an api like ecommerce-io GET /user/lastPaymentMethodUsed to retrieve user last used method) Time of last usage of this wallet by the client\n",
                        "format": "date-time",
                        "deprecated": true
                    }
                },
                "required": [
                    "status"
                ]
            },
            "WalletInfo": {
                "type": "object",
                "description": "Wallet information",
                "properties": {
                    "walletId": {
                        "$ref": "#/components/schemas/WalletId"
                    },
                    "paymentMethodId": {
                        "description": "Payment method identifier",
                        "type": "string"
                    },
                    "status": {
                        "$ref": "#/components/schemas/WalletStatus"
                    },
                    "creationDate": {
                        "description": "Wallet creation date",
                        "type": "string",
                        "format": "date-time"
                    },
                    "updateDate": {
                        "description": "Wallet update date",
                        "type": "string",
                        "format": "date-time"
                    },
                    "applications": {
                        "description": "list of applications for which this wallet is created for",
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/WalletApplicationInfo"
                        }
                    },
                    "clients": {
                        "description": "Client-specific state (e.g. last usage) and configuration (enabled/disabled)",
                        "type": "object",
                        "additionalProperties": {
                            "$ref": "#/components/schemas/WalletClient"
                        }
                    },
                    "details": {
                        "$ref": "#/components/schemas/WalletInfoDetails"
                    },
                    "paymentMethodAsset": {
                        "description": "Payment method asset",
                        "type": "string",
                        "format": "uri",
                        "example": "http://logo.cdn/brandLogo"
                    }
                },
                "required": [
                    "walletId",
                    "paymentMethodId",
                    "status",
                    "creationDate",
                    "updateDate",
                    "applications",
                    "clients",
                    "paymentMethodAsset"
                ]
            },
            "WalletInfoDetails": {
                "description": "details for the specific payment instrument. This field is disciminated by the type field",
                "oneOf": [
                    {
                        "type": "object",
                        "description": "Card payment instrument details",
                        "properties": {
                            "type": {
                                "type": "string",
                                "description": "Wallet details discriminator field. Fixed valued 'CARDS'"
                            },
                            "lastFourDigits": {
                                "description": "Card last 4 digits",
                                "type": "string",
                                "example": "9876"
                            },
                            "expiryDate": {
                                "type": "string",
                                "description": "Credit card expiry date. The date format is `YYYYMM`",
                                "pattern": "^[0-9]{6}$",
                                "example": "203012"
                            },
                            "brand": {
                                "description": "Payment instrument brand",
                                "type": "string"
                            }
                        },
                        "required": [
                            "type",
                            "lastFourDigits",
                            "expiryDate",
                            "brand"
                        ]
                    },
                    {
                        "type": "object",
                        "description": "Paypal instrument details",
                        "properties": {
                            "type": {
                                "type": "string",
                                "description": "Wallet details discriminator field. Fixed valued 'PAYPAL'"
                            },
                            "pspId": {
                                "description": "bank identifier",
                                "type": "string"
                            },
                            "pspBusinessName": {
                                "description": "PSP business name",
                                "type": "string"
                            },
                            "maskedEmail": {
                                "description": "email masked pan",
                                "type": "string",
                                "example": "test***@***test.it"
                            }
                        },
                        "required": [
                            "type",
                            "pspId",
                            "pspBusinessName"
                        ]
                    }
                ]
            },
            "Wallets": {
                "type": "object",
                "description": "Wallets information",
                "properties": {
                    "wallets": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/WalletInfo"
                        }
                    }
                }
            },
            "ProblemJson": {
                "description": "Body definition for error responses containing failure details",
                "type": "object",
                "properties": {
                    "type": {
                        "type": "string",
                        "format": "uri",
                        "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
                        "default": "about:blank",
                        "example": "https://example.com/problem/constraint-violation"
                    },
                    "title": {
                        "type": "string",
                        "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Application Unavailable"
                    },
                    "status": {
                        "$ref": "#/components/schemas/HttpStatusCode"
                    },
                    "detail": {
                        "type": "string",
                        "description": "A human readable explanation specific to this occurrence of the\nproblem.",
                        "example": "There was an error processing the request"
                    },
                    "instance": {
                        "type": "string",
                        "format": "uri",
                        "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
                    }
                }
            },
            "HttpStatusCode": {
                "type": "integer",
                "format": "int32",
                "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
                "minimum": 100,
                "maximum": 600,
                "exclusiveMaximum": true,
                "example": 502
            }
        },
        "securitySchemes": {
            "bearerAuth": {
                "type": "http",
                "scheme": "bearer",
                "description": "Authentication opaque token realeased by authorization service for checkout",
                "bearerFormat": "opaque token"
            }
        }
    }
}