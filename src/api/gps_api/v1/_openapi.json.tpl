{
    "openapi": "3.0.1",
    "info": {
        "title": "PagoPA API Spontaneous Payment",
        "description": "Progetto Gestione Pagamenti Spontanei",
        "termsOfService": "https://www.pagopa.gov.it/",
        "version": "0.0.1"
    },
    "servers": [
        {
            "url": "http://localhost:8080",
            "description": "Generated server url"
        }
    ],
    "paths": {
        "/organizations/{organizationfiscalcode}/spontaneouspayments": {
            "post": {
                "tags": [
                    "Payments API"
                ],
                "summary": "The Organization creates a spontaneous payment.",
                "operationId": "createSpontaneousPayment",
                "parameters": [
                    {
                        "name": "organizationfiscalcode",
                        "in": "path",
                        "description": "Organization fiscal code, the fiscal code of the Organization.",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/SpontaneousPaymentModel"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "201": {
                        "description": "Request created.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PaymentPositionModel"
                                }
                            }
                        }
                    },
                    "500": {
                        "description": "Service unavailable.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "409": {
                        "description": "Conflict: duplicate debt position found.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Malformed request.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
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
                ]
            },
            "parameters": [
                {
                    "name": "X-Request-Id",
                    "in": "header",
                    "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
                    "schema": {
                        "type": "string"
                    }
                }
            ]
        }
    },
    "components": {
        "schemas": {
            "DebtorModel": {
                "required": [
                    "fiscalCode",
                    "fullName",
                    "type"
                ],
                "type": "object",
                "properties": {
                    "type": {
                        "type": "string",
                        "enum": [
                            "F",
                            "G"
                        ]
                    },
                    "fiscalCode": {
                        "type": "string"
                    },
                    "fullName": {
                        "type": "string"
                    },
                    "streetName": {
                        "type": "string"
                    },
                    "civicNumber": {
                        "type": "string"
                    },
                    "postalCode": {
                        "type": "string"
                    },
                    "city": {
                        "type": "string"
                    },
                    "province": {
                        "type": "string"
                    },
                    "region": {
                        "type": "string"
                    },
                    "country": {
                        "type": "string"
                    },
                    "email": {
                        "type": "string"
                    },
                    "phone": {
                        "type": "string"
                    }
                }
            },
            "ServiceModel": {
                "required": [
                    "id",
                    "properties"
                ],
                "type": "object",
                "properties": {
                    "id": {
                        "type": "string"
                    },
                    "properties": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/ServicePropertyModel"
                        }
                    }
                }
            },
            "ServicePropertyModel": {
                "required": [
                    "name"
                ],
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string"
                    },
                    "value": {
                        "type": "string"
                    }
                }
            },
            "SpontaneousPaymentModel": {
                "required": [
                    "debtor",
                    "service"
                ],
                "type": "object",
                "properties": {
                    "debtor": {
                        "$ref": "#/components/schemas/DebtorModel"
                    },
                    "service": {
                        "$ref": "#/components/schemas/ServiceModel"
                    }
                }
            },
            "ProblemJson": {
                "type": "object",
                "properties": {
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
                    }
                }
            },
            "PaymentOptionModel": {
                "required": [
                    "amount",
                    "dueDate",
                    "isPartialPayment",
                    "iuv"
                ],
                "type": "object",
                "properties": {
                    "iuv": {
                        "type": "string"
                    },
                    "amount": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "description": {
                        "type": "string"
                    },
                    "isPartialPayment": {
                        "type": "boolean"
                    },
                    "dueDate": {
                        "type": "string",
                        "format": "date-time"
                    },
                    "retentionDate": {
                        "type": "string",
                        "format": "date-time"
                    },
                    "fee": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "transfer": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/TransferModel"
                        }
                    }
                }
            },
            "PaymentPositionModel": {
                "required": [
                    "companyName",
                    "fiscalCode",
                    "fullName",
                    "iupd",
                    "type"
                ],
                "type": "object",
                "properties": {
                    "iupd": {
                        "type": "string"
                    },
                    "type": {
                        "type": "string",
                        "enum": [
                            "F",
                            "G"
                        ]
                    },
                    "fiscalCode": {
                        "type": "string"
                    },
                    "fullName": {
                        "type": "string"
                    },
                    "streetName": {
                        "type": "string"
                    },
                    "civicNumber": {
                        "type": "string"
                    },
                    "postalCode": {
                        "type": "string"
                    },
                    "city": {
                        "type": "string"
                    },
                    "province": {
                        "type": "string"
                    },
                    "region": {
                        "type": "string"
                    },
                    "country": {
                        "type": "string"
                    },
                    "email": {
                        "type": "string"
                    },
                    "phone": {
                        "type": "string"
                    },
                    "switchToExpired": {
                        "type": "boolean",
                        "description": "feature flag to enable the debt position to expire after the due date",
                        "example": false,
                        "default": false
                    },
                    "companyName": {
                        "type": "string"
                    },
                    "officeName": {
                        "type": "string"
                    },
                    "validityDate": {
                        "type": "string",
                        "format": "date-time"
                    },
                    "status": {
                        "type": "string",
                        "readOnly": true,
                        "enum": [
                            "DRAFT",
                            "PUBLISHED",
                            "VALID",
                            "INVALID",
                            "EXPIRED",
                            "PARTIALLY_PAID",
                            "PAID",
                            "REPORTED"
                        ]
                    },
                    "paymentOption": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/PaymentOptionModel"
                        }
                    }
                }
            },
            "TransferModel": {
                "required": [
                    "amount",
                    "category",
                    "iban",
                    "idTransfer",
                    "remittanceInformation"
                ],
                "type": "object",
                "properties": {
                    "idTransfer": {
                        "type": "string",
                        "enum": [
                            "1",
                            "2",
                            "3",
                            "4",
                            "5"
                        ]
                    },
                    "amount": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "remittanceInformation": {
                        "type": "string"
                    },
                    "category": {
                        "type": "string"
                    },
                    "iban": {
                        "type": "string"
                    },
                    "postalIban": {
                        "type": "string"
                    }
                }
            }
        },
        "securitySchemes": {
            "ApiKey": {
                "type": "apiKey",
                "description": "The API key to access this function app.",
                "name": "Ocp-Apim-Subscription-Key",
                "in": "header"
            },
            "Authorization": {
                "type": "http",
                "description": "JWT token get after Azure Login",
                "scheme": "bearer",
                "bearerFormat": "JWT"
            }
        }
    }
}