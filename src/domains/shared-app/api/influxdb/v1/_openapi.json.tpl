{
    "openapi": "3.0.1",
    "info": {
        "title": "Influxdb",
        "description": "Influx DB for Grafana",
        "version": "1.0"
    },
    "servers": [
        {
            "url": "http://api.dev.platform.pagopa.it/grafanatryit"
        },
        {
            "url": "https://api.dev.platform.pagopa.it/grafanatryit"
        }
    ],
    "paths": {
        "/*": {
            "get": {
                "summary": "get",
                "description": "get",
                "operationId": "632088424ae312f8d056eabc",
                "responses": {
                    "200": {
                        "description": ""
                    }
                }
            },
            "put": {
                "summary": "put",
                "description": "put",
                "operationId": "632088469c81b1ffc87627e5",
                "responses": {
                    "200": {
                        "description": ""
                    }
                }
            },
            "head": {
                "summary": "head",
                "description": "head",
                "operationId": "6320884373e33489abbc231f",
                "responses": {
                    "200": {
                        "description": ""
                    }
                }
            },
            "post": {
                "summary": "post",
                "description": "post",
                "operationId": "63208843be759e30047b8346",
                "responses": {
                    "200": {
                        "description": ""
                    }
                }
            },
            "delete": {
                "summary": "del",
                "description": "del",
                "operationId": "63208842ccddadea93db0ba7",
                "responses": {
                    "200": {
                        "description": ""
                    }
                }
            }
        },
        "/ping": {
            "options": {
                "summary": "opt",
                "description": "opt",
                "operationId": "632088423f3ab95b12a6c746",
                "responses": {
                    "200": {
                        "description": ""
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
