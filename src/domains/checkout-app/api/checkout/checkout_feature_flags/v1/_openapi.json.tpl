{
    "openapi": "3.0.0",
    "info": {
        "version": "1.0.0",
        "title": "Pagopa Feature Flags",
        "description": "This API set contains APIM level apis used to manage feature flags for checkout."
    },
    "servers": [
        {
            "url": "https://${host}"
        }
    ],
    "tags": [
        {
            "name": "featureFlags",
            "description": "This API is used to handle feature flags for checkout, and follows the Openfeature specifications.",
            "externalDocs": {
                "url": "https://openfeature.dev",
                "description": "Openfeature"
            }
        }
    ],
    "paths": {
        "/features/{featureKey}/enabled": {
            "get": {
                "tags": ["featureFlags"],
                "summary": "Get feature flag status",
                "description": "Returns the status of the specified feature flag.",
                "parameters": [
                    {
                        "name": "featureKey",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "description": "The key of the feature flag to check."
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Feature flag status",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/FeatureFlagResponse"
                                },
                                "example": {
                                    "featureKey": "newCheckoutFlow",
                                    "enabled": true
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid request",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ProblemJson"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "Feature flag not found",
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
            }
        }
    },
    "components": {
        "schemas": {
            "FeatureFlagResponse": {
                "type": "object",
                "properties": {
                    "featureKey": {
                        "type": "string",
                        "description": "The name of the feature flag."
                    },
                    "enabled": {
                        "type": "boolean",
                        "description": "The status of the feature flag."
                    }
                },
                "required": ["featureKey", "enabled"]
            },
            "ProblemJson": {
                "type": "object",
                "properties": {
                    "type": {
                        "type": "string",
                        "format": "uri",
                        "description": "An absolute URI that identifies the problem type. When dereferenced, it SHOULD provide human-readable documentation for the problem type (e.g., using HTML).",
                        "default": "about:blank",
                        "example": "https://example.com/problem/constraint-violation"
                    },
                    "title": {
                        "type": "string",
                        "description": "A short, summary of the problem type. Written in English and readable for engineers (usually not suited for non-technical stakeholders and not localized); example: Service Unavailable"
                    },
                    "status": {
                        "$ref": "#/components/schemas/HttpStatusCode"
                    },
                    "detail": {
                        "type": "string",
                        "description": "A human-readable explanation specific to this occurrence of the problem.",
                        "example": "There was an error processing the request"
                    },
                    "instance": {
                        "type": "string",
                        "format": "uri",
                        "description": "An absolute URI that identifies the specific occurrence of the problem. It may or may not yield further information if dereferenced."
                    }
                }
            },
            "HttpStatusCode": {
                "type": "integer",
                "format": "int32",
                "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
                "minimum": 100,
                "maximum": 600,
                "exclusiveMaximum": true,
                "example": 200
            }
        }
    }
}