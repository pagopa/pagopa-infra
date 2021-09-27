{
  "openapi": "3.0.1",
  "info": {
    "title": "Pagopa PM Mock",
    "version": "1.0.0"
  },
  "servers": [{
      "url": "https://${host}"
  }],
  "tags": [
    {
      "name": "paypalmock",
      "description": "todo"
    },
    {
      "name": "paypalmanagement",
      "description": "todo"
    }
  ],
  "paths": {
    "/paypalpsp/api/pp_oboarding_back": {
      "post": {
        "tags": [
          "paypalmock"
        ],
        "summary": "server to server api used to start onboarding",
        "requestBody": {
          "description": "New Onboarding required",
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/StartOnboardingRequest"
              }
            }
          }
        },
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
    }
  },
  "components": {
    "schemas": {
      "StartOnboardingRequest": {
        "required": [
          "url_return",
          "id_appio"
        ],
        "type": "object",
        "properties": {
          "url_return": {
            "type": "string",
            "description": "URL used to return the result"
          },
          "id_appio": {
            "type": "string",
            "description": "user identifier"
          }
        }
      },
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