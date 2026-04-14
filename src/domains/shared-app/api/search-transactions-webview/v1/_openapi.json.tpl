{
  "openapi": "3.0.0",
  "info": {
    "title": "pagoPA CIE search fronted",
    "version": "0.0.1",
    "description": "API to expose CIE search frontend",
    "termsOfService": "https://pagopa.it/terms/"
  },
  "tags": [
    {
      "name": "transactionsSearch",
      "description": "Api's to expose cie-search FE"
    }
  ],
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/*": {
      "get": {
        "tags": [
          "transactionsSearch"
        ],
        "summary": "Redirect to frontend useful to search some transactions by its nav, PA tax code and citizen taxcode",
        "description": "Show result if some transactions for that NAV and citizen exists",
        "operationId": "GETtransactionsSearch",
        "security": [
          {
          }
        ],
        "responses": {
          "200": {
            "description": "Show frontend"
          },
          "400": {
            "description": "Formally invalid input"
          },
          "500": {
            "description": "Internal server error serving request"
          },
          "502": {
            "description": "Gateway error"
          },
          "504": {
            "description": "Timeout serving request"
          }
        }
      },
      "post": {
        "tags": [
          "transactionsSearch"
        ],
        "summary": "Redirect to frontend useful to search some transactions by its nav, PA tax code and citizen taxcode",
        "description": "Show result if some transactions for that NAV and citizen exists",
        "operationId": "POSTtransactionsSearch",
        "security": [
          {
          }
        ],
        "responses": {
          "200": {
            "description": "Show frontend"
          },
          "400": {
            "description": "Formally invalid input"
          },
          "500": {
            "description": "Internal server error serving request"
          },
          "502": {
            "description": "Gateway error"
          },
          "504": {
            "description": "Timeout serving request"
          }
        }
      },
      "options": {
        "tags": [
          "transactionsSearch"
        ],
        "summary": "Redirect to frontend useful to search some transactions by its nav, PA tax code and citizen taxcode",
        "description": "Show result if some transactions for that NAV and citizen exists",
        "operationId": "OPTtransactionsSearch",
        "responses": {
          "200": {
            "description": "Show frontend"
          },
          "400": {
            "description": "Formally invalid input"
          },
          "500": {
            "description": "Internal server error serving request"
          },
          "502": {
            "description": "Gateway error"
          },
          "504": {
            "description": "Timeout serving request"
          }
        }
      },
      "head": {
        "tags": [
          "transactionsSearch"
        ],
        "summary": "Redirect to frontend useful to search some transactions by its nav, PA tax code and citizen taxcode",
        "description": "Show result if some transactions for that NAV and citizen exists",
        "operationId": "HEADtransactionsSearch",
        "responses": {
          "200": {
            "description": "Show frontend"
          },
          "400": {
            "description": "Formally invalid input"
          },
          "500": {
            "description": "Internal server error serving request"
          },
          "502": {
            "description": "Gateway error"
          },
          "504": {
            "description": "Timeout serving request"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {},
    "securitySchemes": {}
  }
}
