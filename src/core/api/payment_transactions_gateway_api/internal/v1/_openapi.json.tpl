{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition for internal payment-transactions-gateway",
    "version": "v0"
  },
  "servers": [
    {
      "url": "${host}/payment-gateway"
    }
  ],
  "security": [
    {
      "ApiKey": []
    }
  ],
  "paths": {
    "/request-payments/bancomatpay": {
      "put": {
        "tags": [
          "BancomatPay-internal"
        ],
        "operationId": "updateTransaction",
        "parameters": [
          {
            "name": "X-Correlation-ID",
            "in": "header",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/AuthMessage"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ACKMessage"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized request correlationId already processes",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "404": {
            "description": "Unknown correlationId",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "424": {
            "description": "Error in transaction patch",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "500": {
            "description": "Generic Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "504": {
            "description": "Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "BancomatPay-internal"
        ],
        "operationId": "requestPaymentToBancomatPay",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BPayPaymentRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/BPayOutcomeResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request mandatory parameters missing",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "401": {
            "description": "transactionId already processed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "500": {
            "description": "Generic Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "504": {
            "description": "Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    },
    "/request-refunds/bancomatpay": {
      "post": {
        "tags": [
          "BancomatPay-internal"
        ],
        "operationId": "refundTransaction",
        "parameters": [
          {
            "name": "X-Correlation-ID",
            "in": "header",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BPayRefundRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/BPayOutcomeResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "500": {
            "description": "Generic Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          },
          "504": {
            "description": "Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    },
    "/request-payments/postepay/{requestId}": {
      "get": {
        "summary": "PGS webview polling call for PostePay authorization",
        "tags": [
          "PostePay-internal"
        ],
        "operationId": "webview-polling",
        "parameters": [
          {
            "in": "path",
            "name": "requestId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "PGS-generated GUID of the request to retrieve",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/PollingResponseEntity"
                }
              }
            }
          },
          "400": {
            "description": "Bad request - missing mandatory parameters",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PollingResponseEntity"
                }
              }
            }
          },
          "401": {
            "description": "transactionId already processed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PollingResponseEntity"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PollingResponseEntity"
                }
              }
            }
          },
          "504": {
            "description": "Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PollingResponseEntity"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "PostePay-internal"
        ],
        "summary": "refund PostePay requests",
        "operationId": "refund-request",
        "parameters": [
          {
            "in": "path",
            "name": "requestId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "PGS-generated GUID of the request to retrieve",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "404": {
            "description": "Request doesn't exist",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "500": {
            "description": "Generic Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "502": {
            "description": "Gateway Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          },
          "504": {
            "description": "Request timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayRefundResponse"
                }
              }
            }
          }
        }
      }
    },
    "/request-payments/postepay": {
      "post": {
        "summary": "payment authorization request to PostePay",
        "tags": [
          "PostePay-internal"
        ],
        "operationId": "auth-request",
        "parameters": [
          {
            "in": "query",
            "name": "isOnboarding",
            "description": "used for onboarding, if true",
            "example": true,
            "schema": {
              "type": "boolean"
            },
            "required": false
          },
          {
            "in": "header",
            "name": "X-Client-ID",
            "description": "channel origin (APP/Web)",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true
          },
          {
            "in": "header",
            "name": "MDC-Fields",
            "description": "MDC information",
            "example": "97g10t83x7bb0437bbc50sdf58e970gt",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PostePayAuthRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthResponseEntity"
                }
              }
            }
          },
          "400": {
            "description": "Bad request - missing mandatory parameters",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthResponseEntity"
                }
              }
            }
          },
          "401": {
            "description": "transactionId already processed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthResponseEntity"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthResponseEntity"
                }
              }
            }
          },
          "504": {
            "description": "Timeout",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PostePayAuthResponseEntity"
                }
              }
            }
          }
        }
      }
    },
    "/request-payments/xpay": {
      "post": {
        "summary": "payment authorization request to xPay",
        "tags": [
          "XPay-internal"
        ],
        "operationId": "auth-request-xpay",
        "parameters": [
          {
            "in": "header",
            "name": "X-Client-ID",
            "description": "channel origin (APP/Web)",
            "example": "APP",
            "schema": {
              "type": "string"
            },
            "required": true
          },
          {
            "in": "header",
            "name": "MDC-Fields",
            "description": "MDC information",
            "example": "97g10t83x7bb0437bbc50sdf58e970gt",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/XPayAuthRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/XPayAuthResponseEntity"
                }
              }
            }
          },
          "400": {
            "description": "Bad request - missing mandatory parameters",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayAuthResponseEntity400"
                }
              }
            }
          },
          "401": {
            "description": "transactionId already processed",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayAuthResponseEntity401"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayAuthResponseEntity500"
                }
              }
            }
          }
        }
      }
    },
    "/request-payments/xpay/{requestId}": {
      "get": {
        "summary": "retrieve XPay payment request",
        "tags": [
          "XPay-internal"
        ],
        "operationId": "auth-response-xpay",
        "parameters": [
          {
            "in": "path",
            "required": true,
            "name": "requestId",
            "description": "Id of the request",
            "example": "41bc2409-5926-4aa9-afcc-797c7054e467",
            "schema": {
              "type": "string"
            }
          },
          {
            "in": "header",
            "name": "MDC-Fields",
            "description": "MDC information",
            "example": "97g10t83x7bb0437bbc50sdf58e970gt",
            "schema": {
              "type": "string"
            },
            "required": false
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "*/*": {
                "schema": {
                  "$ref": "#/components/schemas/XPayPollingResponseEntity"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayPollingResponseEntity404"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "XPay-internal"
        ],
        "summary": "refund xpay requests",
        "operationId": "refund-xpay-request",
        "parameters": [
          {
            "in": "path",
            "name": "requestId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "PGS-generated GUID of the request to retrieve",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayRefundResponse200"
                }
              }
            }
          },
          "404": {
            "description": "Request doesn't exist",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayRefundResponse404"
                }
              }
            }
          },
          "500": {
            "description": "Generic Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayRefundResponse500"
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
      "AuthMessage": {
        "required": [
          "auth_outcome"
        ],
        "type": "object",
        "properties": {
          "auth_outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "auth_code": {
            "type": "string"
          }
        }
      },
      "ACKMessage": {
        "required": [
          "outcome"
        ],
        "type": "object",
        "properties": {
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          }
        }
      },
      "BPayPaymentRequest": {
        "required": [
          "amount",
          "encryptedTelephoneNumber",
          "idPagoPa",
          "idPsp"
        ],
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string"
          },
          "idPagoPa": {
            "type": "integer",
            "format": "int64"
          },
          "amount": {
            "type": "number",
            "format": "double"
          },
          "subject": {
            "type": "string"
          },
          "encryptedTelephoneNumber": {
            "type": "string"
          },
          "language": {
            "type": "string"
          }
        }
      },
      "BPayRefundRequest": {
        "required": [
          "idPagoPa"
        ],
        "type": "object",
        "properties": {
          "idPagoPa": {
            "type": "integer",
            "format": "int64"
          },
          "refundAttempt": {
            "type": "number",
            "format": "integer"
          },
          "subject": {
            "type": "string"
          },
          "language": {
            "type": "string"
          }
        }
      },
      "BPayOutcomeResponse": {
        "type": "object",
        "properties": {
          "outcome": {
            "type": "boolean"
          }
        }
      },
      "PollingResponseEntity": {
        "type": "object",
        "required": [
          "channel",
          "urlRedirect",
          "logoResourcePath",
          "clientResponseUrl",
          "authOutcome",
          "error"
        ],
        "properties": {
          "channel": {
            "type": "string",
            "description": "request payment channel (APP or WEB)",
            "example": "APP"
          },
          "urlRedirect": {
            "type": "string",
            "description": "redirect URL generated by PGS logic",
            "example": "https://.../payment-transactions-gateway/v1/webview/authRequest?requestId=e2f518a9-9de4-4a27-afb0-5303e6eefcbf"
          },
          "logoResourcePath": {
            "type": "string",
            "description": "PostePay logo resource path",
            "example": "payment-gateway/assets/img/postepay/postepay.png"
          },
          "clientResponseUrl": {
            "type": "string",
            "description": "redirect URL for authorization OK, empty for KO case or when PUT request has not been called yet",
            "example": "https://..."
          },
          "authOutcome": {
            "type": "string",
            "description": "authorization outcome",
            "example": "OK"
          },
          "error": {
            "type": "string",
            "description": "error description for 400/500 http error codes",
            "example": ""
          }
        }
      },
      "PostePayAuthRequest": {
        "required": [
          "grandTotal",
          "idTransaction"
        ],
        "type": "object",
        "properties": {
          "grandTotal": {
            "type": "number",
            "format": "integer",
            "description": "amount + fee as euro cents",
            "example": 2350
          },
          "idTransaction": {
            "type": "string",
            "description": "transaction id on Payment Manager",
            "example": "e8c7a6bf-0e52-45b0-b62e-03ae29b59522"
          },
          "description": {
            "type": "string",
            "description": "payment object description",
            "example": "pagamento bollo auto"
          },
          "paymentChannel": {
            "type": "string",
            "description": "request payment channel (APP or WEB)",
            "example": "APP"
          },
          "name": {
            "type": "string",
            "description": "debtor's name and surname",
            "example": "Mario Rossi"
          },
          "email_notice": {
            "type": "string",
            "description": "debtor's email address",
            "example": "mario.rossi@gmail.com"
          }
        }
      },
      "PostePayAuthResponseEntity": {
        "type": "object",
        "required": [
          "requestId",
          "channel",
          "urlRedirect",
          "error"
        ],
        "properties": {
          "requestId": {
            "type": "string",
            "description": "payment request Id"
          },
          "channel": {
            "type": "string",
            "description": "request payment channel (APP or WEB)",
            "example": "APP"
          },
          "urlRedirect": {
            "type": "string",
            "description": "redirect URL generated by PGS logic",
            "example": "https://api.dev.platform.pagopa.it/payment-transactions-gateway/v1/webview/authRequest/e8d24dd5-14e0-4802-9f23-ddf2c198a185"
          },
          "error": {
            "type": "string",
            "description": "error description",
            "example": null
          }
        }
      },
      "Error": {
        "type": "object",
        "properties": {
          "code": {
            "type": "integer",
            "format": "int64"
          },
          "message": {
            "type": "string"
          }
        },
        "required": [
          "code",
          "message"
        ]
      },
      "PostePayRefundResponse": {
        "type": "object",
        "properties": {
          "requestId": {
            "type": "string"
          },
          "paymentId": {
            "type": "string"
          },
          "refundOutcome": {
            "type": "string"
          },
          "error": {
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "paymentId",
          "refundOutcome",
          "error"
        ]
      },
      "XPayAuthRequest": {
        "required": [
          "cvv",
          "pan",
          "expiryDate",
          "grandTotal",
          "idTransaction"
        ],
        "type": "object",
        "properties": {
          "grandTotal": {
            "type": "number",
            "format": "integer",
            "description": "amount + fee as euro cents",
            "example": 2350
          },
          "idTransaction": {
            "type": "string",
            "description": "transaction id on Payment Manager",
            "example": "123456"
          },
          "cvv": {
            "type": "string",
            "description": "Card verification code",
            "example": 123
          },
          "pan": {
            "type": "string",
            "description": "Pan of the card",
            "example": 16589654852
          },
          "exipiryDate": {
            "type": "string",
            "description": "Expiration date of the card, yyyyMM format",
            "example": 203012
          }
        }
      },
      "XPayAuthResponseEntity": {
        "type": "object",
        "required": [
          "requestId",
          "urlRedirect",
          "status"
        ],
        "properties": {
          "requestId": {
            "type": "string",
            "description": "payment request Id"
          },
          "urlRedirect": {
            "type": "string",
            "description": "redirect URL generated by PGS logic",
            "example": "urlRedirect.com"
          },
          "status": {
            "type": "string",
            "description": "status",
            "example": "CREATED"
          }
        }
      },
      "XPayAuthResponseEntity400": {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "string",
            "description": "error description",
            "example": "Bad Request - mandatory parameters missing"
          }
        }
      },
      "XPayAuthResponseEntity401": {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "string",
            "description": "error description",
            "example": "Transaction already processed"
          }
        }
      },
      "XPayAuthResponseEntity500": {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "string",
            "description": "error description",
            "example": "Error while requesting authorization for idTransaction: xxx"
          }
        }
      },
      "XPayPollingResponseEntity": {
        "type": "object",
        "required": [
          "status"
        ],
        "properties": {
          "html": {
            "type": "string",
            "description": "HTML received in response from XPay",
            "example": "<html>\n<head>\n<title>\nGestione Pagamento Fraud detection</title>\n<script type=\"text/javascript\" language=\"javascript\">\nfunction moveWindow() {\n    document.tdsFraudForm.submit();\n}\n</script>\n</head>\n<body>\n<form name=\"tdsFraudForm\" action=\"https://coll-ecommerce.nexi.it/ecomm/ecomm/TdsMerchantServlet\" method=\"POST\">\n<input type=\"hidden\" name=\"action\"     value=\"fraud\">\n<input type=\"hidden\" name=\"merchantId\" value=\"31320986\">\n<input type=\"hidden\" name=\"description\" value=\"7090069933_1606392234626\">\n<input type=\"hidden\" name=\"gdiUrl\"      value=\"\">\n<input type=\"hidden\" name=\"gdiNotify\"   value=\"\">\n</form>\n<script type=\"text/javascript\">\n  moveWindow();\n</script>\n</body>\n</html>\n"
          },
          "status": {
            "type": "string",
            "description": "status",
            "example": "CREATED"
          },
          "authOutcome": {
            "type": "string",
            "description": "authorization outcome received from XPay",
            "example": "OK"
          },
          "authCode": {
            "type": "string",
            "description": "authorization code received from XPay",
            "example": 123
          },
          "redirectUrl": {
            "type": "string",
            "description": "redirection URL after a response from XPay has been received",
            "example": "http://localhost:8080/payment-gateway/request-payments/xpay/2d75ebf8-c789-46a9-9a22-edf1976a8917"
          }
        }
      },
      "XPayPollingResponseEntity404": {
        "type": "object",
        "required": [
          "error"
        ],
        "properties": {
          "error": {
            "type": "object",
            "required": [
              "code",
              "message"
            ],
            "properties": {
              "code": {
                "type": "number",
                "format": "integer",
                "description": "error code",
                "example": 404
              },
              "message": {
                "type": "string",
                "description": "error message",
                "example": "RequestId not found"
              }
            }
          }
        }
      },
      "XPayRefundResponse200": {
        "type": "object",
        "properties": {
          "requestId": {
            "type": "string",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          },
          "refundOutcome": {
            "type": "string",
            "example": "OK"
          },
          "error": {
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "refundOutcome"
        ]
      },
      "XPayRefundResponse404": {
        "type": "object",
        "properties": {
          "requestId": {
            "type": "string",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          },
          "error": {
            "type": "string",
            "example": "RequestId not Found"
          }
        },
        "required": [
          "transactionId",
          "error"
        ]
      },
      "XPayRefundResponse500": {
        "type": "object",
        "properties": {
          "requestId": {
            "type": "string",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          },
          "error": {
            "type": "string",
            "example": "Error while requesting refund for requestId: xxx"
          }
        },
        "required": [
          "transactionId",
          "error"
        ]
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}