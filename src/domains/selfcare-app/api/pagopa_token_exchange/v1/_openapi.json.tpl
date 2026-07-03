{
  "openapi": "3.0.3",
  "info": {
    "title": "PagoPA Token Exchange API",
    "description": "Exchange a Selfcare or pagoPA session token for a pagoPA platform token.",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${host}/backoffice/selfcare/sso/v1"
    }
  ],
  "paths": {
    "/tokens": {
      "post": {
        "operationId": "exchangeToken",
        "summary": "Exchange an identity token",
        "parameters": [
          {
            "name": "IdentityToken",
            "in": "header",
            "description": "Selfcare identity token or pagoPA session token.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "desidered_role",
            "in": "query",
            "description": "Role to activate. When omitted, the first assigned role is used.",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Token generated successfully.",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string",
                  "description": "Signed JWT."
                }
              }
            }
          },
          "400": {
            "description": "The source token has a missing or invalid roles structure.",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "description": "The source token is missing, expired, or has an invalid signature.",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "403": {
            "description": "The requested role is not assigned to the user.",
            "content": {
              "text/plain": {
                "schema": {
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
