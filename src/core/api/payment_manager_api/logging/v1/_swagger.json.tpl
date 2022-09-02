{
  "swagger": "2.0",
  "info": {
    "description": "Payment Manager API - pp-logging",
    "version": "1.0",
    "title": "Payment Manager API - pp-logging",
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
        "parameters" : [{
            "in": "body",
            "name": "UserEventRequest",
            "description": "Info related user event",
            "required": true,
            "schema": {
              "$ref": "#/definitions/UserEventRequest"
          }
        }],
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
    },
    "UserEventRequest": {
      "type": "object",
      "required": [
        "eventId"
      ],
      "properties": {
        "idPayment": {
          "type": "string"
        },
        "paymentId": {
          "type": "integer",
        },
        "transactionId": {
          "type": "integer",
        },
        "userId": {
          "type": "integer",
        },
        "userMail": {
          "type": "string",
        },
        "walletId": {
          "type": "integer",
        },
        "eventId": {
          "type": "integer",
        },
        "eventShortName": {
          "enum": [
            "PAYMNTSUCCESS",
            "PAYMNTSTORNO",
            "PAYMNTSUCCESS_CARD",
            "PAYMNTSUCCESS_MOD1",
            "PAYMNTSUCCESS_MOD2",
            "TRNCARTINIT",
            "TRNMOD1INIT",
            "TRNMOD2INIT",
            "AUTHORIZE",
            "RDRCTPSP",
            "PAYCCVER",
            "DELPAYMT",
            "CANCELPAYMT",
            "CANCELPAYMTUSER",
            "CANCELPAYMTEXPRD",
            "PSPLIST",
            "GETPSP",
            "GETTRNSS",
            "GETTRAN",
            "CHCKSTAT",
            "TRNCRTD",
            "TRNACCNTD",
            "TRNRVRTD",
            "TRNACCMOD2",
            "TRNRFSMOD2",
            "TRNRFS",
            "RESUME",
            "RESUMETRAN",
            "AUTHENTICATION_EMAIL",
            "AUTHENTICATION_SPID",
            "UPDTUSR",
            "EMAILVAL",
            "RSTPWD",
            "VRUPDPWD",
            "VUPPUK",
            "GNRSTPWD",
            "APRVTRMS",
            "SIGNIN",
            "SIGNINPHONE",
            "SETPWD",
            "UPDPWD",
            "CHNGMAIL",
            "CNGPHONE",
            "VRUSRPUK",
            "VRUSRPWD",
            "LOGOUT",
            "DELCC",
            "GETWLLTS",
            "ADDWLLT",
            "ADDWLTCC",
            "GETWLT",
            "DELWLLT",
            "FAVWLLT",
            "CNFRMWLT",
            "UPDWLLT",
            "CHCKBIN"
          ],
          "type": "string",
        },
        "sessionToken": {
          "type": "string",
        },
        "details": {
          "type": "string",
        },
      }
    }
  }
}
