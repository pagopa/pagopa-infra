{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "eCommerce-PM web view for IO App",
    "description": "Web view designed to aid compatibility between eCommerce API for IO App and Payment Manager",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/pay": {
      "get": {
        "summary": "Load PM Payment page",
        "description": "Payment page for Payment Manager with idWallet, idPayment, sessionToken and language as fragment",
        "operationId": "getWebView",
        "responses": {
          "200": {
            "description": "html to submit PM webview",
            "content": {
              "text/html": {
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              }
            }
          }
        }
      }
    }
  }
}