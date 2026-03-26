{
    "openapi": "3.0.2",
    "info": {
        "title": "Nexi Build APIs",
        "version": "0.7"
    },
    "servers": [
        {
            "url": "https://{gateway_test}/api/v1",
            "description": "TEST"
        },
        {
            "url": "https://{gateway_prod}/api/v1",
            "description": "PROD"
        }
    ],
    "security": [
        {
            "ApiKeyAuth": []
        },
        {
            "OAuth2": []
        }
    ],
    "paths": {
        "/psp/api/v1/orders/build": {
            "post": {
                "operationId": "postOrdersBuild",
                "tags": [
                    "Payment Services"
                ],
                "security": [
                    {
                        "ApiKeyAuth": []
                    }
                ],
                "summary": "Create an order and initiates a payment through build functionality.",
                "description": "This service is targeted to ecommerce platforms requiring to implement the payment pages in line with their own dedicated UI style guidelines. The service will return a list of fields expressed in JSON format, to be translated into HTML by the ecommerce platform web app. If the paymentService field is valued at CARDS the service will return a list of fields for the CARD_DATA_COLLECTION without going through the PAYMENT_METHOD_SELECTION state and if it's valued with an APM the service will return an url where the customer should be redirected.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        },
                        "description": "Mandatory field to be valued with a UUID to be renewed at every call. The purpose of the field is to allow referring to a specific call for any integration or maintenance activity."
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/CreateHostedOrderRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "In case of success, the service returns a list of fields to be rendered in the ecomm web app.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/Fields"
                                },
                                "examples": {
                                    "PAYMENT_METHOD_SELECTION": {
                                        "value": {
                                            "sessionId": "052211e8-54c8-4e0a-8402-e10bcb8ff264",
                                            "securityToken": "SECURITY_TOKEN",
                                            "fields": [
                                                {
                                                    "type": "ACTION",
                                                    "class": "APM",
                                                    "id": "APM",
                                                    "src": "https://<fe>/field.html?id=APM&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                                                },
                                                {
                                                    "type": "ACTION",
                                                    "class": "CARD",
                                                    "id": "PAY_WITH_CARD",
                                                    "src": "https://<fe>/field.html?id=CARD&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                                                }
                                            ]
                                        }
                                    },
                                    "CARD_DATA_COLLECTION": {
                                        "value": {
                                            "sessionId": "052211e8-54c8-4e0a-8402-e10bcb8ff264",
                                            "securityToken": "SECURITY_TOKEN",
                                            "fields": [
                                                {
                                                    "type": "TEXT",
                                                    "class": "CARD",
                                                    "id": "SECURITY_CODE",
                                                    "src": "https://<fe>/field.html?id=SECURITY_CODE&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                                                },
                                                {
                                                    "type": "TEXT",
                                                    "class": "CARD",
                                                    "id": "CARDHOLDER_EMAIL",
                                                    "src": "https://<fe>/field.html?id=CARDHOLDER_EMAIL&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                                                }
                                            ]
                                        }
                                    },
                                    "APM_PAYMENT_SERVICE": {
                                        "value": {
                                            "sessionId": "052211e8-54c8-4e0a-8402-e10bcb8ff264",
                                            "securityToken": "SECURITY_TOKEN",
                                            "state": "REDIRECT_TO_EXTERNAL_DOMAIN",
                                            "url": "https://{Apm_Url}"
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/psp/api/v1/build/finalize_payment": {
            "post": {
                "tags": [
                    "Payment Services"
                ],
                "security": [
                    {
                        "ApiKeyAuth": []
                    }
                ],
                "summary": "Finalize a payment.",
                "description": "This service shall be invoked by the ecommerce platforms to finalize the payment. It is limited to the flow versions 1 and 3.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        },
                        "description": "Mandatory field to be valued with a UUID to be renewed at every call. The purpose of the field is to allow referring to a specific call for any integration or maintenance activity."
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/SessionIdRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "The returned states can be:\n* PAYMENT_COMPLETE: meaning that the payment flow reached the end, either with success or failure. The operation field describes in detail the payment result.\n* REDIRECTED_TO_EXTERNAL_DOMAIN: it is required to perform a user authentication on an external domain. This may happen for a 3DS challenge of a card payment or for any payment performed with alternative payment methods. In all cases, the user's browser shall be redirected to the url indicated in the field 'url'.\n",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/StateResponse"
                                },
                                "examples": {
                                    "PAYMENT_COMPLETE": {
                                        "value": {
                                            "state": "PAYMENT_COMPLETE",
                                            "operation": {
                                                "orderId": "btid2384983",
                                                "operationId": "3470744",
                                                "channel": "ECOMMERCE",
                                                "operationType": "CAPTURE",
                                                "operationResult": "AUTHORIZED",
                                                "operationTime": "2022-09-01T01:20:00.001Z",
                                                "paymentMethod": "CARD",
                                                "paymentCircuit": "VISA",
                                                "paymentInstrumentInfo": "***6152",
                                                "paymentEndToEndId": "e723hedsdew",
                                                "cancelledOperationId": "",
                                                "operationAmount": "3545",
                                                "operationCurrency": "EUR",
                                                "customerInfo": {
                                                    "cardHolderName": "Mauro Morandi",
                                                    "cardHolderEmail": "mauro.morandi@nexi.it",
                                                    "billingAddress": {
                                                        "name": "Mario Rossi",
                                                        "street": "Piazza Maggiore, 1",
                                                        "additionalInfo": "Quinto Piano, Scala B",
                                                        "city": "Bologna",
                                                        "postCode": "40124",
                                                        "province": "BO",
                                                        "country": "ITA"
                                                    },
                                                    "shippingAddress": {
                                                        "name": "Mario Rossi",
                                                        "street": "Piazza Maggiore, 1",
                                                        "additionalInfo": "Quinto Piano, Scala B",
                                                        "city": "Bologna",
                                                        "postCode": "40124",
                                                        "province": "BO",
                                                        "country": "ITA"
                                                    },
                                                    "mobilePhoneCountryCode": "39",
                                                    "mobilePhone": "3280987654",
                                                    "homePhone": "391231234567",
                                                    "workPhone": "391231234567",
                                                    "cardHolderAcctInfo": {
                                                        "chAccDate": "2019-02-11",
                                                        "chAccAgeIndicator": "01",
                                                        "chAccChangeDate": "2019-02-11",
                                                        "chAccChangeIndicator": "01",
                                                        "chAccPwChangeDate": "2019-02-11",
                                                        "chAccPwChangeIndicator": "01",
                                                        "nbPurchaseAccount": 0,
                                                        "destinationAddressUsageDate": "2019-02-11",
                                                        "destinationAddressUsageIndicator": "01",
                                                        "destinationNameIndicator": "01",
                                                        "txnActivityDay": 0,
                                                        "txnActivityYear": 0,
                                                        "provisionAttemptsDay": 0,
                                                        "suspiciousAccActivity": "01",
                                                        "paymentAccAgeDate": "2019-02-11",
                                                        "paymentAccIndicator": "0"
                                                    },
                                                    "merchantRiskIndicator": {
                                                        "deliveryEmail": "john.doe@email.com",
                                                        "deliveryTimeframe": "01",
                                                        "giftCardAmount": null,
                                                        "giftCardCount": 0,
                                                        "preOrderDate": "2019-02-11",
                                                        "preOrderPurchaseIndicator": "01",
                                                        "reorderItemsIndicator": "01",
                                                        "shipIndicator": "01"
                                                    }
                                                },
                                                "warnings": [
                                                    {
                                                        "code": "TRA001",
                                                        "description": "3DS warning"
                                                    }
                                                ],
                                                "paymentLinkId": "234244353",
                                                "additionalData": {
                                                    "authorizationCode": "647189",
                                                    "cardCountry": "ITA",
                                                    "threeDS": "FULL_SECURE",
                                                    "schemaTID": "MCS01198U",
                                                    "multiCurrencyConversion": {
                                                        "amount": "2662",
                                                        "currency": "JPY",
                                                        "exchangeRate": "0.007510523"
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    "REDIRECTED_TO_EXTERNAL_DOMAIN": {
                                        "value": {
                                            "state": "REDIRECTED_TO_EXTERNAL_DOMAIN",
                                            "url": "https://..."
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/psp/api/v1/build/confirm_payment": {
            "post": {
                "operationId": "confirmPayment",
                "tags": [
                    "Payment Services"
                ],
                "security": [
                    {
                        "ApiKeyAuth": []
                    }
                ],
                "summary": "Confirm a payment.",
                "description": "This service shall be invoked by the ecommerce platforms to finalize the payment. It is limited to the flow version 2.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        },
                        "description": "Mandatory field to be valued with a UUID to be renewed at every call. The purpose of the field is to allow referring to a specific call for any integration or maintenance activity."
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/ConfirmPaymentRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "The returned states can be:\n* PAYMENT_COMPLETE: meaning that the payment flow reached the end with failure. The operation field describes in detail the payment result.\n* REDIRECTED_TO_EXTERNAL_DOMAIN: This happens in case of a payment performed with alternative payment methods. In this case, the user's browser shall be redirected to the url indicated in the field 'url'.\n* GDI_VERIFICATION: the service returns a fieldSet composed by a unique field dedicated to gdi verification and the sessionId. The ecom platform shall set an hidden internal frame to navigate to the provided URL. Once the GDI verification is completed, the internal frame will send a postMessage indicating the next step of the flow that can be either a URL to perform the 3DS challenge or the final result of the payment.\n",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/StateResponse"
                                },
                                "examples": {
                                    "PAYMENT_COMPLETE": {
                                        "value": {
                                            "state": "PAYMENT_COMPLETE",
                                            "operation": {
                                                "orderId": "btid2384983",
                                                "operationId": "3470744",
                                                "channel": "ECOMMERCE",
                                                "operationType": "CAPTURE",
                                                "operationResult": "THREEDS_FAILED",
                                                "operationTime": "2022-09-01T01:20:00.001Z",
                                                "paymentMethod": "CARD",
                                                "paymentCircuit": "VISA",
                                                "paymentInstrumentInfo": "***6152",
                                                "paymentEndToEndId": "e723hedsdew",
                                                "cancelledOperationId": "",
                                                "operationAmount": "3545",
                                                "operationCurrency": "EUR",
                                                "customerInfo": {
                                                    "cardHolderName": "Mauro Morandi",
                                                    "cardHolderEmail": "mauro.morandi@nexi.it",
                                                    "billingAddress": {
                                                        "name": "Mario Rossi",
                                                        "street": "Piazza Maggiore, 1",
                                                        "additionalInfo": "Quinto Piano, Scala B",
                                                        "city": "Bologna",
                                                        "postCode": "40124",
                                                        "province": "BO",
                                                        "country": "ITA"
                                                    },
                                                    "shippingAddress": {
                                                        "name": "Mario Rossi",
                                                        "street": "Piazza Maggiore, 1",
                                                        "additionalInfo": "Quinto Piano, Scala B",
                                                        "city": "Bologna",
                                                        "postCode": "40124",
                                                        "province": "BO",
                                                        "country": "ITA"
                                                    },
                                                    "mobilePhoneCountryCode": "39",
                                                    "mobilePhone": "3280987654",
                                                    "homePhone": "391231234567",
                                                    "workPhone": "391231234567",
                                                    "cardHolderAcctInfo": {
                                                        "chAccDate": "2019-02-11",
                                                        "chAccAgeIndicator": "01",
                                                        "chAccChangeDate": "2019-02-11",
                                                        "chAccChangeIndicator": "01",
                                                        "chAccPwChangeDate": "2019-02-11",
                                                        "chAccPwChangeIndicator": "01",
                                                        "nbPurchaseAccount": 0,
                                                        "destinationAddressUsageDate": "2019-02-11",
                                                        "destinationAddressUsageIndicator": "01",
                                                        "destinationNameIndicator": "01",
                                                        "txnActivityDay": 0,
                                                        "txnActivityYear": 0,
                                                        "provisionAttemptsDay": 0,
                                                        "suspiciousAccActivity": "01",
                                                        "paymentAccAgeDate": "2019-02-11",
                                                        "paymentAccIndicator": "0"
                                                    },
                                                    "merchantRiskIndicator": {
                                                        "deliveryEmail": "john.doe@email.com",
                                                        "deliveryTimeframe": "01",
                                                        "giftCardAmount": null,
                                                        "giftCardCount": 0,
                                                        "preOrderDate": "2019-02-11",
                                                        "preOrderPurchaseIndicator": "01",
                                                        "reorderItemsIndicator": "01",
                                                        "shipIndicator": "01"
                                                    }
                                                },
                                                "warnings": [
                                                    {
                                                        "code": "TRA001",
                                                        "description": "3DS warning"
                                                    }
                                                ],
                                                "paymentLinkId": "234244353",
                                                "additionalData": {
                                                    "authorizationCode": "647189",
                                                    "cardCountry": "ITA",
                                                    "threeDS": "FULL_SECURE",
                                                    "schemaTID": "MCS01198U",
                                                    "multiCurrencyConversion": {
                                                        "amount": "2662",
                                                        "currency": "JPY",
                                                        "exchangeRate": "0.007510523"
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    "REDIRECTED_TO_EXTERNAL_DOMAIN": {
                                        "value": {
                                            "state": "REDIRECTED_TO_EXTERNAL_DOMAIN",
                                            "url": "https://{Apm_Url}",
                                            "fieldSet": {
                                                "sessionId": "052211e8-54c8-4e0a-8402-e10bcb8ff264"
                                            }
                                        }
                                    },
                                    "GDI_VERIFICATION": {
                                        "value": {
                                            "state": "GDI_VERIFICATION",
                                            "fieldSet": {
                                                "sessionId": "052211e8-54c8-4e0a-8402-e10bcb8ff264",
                                                "fields": [
                                                    {
                                                        "type": "GDI",
                                                        "class": "GDI",
                                                        "id": "GDI",
                                                        "src": "https:/.../iframe.html"
                                                    }
                                                ]
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/psp/api/v1/build/cancel": {
            "post": {
                "tags": [
                    "Payment Services"
                ],
                "security": [
                    {
                        "ApiKeyAuth": []
                    }
                ],
                "summary": "Cancel a payment.",
                "description": "This service is targeted to ecommerce platforms in order to cancel the current payment session. This is typically required to clean up the collected data in case the user decided to quit the payment before completion.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        },
                        "description": "Mandatory field to be valued with a UUID to be renewed at every call. The purpose of the field is to allow referring to a specific call for any integration or maintenance activity."
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/SessionIdRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "In case of success, the service returns the specific status based on the state machine.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/StateResponse"
                                },
                                "example": {
                                    "state": "PAYMENT_COMPLETE",
                                    "operation": {
                                        "orderId": "btid2384983",
                                        "operationId": "3470744",
                                        "channel": "ECOMMERCE",
                                        "operationType": "CANCEL",
                                        "operationResult": "CANCELED",
                                        "operationTime": "2022-09-01T01:20:00.001Z",
                                        "cancelledOperationId": "",
                                        "customerInfo": {
                                            "cardHolderName": "Mauro Morandi",
                                            "cardHolderEmail": "mauro.morandi@nexi.it",
                                            "billingAddress": {
                                                "name": "Mario Rossi",
                                                "street": "Piazza Maggiore, 1",
                                                "additionalInfo": "Quinto Piano, Scala B",
                                                "city": "Bologna",
                                                "postCode": "40124",
                                                "province": "BO",
                                                "country": "ITA"
                                            },
                                            "shippingAddress": {
                                                "name": "Mario Rossi",
                                                "street": "Piazza Maggiore, 1",
                                                "additionalInfo": "Quinto Piano, Scala B",
                                                "city": "Bologna",
                                                "postCode": "40124",
                                                "province": "BO",
                                                "country": "ITA"
                                            },
                                            "mobilePhoneCountryCode": "39",
                                            "mobilePhone": "3280987654",
                                            "homePhone": "391231234567",
                                            "workPhone": "391231234567",
                                            "cardHolderAcctInfo": {
                                                "chAccDate": "2019-02-11",
                                                "chAccAgeIndicator": "01",
                                                "chAccChangeDate": "2019-02-11",
                                                "chAccChangeIndicator": "01",
                                                "chAccPwChangeDate": "2019-02-11",
                                                "chAccPwChangeIndicator": "01",
                                                "nbPurchaseAccount": 0,
                                                "destinationAddressUsageDate": "2019-02-11",
                                                "destinationAddressUsageIndicator": "01",
                                                "destinationNameIndicator": "01",
                                                "txnActivityDay": 0,
                                                "txnActivityYear": 0,
                                                "provisionAttemptsDay": 0,
                                                "suspiciousAccActivity": "01",
                                                "paymentAccAgeDate": "2019-02-11",
                                                "paymentAccIndicator": "0"
                                            },
                                            "merchantRiskIndicator": {
                                                "deliveryEmail": "john.doe@email.com",
                                                "deliveryTimeframe": "01",
                                                "giftCardAmount": null,
                                                "giftCardCount": 0,
                                                "preOrderDate": "2019-02-11",
                                                "preOrderPurchaseIndicator": "01",
                                                "reorderItemsIndicator": "01",
                                                "shipIndicator": "01"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/psp/api/v1/build/state": {
            "get": {
                "operationId": "getState",
                "tags": [
                    "Payment Services"
                ],
                "security": [
                    {
                        "ApiKeyAuth": []
                    }
                ],
                "summary": "Get current payment state.",
                "description": "This service the ecommerce platforms to retrieve the current state of a payment flow.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        },
                        "description": "Mandatory field to be valued with a UUID to be renewed at every call. The purpose of the field is to allow referring to a specific call for any integration or maintenance activity."
                    },
                    {
                        "name": "sessionId",
                        "in": "query",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "description": "the value of the payment session identifier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "The service returns the state of the payment flow and all the accessory information.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/StateResponse"
                                },
                                "examples": {
                                    "PAYMENT_COMPLETE": {
                                        "value": {
                                            "state": "PAYMENT_COMPLETE",
                                            "operation": {
                                                "orderId": "btid2384983",
                                                "operationId": "3470744",
                                                "channel": "ECOMMERCE",
                                                "operationType": "CAPTURE",
                                                "operationResult": "AUTHORIZED",
                                                "operationTime": "2022-09-01T01:20:00.001Z",
                                                "paymentMethod": "CARD",
                                                "paymentCircuit": "VISA",
                                                "paymentInstrumentInfo": "***6152",
                                                "paymentEndToEndId": "e723hedsdew",
                                                "cancelledOperationId": "",
                                                "operationAmount": "3545",
                                                "operationCurrency": "EUR",
                                                "customerInfo": {
                                                    "cardHolderName": "Mauro Morandi",
                                                    "cardHolderEmail": "mauro.morandi@nexi.it",
                                                    "billingAddress": {
                                                        "name": "Mario Rossi",
                                                        "street": "Piazza Maggiore, 1",
                                                        "additionalInfo": "Quinto Piano, Scala B",
                                                        "city": "Bologna",
                                                        "postCode": "40124",
                                                        "province": "BO",
                                                        "country": "ITA"
                                                    },
                                                    "shippingAddress": {
                                                        "name": "Mario Rossi",
                                                        "street": "Piazza Maggiore, 1",
                                                        "additionalInfo": "Quinto Piano, Scala B",
                                                        "city": "Bologna",
                                                        "postCode": "40124",
                                                        "province": "BO",
                                                        "country": "ITA"
                                                    },
                                                    "mobilePhoneCountryCode": "39",
                                                    "mobilePhone": "3280987654",
                                                    "homePhone": "391231234567",
                                                    "workPhone": "391231234567",
                                                    "cardHolderAcctInfo": {
                                                        "chAccDate": "2019-02-11",
                                                        "chAccAgeIndicator": "01",
                                                        "chAccChangeDate": "2019-02-11",
                                                        "chAccChangeIndicator": "01",
                                                        "chAccPwChangeDate": "2019-02-11",
                                                        "chAccPwChangeIndicator": "01",
                                                        "nbPurchaseAccount": 0,
                                                        "destinationAddressUsageDate": "2019-02-11",
                                                        "destinationAddressUsageIndicator": "01",
                                                        "destinationNameIndicator": "01",
                                                        "txnActivityDay": 0,
                                                        "txnActivityYear": 0,
                                                        "provisionAttemptsDay": 0,
                                                        "suspiciousAccActivity": "01",
                                                        "paymentAccAgeDate": "2019-02-11",
                                                        "paymentAccIndicator": "0"
                                                    },
                                                    "merchantRiskIndicator": {
                                                        "deliveryEmail": "john.doe@email.com",
                                                        "deliveryTimeframe": "01",
                                                        "giftCardAmount": null,
                                                        "giftCardCount": 0,
                                                        "preOrderDate": "2019-02-11",
                                                        "preOrderPurchaseIndicator": "01",
                                                        "reorderItemsIndicator": "01",
                                                        "shipIndicator": "01"
                                                    }
                                                },
                                                "warnings": [
                                                    {
                                                        "code": "TRA001",
                                                        "description": "3DS warning"
                                                    }
                                                ],
                                                "paymentLinkId": "234244353",
                                                "additionalData": {
                                                    "authorizationCode": "647189",
                                                    "cardCountry": "ITA",
                                                    "threeDS": "FULL_SECURE",
                                                    "schemaTID": "MCS01198U",
                                                    "multiCurrencyConversion": {
                                                        "amount": "2662",
                                                        "currency": "JPY",
                                                        "exchangeRate": "0.007510523"
                                                    }
                                                }
                                            }
                                        }
                                    },
                                    "READY_FOR_PAYMENT": {
                                        "value": {
                                            "state": "READY_FOR_PAYMENT"
                                        }
                                    },
                                    "CARD_DATA_COLLECTION": {
                                        "value": {
                                            "state": "CARD_DATA_COLLECTION",
                                            "fieldSet": [
                                                {
                                                    "type": "text",
                                                    "class": "cardData",
                                                    "id": "cardholderName",
                                                    "src": "https://<fe>/field.html?id=CARDHOLDER_NAME&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                                                }
                                            ]
                                        }
                                    },
                                    "REDIRECTED_TO_EXTERNAL_DOMAIN": {
                                        "value": {
                                            "state": "REDIRECTED_TO_EXTERNAL_DOMAIN",
                                            "url": "https://{Apm_Url}"
                                        }
                                    },
                                    "GDI_VERIFICATION": {
                                        "value": {
                                            "state": "GDI_VERIFICATION",
                                            "fieldSet": [
                                                {
                                                    "type": "GDI",
                                                    "class": "GDI",
                                                    "id": "GDI",
                                                    "src": "https:/.../iframe.html"
                                                }
                                            ]
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/psp/api/v1/build/cardData": {
            "get": {
                "operationId": "getCardData",
                "tags": [
                    "Payment Services"
                ],
                "security": [
                    {
                        "ApiKeyAuth": []
                    }
                ],
                "summary": "Get card characteristics.",
                "description": "It provides PCI-free non sensitive information about the payment card entered by the user along the current payment session.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        },
                        "description": "Mandatory field to be valued with a UUID to be renewed at every call. The purpose of the field is to allow referring to a specific call for any integration or maintenance activity."
                    },
                    {
                        "name": "sessionId",
                        "in": "query",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "description": "the value of the payment session identifier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "In case of success, the service returns the data collected for the given card.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/CardDataResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/psp/api/v1/operations/{operationId}/refunds": {
            "post": {
                "operationId": "refundPayment",
                "tags": [
                    "Payment Services"
                ],
                "summary": "Create an order and initiates a payment through build functionality.",
                "description": "This service is targeted to ecommerce platforms requiring to implement the refund of a payment given the operationId",
                "parameters": [
                    {
                        "name": "operationId",
                        "required": true,
                        "in": "path",
                        "schema": {
                            "type": "string"
                        },
                        "description": "ID of the operation"
                    },
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        },
                        "description": "Mandatory field to be valued with a UUID to be renewed at every call. The purpose of the field is to allow referring to a specific call for any integration or maintenance activity."
                    },
                    {
                        "name": "x-api-key",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "description": "Default api key"
                    },
                    {
                        "name": "Idempotency-key",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "description": "Idempotence key"
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/RefundRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "In case of success, the service returns a dto containing the information about the operation",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/RefundResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Operation not found"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/psp/api/v1/orders/{orderId}/": {
            "get": {
                "operationId": "getOrder",
                "tags": [
                    "Payment Services"
                ],
                "summary": "Searches for an order and returns its details.",
                "description": "It provides order details including all operations associated with given orderId.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "orderId",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "X-API-KEY",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Order found",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/OrderResponse"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "404": {
                        "description": "Order not found"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/fe/build/text/{id}": {
            "post": {
                "tags": [
                    "Hosted Fields"
                ],
                "security": [
                    {
                        "OAuth2": []
                    }
                ],
                "summary": "It stores a given text data in the ongoing build session.",
                "description": "Through this service, the text is sent to Nexi back end and stored in a secure environment associated to the ongoing payment session. This service is invoked by the pages running in the internal fields. It is not required to invoke it directly by the ecomm platform.",
                "parameters": [
                    {
                        "name": "Idempotency-Key",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "session",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "id",
                        "in": "path",
                        "description": "the unique identifier of the text being submitted.",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "example": "Text01"
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/TextRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "Request completed successfully",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PostMessage"
                                },
                                "examples": {
                                    "EVERY_FIELD": {
                                        "value": {
                                            "event": "BUILD_SUCCESS",
                                            "id": "CARDHOLDER_NAME"
                                        }
                                    },
                                    "LAST_FIELD": {
                                        "value": {
                                            "event": "BUILD_SUCCESS",
                                            "id": "CARDHOLDER_NAME",
                                            "gdiUrl": "https://<gdiUrl>"
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Request rejected",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/fe/build/text": {
            "post": {
                "tags": [
                    "Hosted Fields"
                ],
                "security": [
                    {
                        "OAuth2": []
                    }
                ],
                "summary": "Stores the array of data the current build session.",
                "description": "Through this service, the data is sent to Nexi back end and stored in a secure environment associated to the ongoing payment session.",
                "parameters": [
                    {
                        "name": "Idempotency-Key",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "session",
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
                                "$ref": "#/components/schemas/TextFieldsRequest"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "Request completed successfully",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/SaveResponse"
                                },
                                "examples": {
                                    "GDI": {
                                        "value": {
                                            "fieldStatus": [
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "CARD_NUMBER"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "EXPIRATION_DATE"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "SECURITY_CODE"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "CARDHOLDER_NAME"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "CARDHOLDER_EMAIL"
                                                }
                                            ],
                                            "workflowState": "CARD_DATA_COLLECTION",
                                            "gdiStatus": {
                                                "gdiUrl": "https://gdiurl"
                                            }
                                        }
                                    },
                                    "NO_GDI": {
                                        "value": {
                                            "fieldStatus": [
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "CARD_NUMBER"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "EXPIRATION_DATE"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "SECURITY_CODE"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "CARDHOLDER_NAME"
                                                },
                                                {
                                                    "event": "BUILD_SUCCESS",
                                                    "id": "CARDHOLDER_EMAIL"
                                                }
                                            ],
                                            "workflowState": "READY_FOR_PAYMENT"
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Request rejected",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/fe/build/action/{id}": {
            "post": {
                "tags": [
                    "Hosted Fields"
                ],
                "security": [
                    {
                        "OAuth2": []
                    }
                ],
                "summary": "Submit the action requested by the user",
                "description": "The service executes the requested action.",
                "parameters": [
                    {
                        "name": "Idempotency-Key",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "session",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "id",
                        "in": "path",
                        "description": "The unique identifier of the action.",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "example": "pay"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "The requested action was successfully executed.\n* The event field is always valued with BUILD_FLOW_STATE_CHANGE.\n* The state value indicates the page to be shown on the browser.\n* fieldSet contains the list of fields composing the page. \n",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PostMessage"
                                },
                                "example": {
                                    "event": "BUILD_FLOW_STATE_CHANGE",
                                    "state": "CARD_DATA_COLLECTION",
                                    "fieldSet": [
                                        {
                                            "type": "text",
                                            "class": "CARD_DATA",
                                            "id": "CARDHOLDER_NAME",
                                            "src": "https://<fe>/field.html?id=CARDHOLDER_NAME&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                                        }
                                    ]
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Request rejected",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/fe/build/field_settings/{id}": {
            "get": {
                "tags": [
                    "Hosted Fields"
                ],
                "security": [
                    {
                        "OAuth2": []
                    }
                ],
                "summary": "Get the settings of the specified field.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "session",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "id",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "example": "cardholderName"
                        }
                    },
                    {
                        "name": "lang",
                        "in": "query",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "example": "eng"
                        },
                        "description": "The language of the browser expressed in ISO639-3 format."
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Operation successful",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/FieldSettings"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/fe/build/check_gdi_result": {
            "get": {
                "tags": [
                    "Hosted Fields"
                ],
                "security": [
                    {
                        "OAuth2": []
                    }
                ],
                "summary": "Verify and return the result of the gdi.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "session",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "attemptNumber",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "number"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Operation successful",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/GDIStatus"
                                },
                                "examples": {
                                    "KO_MAX_ATTEMPT": {
                                        "value": {
                                            "result": "KO",
                                            "operation": {
                                                "operationId": "12314",
                                                "orderId": "5344663",
                                                "authorizationCode": "647189",
                                                "cardCountry": "ITA",
                                                "threeDS": "FULL_SECURE",
                                                "schemaTID": "MCS01198U",
                                                "operationResult": "3DS_FAILED"
                                            }
                                        }
                                    },
                                    "KO": {
                                        "value": {
                                            "result": "KO"
                                        }
                                    },
                                    "OK": {
                                        "value": {
                                            "result": "OK"
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/fe/build/gdi_and_finalize": {
            "get": {
                "tags": [
                    "Hosted Fields"
                ],
                "security": [
                    {
                        "OAuth2": []
                    }
                ],
                "summary": "Verify the GDI result in order to return the result of finalize_payment.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    },
                    {
                        "name": "session",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    },
                    {
                        "name": "attemptNumber",
                        "in": "query",
                        "required": false,
                        "schema": {
                            "type": "number"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Operation successful",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/StateResponse"
                                },
                                "examples": {
                                    "PAYMENT_COMPLETE": {
                                        "value": {
                                            "state": "PAYMENT_COMPLETE"
                                        }
                                    },
                                    "CHALLENGE": {
                                        "value": {
                                            "state": "REDIRECTED_TO_EXTERNAL_DOMAIN",
                                            "url": "https://{3DS-Ares-Url}"
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/fe/build/validateAndPay": {
            "get": {
                "tags": [
                    "Hosted Fields"
                ],
                "security": [
                    {
                        "OAuth2": []
                    }
                ],
                "summary": "Finalize a payment after a challenge",
                "description": "Through this service, Nexi back end finalize the payment.",
                "parameters": [
                    {
                        "name": "Correlation-Id",
                        "in": "header",
                        "required": true,
                        "schema": {
                            "type": "string",
                            "format": "uuid"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "In case of success, the service returns the merchant's result url",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/StateResponse"
                                },
                                "example": {
                                    "url": "https://{merchant_result_url}"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request data",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ClientError"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ServerError"
                                }
                            }
                        }
                    }
                }
            }
        }
    },
    "components": {
        "schemas": {
            "StateResponse": {
                "type": "object",
                "properties": {
                    "state": {
                        "$ref": "#/components/schemas/WorkflowState"
                    },
                    "url": {
                        "type": "string",
                        "example": "https://{3DS-Ares-Url}"
                    },
                    "operation": {
                        "$ref": "#/components/schemas/Operation"
                    },
                    "fieldSet": {
                        "$ref": "#/components/schemas/Fields"
                    }
                }
            },
            "Operation": {
                "type": "object",
                "properties": {
                    "orderId": {
                        "maxLength": 27,
                        "type": "string",
                        "description": "Merchant order id, unique in the merchant domain",
                        "example": "btid2384983"
                    },
                    "operationId": {
                        "type": "string",
                        "example": "3470744"
                    },
                    "channel": {
                        "$ref": "#/components/schemas/ChannelType"
                    },
                    "operationType": {
                        "$ref": "#/components/schemas/OperationType"
                    },
                    "operationResult": {
                        "$ref": "#/components/schemas/OperationResult"
                    },
                    "operationTime": {
                        "type": "string",
                        "description": "Operation time in ISO 8601 format",
                        "example": "2022-09-01T01:20:00.000Z"
                    },
                    "paymentMethod": {
                        "$ref": "#/components/schemas/PaymentMethod"
                    },
                    "paymentCircuit": {
                        "$ref": "#/components/schemas/PaymentCircuit"
                    },
                    "paymentInstrumentInfo": {
                        "type": "string",
                        "description": "Payment instrument information",
                        "example": "***6152"
                    },
                    "paymentEndToEndId": {
                        "maxLength": 35,
                        "type": "string",
                        "description": "It is defined by the circuit to uniquely identify the transaction. Required for circuid reconciliation purposes.",
                        "example": "e723hedsdew"
                    },
                    "cancelledOperationId": {
                        "type": "string",
                        "description": "Operation id to be undone",
                        "example": ""
                    },
                    "operationAmount": {
                        "type": "string",
                        "description": "Operation amount in the payment currency",
                        "example": "3545"
                    },
                    "operationCurrency": {
                        "type": "string",
                        "description": "Payment currency",
                        "example": "EUR"
                    },
                    "customerInfo": {
                        "$ref": "#/components/schemas/CustomerInfo"
                    },
                    "warnings": {
                        "$ref": "#/components/schemas/Warnings"
                    },
                    "paymentLinkId": {
                        "type": "string",
                        "description": "PayByLink id used for correlating this operation with the original link.",
                        "example": "234244353"
                    },
                    "additionalData": {
                        "type": "object",
                        "additionalProperties": {},
                        "description": "Map of additional fields specific to the chosen payment method",
                        "example": {
                            "authorizationCode": "647189",
                            "cardCountry": "ITA",
                            "threeDS": "FULL_SECURE",
                            "schemaTID": "MCS01198U",
                            "multiCurrencyConversion": {
                                "amount": "2662",
                                "currency": "JPY",
                                "exchangeRate": "0.007510523"
                            }
                        }
                    }
                }
            },
            "ChannelType": {
                "type": "string",
                "description": "It indicates the originating channel:\n* ECOMMERCE - carholder initiated operation through an online channel.\n* POS - carholder initiated operation through a physical POS.      \n* BACKOFFICE - merchant initiated operation. It includes post operations and MIT.\n",
                "example": "ECOMMERCE",
                "enum": [
                    "ECOMMERCE",
                    "POS",
                    "BACKOFFICE"
                ]
            },
            "OperationType": {
                "type": "string",
                "description": "It indicates the purpose of the request:\n* AUTHORIZATION - any authorization with explicit capture\n* CAPTURE - a captured authorization or an implicit captured payment\n* VOID - reversal of an authorization\n* REFUND - refund of a captured amount\n* CANCEL - the rollback of an capture, refund.      \n",
                "example": "CAPTURE",
                "enum": [
                    "AUTHORIZATION",
                    "CAPTURE",
                    "VOID",
                    "REFUND",
                    "CANCEL"
                ]
            },
            "OperationResult": {
                "type": "string",
                "description": "Transaction output:\n* AUTHORIZED - Payment authorized\n* EXECUTED - Payment confirmed, verification successfully executed\n* DECLINED - Declined by the Issuer during the authorization phase\n* DENIED_BY_RISK - Negative outcome of the transaction risk analysis\n* THREEDS_VALIDATED - 3DS authentication OK or 3DS skipped (non-secure payment)  \n* THREEDS_FAILED - cancellation or authentication failure during 3DS\n* PENDING - Payment ongoing. Follow up notifications are expected\n* CANCELED - Canceled by the cardholder\n* VOIDED - Online reversal of the full authorized amount\n* REFUNDED - Full or partial amount refunded\n* FAILED - Payment failed due to technical reasons\n",
                "example": "AUTHORIZED",
                "enum": [
                    "AUTHORIZED",
                    "EXECUTED",
                    "DECLINED",
                    "DENIED_BY_RISK",
                    "THREEDS_VALIDATED",
                    "THREEDS_FAILED",
                    "PENDING",
                    "CANCELED",
                    "VOIDED",
                    "REFUNDED",
                    "FAILED"
                ]
            },
            "PaymentMethod": {
                "type": "string",
                "description": "* CARD - Any card circuit\n* APM - Alternative payment method\n",
                "example": "CARD",
                "enum": [
                    "CARD",
                    "APM"
                ]
            },
            "PaymentCircuit": {
                "type": "string",
                "description": "one of the payment circuit values returned by the GET payment_methods web service. The list may include (but not limited to) VISA, MC, AMEX, DINERS, GOOGLE_PAY, APPLE_PAY, PAYPAL, BANCONTACT, BANCOMAT_PAY, MYBANK, PIS, AMAZON_PAY, ALIPAY.\"\n",
                "example": "VISA"
            },
            "CardDataResponse": {
                "type": "object",
                "properties": {
                    "bin": {
                        "type": "string",
                        "description": "Bank Identification Number. It corresponds to the first 6 digits of the payment card number.",
                        "example": "123456"
                    },
                    "lastFourDigits": {
                        "type": "string",
                        "minLength": 4,
                        "maxLength": 4,
                        "description": "Last 4 digits of the payment card number.",
                        "example": "1234"
                    },
                    "expiringDate": {
                        "type": "string",
                        "description": "Expiration date of the card, in the format MMYY.",
                        "example": "0423"
                    },
                    "circuit": {
                        "$ref": "#/components/schemas/PaymentCircuit"
                    }
                }
            },
            "Warnings": {
                "type": "array",
                "items": {
                    "$ref": "#/components/schemas/Warnings_inner"
                }
            },
            "Warnings_inner": {
                "type": "object",
                "properties": {
                    "code": {
                        "type": "string",
                        "example": "TRA001"
                    },
                    "description": {
                        "type": "string",
                        "example": "3DS warning"
                    }
                }
            },
            "GDIStatus": {
                "type": "object",
                "properties": {
                    "gdiUrl": {
                        "type": "string",
                        "example": "https://{gdi url}"
                    },
                    "result": {
                        "type": "string",
                        "example": "OK"
                    },
                    "operation": {
                        "$ref": "#/components/schemas/Operation"
                    }
                }
            },
            "FieldSettings": {
                "type": "object",
                "properties": {
                    "type": {
                        "$ref": "#/components/schemas/FieldType"
                    },
                    "ecommPlatformDomain": {
                        "type": "string",
                        "description": "protocol and domain URL of the ecommerce platform, to be used for the cross origin validation during the exchange of messages between the iframe and parent window different domains.",
                        "example": "https://{ecomm platform domain}"
                    },
                    "validationRegExp": {
                        "type": "string",
                        "description": "the regular expression that allows validating the text entered by the user. The value shall reflect the RegExp format.",
                        "example": "^[0-9]{16,23}$"
                    },
                    "image": {
                        "type": "string",
                        "example": "https://<fedomain>/CARD.svg"
                    },
                    "label": {
                        "type": "string",
                        "example": "Pay with card",
                        "description": "the label to be showed on the screen, already translated in the desired language."
                    },
                    "title": {
                        "type": "string",
                        "example": "This payment will require to enter your payment card data",
                        "description": "the label to be showed on the screen as a toolTipText already translated in the desired language."
                    },
                    "filterType": {
                        "type": "string",
                        "example": "This payment will require to enter your payment card data",
                        "description": "the label to be showed on the screen as a toolTipText already translated in the desired language."
                    },
                    "placeholder": {
                        "type": "string",
                        "example": "Card Number",
                        "description": "A placeholder text used inside the input box already translated in the desired language."
                    },
                    "cssLink": {
                        "type": "string",
                        "example": "https:{css url}.css",
                        "description": "the css url used in the fields"
                    },
                    "containerClass": {
                        "type": "string",
                        "example": "This payment will require to enter your payment card data",
                        "description": "the label to be showed on the screen as a toolTipText already translated in the desired language."
                    },
                    "componentClass": {
                        "type": "string",
                        "example": "This payment will require to enter your payment card data",
                        "description": "the label to be showed on the screen as a toolTipText already translated in the desired language."
                    },
                    "defaultValue": {
                        "type": "string",
                        "example": "email@email.com",
                        "description": "the default value of specified field"
                    },
                    "brandIntervalList": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/BrandInterval"
                        }
                    },
                    "fieldRequired": {
                        "type": "boolean"
                    }
                }
            },
            "BrandInterval": {
                "type": "object",
                "properties": {
                    "brandName": {
                        "type": "string"
                    },
                    "bottomLimit": {
                        "type": "string"
                    },
                    "upperLimit": {
                        "type": "string"
                    }
                }
            },
            "CreateHostedOrderRequest": {
                "type": "object",
                "properties": {
                    "version": {
                        "type": "string",
                        "example": "1",
                        "default": "1",
                        "description": "It allows selecting the desired version of the flow. The possible values are:\n  1. the 3DS GDI verification is performed directly in the internal frame of the last card data entered by the user. To confirm the payment it is required to invoke the POST finalize_payment. Note: the confirm_payment shall not be invoked.\n  2. the 3DS GDI verification is performed in a dedicated field returned by the POST confirm_payment. Note: the finalize_payment shall not be invoked.\n  3. the 3DS GDI verification is performed after the postmessage confirm payment injected by the 'continue' button pressed after all the card data have been entered. In this case the GDI verification is performed transparently by the JDK provided by Nexi. After the invokation of the onBuildFlowStateChange with the state READY_FOR_PAYMENT, the ecommerce platform is allowed to invoke the finalize_payment service to complete the payment.\n"
                    },
                    "merchantUrl": {
                        "type": "string",
                        "example": "https://merchanturl.it",
                        "description": "to be valued with the protocol and domain url of the ecommerce platform front-end, where the html page encompassing the internal frames is downloaded from. By leveraging on CORS functionality, this ensures a secure communication between the main web page and each of the pages running in the internal frames. Pl find more details at https://www.w3.org/wiki/CORS."
                    },
                    "order": {
                        "$ref": "#/components/schemas/Order"
                    },
                    "paymentSession": {
                        "$ref": "#/components/schemas/PaymentSession"
                    }
                }
            },
            "ClientError": {
                "type": "object",
                "properties": {
                    "errors": {
                        "$ref": "#/components/schemas/Errors"
                    }
                }
            },
            "Errors": {
                "type": "array",
                "items": {
                    "$ref": "#/components/schemas/Errors_inner"
                }
            },
            "ServerError": {
                "type": "object",
                "properties": {
                    "errors": {
                        "$ref": "#/components/schemas/Errors"
                    }
                }
            },
            "PostMessage": {
                "type": "object",
                "properties": {
                    "event": {
                        "$ref": "#/components/schemas/PostMessageEvent"
                    },
                    "gdiStatus": {
                        "$ref": "#/components/schemas/GDIStatus"
                    },
                    "state": {
                        "$ref": "#/components/schemas/WorkflowState"
                    },
                    "id": {
                        "$ref": "#/components/schemas/FieldId"
                    },
                    "fieldSet": {
                        "$ref": "#/components/schemas/Fields"
                    }
                }
            },
            "SessionIdRequest": {
                "type": "object",
                "properties": {
                    "sessionId": {
                        "type": "string",
                        "example": "052211e8/+54cc/4e0a"
                    }
                }
            },
            "TextRequest": {
                "type": "object",
                "properties": {
                    "value": {
                        "type": "string",
                        "example": "text"
                    }
                }
            },
            "TextFieldsRequest": {
                "type": "array",
                "items": {
                    "$ref": "#/components/schemas/FieldValue"
                }
            },
            "FieldValue": {
                "type": "object",
                "properties": {
                    "id": {
                        "type": "string",
                        "example": "CARDHOLDER_NAME"
                    },
                    "value": {
                        "type": "string",
                        "example": "text"
                    }
                }
            },
            "SaveResponse": {
                "type": "object",
                "properties": {
                    "fieldStatus": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/PostMessage"
                        }
                    },
                    "workflowState": {
                        "$ref": "#/components/schemas/WorkflowState"
                    },
                    "gdiStatus": {
                        "$ref": "#/components/schemas/GDIStatus"
                    }
                }
            },
            "Fields": {
                "type": "object",
                "properties": {
                    "sessionId": {
                        "type": "string",
                        "example": "sessionId"
                    },
                    "securityToken": {
                        "type": "string",
                        "example": "security token"
                    },
                    "fields": {
                        "$ref": "#/components/schemas/FieldsList"
                    },
                    "state": {
                        "$ref": "#/components/schemas/WorkflowState"
                    },
                    "url": {
                        "type": "string",
                        "example": "https:apm_url.it"
                    }
                }
            },
            "FieldsList": {
                "type": "array",
                "items": {
                    "$ref": "#/components/schemas/Field"
                }
            },
            "Field": {
                "type": "object",
                "properties": {
                    "type": {
                        "type": "string",
                        "example": "text"
                    },
                    "class": {
                        "type": "string",
                        "example": "cardData"
                    },
                    "id": {
                        "type": "string",
                        "example": "cardholderName"
                    },
                    "src": {
                        "type": "string",
                        "example": "https://<fe>/field.html?id=CARDHOLDER_NAME&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                    }
                }
            },
            "FieldType": {
                "type": "string",
                "example": "TEXT",
                "enum": [
                    "TEXT",
                    "ACTION",
                    "GDI"
                ],
                "description": "It indicates the type of the hosted field."
            },
            "FieldId": {
                "type": "string",
                "example": "CARDHOLDER_NAME",
                "enum": [
                    "CARD_NUMBER",
                    "EXPIRATION_DATE",
                    "SECURITY_CODE",
                    "CARDHOLDER_NAME",
                    "CARDHOLDER_SURNAME",
                    "CARDHOLDER_EMAIL",
                    "PRIVACY_CONDITIONS"
                ],
                "description": "It indicates the type of data to be collected through the field."
            },
            "PostMessageEvent": {
                "type": "string",
                "example": "BUILD_FLOW_STATE_CHANGE",
                "enum": [
                    "BUILD_FLOW_STATE_CHANGE",
                    "BUILD_SUCCESS",
                    "BUILD_ERROR"
                ],
                "description": "It indicates the flow adopted for the ongoing payment. The possible values are:\n*  BUILD_FLOW_STATE_CHANGE: it indicates the request to mode to another page\n*  BUILD_SUCCESS: indicates a successful validation of the data entered by the user.\n*  BUILD_ERROR: indicates an error in the data entered by the user.\n"
            },
            "WorkflowState": {
                "type": "string",
                "example": "CARD_DATA_COLLECTION",
                "enum": [
                    "PAYMENT_METHOD_SELECTION",
                    "CARD_DATA_COLLECTION",
                    "READY_FOR_PAYMENT",
                    "REDIRECTED_TO_EXTERNAL_DOMAIN",
                    "PAYMENT_COMPLETE",
                    "GDI_VERIFICATION"
                ],
                "description": "It indicates the flow adopted for the ongoing payment. The possible values are:\n* PAYMENT_METHOD_SELECTION\n* CARD_DATA_COLLECTION\n* READY_FOR_PAYMENT\n* REDIRECTED_TO_EXTERNAL_DOMAIN\n* PAYMENT_COMPLETE\n"
            },
            "CustomerInfo": {
                "type": "object",
                "properties": {
                    "cardHolderName": {
                        "maxLength": 255,
                        "type": "string",
                        "example": "Mauro Morandi"
                    },
                    "cardHolderEmail": {
                        "maxLength": 255,
                        "type": "string",
                        "example": "mauro.morandi@nexi.it"
                    },
                    "billingAddress": {
                        "$ref": "#/components/schemas/Address"
                    },
                    "shippingAddress": {
                        "$ref": "#/components/schemas/Address"
                    },
                    "mobilePhoneCountryCode": {
                        "maxLength": 4,
                        "type": "string",
                        "example": "39"
                    },
                    "mobilePhone": {
                        "maxLength": 15,
                        "type": "string",
                        "example": "3280987654"
                    },
                    "homePhone": {
                        "maxLength": 19,
                        "type": "string",
                        "description": "The home phone number provided by the Cardholder.",
                        "example": 391231234567
                    },
                    "workPhone": {
                        "maxLength": 19,
                        "type": "string",
                        "description": "The work phone number provided by the Cardholder.",
                        "example": 391231234567
                    },
                    "cardHolderAcctInfo": {
                        "$ref": "#/components/schemas/CardHolderAccountInfo"
                    },
                    "merchantRiskIndicator": {
                        "$ref": "#/components/schemas/MerchantRiskIndicator"
                    }
                }
            },
            "Address": {
                "type": "object",
                "properties": {
                    "name": {
                        "maxLength": 50,
                        "type": "string",
                        "example": "Mario Rossi"
                    },
                    "street": {
                        "maxLength": 50,
                        "type": "string",
                        "example": "Piazza Maggiore, 1"
                    },
                    "additionalInfo": {
                        "maxLength": 50,
                        "type": "string",
                        "example": "Quinto Piano, Scala B"
                    },
                    "city": {
                        "maxLength": 50,
                        "type": "string",
                        "example": "Bologna"
                    },
                    "postCode": {
                        "maxLength": 16,
                        "type": "string",
                        "example": "40124"
                    },
                    "province": {
                        "maxLength": 3,
                        "type": "string",
                        "example": "BO"
                    },
                    "country": {
                        "type": "string",
                        "description": "ISO 3166-1 alpha-3",
                        "example": "ITA"
                    }
                }
            },
            "CardHolderAccountInfo": {
                "type": "object",
                "properties": {
                    "chAccDate": {
                        "type": "string",
                        "description": "Date that the cardholder opened the account with the 3DS Requestor. ISO 8601 format",
                        "example": "2019-02-11T00:00:00.000Z"
                    },
                    "chAccAgeIndicator": {
                        "type": "string",
                        "description": "Length of time that the cardholder has had the account with the 3DS Requestor.",
                        "example": "01"
                    },
                    "chAccChangeDate": {
                        "type": "string",
                        "description": "Date that the cardholder's account with the 3DS Requestor was last changed, including Billing or Shipping address, new payment account, or new user(s) added. ISO 8601 format",
                        "example": "2019-02-11T00:00:00.000Z"
                    },
                    "chAccChangeIndicator": {
                        "type": "string",
                        "description": "Length of time since the cardholder's account information with the 3DS Requestor was last changed, including Billing or Shipping address, new payment account, or new user(s) added.",
                        "example": "01"
                    },
                    "chAccPwChangeDate": {
                        "type": "string",
                        "description": "Date that cardholder's account with the 3DS Requestor had a password change or account reset. ISO 8601 format",
                        "example": "2019-02-11T00:00:00.000Z"
                    },
                    "chAccPwChangeIndicator": {
                        "type": "string",
                        "description": "Indicates the length of time since the cardholder's account with the 3DS Requestor had a password change or account reset.",
                        "example": "01"
                    },
                    "nbPurchaseAccount": {
                        "type": "number",
                        "description": "Number of purchases with this cardholder account during the previous six months.",
                        "example": 0
                    },
                    "destinationAddressUsageDate": {
                        "type": "string",
                        "description": "Date when the shipping address used for this transaction was first used with the 3DS Requestor. ISO 8601 format",
                        "example": "2019-02-11T00:00:00.000Z"
                    },
                    "destinationAddressUsageIndicator": {
                        "type": "string",
                        "description": "Indicates when the shipping address used for this transaction was first used with the 3DS Requestor.",
                        "example": "01"
                    },
                    "destinationNameIndicator": {
                        "type": "string",
                        "description": "Indicates if the Cardholder Name on the account is identical to the shipping Name used for this transaction.",
                        "example": "01"
                    },
                    "txnActivityDay": {
                        "type": "number",
                        "description": "Number of transactions (successful and abandoned) for this cardholder account with the 3DS Requestor across all payment accounts in the previous 24 hours.",
                        "example": 0
                    },
                    "txnActivityYear": {
                        "type": "number",
                        "description": "Number of transactions (successful and abandoned) for this cardholder account with the 3DS Requestor across all payment accounts in the previous year.",
                        "example": 0
                    },
                    "provisionAttemptsDay": {
                        "type": "number",
                        "description": "Number of Add Card attempts in the last 24 hours.",
                        "example": 0
                    },
                    "suspiciousAccActivity": {
                        "type": "string",
                        "description": "Indicates whether the 3DS Requestor has experienced suspicious activity (including previous fraud) on the cardholder account.",
                        "example": "01"
                    },
                    "paymentAccAgeDate": {
                        "type": "string",
                        "description": "Date that the payment account was enrolled in the cardholder's account with the 3DS Requestor. ISO 8601 format",
                        "example": "2019-02-11T00:00:00.000Z"
                    },
                    "paymentAccIndicator": {
                        "type": "string",
                        "description": "Indicates the length of time that the payment account was enrolled in the cardholder's account with the 3DS Requestor.",
                        "example": "0"
                    }
                }
            },
            "MerchantRiskIndicator": {
                "type": "object",
                "properties": {
                    "deliveryEmail": {
                        "type": "string",
                        "description": "For Electronic delivery, the email address to which the merchandise was delivered.",
                        "example": "john.doe@email.com"
                    },
                    "deliveryTimeframe": {
                        "type": "string",
                        "description": "Indicates the merchandise delivery timeframe.",
                        "example": "01"
                    },
                    "giftCardAmount": {
                        "$ref": "#/components/schemas/MerchantRiskIndicator_giftCardAmount"
                    },
                    "giftCardCount": {
                        "type": "number",
                        "description": "For prepaid or gift card purchase, total count of individual prepaid or gift cards/codes purchased.",
                        "example": 0
                    },
                    "preOrderDate": {
                        "type": "string",
                        "description": "For a pre-ordered purchase, the expected date that the merchandise will be available. ISO 8601 format",
                        "example": "2019-02-11T00:00:00.000Z"
                    },
                    "preOrderPurchaseIndicator": {
                        "type": "string",
                        "description": "Indicates whether Cardholder is placing an order for merchandise with a future availability or release date.",
                        "example": "01"
                    },
                    "reorderItemsIndicator": {
                        "type": "string",
                        "description": "Indicates whether the cardholder is reordering previously purchased merchandise.",
                        "example": "01"
                    },
                    "shipIndicator": {
                        "type": "string",
                        "description": "Indicates shipping method chosen for the transaction.",
                        "example": "01"
                    }
                }
            },
            "Order": {
                "type": "object",
                "properties": {
                    "orderId": {
                        "maxLength": 27,
                        "type": "string",
                        "description": "Merchant order id, unique in the merchant domain",
                        "example": "btid2384983"
                    },
                    "amount": {
                        "type": "string",
                        "description": "Transaction amount in smallest currency unit. 50 EUR is represented as 5000 (2 decimals) 50 JPY is represented as 50 (0 decimals)",
                        "example": "3545"
                    },
                    "currency": {
                        "type": "string",
                        "description": "Transaction currency. ISO 4217 alphabetic code",
                        "example": "EUR"
                    },
                    "customerId": {
                        "maxLength": 27,
                        "type": "string",
                        "description": "Immutable identifier of the payer as registered on the ecommerce platform.",
                        "example": "mcid97295873"
                    },
                    "description": {
                        "maxLength": 255,
                        "type": "string",
                        "description": "Transaction description",
                        "example": "TV LG 3423"
                    },
                    "customField": {
                        "maxLength": 255,
                        "type": "string",
                        "description": "Additional transaction description",
                        "example": "weekend promotion"
                    },
                    "customerInfo": {
                        "$ref": "#/components/schemas/CustomerInfo"
                    },
                    "transactionSummary": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/TransactionSummary"
                        }
                    },
                    "installments": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/Installment"
                        }
                    },
                    "termsAndConditionsIds": {
                        "$ref": "#/components/schemas/TermsAndConditions"
                    }
                }
            },
            "TransactionSummary": {
                "type": "object",
                "properties": {
                    "language": {
                        "type": "string",
                        "description": "Language to be used on the transaction summary details, ISO 639-2.",
                        "example": "eng"
                    },
                    "summaryList": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/TransactionSummaryAttribute"
                        }
                    }
                }
            },
            "TransactionSummaryAttribute": {
                "type": "object",
                "properties": {
                    "label": {
                        "type": "string",
                        "description": "label of the field",
                        "example": "Number of people"
                    },
                    "value": {
                        "type": "string",
                        "description": "value",
                        "example": "4"
                    }
                }
            },
            "Installment": {
                "type": "object",
                "properties": {
                    "date": {
                        "type": "string",
                        "description": "Installment time in ISO 8601 format.",
                        "example": "2022-09-01T00:00:00.000Z"
                    },
                    "amount": {
                        "type": "string",
                        "description": "Installment amount.",
                        "example": "350"
                    }
                }
            },
            "TermsAndConditions": {
                "type": "array",
                "items": {
                    "type": "string",
                    "description": "T&C unique identifier",
                    "example": "16dd6ac6-0791-4c72-b362-85f77f1728a2"
                }
            },
            "PaymentSession": {
                "type": "object",
                "properties": {
                    "actionType": {
                        "$ref": "#/components/schemas/ActionType"
                    },
                    "amount": {
                        "type": "string",
                        "description": "Amount of the first payment which may be less or equals to the order amount. 50 EUR is represented as 5000 (2 decimals) 50 JPY is represented as 50 (0 decimals)",
                        "example": "3545"
                    },
                    "recurrence": {
                        "$ref": "#/components/schemas/RecurringSettings"
                    },
                    "captureType": {
                        "$ref": "#/components/schemas/CaptureType"
                    },
                    "exemptions": {
                        "$ref": "#/components/schemas/ExemptionsSettings"
                    },
                    "language": {
                        "type": "string",
                        "description": "Language to be used on the hosted payment page. ISO 639-2",
                        "example": "ita",
                        "default": "ita"
                    },
                    "resultUrl": {
                        "maxLength": 2048,
                        "type": "string",
                        "description": "Merchant URL where the cardholder is redirected once the hosted payment completes",
                        "example": "https://{merchant_result_url}"
                    },
                    "cancelUrl": {
                        "maxLength": 2048,
                        "type": "string",
                        "description": "Merchant URL where the cardholder is redirected once the hosted payment is abandoned",
                        "example": "https://{merchant_cancel_url}"
                    },
                    "notificationUrl": {
                        "maxLength": 2048,
                        "type": "string",
                        "description": "Merchant URL where the gateway pushes notifications",
                        "example": "https://{merchant_notification_url}"
                    },
                    "paymentService": {
                        "type": "string",
                        "description": "Return the card fields in case of CARDS or an url where the cardholder should be redirect to complete the payment in case of an APM",
                        "example": "GOOGLEPAY"
                    }
                }
            },
            "ActionType": {
                "type": "string",
                "example": "PAY",
                "enum": [
                    "PAY",
                    "VERIFY",
                    "PREAUTH"
                ]
            },
            "RecurringSettings": {
                "type": "object",
                "properties": {
                    "action": {
                        "$ref": "#/components/schemas/RecurringAction"
                    },
                    "contractId": {
                        "maxLength": 255,
                        "type": "string",
                        "example": "C2834987"
                    },
                    "contractType": {
                        "$ref": "#/components/schemas/RecurringContractType"
                    },
                    "contractExpiryDate": {
                        "type": "string",
                        "format": "date",
                        "description": "Used with contractType MIT_SCHEDULED. ISO 8601 format. If the token was provided by VTS or MDES, it represents the expiry date of the token provided by the circuit",
                        "example": "2023-03-16T00:00:00.000Z"
                    },
                    "contractFrequency": {
                        "maxLength": 4,
                        "type": "string",
                        "description": "Used with contractType MIT_SCHEDULED. Number of days",
                        "example": "120"
                    }
                }
            },
            "RecurringAction": {
                "type": "string",
                "example": "NO_RECURRING",
                "enum": [
                    "NO_RECURRING",
                    "SUBSEQUENT_PAYMENT",
                    "CONTRACT_CREATION",
                    "CARD_SUBSTITUTION"
                ]
            },
            "RecurringContractType": {
                "type": "string",
                "description": "It indicates the possible options for the subsequent payments:\n * CIT - the contract can be used only for subsequent payments initiated by the customer. \n* MIT_SCHEDULED - the contract can be used for scheduled merchant initiated transactions. The number of day between one payment and another shall be equal or higher than the value of contractFrequency. \n* MIT_UNSCHEDULED - the contract can be used for unscheduled merchant initiated transactions. The contractFrequency has no effect in this case.",
                "example": "CIT",
                "enum": [
                    "MIT_UNSCHEDULED",
                    "MIT_SCHEDULED",
                    "CIT"
                ]
            },
            "CaptureType": {
                "type": "string",
                "description": "Overwrites the default confirmation method of the terminal, for card payments only:\n* IMPLICIT - automatic confirmation \n* EXPLICIT - authorization only  \nDefault value depends on the terminal configuration.               \n",
                "example": "EXPLICIT",
                "enum": [
                    "IMPLICIT",
                    "EXPLICIT"
                ]
            },
            "ExemptionsSettings": {
                "type": "string",
                "example": "NO_PREFERENCE",
                "default": "NO_PREFERENCE",
                "enum": [
                    "NO_PREFERENCE",
                    "CHALLENGE_REQUESTED"
                ]
            },
            "Errors_inner": {
                "type": "object",
                "properties": {
                    "code": {
                        "type": "string",
                        "example": "GW0001"
                    },
                    "description": {
                        "type": "string",
                        "example": "Invalid merchant URL"
                    }
                }
            },
            "ConfirmPaymentRequest": {
                "type": "object",
                "properties": {
                    "sessionId": {
                        "type": "string",
                        "description": "it must be set with the sessionId value returned by the post orders/build",
                        "example": "052211e8/+54cc/4e0a"
                    },
                    "amount": {
                        "type": "string",
                        "description": "This value allows changing the initial amount specified during the post orders/build. It shall be expressed in the lower unit required by the involved currency. I.e.: 50 EUR is represented as 5000 (2 decimals) 50 JPY is represented as 50 (0 decimals).",
                        "example": "3545"
                    }
                }
            },
            "MerchantRiskIndicator_giftCardAmount": {
                "type": "object",
                "properties": {
                    "value": {
                        "type": "number",
                        "description": "For prepaid or gift card purchase, the purchase amount total of prepaid or gift card(s) in major units (for example, USD 123.45 is 123).",
                        "example": 100
                    },
                    "currency": {
                        "type": "string",
                        "description": "For prepaid or gift card purchase, the currency code of the card as defined in ISO 4217.",
                        "example": "EUR"
                    }
                },
                "example": null
            },
            "RefundRequest": {
                "type": "object",
                "properties": {
                    "amount": {
                        "type": "string",
                        "example": "100",
                        "description": "Amount of the refund in eurocent"
                    },
                    "currency": {
                        "type": "string",
                        "example": "EUR",
                        "description": "Currency of the amount"
                    },
                    "description": {
                        "type": "string",
                        "example": "Goods have been shipped",
                        "description": "Reason for refunding"
                    }
                }
            },
            "RefundResponse": {
                "type": "object",
                "properties": {
                    "operationId": {
                        "type": "string",
                        "example": "3470744",
                        "description": "ID operation"
                    },
                    "operationTime": {
                        "type": "string",
                        "example": "2022-09-01T01:20:00.001Z",
                        "description": "Datetime of the operation"
                    }
                }
            },
            "OrderStatus": {
                "type": "object",
                "properties": {
                    "order": {
                        "$ref": "#/components/schemas/Order"
                    },
                    "authorizedAmount": {
                        "type": "string",
                        "description": "Authorized amount",
                        "example": "3545"
                    },
                    "capturedAmount": {
                        "type": "string",
                        "description": "Captured amount",
                        "example": "3545"
                    },
                    "lastOperationType": {
                        "$ref": "#/components/schemas/OperationType"
                    },
                    "lastOperationTime": {
                        "type": "string",
                        "example": "2022-09-01T01:20:00.001Z",
                        "description": "Datetime of the operation"
                    }
                }
            },
            "PaymentLink": {
                "type": "object",
                "properties": {
                    "linkId": {
                        "type": "string",
                        "example": "92864835"
                    },
                    "amount": {
                        "type": "string",
                        "example": "3545"
                    },
                    "expirationDate": {
                        "type": "string",
                        "example": "2019-02-11T00:00:00.000Z"
                    },
                    "link": {
                        "type": "string",
                        "example": "https://{gateway_hosted_page}"
                    },
                    "paidByOperationId": {
                        "type": "string",
                        "example": "3470744"
                    }
                }
            },
            "OrderResponse": {
                "type": "object",
                "properties": {
                    "orderStatus": {
                        "$ref": "#/components/schemas/OrderStatus"
                    },
                    "operations": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/Operation"
                        }
                    },
                    "links": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/PaymentLink"
                        }
                    }
                }
            }
        },
        "securitySchemes": {
            "ApiKeyAuth": {
                "type": "apiKey",
                "name": "X-API-KEY",
                "in": "header"
            },
            "OAuth2": {
                "type": "http",
                "scheme": "bearer",
                "bearerFormat": "JWT"
            }
        }
    }
}
