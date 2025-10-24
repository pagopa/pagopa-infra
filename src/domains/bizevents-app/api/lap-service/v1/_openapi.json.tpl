{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "Biz-Events Service - Paid Notice REST APIs (aka LAP)",
    "description" : "Microservice for exposing REST APIs about payment receipts.",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "0.1.84"
  },
  "servers" : [ {
    "url" : "http://localhost:8080"
  }, {
    "url" : "https://api.platform.pagopa.it/bizevents/notices-service/v1"
  } ],
  "paths" : {
    "/paids/{event-id}/disable" : {
      "post" : {
        "tags" : [ "Paid Notice REST APIs" ],
        "summary" : "Disable the paid notice details given its id.",
        "operationId" : "disablePaidNotice",
        "parameters" : [ {
          "name" : "x-fiscal-code",
          "in" : "header",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "event-id",
          "in" : "path",
          "description" : "The id of the paid event.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Event Disabled.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : { }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "404" : {
            "description" : "Not found the paid event.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "required" : false,
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/paids" : {
      "get" : {
        "tags" : [ "Paid Notice REST APIs" ],
        "summary" : "Retrieve the paged transaction list from biz events.",
        "description" : "This operation is deprecated. Use Paid Notice APIs instead",
        "operationId" : "getPaidNotices",
        "parameters" : [ {
          "name" : "x-fiscal-code",
          "in" : "header",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "x-continuation-token",
          "in" : "header",
          "required" : false,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "size",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "name" : "is_payer",
          "in" : "query",
          "description" : "Filter by payer",
          "required" : false,
          "schema" : {
            "type" : "boolean"
          }
        }, {
          "name" : "is_debtor",
          "in" : "query",
          "description" : "Filter by debtor",
          "required" : false,
          "schema" : {
            "type" : "boolean"
          }
        }, {
          "name" : "orderby",
          "in" : "query",
          "description" : "Order by TRANSACTION_DATE",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "TRANSACTION_DATE",
            "enum" : [ "TRANSACTION_DATE" ]
          }
        }, {
          "name" : "ordering",
          "in" : "query",
          "description" : "Direction of ordering",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "DESC",
            "enum" : [ "ASC", "DESC" ]
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Obtained paid notices list.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              },
              "x-continuation-token" : {
                "description" : "continuation token for paginated query",
                "style" : "simple",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/NoticeListWrapResponse"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "404" : {
            "description" : "Not found the fiscal code.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "*/*" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "required" : false,
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/paids/{event-id}" : {
      "get" : {
        "tags" : [ "Paid Notice REST APIs" ],
        "summary" : "Retrieve the paid notice details given its id.",
        "operationId" : "getPaidNoticeDetail",
        "parameters" : [ {
          "name" : "x-fiscal-code",
          "in" : "header",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "event-id",
          "in" : "path",
          "description" : "The id of the paid event.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "404" : {
            "description" : "Not found the transaction.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200" : {
            "description" : "Obtained paid notice detail.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/NoticeDetailResponse"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "required" : false,
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/paids/{event-id}/pdf" : {
      "get" : {
        "tags" : [ "Paid Notice REST APIs" ],
        "summary" : "Retrieve the PDF receipt given event id.",
        "operationId" : "generatePDF",
        "parameters" : [ {
          "name" : "x-fiscal-code",
          "in" : "header",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "event-id",
          "in" : "path",
          "description" : "The id of the paid event.",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "401" : {
            "description" : "Wrong or missing function key.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : { }
            }
          },
          "422" : {
            "description" : "Unprocessable receipt.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404" : {
            "description" : "Not found the receipt.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "200" : {
            "description" : "Obtained the PDF receipt.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              },
              "Content-Disposition" : {
                "description" : "Content disposition with name of the file",
                "style" : "simple",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/pdf" : {
                "schema" : {
                  "type" : "string",
                  "format" : "binary"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "required" : false,
        "schema" : {
          "type" : "string"
        }
      } ]
    },
    "/info" : {
      "get" : {
        "tags" : [ "Home" ],
        "summary" : "health check",
        "description" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
          "200" : {
            "description" : "OK",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/AppInfo"
                }
              }
            }
          },
          "401" : {
            "description" : "Unauthorized",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "headers" : {
              "X-Request-Id" : {
                "description" : "This header identifies the call",
                "schema" : {
                  "type" : "string"
                }
              }
            },
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      },
      "parameters" : [ {
        "name" : "X-Request-Id",
        "in" : "header",
        "description" : "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
        "required" : false,
        "schema" : {
          "type" : "string"
        }
      } ]
    }
  },
  "components" : {
    "schemas" : {
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          }
        }
      },
      "NoticeListItem" : {
        "required" : [ "amount", "eventId", "isCart", "isDebtor", "isPayer", "noticeDate", "payeeTaxCode" ],
        "type" : "object",
        "properties" : {
          "eventId" : {
            "type" : "string"
          },
          "payeeName" : {
            "type" : "string"
          },
          "payeeTaxCode" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "string"
          },
          "noticeDate" : {
            "type" : "string"
          },
          "isCart" : {
            "type" : "boolean"
          },
          "isPayer" : {
            "type" : "boolean"
          },
          "isDebtor" : {
            "type" : "boolean"
          }
        }
      },
      "NoticeListWrapResponse" : {
        "required" : [ "notices" ],
        "type" : "object",
        "properties" : {
          "notices" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/NoticeListItem"
            }
          }
        }
      },
      "CartItem" : {
        "required" : [ "amount", "refNumberType", "refNumberValue", "subject" ],
        "type" : "object",
        "properties" : {
          "subject" : {
            "type" : "string"
          },
          "amount" : {
            "type" : "string"
          },
          "payee" : {
            "$ref" : "#/components/schemas/UserDetail"
          },
          "debtor" : {
            "$ref" : "#/components/schemas/UserDetail"
          },
          "refNumberValue" : {
            "type" : "string"
          },
          "refNumberType" : {
            "type" : "string"
          }
        }
      },
      "InfoNotice" : {
        "required" : [ "amount", "eventId", "noticeDate", "origin", "pspName", "rrn" ],
        "type" : "object",
        "properties" : {
          "eventId" : {
            "type" : "string"
          },
          "authCode" : {
            "type" : "string"
          },
          "rrn" : {
            "type" : "string"
          },
          "noticeDate" : {
            "type" : "string"
          },
          "pspName" : {
            "type" : "string"
          },
          "walletInfo" : {
            "$ref" : "#/components/schemas/WalletInfo"
          },
          "paymentMethod" : {
            "type" : "string",
            "enum" : [ "BBT", "BP", "AD", "CP", "PO", "OBEP", "JIF", "MYBK", "PPAL", "UNKNOWN" ]
          },
          "payer" : {
            "$ref" : "#/components/schemas/UserDetail"
          },
          "amount" : {
            "type" : "string"
          },
          "fee" : {
            "type" : "string"
          },
          "origin" : {
            "type" : "string",
            "enum" : [ "INTERNAL", "PM", "NDP001PROD", "NDP002PROD", "NDP003PROD", "NDP004PROD", "UNKNOWN" ]
          }
        }
      },
      "NoticeDetailResponse" : {
        "type" : "object",
        "properties" : {
          "infoNotice" : {
            "$ref" : "#/components/schemas/InfoNotice"
          },
          "carts" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/CartItem"
            }
          }
        }
      },
      "UserDetail" : {
        "required" : [ "taxCode" ],
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string"
          },
          "taxCode" : {
            "type" : "string"
          }
        }
      },
      "WalletInfo" : {
        "type" : "object",
        "properties" : {
          "accountHolder" : {
            "type" : "string"
          },
          "brand" : {
            "type" : "string"
          },
          "blurredNumber" : {
            "type" : "string"
          },
          "maskedEmail" : {
            "type" : "string"
          }
        }
      },
      "AppInfo" : {
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          },
          "environment" : {
            "type" : "string"
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "type" : "apiKey",
        "description" : "The Azure Subscription Key to access this API.",
        "name" : "Ocp-Apim-Subscription-Key",
        "in" : "header"
      }
    }
  }
}