{
  "openapi": "3.0.0",
  "info":
    {
      "version": "0.0.1",
      "title": "Pagopa eCommerce services for app IO",
      "description": "API's exposed from eCommerce services to io webview to allow get transaction.",
      "contact": { "name": "pagoPA - Touchpoints team" },
    },
  "tags":
    [
      {
        "name": "ecommerce-transactions",
        "description": "Api's for performing a transaction",
        "externalDocs":
          {
            "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611287199/-servizio+transactions+service",
            "description": "Technical specifications",
          },
      },
    ],
  "servers": [{ "url": "https://${host}" }],
  "externalDocs":
    {
      "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
      "description": "Design review",
    },
  "paths":
    {
      "/transactions":
        {
          "post":
            {
              "tags": ["ecommerce-transactions"],
              "operationId": "newTransactionForEcommerceWebview",
              "summary": "Create a new transaction",
              "description": "Create a new transaction activating the payments notice by meaning of 'Nodo' ActivatePaymentNotice primitive",
              "security": [{ "eCommerceSessionToken": [] }],
              "requestBody":
                {
                  "content":
                    {
                      "application/json":
                        {
                          "schema":
                            {
                              "$ref": "#/components/schemas/NewTransactionRequest",
                            },
                        },
                    },
                  "required": true,
                },
              "responses":
                {
                  "200":
                    {
                      "description": "New transaction successfully created",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                {
                                  "$ref": "#/components/schemas/NewTransactionResponse",
                                },
                            },
                        },
                    },
                  "400":
                    {
                      "description": "Formally invalid input",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                  "401":
                    {
                      "description": "Unauthorized, access token missing or invalid",
                    },
                  "404":
                    {
                      "description": "Node cannot find the services needed to process this request in its configuration. This error is most likely to occur when submitting a non-existing RPT id.",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                {
                                  "$ref": "#/components/schemas/NodeProblemJson404",
                                },
                            },
                        },
                    },
                  "409":
                    {
                      "description": "Conflict on payment status",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                {
                                  "$ref": "#/components/schemas/NodeProblemJson409",
                                },
                            },
                        },
                    },
                  "502":
                    {
                      "description": "PagoPA services are not available or request is rejected by PagoPa",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                {
                                  "$ref": "#/components/schemas/NodeProblemJson502",
                                },
                            },
                        },
                    },
                  "503":
                    {
                      "description": "EC services are not available",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                {
                                  "$ref": "#/components/schemas/PartyConfigurationFaultPaymentProblemJson",
                                },
                            },
                        },
                    },
                },
            },
        },
      "/transactions/{transactionId}":
        {
          "get":
            {
              "tags": ["ecommerce-transactions"],
              "operationId": "getTransactionInfo",
              "parameters":
                [
                  {
                    "in": "path",
                    "name": "transactionId",
                    "schema": { "type": "string" },
                    "required": true,
                    "description": "Transaction ID",
                  },
                ],
              "security": [{ "eCommerceSessionToken": [] }],
              "summary": "Get transaction information",
              "description": "Return information for the input specific transaction resource",
              "responses":
                {
                  "200":
                    {
                      "description": "Transaction data successfully retrieved",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                {
                                  "$ref": "#/components/schemas/TransactionInfo",
                                },
                            },
                        },
                    },
                  "400":
                    {
                      "description": "Invalid transaction id",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                  "401":
                    {
                      "description": "Unauthorized, access token missing or invalid",
                    },
                  "404":
                    {
                      "description": "Transaction not found",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                  "504":
                    {
                      "description": "Gateway timeout",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                },
            },
        },
      "/transactions/{transactionId}/outcomes":
        {
          "get":
            {
              "tags": ["ecommerce-transactions"],
              "operationId": "getTransactionOutcomes",
              "summary": "Get transaction outcome",
              "description": "Return outcome information for the input specific transaction resource",
              "parameters":
                [
                  {
                    "in": "path",
                    "name": "transactionId",
                    "schema": { "type": "string" },
                    "required": true,
                    "description": "Transaction ID",
                  },
                ],
              "security": [{ "eCommerceSessionToken": [] }],
              "responses":
                {
                  "200":
                    {
                      "description": "Transaction authorization request successfully updated",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                {
                                  "$ref": "#/components/schemas/TransactionOutcomeInfo",
                                },
                            },
                        },
                    },
                  "400":
                    {
                      "description": "Invalid transaction id",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                  "401":
                    {
                      "description": "Unauthorized, access token missing or invalid",
                    },
                  "404":
                    {
                      "description": "Transaction not found",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                  "500":
                    {
                      "description": "Internal server error",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                  "502":
                    {
                      "description": "Bad gateway",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                  "504":
                    {
                      "description": "Gateway timeout",
                      "content":
                        {
                          "application/json":
                            {
                              "schema":
                                { "$ref": "#/components/schemas/ProblemJson" },
                            },
                        },
                    },
                },
            },
        },
    },
  "components":
    {
      "schemas":
        {
          "PaymentNoticeInfo":
            {
              "description": "Informations about a single payment notice",
              "type": "object",
              "properties":
                {
                  "rptId": { "$ref": "#/components/schemas/RptId" },
                  "paymentContextCode":
                    { "$ref": "#/components/schemas/PaymentContextCode" },
                  "amount": { "$ref": "#/components/schemas/AmountEuroCents" },
                },
              "required": ["rptId", "amount"],
              "example":
                {
                  "rptId": "string",
                  "paymentContextCode": "12345678901234567890123456789012",
                  "amount": 100,
                },
            },
          "NewTransactionRequest":
            {
              "type": "object",
              "description": "Request body for creating a new transaction",
              "properties":
                {
                  "paymentNotices":
                    {
                      "type": "array",
                      "items":
                        { "$ref": "#/components/schemas/PaymentNoticeInfo" },
                      "minItems": 1,
                      "maxItems": 1,
                      "example":
                        [
                          {
                            "rptId": "77777777777302012387654312384",
                            "amount": 12000,
                          },
                        ],
                    },
                },
              "required": ["paymentNotices"],
            },
          "ProblemJson":
            {
              "type": "object",
              "properties":
                {
                  "type":
                    {
                      "type": "string",
                      "format": "uri",
                      "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
                      "default": "about:blank",
                      "example": "https://example.com/problem/constraint-violation",
                    },
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "status": { "$ref": "#/components/schemas/HttpStatusCode" },
                  "detail":
                    {
                      "type": "string",
                      "description": "A human readable explanation specific to this occurrence of the\nproblem.",
                      "example": "There was an error processing the request",
                    },
                  "instance":
                    {
                      "type": "string",
                      "format": "uri",
                      "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced.",
                    },
                },
            },
          "HttpStatusCode":
            {
              "type": "integer",
              "format": "int32",
              "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
              "minimum": 100,
              "maximum": 600,
              "exclusiveMaximum": true,
              "example": 500,
            },
          "RptId":
            {
              "type": "string",
              "pattern": "([a-zA-Z0-9]{1,35})|(RFd{2}[a-zA-Z0-9]{1,21})",
            },
          "PaymentContextCode":
            {
              "description": "Payment context code used for verifivaRPT/attivaRPT",
              "type": "string",
              "minLength": 32,
              "maxLength": 32,
            },
          "PaymentInfo":
            {
              "description": "Informations about transaction payments",
              "type": "object",
              "properties":
                {
                  "paymentToken": { "type": "string" },
                  "rptId": { "$ref": "#/components/schemas/RptId" },
                  "reason": { "type": "string" },
                  "amount": { "$ref": "#/components/schemas/AmountEuroCents" },
                  "isAllCCP":
                    {
                      "description": "Flag for the inclusion of Poste bundles. false -> excluded, true -> included",
                      "type": "boolean",
                    },
                  "transferList":
                    {
                      "type": "array",
                      "items": { "$ref": "#/components/schemas/Transfer" },
                      "minItems": 1,
                      "maxItems": 5,
                    },
                },
              "required": ["rptId", "amount"],
              "example":
                {
                  "rptId": "77777777777302012387654312384",
                  "paymentToken": "paymentToken1",
                  "reason": "reason1",
                  "amount": 600,
                  "authToken": "authToken1",
                  "isAllCCP": false,
                  "transferList":
                    [
                      {
                        "paFiscalCode": "77777777777",
                        "digitalStamp": false,
                        "transferCategory": "transferCategory1",
                        "transferAmount": 500,
                      },
                      {
                        "paFiscalCode": "11111111111",
                        "digitalStamp": true,
                        "transferCategory": "transferCategory2",
                        "transferAmount": 100,
                      },
                    ],
                },
            },
          "NewTransactionResponse":
            {
              "type": "object",
              "description": "Transaction data returned when creating a new transaction",
              "properties":
                {
                  "transactionId": { "type": "string" },
                  "payments":
                    {
                      "type": "array",
                      "items": { "$ref": "#/components/schemas/PaymentInfo" },
                      "minItems": 1,
                      "maxItems": 1,
                      "example":
                        [
                          {
                            "rptId": "77777777777302012387654312384",
                            "paymentToken": "paymentToken1",
                            "reason": "reason1",
                            "amount": 600,
                            "transferList":
                              [
                                {
                                  "paFiscalCode": "77777777777",
                                  "digitalStamp": false,
                                  "transferCategory": "transferCategory1",
                                  "transferAmount": 500,
                                },
                                {
                                  "paFiscalCode": "11111111111",
                                  "digitalStamp": true,
                                  "transferCategory": "transferCategory2",
                                  "transferAmount": 100,
                                },
                              ],
                          },
                        ],
                    },
                  "status":
                    { "$ref": "#/components/schemas/TransactionStatus" },
                  "feeTotal":
                    { "$ref": "#/components/schemas/AmountEuroCents" },
                  "clientId":
                    {
                      "description": "transaction client id",
                      "type": "string",
                      "enum": ["IO"],
                    },
                  "sendPaymentResultOutcome":
                    {
                      "description": "The outcome of sendPaymentResult api (OK, KO, NOT_RECEIVED)",
                      "type": "string",
                      "enum": ["OK", "KO", "NOT_RECEIVED"],
                    },
                  "authorizationCode":
                    {
                      "type": "string",
                      "description": "Payment gateway-specific authorization code related to the transaction",
                    },
                  "errorCode":
                    {
                      "type": "string",
                      "description": "Payment gateway-specific error code from the gateway",
                    },
                  "gateway":
                    {
                      "type": "string",
                      "pattern": "XPAY|VPOS|NPG|REDIRECT",
                      "description": "Pgs identifier",
                    },
                },
              "required": ["transactionId", "status", "payments"],
            },
          "TransactionOutcomeInfo":
            {
              "type": "object",
              "description": "Transaction outcome info returned when querying for an existing transaction outcome status. The field totalAmount, if present, is intended as the total amount paid for the transaction in eurocents fees excluded. Fees too, if present, is in eurocents",
              "properties":
                {
                  "outcome":
                    {
                      "type": "number",
                      "enum":
                        [
                          0,
                          1,
                          2,
                          3,
                          4,
                          7,
                          8,
                          10,
                          17,
                          18,
                          25,
                          99,
                          116,
                          117,
                          121,
                        ],
                      "description": "`0` - Success `1` - Generic error `2` - Authorization error `3` - Invalid data `4` - Timeout `7` - Invalid card: expired card etc `8` - Canceled by the user `10` - Excessive amount `17` - Taken in charge `18` - Refunded `25` - PSP Error `99` - Backend Error `116` - Balance not available `117` - CVV Error `121` - Limit exceeded",
                    },
                  "isFinalStatus":
                    {
                      "type": "boolean",
                      "description": "A flag that describe the outcome as final or not. If true, the outcome will not change in the future and the client can interrupt polling.",
                    },
                  "totalAmount":
                    { "$ref": "#/components/schemas/AmountEuroCents" },
                  "fees": { "$ref": "#/components/schemas/AmountEuroCents" },
                },
              "required": ["outcome", "isFinalStatus"],
            },
          "AmountEuroCents":
            {
              "description": "Amount for payments, in euro cents",
              "type": "integer",
              "minimum": 0,
              "maximum": 99999999,
            },
          "TransactionStatus":
            {
              "type": "string",
              "description": "Possible statuses a transaction can be in",
              "enum":
                [
                  "ACTIVATED",
                  "AUTHORIZATION_REQUESTED",
                  "AUTHORIZATION_COMPLETED",
                  "CLOSURE_REQUESTED",
                  "CLOSED",
                  "CLOSURE_ERROR",
                  "NOTIFIED_OK",
                  "NOTIFIED_KO",
                  "NOTIFICATION_ERROR",
                  "NOTIFICATION_REQUESTED",
                  "EXPIRED",
                  "REFUNDED",
                  "CANCELED",
                  "EXPIRED_NOT_AUTHORIZED",
                  "UNAUTHORIZED",
                  "REFUND_ERROR",
                  "REFUND_REQUESTED",
                  "CANCELLATION_REQUESTED",
                  "CANCELLATION_EXPIRED",
                ],
            },
          "TransactionInfo":
            {
              "description": "Transaction data returned when querying for an existing transaction",
              "allOf":
                [
                  { "$ref": "#/components/schemas/NewTransactionResponse" },
                  {
                    "type": "object",
                    "properties":
                      {
                        "status":
                          { "$ref": "#/components/schemas/TransactionStatus" },
                        "gatewayAuthorizationStatus":
                          {
                            "type": "string",
                            "description": "Payment gateway authorization status",
                          },
                      },
                    "required": ["status"],
                  },
                ],
            },
          "Transfer":
            {
              "type": "object",
              "description": "The dto that contains information about the creditor entities",
              "properties":
                {
                  "paFiscalCode":
                    {
                      "type": "string",
                      "description": "The creditor institution fiscal code",
                      "pattern": "^[a-zA-Z0-9]{11}",
                    },
                  "digitalStamp":
                    {
                      "type": "boolean",
                      "description": "True if it is a digital stamp. False otherwise",
                    },
                  "transferCategory":
                    {
                      "type": "string",
                      "description": "The taxonomy of the transfer",
                    },
                  "transferAmount":
                    { "$ref": "#/components/schemas/AmountEuroCents" },
                },
              "required": ["paFiscalCode", "digitalStamp", "transferAmount"],
            },
          "NodeProblemJson404":
            {
              "oneOf":
                [
                  {
                    "$ref": "#/components/schemas/ValidationFaultPaymentDataErrorProblemJson",
                  },
                  {
                    "$ref": "#/components/schemas/ValidationFaultPaymentUnknownProblemJson",
                  },
                ],
            },
          "NodeProblemJson409":
            {
              "oneOf":
                [
                  {
                    "$ref": "#/components/schemas/PaymentOngoingStatusFaultPaymentProblemJson",
                  },
                  {
                    "$ref": "#/components/schemas/PaymentExpiredStatusFaultPaymentProblemJson",
                  },
                  {
                    "$ref": "#/components/schemas/PaymentCanceledStatusFaultPaymentProblemJson",
                  },
                  {
                    "$ref": "#/components/schemas/PaymentDuplicatedStatusFaultPaymentProblemJson",
                  },
                ],
            },
          "NodeProblemJson502":
            {
              "oneOf":
                [
                  {
                    "$ref": "#/components/schemas/GatewayFaultPaymentProblemJson",
                  },
                  {
                    "$ref": "#/components/schemas/ValidationFaultPaymentUnavailableProblemJson",
                  },
                ],
            },
          "ValidationFaultPaymentDataErrorProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["PAYMENT_DATA_ERROR"] },
                  "faultCodeDetail":
                    {
                      "$ref": "#/components/schemas/ValidationFaultPaymentDataError",
                    },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "ValidationFaultPaymentUnknownProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["PAYMENT_UNKNOWN"] },
                  "faultCodeDetail":
                    {
                      "$ref": "#/components/schemas/ValidationFaultPaymentUnknown",
                    },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "PaymentOngoingStatusFaultPaymentProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["PAYMENT_ONGOING"] },
                  "faultCodeDetail":
                    {
                      "$ref": "#/components/schemas/PaymentOngoingStatusFault",
                    },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "PaymentExpiredStatusFaultPaymentProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["PAYMENT_EXPIRED"] },
                  "faultCodeDetail":
                    {
                      "$ref": "#/components/schemas/PaymentExpiredStatusFault",
                    },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "PaymentCanceledStatusFaultPaymentProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["PAYMENT_CANCELED"] },
                  "faultCodeDetail":
                    {
                      "$ref": "#/components/schemas/PaymentCanceledStatusFault",
                    },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "PaymentDuplicatedStatusFaultPaymentProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["PAYMENT_DUPLICATED"] },
                  "faultCodeDetail":
                    {
                      "$ref": "#/components/schemas/PaymentDuplicatedStatusFault",
                    },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },

          "GatewayFaultPaymentProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["GENERIC_ERROR"] },
                  "faultCodeDetail":
                    { "$ref": "#/components/schemas/GatewayFault" },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "PartyConfigurationFaultPaymentProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["DOMAIN_UNKNOWN"] },
                  "faultCodeDetail":
                    { "$ref": "#/components/schemas/PartyConfigurationFault" },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "ValidationFaultPaymentUnavailableProblemJson":
            {
              "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
              "type": "object",
              "properties":
                {
                  "title":
                    {
                      "type": "string",
                      "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable",
                    },
                  "faultCodeCategory":
                    { "type": "string", "enum": ["PAYMENT_UNAVAILABLE"] },
                  "faultCodeDetail":
                    {
                      "$ref": "#/components/schemas/ValidationFaultPaymentUnavailable",
                    },
                },
              "required": ["faultCodeCategory", "faultCodeDetail"],
            },
          "ValidationFaultPaymentDataError":
            {
              "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_SINTASSI_EXTRAXSD`\n- `PPT_SINTASSI_XSD`\n- `PPT_DOMINIO_SCONOSCIUTO`\n- `PPT_STAZIONE_INT_PA_SCONOSCIUTA`",
              "type": "string",
              "enum":
                [
                  "PPT_SINTASSI_EXTRAXSD",
                  "PPT_SINTASSI_XSD",
                  "PPT_DOMINIO_SCONOSCIUTO",
                  "PPT_STAZIONE_INT_PA_SCONOSCIUTA",
                ],
            },
          "ValidationFaultPaymentUnknown":
            {
              "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_SCONOSCIUTO`",
              "type": "string",
              "enum": ["PAA_PAGAMENTO_SCONOSCIUTO"],
            },
          "PaymentOngoingStatusFault":
            {
              "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_PAGAMENTO_IN_CORSO`\n- `PAA_PAGAMENTO_IN_CORSO`",
              "type": "string",
              "enum": ["PPT_PAGAMENTO_IN_CORSO", "PAA_PAGAMENTO_IN_CORSO"],
            },
          "PaymentExpiredStatusFault":
            {
              "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_SCADUTO`",
              "type": "string",
              "enum": ["PAA_PAGAMENTO_SCADUTO"],
            },
          "PaymentCanceledStatusFault":
            {
              "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_ANNULLATO`",
              "type": "string",
              "enum": ["PAA_PAGAMENTO_ANNULLATO"],
            },
          "PaymentDuplicatedStatusFault":
            {
              "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_DUPLICATO`\n- `PPT_PAGAMENTO_DUPLICATO`",
              "type": "string",
              "enum": ["PAA_PAGAMENTO_DUPLICATO", "PPT_PAGAMENTO_DUPLICATO"],
            },
          "GatewayFault":
            {
              "description": "Fault codes for generic downstream services errors, should be mapped to 502 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.",
              "type": "string",
            },
          "ValidationFaultPaymentUnavailable":
            {
              "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_PSP_SCONOSCIUTO`\n- `PPT_PSP_DISABILITATO`\n- `PPT_INTERMEDIARIO_PSP_SCONOSCIUTO`\n- `PPT_INTERMEDIARIO_PSP_DISABILITATO`\n- `PPT_CANALE_SCONOSCIUTO`\n- `PPT_CANALE_DISABILITATO`\n- `PPT_AUTENTICAZIONE`\n- `PPT_AUTORIZZAZIONE`\n- `PPT_DOMINIO_DISABILITATO`\n- `PPT_INTERMEDIARIO_PA_DISABILITATO`\n- `PPT_STAZIONE_INT_PA_DISABILITATA`\n- `PPT_CODIFICA_PSP_SCONOSCIUTA`\n- `PPT_SEMANTICA`\n- `PPT_SYSTEM_ERROR`\n- `PAA_SEMANTICA`",
              "type": "string",
              "enum":
                [
                  "PPT_PSP_SCONOSCIUTO",
                  "PPT_PSP_DISABILITATO",
                  "PPT_INTERMEDIARIO_PSP_SCONOSCIUTO",
                  "PPT_INTERMEDIARIO_PSP_DISABILITATO",
                  "PPT_CANALE_SCONOSCIUTO",
                  "PPT_CANALE_DISABILITATO",
                  "PPT_AUTENTICAZIONE",
                  "PPT_AUTORIZZAZIONE",
                  "PPT_DOMINIO_DISABILITATO",
                  "PPT_INTERMEDIARIO_PA_DISABILITATO",
                  "PPT_STAZIONE_INT_PA_DISABILITATA",
                  "PPT_CODIFICA_PSP_SCONOSCIUTA",
                  "PPT_SEMANTICA",
                  "PPT_SYSTEM_ERROR",
                  "PAA_SEMANTICA",
                ],
            },
          "PartyConfigurationFault":
            {
              "description": "Fault codes for fatal errors from ECs, should be mapped to 503 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE`\n- `PPT_STAZIONE_INT_PA_TIMEOUT`\n- `PPT_STAZIONE_INT_PA_ERRORE_RESPONSE`\n- `PPT_IBAN_NON_CENSITO`\n- `PAA_SINTASSI_EXTRAXSD`\n- `PAA_SINTASSI_XSD`\n- `PAA_ID_DOMINIO_ERRATO`\n- `PAA_ID_INTERMEDIARIO_ERRATO`\n- `PAA_STAZIONE_INT_ERRATA`\n- `PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO`\n- `PPT_ERRORE_EMESSO_DA_PAA`\n- `PAA_SYSTEM_ERROR`",
              "type": "string",
              "enum":
                [
                  "PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE",
                  "PPT_STAZIONE_INT_PA_TIMEOUT",
                  "PPT_STAZIONE_INT_PA_ERRORE_RESPONSE",
                  "PPT_IBAN_NON_CENSITO",
                  "PAA_SINTASSI_EXTRAXSD",
                  "PAA_SINTASSI_XSD",
                  "PAA_ID_DOMINIO_ERRATO",
                  "PAA_ID_INTERMEDIARIO_ERRATO",
                  "PAA_STAZIONE_INT_ERRATA",
                  "PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO",
                  "PPT_ERRORE_EMESSO_DA_PAA",
                  "PAA_SYSTEM_ERROR",
                ],
            },
        },
      "requestBodies":
        {
          "NewTransactionRequest":
            {
              "required": true,
              "content":
                {
                  "application/json":
                    {
                      "schema":
                        {
                          "$ref": "#/components/schemas/NewTransactionRequest",
                        },
                    },
                },
            },
        },
      "securitySchemes":
        {
          "eCommerceSessionToken":
            {
              "type": "http",
              "scheme": "bearer",
              "description": "JWT session token taken from /sessions response body",
            },
        },
    },
}
