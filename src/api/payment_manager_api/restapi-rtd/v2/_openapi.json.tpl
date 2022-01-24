{
  "openapi": "3.0.1",
  "info": {
    "title": "Registro Transazioni Digitali",
    "description": "RESTful API provided by the \"Payment Manager\" system to the \"Registro Transazioni Digitali\" system",
    "version": "1.10.0"
  },
  "servers": [
    {
      "url": "/pp-restapi-rtd"
    }
  ],
  "tags": [
    {
      "name": "np-wallets",
      "description": "Sub-collection of \"Natural Persons' Wallet\" resources"
    },
    {
      "name": "static-contents",
      "description": "Collection of \"Static Content\" resources"
    }
  ],
  "paths": {
    "/v2/wallets/np-wallets/get-wallets/{fiscalCode}": {
      "get": {
        "tags": [
          "np-wallets-v2"
        ],
        "summary": "Retrieves user's RTD instruments list",
        "operationId": "getUserRtdWallets",
        "parameters": [
          {
            "in": "path",
            "name": "fiscalCode",
            "description": "user's fiscal code",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "User's RTD wallets list",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/WalletNPResponse"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {}
          },
          "500": {
            "description": "Internal Server Error",
            "content": {}
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "CardType": {
        "type": "string",
        "enum": [
          "CRD",
          "DEB",
          "PP"
        ]
      },
      "WalletCardInfoInput": {
        "required": [
          "expireMonth",
          "expireYear",
          "pan",
          "type",
          "brand"
        ],
        "type": "object",
        "properties": {
          "pan": {
            "type": "string",
            "description": "encrypted with PGP"
          },
          "expireMonth": {
            "maxLength": 2,
            "minLength": 2,
            "type": "string",
            "example": "01"
          },
          "expireYear": {
            "maxLength": 4,
            "minLength": 4,
            "type": "string",
            "example": "2022"
          },
          "type": {
            "$ref": "#/components/schemas/CardType"
          },
          "holder": {
            "type": "string"
          },
          "brand": {
            "type": "string",
            "enum": [
              "VISA",
              "MASTERCARD",
              "MAESTRO",
              "VISA_ELECTRON",
              "AMEX",
              "OTHER"
            ]
          },
          "issuerAbiCode": {
            "maxLength": 5,
            "minLength": 5,
            "type": "string",
            "format": "ABI Code"
          },
          "par": {
            "type": "string",
            "description": "Payment Account Reference"
          },
          "tokensList": {
            "type": "string",
            "example": "token1;token2;token3",
            "description": "list of PGP-encrypted tokens joined with a ;"
          }
        }
      },
      "SecretKey": {
        "type": "object",
        "properties": {
          "algorithm": {
            "type": "string"
          },
          "format": {
            "type": "string"
          },
          "encoded": {
            "type": "string"
          },
          "destroyed": {
            "type": "string"
          }
        }
      },
      "WalletNPResponse": {
        "type": "object",
        "properties": {
          "taxCode": {
            "type": "string"
          },
          "channel": {
            "type": "string"
          },
          "walletType": {
            "$ref": "#/components/schemas/WalletType"
          },
          "info": {
            "type": "object",
            "oneOf": [
              {
                "$ref": "#/components/schemas/WalletCardInfoInput"
              },
              {
                "$ref": "#/components/schemas/WalletSatispayInfoInput"
              },
              {
                "$ref": "#/components/schemas/WalletBpayInfoInput"
              },
              {
                "$ref": "#/components/schemas/WalletGenericInfoInput"
              }
            ],
            "discriminator": {
              "propertyName": "walletType",
              "mapping": {
                "Card": "#/components/schemas/WalletCardInfoInput",
                "Bancomat": "#/components/schemas/WalletCardInfoInput",
                "Satispay": "#/components/schemas/WalletSatispayInfoInput",
                "BPay": "#/components/schemas/WalletBpayInfoInput",
                "Generic": "#/components/schemas/WalletGenericInfoInput"
              }
            }
          },
          "hsmEnabledHashEncryptionKey": {
            "type": "string"
          },
          "hsmDisabledEncryptionKey": {
            "$ref": "#/components/schemas/SecretKey"
          },
          "hashCode": {
            "type": "string"
          },
          "state": {
            "enum": [
              "0",
              "2"
            ]
          }
        }
      },
      "WalletSatispayInfoInput": {
        "required": [
          "id"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          }
        }
      },
      "WalletGenericInfoInput": {
        "required": [
          "id",
          "instrumentBrand",
          "description"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Instrument identifier encrypted with PGP"
          },
          "instrumentBrand": {
            "type": "string",
            "description": "Free string but to be agreed",
            "example": [
              "TELEPASS",
              "TPAY",
              "VENP_CCAPP"
            ]
          },
          "description": {
            "type": "string",
            "maxLength": 30,
            "description": "Instrument identifier known to the user"
          },
          "additionalInfo": {
            "type": "string",
            "description": "Additional info to be agreed",
            "example": "31-01-2020"
          },
          "additionalInfo2": {
            "type": "string",
            "description": "Additional info to be agreed"
          }
        }
      },
      "WalletBpayInfoInput": {
        "required": [
          "codGruppo",
          "codIstituto",
          "nomeBanca",
          "nomeOffuscato",
          "cognomeOffuscato",
          "numeroTelefonicoOffuscato",
          "numeroTelefonicoCriptato",
          "UIDCriptato",
          "statoServizio",
          "infoStrumenti"
        ],
        "type": "object",
        "properties": {
          "codGruppo": {
            "type": "string"
          },
          "codIstituto": {
            "type": "string"
          },
          "nomeBanca": {
            "type": "string"
          },
          "nomeOffuscato": {
            "type": "string"
          },
          "cognomeOffuscato": {
            "type": "string"
          },
          "numeroTelefonicoOffuscato": {
            "type": "string"
          },
          "numeroTelefonicoCriptato": {
            "type": "string"
          },
          "UIDCriptato": {
            "type": "string"
          },
          "statoServizio": {
            "type": "string",
            "enum": [
              "ATT",
              "DIS",
              "SOSP",
              "SAT_GG",
              "SAT_MM",
              "SAT_NO",
              "NFC_IN_COR",
              "NFC_ESTINTO",
              "ATTPND",
              "DISPND"
            ]
          },
          "infoStrumenti": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/InfoStrumenti"
            }
          }
        }
      },
      "InfoStrumenti": {
        "required": [
          "iban",
          "flgPreferitoPagamento",
          "flgPreferitoRicezione"
        ],
        "type": "object",
        "properties": {
          "iban": {
            "type": "string"
          },
          "flgPreferitoPagamento": {
            "type": "boolean"
          },
          "flgPreferitoRicezione": {
            "type": "boolean"
          }
        }
      },
      "WalletType": {
        "type": "string",
        "enum": [
          "Card",
          "Bancomat",
          "Satispay",
          "BPay",
          "Generic"
        ]
      }
    }
  }
}
