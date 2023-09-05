{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition - Authorizer",
    "version": "0.0.1"
  },
  "servers": [
    {
      "url": "${host}/authorizer/",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/cache/domains/{domain}": {
      "post": {
        "tags": [
          "Authorizer API"
        ],
        "summary": "Enable a list of authorized entities to be handled by clients using a subscription key into a specific domain.",
        "operationId": "subscribeAuthorization",
        "parameters": [
          {
            "name": "domain",
            "in": "path",
            "description": "The domain on which the entities will be authorized to be called with a certain subscription key.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "add_in_progress",
            "in": "query",
            "description": "The flag that permits to define a locking mechanism on concurrent sync operations on same domain. Default = true",
            "required": false,
            "schema": {
              "type": "boolean",
              "default": true
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/AuthorizationModel"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Operation executed successfully."
          },
          "503": {
            "description": "Operation in progress."
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "AuthorizationModel": {
        "required": [
          "key",
          "value"
        ],
        "type": "object",
        "properties": {
          "key": {
            "type": "string",
            "description": "The element that will be saved as key for authorization check. The key must follows the format: <domain>_<subscriptionkey>",
            "example": "domainx_subkeyx"
          },
          "value": {
            "type": "string",
            "description": "The entities that will be saved as value for authorization check. If two or more entities must be added, they must be separated by a hash character.",
            "example": "entity1#entity2#entity3"
          },
          "metadata": {
            "type": "string",
            "description": "The metadata that will be saved as additional information for further operations. If two or more entities must be added, they must be separated by a double semicolumn character.",
            "example": "_o=pagoPA;;_sco=Test Purpose;;"
          }
        }
      }
    }
  }
}
