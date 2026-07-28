{
    "openapi": "3.0.1",
    "info": {
        "title": "Node Forwarder",
        "description": "API to forward Node requests to the related CIs and PSPs",
        "termsOfService": "https://www.pagopa.gov.it/",
        "version": "0.0.1-1"
    },
    "servers": [
        {
            "url": "http://localhost:8080",
            "description": "Generated server url"
        }
    ],
    "tags": [
        {
            "name": "Actuator",
            "description": "Monitor and interact",
            "externalDocs": {
                "description": "Spring Boot Actuator Web API Documentation",
                "url": "https://docs.spring.io/spring-boot/docs/current/actuator-api/html/"
            }
        }
    ],
    "paths": {
        "/forward": {
            "post": {
                "tags": [
                    "Proxy"
                ],
                "operationId": "forward",
                "parameters": [
                    {
                        "name": "X-Host-Url",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "X-Host-Port",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "integer",
                            "format": "int32"
                        }
                    },
                    {
                        "name": "X-Host-Path",
                        "in": "header",
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
