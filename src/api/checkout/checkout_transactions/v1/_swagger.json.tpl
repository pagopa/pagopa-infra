{
  "swagger": "2.0",
  "info": {
    "version": "1.0.0",
    "title": "Checkout payment transactions API",
    "contact": {
      "name": "pagoPA team",
    },
    "description": "Documentation of the Checkout Function payment transactions API here.\n"
  },
  "host": "${host}",
  "basePath": "/api/v1",
  "schemes": [
    "https"
  ],
  "paths": {
    "/transactions/{id}/method": {
      "post": {
        "operationId": "PostTransactionsMethod3ds2",
        "description": "API to support 3ds2 method step",
        "produces": [
          "text/html"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "description": "transaction id",
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "html with redirect io-pay"
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
    "/transactions/{id}/challenge": {
      "post": {
        "operationId": "PostTransactionsChallenge3ds2",
        "description": "API to support 3ds2 challenge step",
        "produces": [
          "text/html"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "description": "transaction id",
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "html with redirect io-pay"
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
    "/transactions/xpay/{id}": {
      "get": {
        "operationId": "GetTransactionsXpay",
        "description": "API to support xpay flow",
        "produces": [
          "text/html"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "description": "transaction id",
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "html with redirect io-pay"
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
    "/transactions/xpay/verification/{id}": {
      "get": {
        "operationId": "GetTransactionsXpayVerification",
        "description": "API to support xpay verification flow",
        "produces": [
          "text/html"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "description": "transaction id",
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "html with redirect io-pay"
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
  "definitions": {
    "ProblemJson": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v10.7.0/openapi/definitions.yaml#/ProblemJson"
    },
    "PaymentProblemJson": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/PaymentProblemJson"
    },
    "CodiceContestoPagamento": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/CodiceContestoPagamento"
    },
    "EnteBeneficiario": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/EnteBeneficiario"
    },
    "Iban": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/Iban"
    },
    "ImportoEuroCents": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/ImportoEuroCents"
    },
    "PaymentActivationsGetResponse": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/PaymentActivationsGetResponse"
    },
    "PaymentActivationsPostRequest": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/PaymentActivationsPostRequest"
    },
    "PaymentActivationsPostResponse": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/PaymentActivationsPostResponse"
    },
    "PaymentRequestsGetResponse": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/PaymentRequestsGetResponse"
    },
    "RptId": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/RptId"
    },
    "SpezzoneStrutturatoCausaleVersamento": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/SpezzoneStrutturatoCausaleVersamento"
    },
    "SpezzoniCausaleVersamento": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/SpezzoniCausaleVersamento"
    },
    "SpezzoniCausaleVersamentoItem": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.8.6/api_pagopa.yaml#/definitions/SpezzoniCausaleVersamentoItem"
    },
    "BrowserInfoResponse": {
      "type": "object",
      "required": [
        "ip",
        "useragent",
        "accept"
      ],
      "properties": {
        "ip": {
          "type": "string"
        },
        "useragent": {
          "type": "string"
        },
        "accept": {
          "type": "string"
        }
      }
    }
  }
}
