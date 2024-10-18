{
    "openapi": "3.0.1",
    "info": {
        "title": "Status Page - API",
        "description": "API to Status Page",
        "version": "v1"
    },
    "servers": [
        {
            "url": "https://api.dev.platform.pagopa.it/shared/statuspage/v1"
        }
    ],
    "paths": {
        "/info": {
            "get": {
                "tags": [
                    "Home"
                ],
                "summary": "Health Check",
                "description": "Return OK if application is started",
                "operationId": "healthCheck",
                "parameters": [
                    {
                        "name": "product",
                        "in": "query",
                        "description": "It identifies the product to retrive info about.",
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {}
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "403": {
                        "description": "Forbidden"
                    },
                    "429": {
                        "description": "Too many requests"
                    },
                    "500": {
                        "description": "Service unavailable",
                        "content": {
                            "application/json": {}
                        }
                    }
                }
            }
        },
        "/github/*": {
            "get": {
                "summary": "Proxy GitHub",
                "operationId": "proxyGithub",
                "responses": {
                    "200": {
                        "description": "OK"
                    }
                }
            }
        }
    },
    "components": {}
}
