{
    "openapi": "3.0.1",
    "info": {
        "title": "BPD PM Payment Instrument",
        "version": "1.0"
    },
    "servers": [{
        "url": "https://${host}/bpd/pm/payment-instrument"
    }],
    "paths": {
        "/{id}": {
            "delete": {
                "summary": "delete",
                "description": "delete",
                "operationId": "delete",
                "parameters": [{
                    "name": "id",
                    "in": "path",
                    "description": "id dello strumento di pagamento che corrisponde all'hash del pan",
                    "required": true,
                    "schema": {
                        "type": "string"
                    }
                }, {
                    "name": "fiscalCode",
                    "in": "query",
                    "description": "codice fiscale dell'utente",
                    "required": true,
                    "schema": {
                        "type": "string"
                    }
                }],
                "responses": {
                    "204": {
                        "description": ""
                    },
                    "401": {
                        "description": ""
                    },
                    "404": {
                        "description": ""
                    },
                    "409": {
                        "description": ""
                    },
                    "500": {
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
    "security": [{
        "apiKeyHeader": []
    }, {
        "apiKeyQuery": []
    }]
}