{
    "openapi": "3.0.1",
    "info": {
        "title": "PM Mock Service authenticated",
        "description": "",
        "version": "1.0"
    },
    "servers": [{
        "url": "https://${host}/pmmockserviceapiauth"
    }],
    "paths": {
        "/nodo/sit/send/rpt": {
            "patch": {
                "summary": "Send RPT SIT",
                "operationId": "send-rpt-sit",
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
    "security": [{
        "apiKeyHeader": []
    }, {
        "apiKeyQuery": []
    }]
}