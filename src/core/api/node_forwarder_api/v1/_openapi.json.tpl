{
    "openapi": "3.0.1",
    "info": {
        "title": "API pagoPA Node Forwarder",
        "description": "API pagoPA Node Forwarder",
        "termsOfService": "https://www.pagopa.gov.it/",
        "version": "0.0.1"
    },
    "servers": [
        {
            "url": "${host}",
            "description": "Generated server url"
        }
    ],
    "paths": {
        "/actuator": {
            "get": {
                "tags": [
                    "Actuator"
                ],
                "summary": "Actuator root web endpoint",
                "operationId": "links",
                "responses": {
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
                            "application/vnd.spring-boot.actuator.v3+json": {
                                "schema": {
                                    "type": "object",
                                    "additionalProperties": {
                                        "type": "object",
                                        "additionalProperties": {
                                            "$ref": "#/components/schemas/Link"
                                        }
                                    }
                                }
                            },
                            "application/vnd.spring-boot.actuator.v2+json": {
                                "schema": {
                                    "type": "object",
                                    "additionalProperties": {
                                        "type": "object",
                                        "additionalProperties": {
                                            "$ref": "#/components/schemas/Link"
                                        }
                                    }
                                }
                            },
                            "application/json": {
                                "schema": {
                                    "type": "object",
                                    "additionalProperties": {
                                        "type": "object",
                                        "additionalProperties": {
                                            "$ref": "#/components/schemas/Link"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
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
        "/actuator/health": {
            "get": {
                "tags": [
                    "Actuator"
                ],
                "summary": "Actuator web endpoint 'health'",
                "operationId": "health",
                "responses": {
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
                            "application/vnd.spring-boot.actuator.v3+json": {
                                "schema": {
                                    "type": "object"
                                }
                            },
                            "application/vnd.spring-boot.actuator.v2+json": {
                                "schema": {
                                    "type": "object"
                                }
                            },
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
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
        "/actuator/health/**": {
            "get": {
                "tags": [
                    "Actuator"
                ],
                "summary": "Actuator web endpoint 'health-path'",
                "operationId": "health-path",
                "responses": {
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
                            "application/vnd.spring-boot.actuator.v3+json": {
                                "schema": {
                                    "type": "object"
                                }
                            },
                            "application/vnd.spring-boot.actuator.v2+json": {
                                "schema": {
                                    "type": "object"
                                }
                            },
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
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
        "/actuator/info": {
            "get": {
                "tags": [
                    "Actuator"
                ],
                "summary": "Actuator web endpoint 'info'",
                "operationId": "info",
                "responses": {
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
                            "application/vnd.spring-boot.actuator.v3+json": {
                                "schema": {
                                    "type": "object"
                                }
                            },
                            "application/vnd.spring-boot.actuator.v2+json": {
                                "schema": {
                                    "type": "object"
                                }
                            },
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
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
        "/forward": {
            "get": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_3",
                "parameters": [
                    {
                        "name": "body",
                        "in": "query",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
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
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "put": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_2",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
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
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "post": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_1",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
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
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "delete": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_4",
                "responses": {
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
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "options": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_5",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
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
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "head": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_6",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
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
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "patch": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
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
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
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
            "Link": {
                "type": "object",
                "properties": {
                    "href": {
                        "type": "string"
                    },
                    "templated": {
                        "type": "boolean"
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
            }
        }
    }
}
