{
    "openapi": "3.0.1",
    "info": {
        "title": "PagoPA API configuration",
        "description": "Spring Application exposes Api to manage configuration for EC/PSP on the Nodo dei Pagamenti",
        "termsOfService": "https://www.pagopa.gov.it/",
        "version": "0.8.0"
    },
    "servers": [
        {
            "url": "http://127.0.0.1:8080/apiconfig/api/v1",
            "description": "Generated server url"
        }
    ],
    "tags": [
        {
            "name": "Payment Service Providers",
            "description": "Everything about Payment Service Providers"
        }
    ],
    "paths": {
        "/info": {
            "get": {
                "tags": [
                    "Home"
                ],
                "summary": "Return OK if application is started",
                "operationId": "healthCheck",
                "responses": {
                    "429": {
                        "description": "Too many requests",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "200": {
                        "description": "OK",
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
                                    "$ref": "#/components/schemas/AppInfo"
                                }
                            }
                        }
                    },
                    "500": {
                        "description": "Service unavailable",
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
                        "description": "Unauthorized",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Bad Request",
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
                    "403": {
                        "description": "Forbidden",
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
        },
        "/services": {
            "get": {
                "tags": [
                    "Payment Service Providers"
                ],
                "summary": "Get paginated list of services",
                "operationId": "getServices",
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
                        "name": "pspcode",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "brokerpspcode",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "channelcode",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "paymentmethodchannel",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "integer",
                            "format": "int64"
                        }
                    },
                    {
                        "name": "paymenttypecode",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "pspflagftamp",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "boolean"
                        }
                    },
                    {
                        "name": "channelapp",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "boolean"
                        }
                    },
                    {
                        "name": "onus",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "boolean"
                        }
                    },
                    {
                        "name": "flagio",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "boolean"
                        }
                    },
                    {
                        "name": "flowid",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "minimumamount",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "number",
                            "format": "double"
                        }
                    },
                    {
                        "name": "maximumamount",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "number",
                            "format": "double"
                        }
                    },
                    {
                        "name": "languagecode",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "string",
                            "enum": [
                                "IT",
                                "EN",
                                "FR",
                                "DE",
                                "SL"
                            ],
                            "default": "IT"
                        }
                    },
                    {
                        "name": "conventionCode",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "429": {
                        "description": "Too many requests",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "200": {
                        "description": "OK",
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
                                    "$ref": "#/components/schemas/Services"
                                }
                            }
                        }
                    },
                    "500": {
                        "description": "Service unavailable",
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
                        "description": "Unauthorized",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Bad Request",
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
                    "403": {
                        "description": "Forbidden",
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
            "Service": {
                "type": "object",
                "properties": {
                    "psp_code": {
                        "maxLength": 35,
                        "minLength": 0,
                        "type": "string"
                    },
                    "flow_id": {
                        "maxLength": 35,
                        "minLength": 0,
                        "type": "string"
                    },
                    "psp_business_name": {
                        "type": "string"
                    },
                    "psp_flag_stamp": {
                        "type": "boolean"
                    },
                    "broker_psp_code": {
                        "maxLength": 35,
                        "minLength": 0,
                        "type": "string"
                    },
                    "channel_code": {
                        "maxLength": 35,
                        "minLength": 0,
                        "type": "string"
                    },
                    "service_name": {
                        "maxLength": 35,
                        "minLength": 0,
                        "type": "string"
                    },
                    "payment_method_channel": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "payment_type_code": {
                        "type": "string"
                    },
                    "language_code": {
                        "type": "string",
                        "enum": [
                            "IT",
                            "EN",
                            "FR",
                            "DE",
                            "SL"
                        ]
                    },
                    "service_description": {
                        "maxLength": 511,
                        "minLength": 0,
                        "type": "string"
                    },
                    "service_availability": {
                        "maxLength": 511,
                        "minLength": 0,
                        "type": "string"
                    },
                    "channel_url": {
                        "type": "string"
                    },
                    "minimum_amount": {
                        "type": "number",
                        "format": "double"
                    },
                    "maximum_amount": {
                        "type": "number",
                        "format": "double"
                    },
                    "fixed_cost": {
                        "type": "number",
                        "format": "double"
                    },
                    "timestamp_insertion": {
                        "type": "string",
                        "format": "date-time"
                    },
                    "validity_date": {
                        "type": "string",
                        "format": "date-time"
                    },
                    "logo_psp": {
                        "type": "array",
                        "items": {
                            "type": "string",
                            "format": "byte"
                        }
                    },
                    "tags": {
                        "maxLength": 135,
                        "minLength": 0,
                        "type": "string"
                    },
                    "logo_service": {
                        "type": "array",
                        "items": {
                            "type": "string",
                            "format": "byte"
                        }
                    },
                    "channel_app": {
                        "type": "boolean"
                    },
                    "on_us": {
                        "type": "boolean"
                    },
                    "cart_card": {
                        "type": "boolean"
                    },
                    "abi_code": {
                        "maxLength": 5,
                        "minLength": 0,
                        "type": "string"
                    },
                    "mybank_code": {
                        "maxLength": 35,
                        "minLength": 0,
                        "type": "string"
                    },
                    "convention_code": {
                        "maxLength": 35,
                        "minLength": 0,
                        "type": "string"
                    },
                    "flag_io": {
                        "type": "boolean"
                    }
                }
            },
            "Services": {
                "required": [
                    "page_info",
                    "services"
                ],
                "type": "object",
                "properties": {
                    "services": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/Service"
                        }
                    },
                    "page_info": {
                        "$ref": "#/components/schemas/PageInfo"
                    }
                }
            },
            "AppInfo": {
                "required": [
                    "environment",
                    "name",
                    "version"
                ],
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string"
                    },
                    "version": {
                        "type": "string"
                    },
                    "environment": {
                        "type": "string"
                    },
                    "dbConnection": {
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
