{
  "openapi": "3.0.1",
  "info": {
    "title": "Pagopa webview PM Mock",
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
      "/paypalpsp/management/response": {
        "get": {
          "operationId": "getmanagementresponse",
          "description": "get management",
          "responses": {
            "200": {
              "description": "json response"
            },
            "400": {
              "description": "Bad request"
            },
            "500": {
              "description": "generic error"
            }
          }
        },
        "patch": {
          "operationId": "patchmanagement",
          "description": "patch management",
          "responses": {
            "200": {
              "description": "json response"
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
     "/paypalpsp/management/response/{idappio}/{apiid}": {
        "get": {
          "parameters": [
            {
              "in": "path",
              "name": "idappio",
              "required": true,
              "schema": {
                "type": "string"
              }
            },
            {
              "in": "path",
              "name": "apiid",
              "required": true,
              "schema": {
                "type": "string"
              }
            }
          ],        
          "operationId": "getmanagement",
          "description": "GET management",
          "responses": {
            "200": {
              "description": "json response"
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