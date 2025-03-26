{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "SPID Login Simulation",
    "description": "API for simulating an SPID login page"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "tags": [
    {
      "name": "spidLogin",
      "description": "API for simulating an SPID login page"
    }
  ],
  "paths": {
    "/login": {
      "get": {
        "tags": [
          "spidLogin"
        ],
        "operationId": "spidLoginPage",
        "summary": "Returns the SPID login page",
        "description": "API that returns an HTML page to simulate an SPID login.",
        "responses": {
          "200": {
            "description": "SPID login HTML page",
            "content": {
              "text/html": {
                "schema": {
                  "type": "string",
                  "description": "HTML containing the SPID login simulation page"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
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
      "ProblemJson": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI identifying the problem type. When dereferenced, it should provide human-readable documentation for the problem type.",
            "default": "about:blank"
          },
          "title": {
            "type": "string",
            "description": "A short summary of the problem type."
          },
          "detail": {
            "type": "string",
            "description": "A human-readable explanation specific to this occurrence of the problem."
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI identifying the specific occurrence of the problem."
          }
        }
      }
    }
  }
}