{
  "openapi": "3.0.1",
  "info": {
    "title": "Pagopa PM Mock",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "tags": [
    {
      "name": "paypalmock",
      "description": "todo"
    }
  ],
  "paths": {
    "/paypalpsp/api/pp_onboarding_back": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to start onboarding",
        "responses": {
          "200": {
            "description": "Response",
            "content": {
              "application/json": {
                "schema": {
                  "oneOf": [
                    {
                      "$ref": "#/components/schemas/StartOnboardingResponseSuccess"
                    },
                    {
                      "$ref": "#/components/schemas/StartOnboardingResponseError"
                    }
                  ]
                }
              }
            }
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalpsp/api/pp_pay_direct": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to pay",
        "responses": {
          "200": {
            "description": "Response"
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalpsp/api/pp_refund_direct": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to refund payment",
        "responses": {
          "200": {
            "description": "Response"
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalpsp/api/pp_bilagr_del": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to delete contract",
        "responses": {
          "200": {
            "description": "Response"
          }
        },
        "security": [
          {
            "bearerAuth": []
          }
        ]
      }
    },
    "/paypalweb/*": {
      "get": {
        "operationId": "WebView GET",
        "description": "TEST WebView paypal",
        "tags": [
          "paypalmock"
        ],
        "responses": {
          "200": {
            "description": "html with redirect"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      },
      "post": {
        "operationId": "WebView POST",
        "description": "TEST WebView paypal",
        "tags": [
          "paypalmock"
        ],
        "responses": {
          "200": {
            "description": "html with redirect"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    },
    "/static/*": {
      "get": {
        "operationId": "staticResourcesGET",
        "description": "static resources GET",
        "responses": {
          "200": {
            "description": "static resource"
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "StartOnboardingResponseSuccess": {
        "required": [
          "esito",
          "url_to_call"
        ],
        "type": "object",
        "properties": {
          "esito": {
            "type": "string",
            "enum": [
              "1"
            ],
            "description": "URL used to return the result"
          },
          "url_to_call": {
            "type": "string",
            "description": "url to call to proceed with onboarding"
          }
        }
      },
      "StartOnboardingResponseError": {
        "required": [
          "esito",
          "err_code",
          "err_desc"
        ],
        "type": "object",
        "properties": {
          "esito": {
            "type": "string",
            "enum": [
              "3",
              "9"
            ],
            "description": "Api result"
          },
          "err_code": {
            "type": "string",
            "enum": [
              "9",
              "11",
              "13",
              "15",
              "19",
              "67"
            ]
          },
          "err_desc": {
            "type": "string"
          }
        }
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "string"
      }
    }
  }
}
