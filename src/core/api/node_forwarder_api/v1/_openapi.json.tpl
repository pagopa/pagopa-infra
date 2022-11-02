{
    "openapi": "3.0.1",
    "info": {
        "title": "Your project name",
        "description": "Your description",
        "termsOfService": "https://www.pagopa.gov.it/",
        "version": "0.0.1"
    },
    "servers": [
        {
            "url": "http://localhost:8080",
            "description": "Generated server url"
        }
    ],
    "paths": {
        "/forward": {
            "get": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_3",
                "parameters": [
                    {
                        "name": "body",
                        "in": "query",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "put": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_2",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "post": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_1",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "delete": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_4",
                "responses": {
                    "200": {
                        "description": "OK",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "options": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_5",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "head": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM_6",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
            },
            "patch": {
                "tags": [
                    "proxy-controller"
                ],
                "operationId": "sendRequestToSPM",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "type": "string"
                            }
                        }
                    }
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "headers": {
                            "X-Request-Id": {
                                "description": "This header identifies the call",
                                "schema": {
                                    "type": "string"
                                }
                            }
                        },
                        "content": {
                            "*/*": {
                                "schema": {
                                    "type": "string"
                                }
                            }
                        }
                    }
                }
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
}
