{
  "openapi": "3.0.3",
  "info": {
    "title": "PagoPA Token Exchange API",
    "description": "Exchange a Selfcare identity token for a pagoPA platform token.",
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
            "description": "Selfcare identity token.",
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
          "401": {
            "description": "The Selfcare identity token is invalid or the requested role is not assigned to the user.",
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
