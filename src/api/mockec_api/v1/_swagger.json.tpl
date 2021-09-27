{
  "swagger": "2.0",
  "info": {
    "title": "paForNode_Service",
    "description": "",
    "x-ibm-name": "pafornodeservice",
    "version": "1.0.0"
  },
  "host": "${host}",
  "schemes": [
    "https"
  ],
  "basePath": "/paForNode_Service",
  "produces": [
    "application/xml"
  ],
  "consumes": [
    "text/xml"
  ],
  "securityDefinitions": {
    "clientID": {
      "type": "apiKey",
      "name": "X-IBM-Client-Id",
      "in": "header",
      "description": ""
    }
  },
  "security": [
    {
      "clientID": []
    }
  ],
  "x-ibm-configuration": {
    "type": "wsdl",
    "phase": "realized",
    "enforced": true,
    "testable": true,
    "gateway": "datapower-gateway",
    "cors": {
      "enabled": true
    },
    "wsdl-definition": {
      "wsdl": "paForNode.wsdl",
      "service": "paForNode_Service",
      "port": "paForNode_Port",
      "soap-version": "1.1"
    },
    "assembly": {
      "execute": [
        {
          "proxy": {
            "title": "proxy",
            "target-url": "http://pagopa-api.pagopa.gov.it/service/pa/paForNode"
          }
        }
      ]
    },
    "x-ibm-apiconnect-wsdl": {
      "package-version": "1.8.19",
      "options": {},
      "messages": {
        "info": [],
        "warning": [],
        "error": []
      }
    }
  },
  "paths": {
    "/paVerifyPaymentNotice": {
      "post": {
        "summary": "Operation paVerifyPaymentNotice",
        "description": "Through the primitive `paVerifyPaymentNotice` the PA is interrogated to verify which are the options available to the citizen at the same time.\n\nAll available options will then be proposed until one of the following events occurs:\n\n- a payment receipt is notified, therefore the debt position is closed and no payment option will be available anymore.\n- the PA becomes in possession of the notification data, therefore it can update the payment options by entering the correct expiry data for each of the options.",
        "operationId": "paVerifyPaymentNotice",
        "x-ibm-soap": {
          "soap-action": "paVerifyPaymentNotice",
          "soap-operation": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd}paVerifyPaymentNoticeReq"
        },
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/paVerifyPaymentNoticeInput"
            }
          }
        ],
        "responses": {
          "default": {
            "description": "",
            "schema": {
              "$ref": "#/definitions/paVerifyPaymentNoticeOutput"
            }
          }
        }
      }
    },
    "/paGetPayment": {
      "post": {
        "summary": "Operation paGetPayment",
        "description": "A PA connected to the pagoPA Platform must offer a service that returns a payment linked to a debt position through the\nprimitive `paGetPayment`.\n\nEach request is specified through the parameters `amount` and `due_date`, which are returned by the `paVerifyPayment`,\nand the `transferType` parameter that defines the type of credit that the PSP would like to have.\n**NOTE** : _(currently the only option is related to necessity of a postal current account)._\n\nIf these parameters are not present, the PA will set the real amount.\nIn response, the PA returns all the data necessary for the payment.\n\nIn addition, the PA can define a validity date for the information sent. If present, the platform will be authorized to manage\nautonomously similar requests without necessarily contacting the PA.",
        "operationId": "paGetPayment",
        "x-ibm-soap": {
          "soap-action": "paGetPayment",
          "soap-operation": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd}paGetPaymentReq"
        },
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/paGetPaymentInput"
            }
          }
        ],
        "responses": {
          "default": {
            "description": "",
            "schema": {
              "$ref": "#/definitions/paGetPaymentOutput"
            }
          }
        }
      }
    },
    "/paSendRT": {
      "post": {
        "summary": "Operation paSendRT",
        "description": "Following any payment made on the pagoPA, the system'll generate a receipt, and promptly notified it. \nA receipt certifying the payment made with references to the debt position and related details.\n\nReceipts are sent:\n\n- in the case of online payment to the station requesting the payment\n- in the case of payment by payment notification at the station indicated in the notice\n- to all stations identified as `broadcast` if the entity beneficiary, contained within the payment, is not associated to the stations described above.\n\nIn order to receive such receipts, the EC shall implement `paSendRT` service.\n\nThe pagoPA Platform will make a maximum of 5 sending attempts of the receipt to PA. \n\n**Note**: receipts cannot be refused, the existence of the the receipt itself certifies the payment according to the processes\ndescribed and notify future accreditation operations. Any cancellations must be managed directly by the EC.",
        "operationId": "paSendRT",
        "x-ibm-soap": {
          "soap-action": "paSendRT",
          "soap-operation": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd}paSendRTReq"
        },
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "required": true,
            "schema": {
              "$ref": "#/definitions/paSendRTInput"
            }
          }
        ],
        "responses": {
          "default": {
            "description": "",
            "schema": {
              "$ref": "#/definitions/paSendRTOutput"
            }
          }
        }
      }
    }
  },
  "definitions": {
    "Security": {
      "xml": {
        "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
        "prefix": "wsse"
      },
      "description": "Header for WS-Security",
      "type": "object",
      "properties": {
        "UsernameToken": {
          "xml": {
            "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
            "prefix": "wsse"
          },
          "type": "object",
          "properties": {
            "Username": {
              "xml": {
                "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
                "prefix": "wsse"
              },
              "type": "string"
            },
            "Password": {
              "xml": {
                "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
                "prefix": "wsse"
              },
              "type": "string"
            },
            "Nonce": {
              "xml": {
                "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
                "prefix": "wsse"
              },
              "type": "string",
              "properties": {
                "EncodingType": {
                  "xml": {
                    "namespace": "",
                    "attribute": true
                  },
                  "type": "string"
                }
              }
            },
            "Created": {
              "xml": {
                "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd",
                "prefix": "wsu"
              },
              "type": "string"
            }
          }
        },
        "Timestamp": {
          "xml": {
            "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd",
            "prefix": "wsu"
          },
          "type": "object",
          "properties": {
            "Created": {
              "xml": {
                "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd",
                "prefix": "wsu"
              },
              "type": "string"
            },
            "Expires": {
              "xml": {
                "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd",
                "prefix": "wsu"
              },
              "type": "string"
            },
            "Id": {
              "xml": {
                "namespace": "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd",
                "prefix": "wsu",
                "attribute": true
              },
              "type": "string"
            }
          }
        }
      }
    },
    "paVerifyPaymentNoticeInput": {
      "description": "Input message for wsdl operation paVerifyPaymentNoticeReq",
      "type": "object",
      "properties": {
        "Envelope": {
          "xml": {
            "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
            "prefix": "soapenv"
          },
          "type": "object",
          "properties": {
            "Header": {
              "$ref": "#/definitions/paVerifyPaymentNoticeHeader"
            },
            "Body": {
              "xml": {
                "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
                "prefix": "soapenv"
              },
              "type": "object",
              "properties": {
                "paVerifyPaymentNoticeReq": {
                  "$ref": "#/definitions/paVerifyPaymentNoticeReq_element_pafn"
                }
              },
              "required": [
                "paVerifyPaymentNoticeReq"
              ]
            }
          },
          "required": [
            "Body"
          ]
        }
      },
      "required": [
        "Envelope"
      ],
      "x-ibm-schema": {
        "wsdl-port": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.wsdl}paForNode_Port",
        "wsdl-operation": "paVerifyPaymentNoticeReq",
        "wsdl-message-direction-or-name": "paVerifyPaymentNoticeReqRequest"
      },
      "example": "\n<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n <soapenv:Header>\n  <!-- The Security element should be removed if WS-Security is not enabled on the SOAP target-url -->\n  <wsse:Security xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\">\n   <wsse:UsernameToken>\n    <wsse:Username>string</wsse:Username>\n    <wsse:Password>string</wsse:Password>\n    <wsse:Nonce EncodingType=\"string\">string</wsse:Nonce>\n    <wsu:Created>string</wsu:Created>\n   </wsse:UsernameToken>\n   <wsu:Timestamp wsu:Id=\"string\">\n    <wsu:Created>string</wsu:Created>\n    <wsu:Expires>string</wsu:Expires>\n   </wsu:Timestamp>\n  </wsse:Security>\n </soapenv:Header>\n <soapenv:Body>\n  <pafn:paVerifyPaymentNoticeReq xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\"><!-- mandatory -->\n   <idPA><!-- mandatory -->string</idPA>\n   <idBrokerPA><!-- mandatory -->string</idBrokerPA>\n   <idStation><!-- mandatory -->string</idStation>\n   <qrCode><!-- mandatory -->\n    <fiscalCode><!-- mandatory -->string</fiscalCode>\n    <noticeNumber><!-- mandatory -->string</noticeNumber>\n   </qrCode>\n  </pafn:paVerifyPaymentNoticeReq>\n </soapenv:Body>\n</soapenv:Envelope>"
    },
    "paVerifyPaymentNoticeHeader": {
      "description": "Input headers for wsdl operation paVerifyPaymentNoticeReq",
      "type": "object",
      "properties": {
        "Security": {
          "$ref": "#/definitions/Security"
        }
      }
    },
    "paVerifyPaymentNoticeOutput": {
      "description": "Output message for wsdl operation paVerifyPaymentNoticeReq",
      "type": "object",
      "properties": {
        "Envelope": {
          "xml": {
            "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
            "prefix": "soapenv"
          },
          "type": "object",
          "properties": {
            "Body": {
              "xml": {
                "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
                "prefix": "soapenv"
              },
              "type": "object",
              "properties": {
                "paVerifyPaymentNoticeRes": {
                  "$ref": "#/definitions/paVerifyPaymentNoticeRes_element_pafn"
                }
              }
            }
          },
          "required": [
            "Body"
          ]
        }
      },
      "required": [
        "Envelope"
      ],
      "x-ibm-schema": {
        "wsdl-port": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.wsdl}paForNode_Port",
        "wsdl-operation": "paVerifyPaymentNoticeReq",
        "wsdl-message-direction-or-name": "paVerifyPaymentNoticeReqResponse"
      },
      "example": "\n<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n <soapenv:Body>\n  <pafn:paVerifyPaymentNoticeRes xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n   <outcome><!-- mandatory -->string</outcome>\n   <fault>\n    <faultCode><!-- mandatory -->string</faultCode>\n    <faultString><!-- mandatory -->string</faultString>\n    <id><!-- mandatory -->string</id>\n    <description>string</description>\n    <serial>3</serial>\n    <originalFaultCode>string</originalFaultCode>\n    <originalFaultString>string</originalFaultString>\n    <originalDescription>string</originalDescription>\n   </fault>\n   <paymentList>\n    <paymentOptionDescription><!-- mandatory --><!-- between 1 and 5 repetitions of this element -->\n     <amount><!-- mandatory -->999999996.99</amount>\n     <options><!-- mandatory -->string</options>\n     <dueDate>2016-04-18</dueDate>\n     <detailDescription>string</detailDescription>\n     <transferType>string</transferType>\n    </paymentOptionDescription>\n   </paymentList>\n   <paymentDescription>string</paymentDescription>\n   <fiscalCodePA>string</fiscalCodePA>\n   <companyName>string</companyName>\n   <officeName>string</officeName>\n  </pafn:paVerifyPaymentNoticeRes>\n </soapenv:Body>\n</soapenv:Envelope>"
    },
    "paGetPaymentInput": {
      "description": "Input message for wsdl operation paGetPaymentReq",
      "type": "object",
      "properties": {
        "Envelope": {
          "xml": {
            "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
            "prefix": "soapenv"
          },
          "type": "object",
          "properties": {
            "Header": {
              "$ref": "#/definitions/paGetPaymentHeader"
            },
            "Body": {
              "xml": {
                "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
                "prefix": "soapenv"
              },
              "type": "object",
              "properties": {
                "paGetPaymentReq": {
                  "$ref": "#/definitions/paGetPaymentReq_element_pafn"
                }
              },
              "required": [
                "paGetPaymentReq"
              ]
            }
          },
          "required": [
            "Body"
          ]
        }
      },
      "required": [
        "Envelope"
      ],
      "x-ibm-schema": {
        "wsdl-port": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.wsdl}paForNode_Port",
        "wsdl-operation": "paGetPaymentReq",
        "wsdl-message-direction-or-name": "paGetPaymentReqRequest"
      },
      "example": "\n<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n <soapenv:Header>\n  <!-- The Security element should be removed if WS-Security is not enabled on the SOAP target-url -->\n  <wsse:Security xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\">\n   <wsse:UsernameToken>\n    <wsse:Username>string</wsse:Username>\n    <wsse:Password>string</wsse:Password>\n    <wsse:Nonce EncodingType=\"string\">string</wsse:Nonce>\n    <wsu:Created>string</wsu:Created>\n   </wsse:UsernameToken>\n   <wsu:Timestamp wsu:Id=\"string\">\n    <wsu:Created>string</wsu:Created>\n    <wsu:Expires>string</wsu:Expires>\n   </wsu:Timestamp>\n  </wsse:Security>\n </soapenv:Header>\n <soapenv:Body>\n  <pafn:paGetPaymentReq xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\"><!-- mandatory -->\n   <idPA><!-- mandatory -->string</idPA>\n   <idBrokerPA><!-- mandatory -->string</idBrokerPA>\n   <idStation><!-- mandatory -->string</idStation>\n   <qrCode><!-- mandatory -->\n    <fiscalCode><!-- mandatory -->string</fiscalCode>\n    <noticeNumber><!-- mandatory -->string</noticeNumber>\n   </qrCode>\n   <amount>999999996.99</amount>\n   <paymentNote>string</paymentNote>\n   <transferType>string</transferType>\n   <dueDate>2016-04-18</dueDate>\n  </pafn:paGetPaymentReq>\n </soapenv:Body>\n</soapenv:Envelope>"
    },
    "paGetPaymentHeader": {
      "description": "Input headers for wsdl operation paGetPaymentReq",
      "type": "object",
      "properties": {
        "Security": {
          "$ref": "#/definitions/Security"
        }
      }
    },
    "paGetPaymentOutput": {
      "description": "Output message for wsdl operation paGetPaymentReq",
      "type": "object",
      "properties": {
        "Envelope": {
          "xml": {
            "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
            "prefix": "soapenv"
          },
          "type": "object",
          "properties": {
            "Body": {
              "xml": {
                "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
                "prefix": "soapenv"
              },
              "type": "object",
              "properties": {
                "paGetPaymentRes": {
                  "$ref": "#/definitions/paGetPaymentRes_element_pafn"
                }
              }
            }
          },
          "required": [
            "Body"
          ]
        }
      },
      "required": [
        "Envelope"
      ],
      "x-ibm-schema": {
        "wsdl-port": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.wsdl}paForNode_Port",
        "wsdl-operation": "paGetPaymentReq",
        "wsdl-message-direction-or-name": "paGetPaymentReqResponse"
      },
      "example": "\n<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n <soapenv:Body>\n  <pafn:paGetPaymentRes xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n   <outcome><!-- mandatory -->string</outcome>\n   <fault>\n    <faultCode><!-- mandatory -->string</faultCode>\n    <faultString><!-- mandatory -->string</faultString>\n    <id><!-- mandatory -->string</id>\n    <description>string</description>\n    <serial>3</serial>\n    <originalFaultCode>string</originalFaultCode>\n    <originalFaultString>string</originalFaultString>\n    <originalDescription>string</originalDescription>\n   </fault>\n   <data>\n    <creditorReferenceId><!-- mandatory -->string</creditorReferenceId>\n    <paymentAmount><!-- mandatory -->999999996.99</paymentAmount>\n    <dueDate><!-- mandatory -->2016-04-18</dueDate>\n    <retentionDate>2016-04-18T14:07:37</retentionDate>\n    <lastPayment>true</lastPayment>\n    <description><!-- mandatory -->string</description>\n    <companyName>string</companyName>\n    <officeName>string</officeName>\n    <debtor><!-- mandatory -->\n     <uniqueIdentifier><!-- mandatory -->\n      <entityUniqueIdentifierType><!-- mandatory -->string</entityUniqueIdentifierType>\n      <entityUniqueIdentifierValue><!-- mandatory -->string</entityUniqueIdentifierValue>\n     </uniqueIdentifier>\n     <fullName><!-- mandatory -->string</fullName>\n     <streetName>string</streetName>\n     <civicNumber>string</civicNumber>\n     <postalCode>string</postalCode>\n     <city>string</city>\n     <stateProvinceRegion>string</stateProvinceRegion>\n     <country>string</country>\n     <e-mail>string</e-mail>\n    </debtor>\n    <transferList><!-- mandatory -->\n     <transfer><!-- mandatory --><!-- between 1 and 5 repetitions of this element -->\n      <idTransfer><!-- mandatory -->3</idTransfer>\n      <transferAmount><!-- mandatory -->999999996.99</transferAmount>\n      <fiscalCodePA><!-- mandatory -->string</fiscalCodePA>\n      <IBAN><!-- mandatory -->string</IBAN>\n      <remittanceInformation><!-- mandatory -->string</remittanceInformation>\n      <transferCategory><!-- mandatory -->string</transferCategory>\n     </transfer>\n    </transferList>\n    <metadata>\n     <mapEntry><!-- mandatory --><!-- between 1 and 10 repetitions of this element -->\n      <key><!-- mandatory -->string</key>\n      <value><!-- mandatory -->string</value>\n     </mapEntry>\n    </metadata>\n   </data>\n  </pafn:paGetPaymentRes>\n </soapenv:Body>\n</soapenv:Envelope>"
    },
    "paSendRTInput": {
      "description": "Input message for wsdl operation paSendRTReq",
      "type": "object",
      "properties": {
        "Envelope": {
          "xml": {
            "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
            "prefix": "soapenv"
          },
          "type": "object",
          "properties": {
            "Header": {
              "$ref": "#/definitions/paSendRTHeader"
            },
            "Body": {
              "xml": {
                "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
                "prefix": "soapenv"
              },
              "type": "object",
              "properties": {
                "paSendRTReq": {
                  "$ref": "#/definitions/paSendRTReq_element_pafn"
                }
              },
              "required": [
                "paSendRTReq"
              ]
            }
          },
          "required": [
            "Body"
          ]
        }
      },
      "required": [
        "Envelope"
      ],
      "x-ibm-schema": {
        "wsdl-port": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.wsdl}paForNode_Port",
        "wsdl-operation": "paSendRTReq",
        "wsdl-message-direction-or-name": "paSendRTReqRequest"
      },
      "example": "\n<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n <soapenv:Header>\n  <!-- The Security element should be removed if WS-Security is not enabled on the SOAP target-url -->\n  <wsse:Security xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" xmlns:wsu=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\">\n   <wsse:UsernameToken>\n    <wsse:Username>string</wsse:Username>\n    <wsse:Password>string</wsse:Password>\n    <wsse:Nonce EncodingType=\"string\">string</wsse:Nonce>\n    <wsu:Created>string</wsu:Created>\n   </wsse:UsernameToken>\n   <wsu:Timestamp wsu:Id=\"string\">\n    <wsu:Created>string</wsu:Created>\n    <wsu:Expires>string</wsu:Expires>\n   </wsu:Timestamp>\n  </wsse:Security>\n </soapenv:Header>\n <soapenv:Body>\n  <pafn:paSendRTReq xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\"><!-- mandatory -->\n   <idPA><!-- mandatory -->string</idPA>\n   <idBrokerPA><!-- mandatory -->string</idBrokerPA>\n   <idStation><!-- mandatory -->string</idStation>\n   <receipt><!-- mandatory -->\n    <receiptId><!-- mandatory -->string</receiptId>\n    <noticeNumber><!-- mandatory -->string</noticeNumber>\n    <fiscalCode><!-- mandatory -->string</fiscalCode>\n    <outcome><!-- mandatory -->string</outcome>\n    <creditorReferenceId><!-- mandatory -->string</creditorReferenceId>\n    <paymentAmount><!-- mandatory -->999999996.99</paymentAmount>\n    <description><!-- mandatory -->string</description>\n    <companyName><!-- mandatory -->string</companyName>\n    <officeName>string</officeName>\n    <debtor><!-- mandatory -->\n     <uniqueIdentifier><!-- mandatory -->\n      <entityUniqueIdentifierType><!-- mandatory -->string</entityUniqueIdentifierType>\n      <entityUniqueIdentifierValue><!-- mandatory -->string</entityUniqueIdentifierValue>\n     </uniqueIdentifier>\n     <fullName><!-- mandatory -->string</fullName>\n     <streetName>string</streetName>\n     <civicNumber>string</civicNumber>\n     <postalCode>string</postalCode>\n     <city>string</city>\n     <stateProvinceRegion>string</stateProvinceRegion>\n     <country>string</country>\n     <e-mail>string</e-mail>\n    </debtor>\n    <transferList><!-- mandatory -->\n     <transfer><!-- mandatory --><!-- between 1 and 5 repetitions of this element -->\n      <idTransfer><!-- mandatory -->3</idTransfer>\n      <transferAmount><!-- mandatory -->999999996.99</transferAmount>\n      <fiscalCodePA><!-- mandatory -->string</fiscalCodePA>\n      <IBAN><!-- mandatory -->string</IBAN>\n      <remittanceInformation><!-- mandatory -->string</remittanceInformation>\n      <transferCategory><!-- mandatory -->string</transferCategory>\n     </transfer>\n    </transferList>\n    <idPSP><!-- mandatory -->string</idPSP>\n    <pspFiscalCode>string</pspFiscalCode>\n    <pspPartitaIVA>string</pspPartitaIVA>\n    <PSPCompanyName><!-- mandatory -->string</PSPCompanyName>\n    <idChannel><!-- mandatory -->string</idChannel>\n    <channelDescription><!-- mandatory -->string</channelDescription>\n    <payer>\n     <uniqueIdentifier><!-- mandatory -->\n      <entityUniqueIdentifierType><!-- mandatory -->string</entityUniqueIdentifierType>\n      <entityUniqueIdentifierValue><!-- mandatory -->string</entityUniqueIdentifierValue>\n     </uniqueIdentifier>\n     <fullName><!-- mandatory -->string</fullName>\n     <streetName>string</streetName>\n     <civicNumber>string</civicNumber>\n     <postalCode>string</postalCode>\n     <city>string</city>\n     <stateProvinceRegion>string</stateProvinceRegion>\n     <country>string</country>\n     <e-mail>string</e-mail>\n    </payer>\n    <paymentMethod>string</paymentMethod>\n    <fee>999999996.99</fee>\n    <paymentDateTime>2016-04-18T14:07:37</paymentDateTime>\n    <applicationDate>2016-04-18</applicationDate>\n    <transferDate>2016-04-18</transferDate>\n    <metadata>\n     <mapEntry><!-- mandatory --><!-- between 1 and 10 repetitions of this element -->\n      <key><!-- mandatory -->string</key>\n      <value><!-- mandatory -->string</value>\n     </mapEntry>\n    </metadata>\n   </receipt>\n  </pafn:paSendRTReq>\n </soapenv:Body>\n</soapenv:Envelope>"
    },
    "paSendRTHeader": {
      "description": "Input headers for wsdl operation paSendRTReq",
      "type": "object",
      "properties": {
        "Security": {
          "$ref": "#/definitions/Security"
        }
      }
    },
    "paSendRTOutput": {
      "description": "Output message for wsdl operation paSendRTReq",
      "type": "object",
      "properties": {
        "Envelope": {
          "xml": {
            "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
            "prefix": "soapenv"
          },
          "type": "object",
          "properties": {
            "Body": {
              "xml": {
                "namespace": "http://schemas.xmlsoap.org/soap/envelope/",
                "prefix": "soapenv"
              },
              "type": "object",
              "properties": {
                "paSendRTRes": {
                  "$ref": "#/definitions/paSendRTRes_element_pafn"
                }
              }
            }
          },
          "required": [
            "Body"
          ]
        }
      },
      "required": [
        "Envelope"
      ],
      "x-ibm-schema": {
        "wsdl-port": "{http://pagopa-api.pagopa.gov.it/pa/paForNode.wsdl}paForNode_Port",
        "wsdl-operation": "paSendRTReq",
        "wsdl-message-direction-or-name": "paSendRTReqResponse"
      },
      "example": "\n<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n <soapenv:Body>\n  <pafn:paSendRTRes xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n   <outcome><!-- mandatory -->string</outcome>\n   <fault>\n    <faultCode><!-- mandatory -->string</faultCode>\n    <faultString><!-- mandatory -->string</faultString>\n    <id><!-- mandatory -->string</id>\n    <description>string</description>\n    <serial>3</serial>\n    <originalFaultCode>string</originalFaultCode>\n    <originalFaultString>string</originalFaultString>\n    <originalDescription>string</originalDescription>\n   </fault>\n  </pafn:paSendRTRes>\n </soapenv:Body>\n</soapenv:Envelope>"
    },
    "paVerifyPaymentNoticeReq_element_pafn": {
      "xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn",
        "name": "paVerifyPaymentNoticeReq"
      },
      "description": "The `paVerifyPaymentNotice` request contains :\n- `idPA` : alphanumeric field containing the tax code of the structure sending the payment request.\n- `idBrokerPA` : identification of subject that operates as an intermediary for the PA.\n- `idStation` : identification of the station of the PA into pagoPa system.\n- `qrCode` : is the union of `fiscalCode` and `noticeNumber`",
      "type": "object",
      "properties": {
        "idPA": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "idBrokerPA": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "idStation": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "qrCode": {
          "$ref": "#/definitions/ctQrCode_type_pafn"
        }
      },
      "required": [
        "idPA",
        "idBrokerPA",
        "idStation",
        "qrCode"
      ],
      "example": "\n<pafn:paVerifyPaymentNoticeReq xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n <idPA><!-- mandatory -->string</idPA>\n <idBrokerPA><!-- mandatory -->string</idBrokerPA>\n <idStation><!-- mandatory -->string</idStation>\n <qrCode><!-- mandatory -->\n  <fiscalCode><!-- mandatory -->string</fiscalCode>\n  <noticeNumber><!-- mandatory -->string</noticeNumber>\n </qrCode>\n</pafn:paVerifyPaymentNoticeReq>"
    },
    "paVerifyPaymentNoticeRes_element_pafn": {
      "xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn",
        "name": "paVerifyPaymentNoticeRes"
      },
      "description": "Its a response to `paVerifyPaymentNoticeReq` and contains :\n\n- `outcome` and _optional_ `fault` (_see below to details_)\n- `paymentList` : the list of all available payment options (_see below to details_)\n- `paymentDescription` : \n\nIf the Public Administration is configured as _OLD_ (i.e. still uses the old primitives) this field must be set with the data `nodeTipoDatiPagamentoPA` of the` nodeVerificaRPTRanspond` specifically:\n- `causaleVersamento`: represents the extended description of the reason for the payment, or\n- `spezzoniCausaleVersamento`: structure available to Public Administration to specify the payment reasons.\n\nThe size of the current field is such as to allow the concatenation of the old information previously described.\n\n- `fiscalCodePA` : Tax code of the public administration\n- `companyName` : Public Administration full name\n- `officeName` : Public Administration Department Name",
      "allOf": [
        {
          "$ref": "#/definitions/ctResponse_type_pafn"
        },
        {
          "type": "object",
          "properties": {
            "paymentList": {
              "$ref": "#/definitions/ctPaymentOptionsDescriptionListPA_type_pafn"
            },
            "paymentDescription": {
              "$ref": "#/definitions/stText140_type_pafn"
            },
            "fiscalCodePA": {
              "$ref": "#/definitions/stFiscalCodePA_type_pafn"
            },
            "companyName": {
              "$ref": "#/definitions/stText140_type_pafn"
            },
            "officeName": {
              "$ref": "#/definitions/stText140_type_pafn"
            }
          }
        }
      ],
      "example": "\n<pafn:paVerifyPaymentNoticeRes xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n <outcome><!-- mandatory -->string</outcome>\n <fault>\n  <faultCode><!-- mandatory -->string</faultCode>\n  <faultString><!-- mandatory -->string</faultString>\n  <id><!-- mandatory -->string</id>\n  <description>string</description>\n  <serial>3</serial>\n  <originalFaultCode>string</originalFaultCode>\n  <originalFaultString>string</originalFaultString>\n  <originalDescription>string</originalDescription>\n </fault>\n <paymentList>\n  <paymentOptionDescription><!-- mandatory --><!-- between 1 and 5 repetitions of this element -->\n   <amount><!-- mandatory -->999999996.99</amount>\n   <options><!-- mandatory -->string</options>\n   <dueDate>2016-04-18</dueDate>\n   <detailDescription>string</detailDescription>\n   <transferType>string</transferType>\n  </paymentOptionDescription>\n </paymentList>\n <paymentDescription>string</paymentDescription>\n <fiscalCodePA>string</fiscalCodePA>\n <companyName>string</companyName>\n <officeName>string</officeName>\n</pafn:paVerifyPaymentNoticeRes>"
    },
    "paGetPaymentReq_element_pafn": {
      "xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn",
        "name": "paGetPaymentReq"
      },
      "description": "The `paVerifyPaymentNotice` request contains :\n- `idPA` : alphanumeric field containing the tax code of the structure sending the payment request.\n- `idBrokerPA` : identification of subject that operates as an intermediary for the PA.\n- `idStation` : identification of the station of the PA into pagoPa system.\n- `qrCode` : is the union of `fiscalCode` and `noticeNumber`\n- `amount` : amount of the payment\n- `paymentNote` : details description of the payment\n- `transferType` : _specific only for POSTE Italiane_\n- `dueDate` : indicates the expiration payment date according to the ISO 8601 format `[YYYY]-[MM]-[DD]`.",
      "type": "object",
      "properties": {
        "idPA": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "idBrokerPA": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "idStation": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "qrCode": {
          "$ref": "#/definitions/ctQrCode_type_pafn"
        },
        "amount": {
          "$ref": "#/definitions/stAmount_type_pafn"
        },
        "paymentNote": {
          "$ref": "#/definitions/stText210_type_pafn"
        },
        "transferType": {
          "$ref": "#/definitions/stTransferType_type_pafn"
        },
        "dueDate": {
          "$ref": "#/definitions/stISODate_type_pafn"
        }
      },
      "required": [
        "idPA",
        "idBrokerPA",
        "idStation",
        "qrCode"
      ],
      "example": "\n<pafn:paGetPaymentReq xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n <idPA><!-- mandatory -->string</idPA>\n <idBrokerPA><!-- mandatory -->string</idBrokerPA>\n <idStation><!-- mandatory -->string</idStation>\n <qrCode><!-- mandatory -->\n  <fiscalCode><!-- mandatory -->string</fiscalCode>\n  <noticeNumber><!-- mandatory -->string</noticeNumber>\n </qrCode>\n <amount>999999996.99</amount>\n <paymentNote>string</paymentNote>\n <transferType>string</transferType>\n <dueDate>2016-04-18</dueDate>\n</pafn:paGetPaymentReq>"
    },
    "paGetPaymentRes_element_pafn": {
      "xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn",
        "name": "paGetPaymentRes"
      },
      "description": "Its a response to `paGetPaymentReq` and contains :\n\n- `outcome` and _optional_ `fault` (_see below to details_)\n- all `data` related to payment (_see below to details_)",
      "allOf": [
        {
          "$ref": "#/definitions/ctResponse_type_pafn"
        },
        {
          "type": "object",
          "properties": {
            "data": {
              "$ref": "#/definitions/ctPaymentPA_type_pafn"
            }
          }
        }
      ],
      "example": "\n<pafn:paGetPaymentRes xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n <outcome><!-- mandatory -->string</outcome>\n <fault>\n  <faultCode><!-- mandatory -->string</faultCode>\n  <faultString><!-- mandatory -->string</faultString>\n  <id><!-- mandatory -->string</id>\n  <description>string</description>\n  <serial>3</serial>\n  <originalFaultCode>string</originalFaultCode>\n  <originalFaultString>string</originalFaultString>\n  <originalDescription>string</originalDescription>\n </fault>\n <data>\n  <creditorReferenceId><!-- mandatory -->string</creditorReferenceId>\n  <paymentAmount><!-- mandatory -->999999996.99</paymentAmount>\n  <dueDate><!-- mandatory -->2016-04-18</dueDate>\n  <retentionDate>2016-04-18T14:07:37</retentionDate>\n  <lastPayment>true</lastPayment>\n  <description><!-- mandatory -->string</description>\n  <companyName>string</companyName>\n  <officeName>string</officeName>\n  <debtor><!-- mandatory -->\n   <uniqueIdentifier><!-- mandatory -->\n    <entityUniqueIdentifierType><!-- mandatory -->string</entityUniqueIdentifierType>\n    <entityUniqueIdentifierValue><!-- mandatory -->string</entityUniqueIdentifierValue>\n   </uniqueIdentifier>\n   <fullName><!-- mandatory -->string</fullName>\n   <streetName>string</streetName>\n   <civicNumber>string</civicNumber>\n   <postalCode>string</postalCode>\n   <city>string</city>\n   <stateProvinceRegion>string</stateProvinceRegion>\n   <country>string</country>\n   <e-mail>string</e-mail>\n  </debtor>\n  <transferList><!-- mandatory -->\n   <transfer><!-- mandatory --><!-- between 1 and 5 repetitions of this element -->\n    <idTransfer><!-- mandatory -->3</idTransfer>\n    <transferAmount><!-- mandatory -->999999996.99</transferAmount>\n    <fiscalCodePA><!-- mandatory -->string</fiscalCodePA>\n    <IBAN><!-- mandatory -->string</IBAN>\n    <remittanceInformation><!-- mandatory -->string</remittanceInformation>\n    <transferCategory><!-- mandatory -->string</transferCategory>\n   </transfer>\n  </transferList>\n  <metadata>\n   <mapEntry><!-- mandatory --><!-- between 1 and 10 repetitions of this element -->\n    <key><!-- mandatory -->string</key>\n    <value><!-- mandatory -->string</value>\n   </mapEntry>\n  </metadata>\n </data>\n</pafn:paGetPaymentRes>"
    },
    "paSendRTReq_element_pafn": {
      "xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn",
        "name": "paSendRTReq"
      },
      "description": "The `paSendRT` request contains :\n- `idPA` : alphanumeric field containing the tax code of the structure sending the payment request.\n- `idBrokerPA` : identification of subject that operates as an intermediary for the PA.\n- `idStation` : identification of the station of the PA into pagoPa system.\n- `receipt` : the payment receipt (_see below to details_)",
      "type": "object",
      "properties": {
        "idPA": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "idBrokerPA": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "idStation": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "receipt": {
          "$ref": "#/definitions/ctReceipt_type_pafn"
        }
      },
      "required": [
        "idPA",
        "idBrokerPA",
        "idStation",
        "receipt"
      ],
      "example": "\n<pafn:paSendRTReq xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n <idPA><!-- mandatory -->string</idPA>\n <idBrokerPA><!-- mandatory -->string</idBrokerPA>\n <idStation><!-- mandatory -->string</idStation>\n <receipt><!-- mandatory -->\n  <receiptId><!-- mandatory -->string</receiptId>\n  <noticeNumber><!-- mandatory -->string</noticeNumber>\n  <fiscalCode><!-- mandatory -->string</fiscalCode>\n  <outcome><!-- mandatory -->string</outcome>\n  <creditorReferenceId><!-- mandatory -->string</creditorReferenceId>\n  <paymentAmount><!-- mandatory -->999999996.99</paymentAmount>\n  <description><!-- mandatory -->string</description>\n  <companyName><!-- mandatory -->string</companyName>\n  <officeName>string</officeName>\n  <debtor><!-- mandatory -->\n   <uniqueIdentifier><!-- mandatory -->\n    <entityUniqueIdentifierType><!-- mandatory -->string</entityUniqueIdentifierType>\n    <entityUniqueIdentifierValue><!-- mandatory -->string</entityUniqueIdentifierValue>\n   </uniqueIdentifier>\n   <fullName><!-- mandatory -->string</fullName>\n   <streetName>string</streetName>\n   <civicNumber>string</civicNumber>\n   <postalCode>string</postalCode>\n   <city>string</city>\n   <stateProvinceRegion>string</stateProvinceRegion>\n   <country>string</country>\n   <e-mail>string</e-mail>\n  </debtor>\n  <transferList><!-- mandatory -->\n   <transfer><!-- mandatory --><!-- between 1 and 5 repetitions of this element -->\n    <idTransfer><!-- mandatory -->3</idTransfer>\n    <transferAmount><!-- mandatory -->999999996.99</transferAmount>\n    <fiscalCodePA><!-- mandatory -->string</fiscalCodePA>\n    <IBAN><!-- mandatory -->string</IBAN>\n    <remittanceInformation><!-- mandatory -->string</remittanceInformation>\n    <transferCategory><!-- mandatory -->string</transferCategory>\n   </transfer>\n  </transferList>\n  <idPSP><!-- mandatory -->string</idPSP>\n  <pspFiscalCode>string</pspFiscalCode>\n  <pspPartitaIVA>string</pspPartitaIVA>\n  <PSPCompanyName><!-- mandatory -->string</PSPCompanyName>\n  <idChannel><!-- mandatory -->string</idChannel>\n  <channelDescription><!-- mandatory -->string</channelDescription>\n  <payer>\n   <uniqueIdentifier><!-- mandatory -->\n    <entityUniqueIdentifierType><!-- mandatory -->string</entityUniqueIdentifierType>\n    <entityUniqueIdentifierValue><!-- mandatory -->string</entityUniqueIdentifierValue>\n   </uniqueIdentifier>\n   <fullName><!-- mandatory -->string</fullName>\n   <streetName>string</streetName>\n   <civicNumber>string</civicNumber>\n   <postalCode>string</postalCode>\n   <city>string</city>\n   <stateProvinceRegion>string</stateProvinceRegion>\n   <country>string</country>\n   <e-mail>string</e-mail>\n  </payer>\n  <paymentMethod>string</paymentMethod>\n  <fee>999999996.99</fee>\n  <paymentDateTime>2016-04-18T14:07:37</paymentDateTime>\n  <applicationDate>2016-04-18</applicationDate>\n  <transferDate>2016-04-18</transferDate>\n  <metadata>\n   <mapEntry><!-- mandatory --><!-- between 1 and 10 repetitions of this element -->\n    <key><!-- mandatory -->string</key>\n    <value><!-- mandatory -->string</value>\n   </mapEntry>\n  </metadata>\n </receipt>\n</pafn:paSendRTReq>"
    },
    "paSendRTRes_element_pafn": {
      "xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn",
        "name": "paSendRTRes"
      },
      "description": "Its a response to `paSendRTReq` and contains :\n\n- `outcome` and _optional_ `fault` (_see below to details_)",
      "allOf": [
        {
          "$ref": "#/definitions/ctResponse_type_pafn"
        },
        {
          "type": "object",
          "properties": {}
        }
      ],
      "example": "\n<pafn:paSendRTRes xmlns:pafn=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\">\n <outcome><!-- mandatory -->string</outcome>\n <fault>\n  <faultCode><!-- mandatory -->string</faultCode>\n  <faultString><!-- mandatory -->string</faultString>\n  <id><!-- mandatory -->string</id>\n  <description>string</description>\n  <serial>3</serial>\n  <originalFaultCode>string</originalFaultCode>\n  <originalFaultString>string</originalFaultString>\n  <originalDescription>string</originalDescription>\n </fault>\n</pafn:paSendRTRes>"
    },
    "stText35_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "minLength": 1,
      "maxLength": 35,
      "x-xsi-type": "stText35",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stText35_type_pafn"
    },
    "ctQrCode_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "Payment Notice **QR-CODE** data.\nQR-CODE is ISO/IEC 18004:2015 compliant generated with:\n\nParameters for generating the QR-CODE\n\n- Symbol Version : 4\n- Modules : 33x33\n- Modules width : 3 pixels\n- ECC Level: M ( max correction error 15%)\n- Character set : UTF-8\n\nQR-CODE contains a string formatted as :\n`PAGOPA|002|noticeNumber|fiscalCode|amount`\n\nWhere `noticeNumber` is composed by :\n\n`[auxDigit][segregationCode][IUVBase][IUVCheckDigit]`\n\nWhile `fiscalCode` is the creditor tax code.",
      "type": "object",
      "properties": {
        "fiscalCode": {
          "$ref": "#/definitions/stFiscalCodePA_type_pafn"
        },
        "noticeNumber": {
          "$ref": "#/definitions/stNoticeNumber_type_pafn"
        }
      },
      "required": [
        "fiscalCode",
        "noticeNumber"
      ],
      "x-xsi-type": "ctQrCode",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctQrCode_type_pafn"
    },
    "ctPaymentOptionsDescriptionListPA_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "Structure containing the details of possible payments relating to the debt position to be paid.\n\nCurrently set at 5 eligible payments per single position.\n\nWhere each `paymentOptionDescription` items contains :\n\n- `amount` : payment amount\n- `options` : indicates the payment criteria accepted by the institution with respect to the amount, or if it accepts for this payment option other than `amount`.\n- `dueDate` : indicates the expiration payment date according to the ISO 8601 format `[YYYY]-[MM]-[DD]`.\n- `detailDescription` : Free text available to describe the payment reasons\n- `transferType` : _specific only for POSTE Italiane_",
      "type": "object",
      "properties": {
        "paymentOptionDescription": {
          "type": "array",
          "minItems": 1,
          "maxItems": 5,
          "items": {
            "$ref": "#/definitions/ctPaymentOptionDescriptionPA_type_pafn"
          }
        }
      },
      "required": [
        "paymentOptionDescription"
      ],
      "x-xsi-type": "ctPaymentOptionsDescriptionListPA",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctPaymentOptionsDescriptionListPA_type_pafn"
    },
    "stText140_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "minLength": 1,
      "maxLength": 140,
      "x-xsi-type": "stText140",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stText140_type_pafn"
    },
    "stFiscalCodePA_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "Tax code of the public administration to which the payment notification is made out",
      "type": "string",
      "pattern": "[0-9]{11}",
      "minLength": 11,
      "maxLength": 11,
      "x-xsi-type": "stFiscalCodePA",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stFiscalCodePA_type_pafn"
    },
    "stAmount_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "Amount of payment in euro",
      "type": "number",
      "maximum": 999999999.99,
      "pattern": "\\d+\\.\\d{2}",
      "x-xsi-type": "stAmount",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stAmount_type_pafn"
    },
    "stText210_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "minLength": 1,
      "maxLength": 210,
      "x-xsi-type": "stText210",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stText210_type_pafn"
    },
    "stTransferType_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "enum": [
        "POSTAL"
      ],
      "x-xsi-type": "stTransferType",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stTransferType_type_pafn"
    },
    "stISODate_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "format": "date",
      "x-xsi-type": "stISODate",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stISODate_type_pafn"
    },
    "ctPaymentPA_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "Its contains all payment information :\n\n- `creditorReferenceId` : its equal to **IUV** _Identificativo Univoco Versamento_ \n- `paymentAmount` : amount, it must be equal to the sums of `transferAmount` present in the `transferList`\n- `dueDate` : indicates the expiration payment date according to the ISO 8601 format `[YYYY]-[MM]-[DD]`.\n- `retentionDate` : indicates the retention payment date according to the ISO 8601 format `[YYYY]-[MM]-[DD]`.\n- `lastPayment` : boolean flag used for in installment payments \n- `description` : free text available to describe the payment reasons\n- `companyName` : Public Administration full name\n- `officeName` : Public Admninistration Department Name\n- `debtor` : identifies the debtor to whom the debt position refers\n- `transferList` : the list of all available transfer information (_see below to details_)\n- `metadata` : (_see below to details_)",
      "type": "object",
      "properties": {
        "creditorReferenceId": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "paymentAmount": {
          "$ref": "#/definitions/stAmountNotZero_type_pafn"
        },
        "dueDate": {
          "$ref": "#/definitions/stISODate_type_pafn"
        },
        "retentionDate": {
          "xml": {
            "namespace": ""
          },
          "type": "string",
          "format": "date-time"
        },
        "lastPayment": {
          "xml": {
            "namespace": ""
          },
          "type": "boolean"
        },
        "description": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "companyName": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "officeName": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "debtor": {
          "$ref": "#/definitions/ctSubject_type_pafn"
        },
        "transferList": {
          "$ref": "#/definitions/ctTransferListPA_type_pafn"
        },
        "metadata": {
          "$ref": "#/definitions/ctMetadata_type_pafn"
        }
      },
      "required": [
        "creditorReferenceId",
        "paymentAmount",
        "dueDate",
        "description",
        "debtor",
        "transferList"
      ],
      "x-xsi-type": "ctPaymentPA",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctPaymentPA_type_pafn"
    },
    "ctReceipt_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "Its contains all receipt information :\n\n**identifier section**\n- `outcome` : result of receipt **OK** / **KO**\n- `receiptId` : unique identifier of receipt (assigned by pagoPa) it contains `paymentToken` present in to `activatePaymentNotice` response \n- `noticeNumber` : notice number\n- `fiscalCode` : Tax code of the public administration\n\n**PA data**\n- `creditorReferenceId` : **IUV** _Identificativo Univoco Versamento_\n- `paymentAmount` : amount\n- `description` : \n- `companyName` : Public Administration full name\n- `officeName` Public Administration Department Name\n- `debtor` : debtor subject identifier\n- `transferList` : the list of transfers\n- `metadata` : info received in to `paGetPaymentRes`\n\n**PSP data**\n- `idPSP` : PSP Identifier, it has been assigned from pagoPA.\n- `pspFiscalCode` : PSP' fiscal code\n- `pspPartitaIVA` : PSP' _Partita IVA_\n- `PSPCompanyName` : PSP full name\n- `idChannel` : Channel Identifier, it identifies a payment service category and through which the transaction is carried out.\n- `channelDescription` : Channel Identifier description\n- `payer` : who made the payment\n- `paymentMethod` : Method of the payment , i.e. `cash`, `creditCard`, `bancomat` or `other`\n- `fee` : PSP's fee applied\n- `paymentDateTime` : payment execution date by the user\n- `applicationDate` : application date, payment date on the PSP side\n- `transferDate` : transfer date",
      "type": "object",
      "properties": {
        "receiptId": {
          "xml": {
            "namespace": ""
          },
          "type": "string"
        },
        "noticeNumber": {
          "$ref": "#/definitions/stNoticeNumber_type_pafn"
        },
        "fiscalCode": {
          "$ref": "#/definitions/stFiscalCodePA_type_pafn"
        },
        "outcome": {
          "$ref": "#/definitions/stOutcome_type_pafn"
        },
        "creditorReferenceId": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "paymentAmount": {
          "$ref": "#/definitions/stAmount_type_pafn"
        },
        "description": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "companyName": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "officeName": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "debtor": {
          "$ref": "#/definitions/ctSubject_type_pafn"
        },
        "transferList": {
          "$ref": "#/definitions/ctTransferListPA_type_pafn"
        },
        "idPSP": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "pspFiscalCode": {
          "$ref": "#/definitions/stText70_type_pafn"
        },
        "pspPartitaIVA": {
          "$ref": "#/definitions/stText20_type_pafn"
        },
        "PSPCompanyName": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "idChannel": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "channelDescription": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "payer": {
          "$ref": "#/definitions/ctSubject_type_pafn"
        },
        "paymentMethod": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "fee": {
          "$ref": "#/definitions/stAmount_type_pafn"
        },
        "paymentDateTime": {
          "$ref": "#/definitions/stISODateTime_type_pafn"
        },
        "applicationDate": {
          "$ref": "#/definitions/stISODate_type_pafn"
        },
        "transferDate": {
          "$ref": "#/definitions/stISODate_type_pafn"
        },
        "metadata": {
          "$ref": "#/definitions/ctMetadata_type_pafn"
        }
      },
      "required": [
        "receiptId",
        "noticeNumber",
        "fiscalCode",
        "outcome",
        "creditorReferenceId",
        "paymentAmount",
        "description",
        "companyName",
        "debtor",
        "transferList",
        "idPSP",
        "PSPCompanyName",
        "idChannel",
        "channelDescription"
      ],
      "x-xsi-type": "ctReceipt",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctReceipt_type_pafn"
    },
    "stOutcome_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "The outcome of the operation may contain the following result string code: \n\n- **OK** : operation performed successfully\n- **KO** : operation terminated with error",
      "type": "string",
      "enum": [
        "OK",
        "KO"
      ],
      "x-xsi-type": "stOutcome",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stOutcome_type_pafn"
    },
    "ctFaultBean_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "- `id` : Subject issuing the error.\nAllowed values \u000b\u000bare : \n  - `NodoDeiPagamentiSPC` : constant which identifies the NodoSPC\n  - `[domain identifier]` : domain id of the creditor entity issuing the fault\n  - `[PSP identifier]` : PSP identifier issuing the fault\n\n- `faultCode` : error code (see `stFaultCode` to details)\n\n- `faultString` : Specification of the error code, specific to the subject issuing it. Contains a more talking description relating to the `faultCode`.\n\n- `description` : Additional description of the error set by the NodoSPC, by the creditor or PSP.\n\n- `serial` : Position of the element in the referenced list. Useful when providing a parameter in the form of a vector (for example, in the primitive `SendCarrelloRPT` node).\nIf the error is generated by the EC or by the PSP, the data reported is the value of the `faultBean.serial` data set by the EC or by the PSP.\n\n- `originalFaultCode` : Error code generated by the counterpart. (_Set only it isn't generated by NodoSPC._)\n\n- `originalFaultString` : Specification of the error code generated by the counterpart. (_Set only it isn't generated by NodoSPC._)\n\n- `originalDescription` : Additional description of the error generated by the counterparty. (_Set only it isn't generated by NodoSPC._)",
      "type": "object",
      "properties": {
        "faultCode": {
          "$ref": "#/definitions/stFaultCode_type_pafn"
        },
        "faultString": {
          "xml": {
            "namespace": ""
          },
          "type": "string"
        },
        "id": {
          "xml": {
            "namespace": ""
          },
          "type": "string"
        },
        "description": {
          "xml": {
            "namespace": ""
          },
          "type": "string"
        },
        "serial": {
          "xml": {
            "namespace": ""
          },
          "type": "integer",
          "format": "int32"
        },
        "originalFaultCode": {
          "xml": {
            "namespace": ""
          },
          "type": "string"
        },
        "originalFaultString": {
          "xml": {
            "namespace": ""
          },
          "type": "string"
        },
        "originalDescription": {
          "xml": {
            "namespace": ""
          },
          "type": "string"
        }
      },
      "required": [
        "faultCode",
        "faultString",
        "id"
      ],
      "x-xsi-type": "ctFaultBean",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctFaultBean_type_pafn"
    },
    "stNoticeNumber_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "`noticeNumber` is composed by :\n\n`[auxDigit][segregationCode][IUVBase][IUVCheckDigit]`",
      "type": "string",
      "pattern": "[0-9]{18}",
      "x-xsi-type": "stNoticeNumber",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stNoticeNumber_type_pafn"
    },
    "ctPaymentOptionDescriptionPA_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "type": "object",
      "properties": {
        "amount": {
          "$ref": "#/definitions/stAmount_type_pafn"
        },
        "options": {
          "$ref": "#/definitions/stAmountOption_type_pafn"
        },
        "dueDate": {
          "$ref": "#/definitions/stISODate_type_pafn"
        },
        "detailDescription": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "transferType": {
          "$ref": "#/definitions/stTransferType_type_pafn"
        }
      },
      "required": [
        "amount",
        "options"
      ],
      "x-xsi-type": "ctPaymentOptionDescriptionPA",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctPaymentOptionDescriptionPA_type_pafn"
    },
    "stAmountNotZero_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "Amount of payment in euro (_it doesn't admit values \u000b\u000bequal to 0_)",
      "type": "number",
      "minimum": 0.01,
      "maximum": 999999999.99,
      "pattern": "\\d+\\.\\d{2}",
      "x-xsi-type": "stAmountNotZero",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stAmountNotZero_type_pafn"
    },
    "ctSubject_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "Contains all data for the subject of payment :\n\n- `uniqueIdentifier` : (_see below to details_)\n- `fullName` : name of the subject\n- `streetName` : street name\n- `civicNumber` : building number\n- `postalCode` : postal code\n- `city` : town name\n- `stateProvinceRegion` : country subdivision\n- `country` : country name\n- `e-mail` : remittance location electronic address",
      "type": "object",
      "properties": {
        "uniqueIdentifier": {
          "$ref": "#/definitions/ctEntityUniqueIdentifier_type_pafn"
        },
        "fullName": {
          "$ref": "#/definitions/stText70_type_pafn"
        },
        "streetName": {
          "$ref": "#/definitions/stText70_type_pafn"
        },
        "civicNumber": {
          "$ref": "#/definitions/stText16_type_pafn"
        },
        "postalCode": {
          "$ref": "#/definitions/stText16_type_pafn"
        },
        "city": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "stateProvinceRegion": {
          "$ref": "#/definitions/stText35_type_pafn"
        },
        "country": {
          "$ref": "#/definitions/stNazioneProvincia_type_pafn"
        },
        "e-mail": {
          "$ref": "#/definitions/stEMail_type_pafn"
        }
      },
      "required": [
        "uniqueIdentifier",
        "fullName"
      ],
      "x-xsi-type": "ctSubject",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctSubject_type_pafn"
    },
    "ctTransferListPA_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "Structure containing the details of possible tranfer payments.\n\nCurrently set at 5 eligible payments per single position.\n\nWhere each `transfer` items contains :\n\n- `idTransfer` : index of the list (from `1` to `5`) \n- `transferAmount` : amount \n- `fiscalCodePA` : Tax code of the public administration\n- `IBAN` : contains the IBAN of the account to be credited\n- `remittanceInformation` : reason for payment (_alias_ `causaleVersamento`)\n- `transferCategory` : contains the union of **CODICE TIPOLOGIA SERVIZIO** following by ***TIPO SERVIZIO* as define in [Tassonomia dei servizi](https://drive.google.com/file/d/13xOd__Qd4pwKHr3wjE-73NAB2O7UKmIt/view)",
      "type": "object",
      "properties": {
        "transfer": {
          "type": "array",
          "minItems": 1,
          "maxItems": 5,
          "items": {
            "$ref": "#/definitions/ctTransferPA_type_pafn"
          }
        }
      },
      "required": [
        "transfer"
      ],
      "x-xsi-type": "ctTransferListPA",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctTransferListPA_type_pafn"
    },
    "ctMetadata_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "description": "Its a _key/value_ store fields for the exclusive use of the PA. \nThe data will return in the receipt (`paSendRT`)",
      "type": "object",
      "properties": {
        "mapEntry": {
          "type": "array",
          "minItems": 1,
          "maxItems": 10,
          "items": {
            "$ref": "#/definitions/ctMapEntry_type_pafn"
          }
        }
      },
      "required": [
        "mapEntry"
      ],
      "x-xsi-type": "ctMetadata",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctMetadata_type_pafn"
    },
    "stText70_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "minLength": 1,
      "maxLength": 70,
      "x-xsi-type": "stText70",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stText70_type_pafn"
    },
    "stText20_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "minLength": 1,
      "maxLength": 20,
      "x-xsi-type": "stText20",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stText20_type_pafn"
    },
    "stISODateTime_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "format": "date-time",
      "x-xsi-type": "stISODateTime",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stISODateTime_type_pafn"
    },
    "stFaultCode_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "### Generic Errors\n\n**PPT_SINTASSI_EXTRAXSD** : _Generic error related to any WSDL/XSD syntax error. It can be returned from any message_\n\n**PPT_STAZIONE_INT_PA_ERRORE_RESPONSE** : _Generic error related to any PA error. It can be returned from verifyPaymentNotice and ActivatePaymentNotice messages_\n\n**PPT_STAZIONE_INT_PA_DISABILITATA** : _PA configuration error. It can be returned from VerifyPaymentNotice and ActivatePaymentNotice messages_\n\n**PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE** : _PA configuration error. It can be returned from VerifyPaymentNotice and ActivatePaymentNotice messages_\n\n**PPT_INTERMEDIARIO_PA_DISABILITATO** : _PA configuration error. It can be returned from VerifyPaymentNotice and ActivatePaymentNotice messages_\n\n**PPT_STAZIONE_INT_PA_TIMEOUT** : _PA information is not available, the operation can not be authorized. It can be returned from VerifyPaymentNotice and ActivatePaymentNotice messages_\n \n### Authentication Errors\n\n**PPT_PSP_SCONOSCIUTO** : _Authentication Error. It can be returned from any messages_\n\n**PPT_PSP_DISABILITATO** : _Authentication Error. It can be returned from any messages_\n\n**PPT_INTERMEDIARIO_PSP_SCONOSCIUTO** : _Authentication Error. It can be returned from any messages_\n\n**PPT_INTERMEDIARIO_PSP_DISABILITATO** : _Authentication Error. It can be returned from any messages_\n\n**PPT_CANALE_SCONOSCIUTO** : _Authentication Error. It can be returned from any messages_\n\n**PPT_CANALE_DISABILITATO** : _Authentication Error. It can be returned from any messages_\n\n**PPT_AUTORIZZAZIONE** : _Authentication Error. It can be returned from any messages_\n\n### Request Errors\n\n**PPT_DOMINIO_SCONOSCIUTO** : _Request Error. Unknown PA fiscal code. It can be returned from VerifyPaymentNotice and ActivatePaymentNotice messages_\n\n**PPT_DOMINIO_DISABILITATO** : _Request Error. Unknown PA fiscal code. It can be returned from VerifyPaymentNotice and ActivatePaymentNotice messages_\n\n**PPT_INT_PA_SCONOSCIUTA** :  _Notice Number Error. It can be returned from VerifyPaymentNotice messages_\n\n### Business Errors\n\n**PPT_ERRORE_EMESSO_DA_PAA** : _Operation not authorized. It can be returned from VerifyPaymentNotice and ActivatePaymentNotice messages_\n\n**PPT_SEMANTICA** : _Idempotency key expired. It can be returned from  ActivatePaymentNotice messages; The same fault code can be related to an integration error._\n\n**PPT_PAGAMENTO_IN_CORSO** : _Payment in process, the operation can not be authorized. It can be returned from  ActivatePaymentNotice messages:\n\n**PPT_TOKEN_SCONOSCIUTO** : _Unknown Payment Token, the operation can not be authorized. It can be returned from  SendPaymentOutcome messages_\n\n**PPT_ESITO_GIA_ACQUISITO** : _Idempotency Error, the same request has been already processed with different params. It can be returned from  SendPaymentOutcome messages_\n\n**PPT_TOKEN_SCADUTO** : _Expired payment token, the position debt is still payable. The operation can not be authorized. It can be returned from  SendPaymentOutcome messages_\n\n**PPT_PAGAMENTO_DUPLICATO** : _Expired payment token, the position debt has benn already payed. The operation can not be authorized. It can be returned from  SendPaymentOutcome messages_",
      "type": "string",
      "x-xsi-type": "stFaultCode",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stFaultCode_type_pafn"
    },
    "stAmountOption_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "Indicates the payment criteria accepted by public administration respect to the amount, i.e. if it accepts an `amount` for this payment option\n\n- equals `EQ`\n- less `LT`\n- greater `GT`\n- any `ANY`\n\nthan indicated.",
      "type": "string",
      "enum": [
        "EQ",
        "LS",
        "GT",
        "ANY"
      ],
      "x-xsi-type": "stAmountOption",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stAmountOption_type_pafn"
    },
    "ctEntityUniqueIdentifier_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "type": "object",
      "properties": {
        "entityUniqueIdentifierType": {
          "$ref": "#/definitions/stEntityUniqueIdentifierType_type_pafn"
        },
        "entityUniqueIdentifierValue": {
          "$ref": "#/definitions/stEntityUniqueIdentifierValue_type_pafn"
        }
      },
      "required": [
        "entityUniqueIdentifierType",
        "entityUniqueIdentifierValue"
      ],
      "x-xsi-type": "ctEntityUniqueIdentifier",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctEntityUniqueIdentifier_type_pafn"
    },
    "stText16_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "minLength": 1,
      "maxLength": 16,
      "x-xsi-type": "stText16",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stText16_type_pafn"
    },
    "stNazioneProvincia_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "pattern": "[A-Z]{2,2}",
      "x-xsi-type": "stNazioneProvincia",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stNazioneProvincia_type_pafn"
    },
    "stEMail_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "pattern": "[a-zA-Z0-9_\\.\\+\\-]+@[a-zA-Z0-9\\-]+(\\.[a-zA-Z0-9\\-]+)*",
      "maxLength": 256,
      "x-xsi-type": "stEMail",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stEMail_type_pafn"
    },
    "ctTransferPA_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "type": "object",
      "properties": {
        "idTransfer": {
          "$ref": "#/definitions/stIdTransfer_type_pafn"
        },
        "transferAmount": {
          "$ref": "#/definitions/stAmountNotZero_type_pafn"
        },
        "fiscalCodePA": {
          "$ref": "#/definitions/stFiscalCodePA_type_pafn"
        },
        "IBAN": {
          "$ref": "#/definitions/stIBAN_type_pafn"
        },
        "remittanceInformation": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "transferCategory": {
          "$ref": "#/definitions/stText140_type_pafn"
        }
      },
      "required": [
        "idTransfer",
        "transferAmount",
        "fiscalCodePA",
        "IBAN",
        "remittanceInformation",
        "transferCategory"
      ],
      "x-xsi-type": "ctTransferPA",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctTransferPA_type_pafn"
    },
    "ctMapEntry_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "type": "object",
      "properties": {
        "key": {
          "$ref": "#/definitions/stText140_type_pafn"
        },
        "value": {
          "$ref": "#/definitions/stText140_type_pafn"
        }
      },
      "required": [
        "key",
        "value"
      ],
      "x-xsi-type": "ctMapEntry",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctMapEntry_type_pafn"
    },
    "stEntityUniqueIdentifierType_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "Alphanumeric field indicating the nature of the subject; it can assume the following values:\n\n- **F** : Natural person\n- **G** : Legal Person",
      "type": "string",
      "enum": [
        "F",
        "G"
      ],
      "minLength": 1,
      "maxLength": 1,
      "x-xsi-type": "stEntityUniqueIdentifierType",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stEntityUniqueIdentifierType_type_pafn"
    },
    "stEntityUniqueIdentifierValue_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "description": "Alphanumeric field that can contain the tax code or, alternatively, the VAT number of the payer.\n\nIn applicable cases, when it is not possible to identify for tax purposes the subject, the `ANONIMO` value can be used",
      "type": "string",
      "minLength": 2,
      "maxLength": 16,
      "x-xsi-type": "stEntityUniqueIdentifierValue",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stEntityUniqueIdentifierValue_type_pafn"
    },
    "stIdTransfer_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "integer",
      "format": "int32",
      "enum": [
        1,
        2,
        3,
        4,
        5
      ],
      "x-xsi-type": "stIdTransfer",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stIdTransfer_type_pafn"
    },
    "stIBAN_type_pafn": {
      "xml": {
        "namespace": ""
      },
      "type": "string",
      "minLength": 1,
      "maxLength": 35,
      "x-xsi-type": "stIBAN",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "stIBAN_type_pafn"
    },
    "ctResponse_type_pafn": {
      "xml": {
        "namespace": "",
        "prefix": ""
      },
      "type": "object",
      "properties": {
        "outcome": {
          "$ref": "#/definitions/stOutcome_type_pafn"
        },
        "fault": {
          "$ref": "#/definitions/ctFaultBean_type_pafn"
        }
      },
      "required": [
        "outcome"
      ],
      "x-ibm-discriminator": true,
      "x-xsi-type": "ctResponse",
      "x-xsi-type-xml": {
        "namespace": "http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd",
        "prefix": "pafn"
      },
      "x-xsi-type-uniquename": "ctResponse_type_pafn"
    }
  }
}
