{
    "openapi": "3.0.1",
    "info": {
        "title": "PM Mock Service",
        "description": "",
        "version": "1.0"
    },
    "servers": [
        {
            "url": "https://${host}/pmmockserviceapi"
        }
    ],
    "paths": {
        "/*": {
            "get": {
                "summary": "TEST",
                "operationId": "test",
                "responses": {
                    "200": {
                        "description": null
                    }
                }
            },
            "post": {
                "summary": "POST",
                "operationId": "post",
                "responses": {
                    "200": {
                        "description": null
                    }
                }
            },
            "put": {
                "summary": "PUT",
                "operationId": "put",
                "responses": {
                    "200": {
                        "description": null
                    }
                }
            },
            "delete": {
                "summary": "delete",
                "operationId": "delete",
                "responses": {
                    "200": {
                        "description": null
                    }
                }
            }
        },
        "/": {
            "get": {
                "summary": "HOME",
                "operationId": "home",
                "responses": {
                    "200": {
                        "description": null
                    }
                }
            }
        }
    },
    "components": {
        "securitySchemes": {
            "apiKeyHeader": {
                "type": "apiKey",
                "name": "Ocp-Apim-Subscription-Key",
                "in": "header"
            },
            "apiKeyQuery": {
                "type": "apiKey",
                "name": "subscription-key",
                "in": "query"
            }
        }
    },
    "security": [
        {
            "apiKeyHeader": []
        },
        {
            "apiKeyQuery": []
        }
    ]
}