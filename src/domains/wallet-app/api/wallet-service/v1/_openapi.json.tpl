{
    "openapi": "3.0.3",
    "info": {
      "version": "0.0.1,",
      "title": "Wallet - OpenAPI 3.0",
      "description": "Wallet",
      "contact": {
        "name": "pagoPA - Touchpoints team"
      }
    },
    "tags": [
      {
        "name": "Wallet",
        "description": "Intercat with wallet"
      }
    ],
    "externalDocs": {
      "description": "Design review",
      "url": "http://swagger.io"
    },
    "servers": [
      {
        "url": "https://${hostname}"
      }
    ],
    "paths": {
      "/wallets": {
        "post": {
          "tags": [
            "wallets"
          ],
          "summary": "Add a new wallet",
          "description": "Add a new wallet",
          "operationId": "addWallet",
          "parameters": [
            {
              "in": "header",
              "name": "x-user-id",
              "schema": {
                "type": "string"
              },
              "required": true
            }
          ],
          "requestBody": {
            "description": "Create a new wallet",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletPost"
                }
              }
            },
            "required": true
          },
          "responses": {
            "200": {
              "description": "Successful operation",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/WalletPostResponse"
                  }
                }
              }
            },
            "405": {
              "description": "Invalid input"
            }
          }
        }
      },
      "/wallets/{walletId}": {
        "put": {
          "tags": [
            "wallets"
          ],
          "summary": "Update an existing wallet",
          "description": "Update an existing wallet by Id",
          "operationId": "updateWallet",
          "parameters": [
            {
              "name": "walletId",
              "in": "path",
              "description": "ID of wallet to return",
              "required": true,
              "schema": {
                "type": "string"
              }
            }
          ],
          "requestBody": {
            "description": "Update an existent wallet",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletUpdate"
                }
              }
            },
            "required": true
          },
          "responses": {
            "200": {
              "description": "Successful operation",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/WalletUpdateResponse"
                  }
                }
              }
            },
            "400": {
              "description": "Invalid ID supplied"
            },
            "404": {
              "description": "wallet not found"
            },
            "405": {
              "description": "Validation exception"
            }
          }
        },
        "get": {
          "tags": [
            "wallets"
          ],
          "summary": "Find wallet by ID",
          "description": "Returns a single pet",
          "operationId": "getWalletById",
          "parameters": [
            {
              "name": "walletId",
              "in": "path",
              "description": "ID of wallet to return",
              "required": true,
              "schema": {
                "type": "integer",
                "format": "int64"
              }
            }
          ],
          "responses": {
            "200": {
              "description": "successful operation",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/WalletUpdateResponse"
                  }
                }
              }
            },
            "400": {
              "description": "Invalid ID supplied"
            },
            "404": {
              "description": "Wallet not found"
            }
          }
        },
        "delete": {
          "tags": [
            "wallets"
          ],
          "summary": "Deletes a wallet by ID",
          "description": "delete a wallet",
          "operationId": "deleteWallet",
          "parameters": [
            {
              "name": "walletId",
              "in": "path",
              "description": "Wallet id to delete",
              "required": true,
              "schema": {
                "type": "integer",
                "format": "int64"
              }
            }
          ],
          "responses": {
            "200": {
              "description": "successful operation",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/WalletDeleteResponse"
                  }
                }
              }
            },
            "400": {
              "description": "Invalid ID supplied"
            },
            "404": {
              "description": "Wallet not found"
            }
          }
        }
      }
    },
    "components": {
      "schemas": {
        "Wallet": {
          "type": "object",
          "properties": {
            "paymentInstrumentId": {
              "type": "string"
            }
          }
        },
        "WalletPost": {
          "type": "object",
          "properties": {
            "paymentInstrumentType": {
              "type": "string",
              "enum": [
                "cards",
                "paypal",
                "bancomatpay"
              ]
            }
          }
        },
        "WalletPostResponse": {
          "type": "object",
          "properties": {
            "walletItemId": {
              "type": "string"
            },
            "logoutURI": {
              "type": "string"
            }
          }
        },
        "WalletUpdate": {
          "type": "object"
        },
        "WalletUpdateResponse": {
          "type": "object"
        },
        "WalletDeleteResponse": {
          "type": "object"
        }
      }
    }
  }