{
  "openapi": "3.0.3",
  "info": {
    "title": "FDR - Flussi di rendicontazione (dev) ${service}",
    "description": "Questo microservizio � usato per storicizzare e servire i flussi di rendicontazione tra EC e PSP ${service}",
    "termsOfService": "Your terms here",
    "contact": {
      "name": "Example API Support",
      "url": "http://exampleurl.com/contact",
      "email": "techsupport@example.com"
    },
    "license": {
      "name": "Apache 2.0",
      "url": "https://www.apache.org/licenses/LICENSE-2.0.html"
    },
    "version": "1.0.0-SNAPSHOT"
  },
  "servers": [
    {
      "url": "${host}",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/fruits": {
      "get": {
        "tags": [
          "Fruit Resource"
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/FruitDto"
                  }
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "Fruit Resource"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FruitAddRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/FruitDto"
                  }
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "Fruit Resource"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FruitDeleteRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/FruitDto"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/fruits/{name}": {
      "get": {
        "tags": [
          "Fruit Resource"
        ],
        "parameters": [
          {
            "name": "name",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FruitDto"
                }
              }
            }
          }
        }
      }
    },
    "/info": {
      "get": {
        "tags": [
          "Info Resource"
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Info"
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
      "FruitAddRequest": {
        "required": [
          "name"
        ],
        "type": "object",
        "properties": {
          "name": {
            "minLength": 1,
            "type": "string"
          },
          "description": {
            "type": "string"
          }
        }
      },
      "FruitDeleteRequest": {
        "required": [
          "name"
        ],
        "type": "object",
        "properties": {
          "name": {
            "minLength": 1,
            "type": "string"
          }
        }
      },
      "FruitDto": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "description": {
            "type": "string"
          }
        }
      },
      "Info": {
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
      }
    }
  }
}
