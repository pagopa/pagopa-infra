{
  "openapi": "3.0.1",
  "info": {
    "version": "1.0.0",
    "title": "qi-smo-jira-tickets-api",
    "description": "Api for QI SMO JIRA TICKETS pagoPA"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "Ticket",
      "description": "Api's for ticket on Service Now"
    }
  ],
  "paths": {
    "/create": {
      "post": {
        "tags": [
          "Ticket"
        ],
        "summary": "Create a new ticket on Service Now",
        "description": "Create a new ticket on Service Now",
        "operationId": "create",
        "requestBody": {
          "description": "Create a new ticket on Service Now retrieving information from Jira Ticket ID",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/create"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIOK"
                }
              }
            }
          },
          "500": {
            "description": "Error from API",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIKO"
                }
              }
            }
          }
        }
      }
    },
    "/assign": {
      "post": {
        "tags": [
          "Ticket"
        ],
        "summary": "Assign a ticket to Service Now Team",
        "description": "Assign a ticket to Service Now Team",
        "operationId": "assign",
        "requestBody": {
          "description": "Assign a ticket to a Service Now Team",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/assign"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIOK"
                }
              }
            }
          },
          "500": {
            "description": "Error from API",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIKO"
                }
              }
            }
          }
        }
      }
    },
    "/comment": {
      "post": {
        "tags": [
          "Ticket"
        ],
        "summary": "Send a new comment on a Service Now Ticket",
        "description": "Send a new comment on a Service Now Ticket",
        "operationId": "comment",
        "requestBody": {
          "description": "Send a new comment on a Service Now Ticket",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/comment"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIOK"
                }
              }
            }
          },
          "500": {
            "description": "Error from API",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIKO"
                }
              }
            }
          }
        }
      }
    },
    "/close": {
      "post": {
        "tags": [
          "Ticket"
        ],
        "summary": "Close a ticket on Service Now",
        "description": "Close a ticket on Service Now",
        "operationId": "close",
        "requestBody": {
          "description": "Send a new comment on a Service Now Ticket",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/close"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIOK"
                }
              }
            }
          },
          "500": {
            "description": "Error from API",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIKO"
                }
              }
            }
          }
        }
      }
    },
    "/cancel": {
      "post": {
        "tags": [
          "Ticket"
        ],
        "summary": "Cancel a ticket on Service Now",
        "description": "Cancel a ticket on Service Now",
        "operationId": "cancel",
        "requestBody": {
          "description": "Cancel a ticket on Service Now",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/cancel"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIOK"
                }
              }
            }
          },
          "500": {
            "description": "Error from API",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIKO"
                }
              }
            }
          }
        }
      }
    },
    "/sync": {
      "post": {
        "tags": [
          "Ticket"
        ],
        "summary": "Sync attach between Jira Service Management and Service Now",
        "description": "Sync attach between Jira Service Management and Service Now",
        "operationId": "sync",
        "requestBody": {
          "description": "Sync attach between Jira Service Management and Service Now",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/sync"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Successful operation",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIOK"
                }
              }
            }
          },
          "500": {
            "description": "Error from API",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ResponseAPIKO"
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
      "create": {
        "required": [
          "action",
          "jira_ticket"
        ],
        "type": "object",
        "properties": {
          "action": {
            "type": "string",
            "description": "Action to be performed",
            "enum": [
              "create",
              "createByTicket"
            ]
          },
          "jira_ticket": {
            "type": "string",
            "example": "PPIT-100",
            "description": "Jira Service Management Ticket to send to Service Now"
          }
        }
      },
      "assign": {
        "required": [
          "ticket_id"
        ],
        "type": "object",
        "properties": {
          "ticket_id": {
            "type": "string",
            "example": "PPIT-100",
            "description": "Jira Service Management Ticket to send to Service Now"
          }
        }
      },
      "comment": {
        "required": [
          "ticket_id",
          "comment"
        ],
        "type": "object",
        "properties": {
          "ticket_id": {
            "type": "string",
            "example": "PPIT-100",
            "description": "Jira Service Management Ticket to send to Service Now"
          },
          "comment": {
            "type": "string",
            "example": "This is a new comment",
            "description": "Comment to send"
          }
        }
      },
      "close": {
        "required": [
          "ticket_id"
        ],
        "type": "object",
        "properties": {
          "ticket_id": {
            "type": "string",
            "example": "PPIT-100",
            "description": "Jira Service Management Ticket to send to Service Now"
          }
        }
      },
      "cancel": {
        "required": [
          "ticket_id"
        ],
        "type": "object",
        "properties": {
          "ticket_id": {
            "type": "string",
            "example": "PPIT-100",
            "description": "Jira Service Management Ticket to send to Service Now"
          }
        }
      },
      "sync": {
        "required": [
          "ticket_id"
        ],
        "type": "object",
        "properties": {
          "ticket_id": {
            "type": "string",
            "example": "PPIT-100",
            "description": "Jira Service Management Ticket to send to Service Now"
          }
        }
      },
      "ResponseAPIOK": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "description": "Response Status of API call (OK, KO))",
            "example": "OK",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "code": {
            "type": "integer",
            "description": "Application code from Service Now API",
            "example": 200
          },
          "jira_ticket_id": {
            "type": "string",
            "description": "Jira Ticket used for operation on Service Now Ticket",
            "example": "PPIT-100"
          },
          "ticket_id": {
            "type": "string",
            "description": "Ticket id opened on Service Now (uuid form)",
            "example": "a984ea7749ae0abc77ec624167aefc91"
          },
          "ticket_cs": {
            "type": "string",
            "description": "Ticket id opened on Service Now (CS* form)",
            "example": "CS123456"
          }
        }
      },
      "ResponseAPIKO": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "description": "Response Status of API call (OK, KO))",
            "example": "KO",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "code": {
            "type": "integer",
            "description": "Application code from Service Now API",
            "example": 702
          },
          "msg": {
            "type": "string",
            "description": "Error message generated by API or application",
            "example": "An error has occured"
          }
        }
      }
    }
  }
}