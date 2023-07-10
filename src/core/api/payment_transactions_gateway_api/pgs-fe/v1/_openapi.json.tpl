{
  "openapi": "3.0.1",
  "info": {
    "title": "Openapi for pagopa-payment-transactions-gateway (PGS) dedicated to fronted (pgs-fe)",
    "version": "0.0.1",
    "description": "Openapi definitåion for the API exposed by the *pagopa-payment-transactions-gateway* (**PGS**) and\nconsumed by fronted (pgs-fe) to\ncheck the payments status via the following payment gateway:\n<ol>\n  <li>xpay</li>\n  <li>vpos</li>\n</ol> \n"
  },
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/TKM/overview",
    "description": "Design review"
  },
  "servers": [
    {
      "url": "http://localhost:8080/",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/xpay/authorizations/{paymentAuthorizationId}": {
      "get": {
        "summary": "Retrieve xpay payment authorization",
        "description": "Retrieve xpay payment authorization given paymentAuthorizationId",
        "tags": [
          "XPay"
        ],
        "operationId": "getAuthPaymentXpay",
        "parameters": [
          {
            "in": "path",
            "required": true,
            "name": "paymentAuthorizationId",
            "description": "Id of the payment authorization",
            "example": "41bc2409-5926-4aa9-afcc-797c7054e467",
            "schema": {
              "type": "string"
            }
          }
        ],
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayPaymentAuthorization"
                }
              }
            }
          },
          "404": {
            "description": "payment authorization not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayPaymentAuthorizationError"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/XPayPaymentAuthorizationError"
                }
              }
            }
          }
        }
      }
    },
    "/vpos/authorizations/{paymentAuthorizationId}": {
      "get": {
        "summary": "retrieve vpos payment authorization",
        "tags": [
          "Vpos"
        ],
        "operationId": "getAuthPaymentVpos",
        "parameters": [
          {
            "in": "path",
            "required": true,
            "name": "paymentAuthorizationId",
            "description": "Id of the request",
            "example": "41bc2409-5926-4aa9-afcc-797c7054e467",
            "schema": {
              "type": "string"
            }
          }
        ],
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "oneOf": [
                    {
                      "$ref": "#/components/schemas/CcPaymentInfoAcceptedResponse"
                    },
                    {
                      "$ref": "#/components/schemas/CcPaymentInfoAcsResponse"
                    },
                    {
                      "$ref": "#/components/schemas/CcPaymentInfoAuthorizedResponse"
                    }
                  ]
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CcPaymentInfoError"
                }
              }
            }
          }
        }
      }
    },
    "/vpos/authorizations/{paymentAuthorizationId}/resume/method": {
      "post": {
        "summary": "resume vpos payment authorization",
        "tags": [
          "Vpos"
        ],
        "operationId": "postMethodResumeVpos",
        "parameters": [
          {
            "in": "path",
            "required": true,
            "name": "paymentAuthorizationId",
            "description": "Id of the request",
            "example": "41bc2409-5926-4aa9-afcc-797c7054e467",
            "schema": {
              "type": "string",
              "format": "UUID"
            }
          }
        ],
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreditCardResumeRequest"
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
                  "$ref": "#/components/schemas/VposResumeResponse"
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
      "XPayPaymentAuthorization": {
        "type": "object",
        "required": [
          "status",
          "paymentAuthorizationId"
        ],
        "properties": {
          "html": {
            "type": "string",
            "description": "HTML received in response from XPay",
            "example": "<html>\n<head>\n<title>\nGestione Pagamento Fraud detection</title>\n<script type=\"text/javascript\" language=\"javascript\">\nfunction moveWindow() {\n    document.tdsFraudForm.submit();\n}\n</script>\n</head>\n<body>\n<form name=\"tdsFraudForm\" action=\"https://coll-ecommerce.nexi.it/ecomm/ecomm/TdsMerchantServlet\" method=\"POST\">\n<input type=\"hidden\" name=\"action\"     value=\"fraud\">\n<input type=\"hidden\" name=\"merchantId\" value=\"31320986\">\n<input type=\"hidden\" name=\"description\" value=\"7090069933_1606392234626\">\n<input type=\"hidden\" name=\"gdiUrl\"      value=\"\">\n<input type=\"hidden\" name=\"gdiNotify\"   value=\"\">\n</form>\n<script type=\"text/javascript\">\n  moveWindow();\n</script>\n</body>\n</html>\n"
          },
          "paymentAuthorizationId": {
            "type": "string",
            "description": "payment authorization Id",
            "example": "affd8e24-f99a-406f-9ded-67a4a20c097f"
          },
          "status": {
            "type": "string",
            "enum": [
              "CREATED",
              "AUTHORIZED",
              "DENIED",
              "REFUNDED"
            ],
            "description": "status",
            "example": "CREATED"
          },
          "outcomeXpayGateway": {
            "$ref": "#/components/schemas/OutcomeXpayGateway"
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
      "XPayPaymentAuthorizationError": {
        "type": "object",
        "required": [
          "errorDetail"
        ],
        "properties": {
          "errorDetail": {
            "type": "string",
            "description": "error detail",
            "example": "Bad Request - mandatory parameters missing"
          }
        }
      },
      "CcPaymentInfoAcceptedResponse": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "enum": [
              "CREATED",
              "AUTHORIZED",
              "DENIED",
              "CANCELLED"
            ]
          },
          "requestId": {
            "type": "string"
          },
          "vposUrl": {
            "type": "string"
          },
          "redirectUrl": {
            "type": "string"
          },
          "threeDsMethodData": {
            "type": "string",
            "format": "base64"
          },
          "creq": {
            "type": "string",
            "format": "base64"
          }
        },
        "required": [
          "status",
          "requestId"
        ]
      },
      "CcPaymentInfoAcsResponse": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "enum": [
              "CREATED",
              "AUTHORIZED",
              "DENIED",
              "CANCELLED"
            ]
          },
          "responseType": {
            "type": "string",
            "enum": [
              "METHOD",
              "CHALLENGE",
              "AUTHORIZATION",
              "ERROR"
            ]
          },
          "requestId": {
            "type": "string"
          },
          "vposUrl": {
            "type": "string"
          },
          "threeDsMethodData": {
            "type": "string",
            "format": "base64"
          },
          "creq": {
            "type": "string",
            "format": "base64"
          }
        },
        "required": [
          "status",
          "responseType",
          "requestId",
          "vposUrl"
        ]
      },
      "CcPaymentInfoAuthorizedResponse": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "enum": [
              "CREATED",
              "AUTHORIZED",
              "DENIED",
              "CANCELLED"
            ]
          },
          "requestId": {
            "type": "string"
          },
          "redirectUrl": {
            "type": "string"
          },
          "creq": {
            "type": "string",
            "format": "base64"
          },
          "authCode": {
            "type": "string",
            "description": "authorization code received from XPay",
            "example": 123
          }
        },
        "required": [
          "status",
          "requestId",
          "redirectUrl",
          "authCode"
        ]
      },
      "CcPaymentInfoError": {
        "type": "object",
        "properties": {
          "redirectUrl": {
            "type": "string"
          },
          "status": {
            "type": "string",
            "enum": [
              "DENIED",
              "CANCELLED"
            ]
          },
          "requestId": {
            "type": "string"
          }
        },
        "required": [
          "status",
          "requestId",
          "redirectUrl"
        ]
      },
      "CreditCardResumeRequest": {
        "type": "object",
        "required": [
          "methodCompleted"
        ],
        "properties": {
          "methodCompleted": {
            "type": "string",
            "example": "Y"
          }
        }
      },
      "VposResumeResponse": {
        "type": "object",
        "required": [
          "requestId"
        ],
        "properties": {
          "requestId": {
            "type": "string",
            "format": "uuid",
            "example": "1f3af548-f9d3-423f-b7b0-4e68948d41d2"
          }
        }
      },
      "OutcomeXpayGateway": {
        "type": "object",
        "properties": {
          "outcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "authorizationCode": {
            "type": "string"
          },
          "errorCode": {
            "type": "number",
            "description": "error code received from XPay - https://ecommerce.nexi.it/specifiche-tecniche/tabelleecodifiche/codicierroreapirestful.html",
            "enum": [
              1,
              2,
              3,
              4,
              5,
              7,
              8,
              9,
              12,
              13,
              14,
              15,
              16,
              17,
              18,
              19,
              20,
              21,
              22,
              50,
              96,
              97,
              98,
              99,
              100
            ]
          }
        },
        "required": [
          "outcome"
        ]
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      }
    }
  }
}