{
    "openapi": "3.0.1",
    "info": {
      "title": "Ukraine donations",
      "description": "",
      "version": "1.0"
    },
    "servers": [
      {
        "url": "https://${host}"
      }
    ],
    "paths": {
      "/availabledonations": {
        "get": {
          "summary": "GET avalable iuvs for Ukraine donations",
          "operationId": "getavailabledonations",
          "responses": {
            "200": {
              "description": "OK.",
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
                    "$ref": "#/components/schemas/Donations"
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
        "Donations": {
          "type": "object",
          "properties": {
            "debtorFullName": {
              "type": "string",
              "example": "anonimo"
            },
            "debtorEntityUniqueIdentifierType": {
              "type": "string",
              "example": "F"
            },
            "debtorEntityUniqueIdentifierValue": {
              "type": "string",
              "example": "anonimo"
            },
            "data": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "name": {
                    "type": "string",
                    "example": "Croce Rossa Italiana"
                  },
                  "reason": {
                    "type": "string",
                    "example": "Donazione Emergenza Ucraina"
                  },
                  "web_site": {
                    "type": "string",
                    "example": "https://cri.it/emergenzaucraina/"
                  },
                  "base64Logo": {
                    "type": "string",
                    "example": "/9j/4AAQSk"
                  },
                  "cf": {
                    "type": "string",
                    "example": "77777777777"
                  },
                  "iban": {
                    "type": "string",
                    "example": "IT0000000000000000000000000"
                  },
                  "paymentDescription": {
                    "type": "string",
                    "example": "Donazione Ucraina"
                  },
                  "companyName": {
                    "type": "string",
                    "example": "company Croce Rossa Italiana"
                  },
                  "officeName": {
                    "type": "string",
                    "example": "office Croce Rossa Italiana"
                  },
                  "slices": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "idDonation": {
                          "type": "string",
                          "example": "00"
                        },
                        "amount": {
                          "type": "number",
                          "example": "500"
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      },
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
