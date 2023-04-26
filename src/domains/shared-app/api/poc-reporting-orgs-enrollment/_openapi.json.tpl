{
    "openapi": "3.0.3",
    "info": {
        "title": "Reporting Orgs Enrollment API",
        "version": "0.0.1"
    },
    "servers": [
      {
        "url": "${host}",
        "description": "Generated server url"
      }
    ],
    "paths": {
        "/info": {
            "get": {
                "tags": [
                    "Home Controller"
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/AppInfo"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Bad Request",
                        "content": {
                            "application/json": {}
                        }
                    }
                }
            }
        },
        "/organizations": {
            "get": {
                "tags": [
                    "Enrollments Controller"
                ],
                "summary": "Return the list of organizations",
                "description": "Return the list of organizations",
                "operationId": "getOrganizations",
                "responses": {
                    "200": {
                        "description": "Obtained all enrollments.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "array",
                                    "items": {
                                        "$ref": "#/components/schemas/OrganizationModelResponse"
                                    }
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized.",
                        "content": {
                            "application/json": {
                                "schema": {}
                            }
                        }
                    },
                    "500": {
                        "description": "Service unavailable.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/organizations/{organizationFiscalCode}": {
            "get": {
                "tags": [
                    "Enrollments Controller"
                ],
                "parameters": [
                    {
                        "name": "organizationFiscalCode",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "summary": "Return the specified organization",
                "description": "Return the specified organization",
                "operationId": "getOrganization",
                "responses": {
                    "200": {
                        "description": "Obtained single enrollment.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized.",
                        "content": {
                            "application/json": {
                                "schema": {}
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the enroll service.",
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
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    }
                }
            },
            "post": {
                "tags": [
                    "Enrollments Controller"
                ],
                "parameters": [
                    {
                        "name": "organizationFiscalCode",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "summary": "Create an organization",
                "description": "Create an organization",
                "operationId": "createOrganization",
                "responses": {
                    "201": {
                        "description": "Created",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized",
                        "content": {
                            "application/json": {}
                        }
                    },
                    "409": {
                        "description": "Conflict",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "500": {
                        "description": "Internal server error",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    }
                }
            },
            "delete": {
                "tags": [
                    "Enrollments Controller"
                ],
                "parameters": [
                    {
                        "name": "organizationFiscalCode",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "summary": "Delete the specified organization",
                "description": "Delete the specified organization",
                "operationId": "removeOrganization",
                "responses": {
                    "200": {
                        "description": "Request deleted.",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/OrganizationModelResponse"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized.",
                        "content": {
                            "application/json": {
                                "schema": {}
                            }
                        }
                    },
                    "404": {
                        "description": "Not found the creditor institution.",
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
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
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
            "AppInfo": {
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string"
                    },
                    "version": {
                        "type": "string"
                    },
                    "environment": {
                        "type": "string"
                    }
                }
            },
            "LocalDateTime": {
                "format": "date-time",
                "type": "string",
                "example": "2022-03-10T12:15:50"
            },
            "OrganizationModelResponse": {
                "type": "object",
                "properties": {
                    "organizationFiscalCode": {
                        "type": "string"
                    },
                    "organizationOnboardingDate": {
                        "$ref": "#/components/schemas/LocalDateTime"
                    }
                }
            },
            "ProblemJson": {
                "type": "object",
                "properties": {
                    "title": {
                        "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable",
                        "type": "string"
                    },
                    "status": {
                        "format": "int32",
                        "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
                        "maximum": 600,
                        "minimum": 100,
                        "type": "integer",
                        "example": 200
                    },
                    "detail": {
                        "description": "A human readable explanation specific to this occurrence of the problem.",
                        "type": "string",
                        "example": "There was an error processing the request"
                    }
                }
            }
        }
    }
}