{
  "swagger": "2.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa - Mybank Buyer banks",
    "contact": {
      "name": "Checkout team"
    },
    "description": "Documentation of the Mybank Buyer banks Function API.\n"
  },
  "host": "${host}",
  "basePath": "/api/v1",
  "schemes": [
    "https"
  ],
  "paths": {
    "/banks": {
      "x-swagger-router-controller": "PagoPAProxyController",
      "get": {
        "operationId": "GetBuyerBanks",
        "summary": "Get Buyerbanks Info",
        "description": "Retrieve information about buyer banks",
        "responses": {
          "200": {
            "description": "Buyer list information retrieved",
            "schema": {
              "$ref": "#/definitions/BuyerBanksGetResponse"
            },
            "examples": {
              "application/json": {
                "output": {
                  "result": "success",
                  "messages": [
                    {
                      "code": "200",
                      "message": "ok",
                      "severity": "info"
                    }
                  ],
                  "body": {
                    "aliases": [
                      {
                        "id": 0,
                        "participantID": "string",
                        "country": "string",
                        "alias": "string",
                        "language": "string"
                      }
                    ]
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad request"
          },
          "401": {
            "description": "Verification of the signature failed"
          },
          "500": {
            "description": "PagoPA services are not available or request is rejected"
          }
        }
      },
      "put": {
        "operationId": "SyncBuyerBanks",
        "summary": "Request for an update of buyerbank list",
        "description": "Synchronize buyerbanks with MyBank web services",
        "responses": {
          "200": {
            "description": "Request outcome",
            "schema": {
              "$ref": "#/definitions/BuyerBanksPutResponse"
            },
            "examples": {
              "application/json": {
                "result": "success"
              }
            }
          },
          "400": {
            "description": "Bad request"
          },
          "401": {
            "description": "Verification of the signature failed"
          },
          "500": {
            "description": "PagoPA services are not available or request is rejected"
          }
        }
      }
    }
  },
  "definitions": {
    "BuyerBanksGetResponse": {
      "type": "object",
      "required": [
        "output"
      ],
      "properties": {
        "output": {
          "type": "object",
          "properties": {
            "result": {
              "type": "string"
            },
            "messages": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "code": {
                    "type": "string"
                  },
                  "message": {
                    "type": "string"
                  },
                  "severity": {
                    "type": "string"
                  }
                }
              }
            },
            "body": {
              "type": "object",
              "properties": {
                "aliases": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "id": {
                        "type": "integer"
                      },
                      "participantID": {
                        "type": "string"
                      },
                      "country": {
                        "type": "string"
                      },
                      "alias": {
                        "type": "string"
                      },
                      "language": {
                        "type": "string"
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
    "BuyerBanksPutResponse": {
      "type": "object",
      "required": [
        "result"
      ],
      "properties": {
        "result": {
          "type": "string"
        }
      }
    }
  }
}
