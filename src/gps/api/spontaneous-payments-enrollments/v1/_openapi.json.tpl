{
    "openapi": "3.0.1",
    "info": {
        "title": "PagoPA API Spontaneous Payment",
        "description": "Progetto Gestione Pagamenti Spontanei",
        "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.0.3-20"
    },
    "servers": [
        {
      "url": "${host}/gps/spontaneous-payments-enrollments-service/v1",
            "description": "Generated server url"
        }
    ],
    "paths": {
        "/": {
            "get": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "Return all enrollments for a creditor institution.",
                "operationId": "getECEnrollments",
                "responses": {
                    "200": {
                        "description": "Obtained all enrollments for the creditor institution.",
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
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the creditor institution.",
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
                    "500": {
                        "description": "Service unavailable.",
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
            "put": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "The organization updates the creditor institution.",
                "operationId": "updateEC",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/OrganizationModel"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "Request updated.",
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
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Malformed request.",
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
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the creditor institution.",
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
                    "500": {
                        "description": "Service unavailable.",
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
            "post": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "The organization creates a creditor institution with possible enrollments to services.",
                "operationId": "createEC",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/OrganizationEnrollmentModel"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "201": {
                        "description": "Request created.",
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
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Malformed request.",
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
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "409": {
                        "description": "The organization to create already exists.",
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
                    "500": {
                        "description": "Service unavailable.",
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
            "delete": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "The organization deletes the creditor institution.",
                "operationId": "deleteEC",
                "responses": {
                    "200": {
                        "description": "Request deleted.",
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
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the creditor institution.",
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
                    "500": {
                        "description": "Service unavailable.",
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
        "/services/{serviceId}": {
            "get": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "Return the single enrollment to a service.",
                "operationId": "getSingleEnrollment",
                "parameters": [
                    {
                        "name": "serviceId",
                        "in": "path",
                        "description": "The service id to enroll.",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Obtained single enrollment.",
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
                                    "$ref": "#/components/schemas/EnrollmentModelResponse"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the enroll service.",
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
                    "500": {
                        "description": "Service unavailable.",
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
            "put": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "The organization update an enrollment to a service for the creditor institution.",
                "operationId": "updateECEnrollment",
                "parameters": [
                    {
                        "name": "serviceId",
                        "in": "path",
                        "description": "The service id to enroll.",
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
                                "$ref": "#/components/schemas/EnrollmentModel"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "Request updated.",
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
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Malformed request.",
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
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the creditor institution or the enroll service.",
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
                    "500": {
                        "description": "Service unavailable.",
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
            "post": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "The organization creates an enrollment to a service for the creditor institution.",
                "operationId": "createECEnrollment",
                "parameters": [
                    {
                        "name": "serviceId",
                        "in": "path",
                        "description": "The service id to enroll.",
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
                                "$ref": "#/components/schemas/EnrollmentModel"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "201": {
                        "description": "Request created.",
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
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Malformed request.",
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
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the creditor institution or the enroll service.",
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
                    "409": {
                        "description": "The enrollment to the service already exists.",
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
                    "500": {
                        "description": "Service unavailable.",
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
            "delete": {
                "tags": [
                    "Enrollments API"
                ],
                "summary": "The organization deletes the enrollment to service for the creditor institution.",
                "operationId": "deleteECEnrollment",
                "parameters": [
                    {
                        "name": "serviceId",
                        "in": "path",
                        "description": "The service id to enroll.",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Request deleted.",
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
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Wrong or missing function key.",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the creditor institution or the enroll service.",
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
                    "500": {
                        "description": "Service unavailable.",
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
            "OrganizationModel": {
                "type": "object",
                "properties": {
                    "companyName": {
                        "type": "string"
                    },
                    "status": {
                        "type": "string",
                        "enum": [
                            "ENABLED",
                            "DISABLED"
                        ]
                    }
                }
            },
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
            "EnrollmentModelResponse": {
                "required": [
                    "iban",
          "remittanceInformation",
          "segregationCode",
                    "serviceId"
                ],
                "type": "object",
                "properties": {
                    "serviceId": {
                        "type": "string"
                    },
                    "iban": {
                        "type": "string"
                    },
                    "officeName": {
                        "type": "string"
          },
          "segregationCode": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "postalIban": {
            "type": "string"
                    }
                }
            },
            "OrganizationModelResponse": {
                "required": [
                    "companyName",
                    "fiscalCode",
                    "status"
                ],
                "type": "object",
                "properties": {
                    "fiscalCode": {
                        "type": "string"
                    },
                    "companyName": {
                        "type": "string"
                    },
                    "status": {
                        "type": "string",
                        "enum": [
                            "ENABLED",
                            "DISABLED"
                        ]
                    },
                    "enrollments": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/EnrollmentModelResponse"
                        }
                    }
                }
            },
            "EnrollmentModel": {
        "required": [
          "iban",
          "remittanceInformation",
          "segregationCode"
        ],
                "type": "object",
                "properties": {
                    "iban": {
                        "type": "string"
                    },
                    "officeName": {
                        "type": "string"
                    },
                     "segregationCode": {
                                "type": "string"
                              },
                              "remittanceInformation": {
                                "type": "string"
                              },
                              "postalIban": {
                                "type": "string"
                              }
                }
            },
            "CreateEnrollmentModel": {
                "required": [
                    "iban",
          "remittanceInformation",
          "segregationCode",
                    "serviceId"
                ],
                "type": "object",
                "properties": {
                    "serviceId": {
                        "type": "string"
                    },
                    "iban": {
                        "type": "string"
                    },
                    "officeName": {
                        "type": "string"
          },
          "segregationCode": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "postalIban": {
            "type": "string"
                    }
                }
            },
            "OrganizationEnrollmentModel": {
                "required": [
                    "companyName"
                ],
                "type": "object",
                "properties": {
                    "companyName": {
                        "type": "string"
                    },
                    "enrollments": {
                        "type": "array",
                        "items": {
                            "$ref": "#/components/schemas/CreateEnrollmentModel"
                        }
                    }
                }
            },
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