{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-logging",
    "version": "1.0",
    "title": "Payment Manager API",
    "x-version": "36.1.3"
  },
  "host": "${host}",
  "basePath": "/pp-logging",
  "schemes": [
    "https"
  ],
  "paths": {
    "/logging/db/save": {
      "put": {
        "operationId": "addNewEvent",
        "summary": "Add new event",
        "description": "Add new event in PP_LOGGING",
        "responses": {
          "200": {
            "description": "Request outcome",
            "schema": {
              "$ref": "#/definitions/UserEventResponse"
            }
          },
          "400": {
            "description": "Bad request"
          },
          "401": {
            "description": "Unauthorized"
          },
          "500": {
            "description": "Services are not available or request is rejected"
          }
        }
      }
    }
  },
  "definitions": {
    "UserEventResponse": {
      "type": "object",
      "required": [
        "eventId"
      ],
      "properties": {
        "eventId": {
          "type": "integer",
        }
      }
    }
  }
}
