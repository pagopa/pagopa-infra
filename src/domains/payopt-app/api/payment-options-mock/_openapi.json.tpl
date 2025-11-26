{
    "openapi": "3.0.1",
    "info": {
        "title": "Mocker Payopts",
        "description": "",
        "version": "1.0"
    },
    "servers": [
        {
            "url": "https://api.dev.platform.pagopa.it/payopt-mock"
        }
    ],
    "paths": {
        "/payment-options/organizations/{organization-fiscal-code}/notices/{notice-number}": {
            "post": {
                "summary": "Get Payment Options",
                "operationId": "get-payment-options",
                "parameters": [
                    {
                        "name": "organization-fiscal-code",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": ""
                        }
                    },
                    {
                        "name": "notice-number",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": ""
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Single Opt Response",
                        "content": {
                            "application/json": {
                                "example": {
                                    "organizationFiscalCode": "77777777777",
                                    "companyName": "EC",
                                    "officeName": "EC",
                                    "paymentOptions": [
                                        {
                                            "description": "Test PayOpt - unica opzione",
                                            "numberOfInstallments": 1,
                                            "amount": 120,
                                            "dueDate": "2024-10-30T23:59:59.0000000+00:00",
                                            "validFrom": "2024-09-30T23:59:59.0000000+00:00",
                                            "status": "non pagato",
                                            "status reason": "desc",
                                            "allCCP": "false",
                                            "installments": [
                                                {
                                                    "nav": "311111111111111111",
                                                    "iuv": "311111111111111111",
                                                    "amount": 120,
                                                    "description": "Test Opt Inst - unica opzione",
                                                    "dueDate": "2024-10-30T23:59:59.0000000+00:00",
                                                    "validFrom": "2024-09-30T23:59:59.0000000+00:00",
                                                    "status": "non pagato",
                                                    "status reason": "desc"
                                                }
                                            ]
                                        }
                                    ]
                                }
                            }
                        }
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
