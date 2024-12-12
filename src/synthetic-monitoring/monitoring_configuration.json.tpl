[
  {
    "apiName" : "root",
    "appName" : "pagopa",
    "url" : "https://${api_dot_env_name}.platform.pagopa.it/",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} context root"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmCalculator",
    "url" :  "https://${internal_api_domain_prefix}.afm.${internal_api_domain_suffix}/pagopa-afm-calculator-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} afm calculator status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmCalculator",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=afmcalculator",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} afm calculator status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "afmMarketplace",
    "url" :  "https://${internal_api_domain_prefix}.afm.${internal_api_domain_suffix}/pagopa-afm-marketplace-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} afm marketplace status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmMarketplace",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=afmmarketplace",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} afm marketplace status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "afmUtils",
    "url" :  "https://${internal_api_domain_prefix}.afm.${internal_api_domain_suffix}/pagopa-afm-utils-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} afm utils status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmUtils",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=afmutils",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} afm utils status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "apiConfig",
    "url" :  "https://${internal_api_domain_prefix}.apiconfig.${internal_api_domain_suffix}/pagopa-api-config-core-service/o/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} apiconfig status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "apiConfig",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=apiconfig",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} apiconfig status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "authorizerConfig",
    "url" :  "https://${internal_api_domain_prefix}.shared.${internal_api_domain_suffix}/authorizer-config/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} authorizer status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "authorizer",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=authorizer",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} authorizer status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
    {
    "apiName" : "status",
    "appName" : "bizevents",
    "url" :  "https://${internal_api_domain_prefix}.bizevents.${internal_api_domain_suffix}/pagopa-biz-events-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} bizevents status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "bizevents",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=bizevents",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} bizevents status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "bizeventsNeg",
    "url" :  "https://${internal_api_domain_prefix}.bizevents.${internal_api_domain_suffix}/pagopa-negative-biz-events-datastore-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} bizevents negative status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "bizeventsNeg",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=bizeventsdatastoreneg",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} bizevents negative status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "bizeventsDs",
    "url" :  "https://${internal_api_domain_prefix}.bizevents.${internal_api_domain_suffix}/pagopa-biz-events-datastore-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} bizevents datastore status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "bizeventsDs",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=bizeventsdatastorepos",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} bizevents datastore status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "selfcare",
    "url" :  "https://${internal_api_domain_prefix}.selfcare.${internal_api_domain_suffix}/selfcare/pagopa/v1/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} selfcare status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "fdr",
    "url" :  "https://${internal_api_domain_prefix}.fdr.${internal_api_domain_suffix}/pagopa-fdr-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} fdr status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "fdr",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=fdrndpnew",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} fdr status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "gpd",
    "url" :  "https://${internal_api_domain_prefix}.gps.${internal_api_domain_suffix}/pagopa-gpd-core/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=gpd",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "gpdPayments",
    "url" :  "https://${internal_api_domain_prefix}.gps.${internal_api_domain_suffix}/pagopa-gpd-payments/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd payments status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpdPayments",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=gpdpayments",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd payments status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpdPaymentsPull",
    "url" :  "https://${internal_api_domain_prefix}.gps.${internal_api_domain_suffix}/pagopa-gpd-payments-pull/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd payments pull status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpdEnrollment",
    "url" :  "https://${internal_api_domain_prefix}.gps.${internal_api_domain_suffix}/pagopa-gpd-reporting-orgs-enrollment/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd reports status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpdEnrollment",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=gpdenrollment",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd reports status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "gps",
    "url" :  "https://${internal_api_domain_prefix}.gps.${internal_api_domain_suffix}/pagopa-spontaneous-payments-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gps status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "gps",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=gps",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gps status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "receiptsDatastore",
    "url" :  "https://${internal_api_domain_prefix}.receipts.${internal_api_domain_suffix}/pagopa-receipt-pdf-datastore/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts datastore status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "receiptsDatastore",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=receiptpdfdatastore",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts datastore status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "receiptsGenerator",
    "url" :  "https://${internal_api_domain_prefix}.receipts.${internal_api_domain_suffix}/pagopa-receipt-pdf-generator/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts generator status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "receiptsGenerator",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=receiptpdfgenerator",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts generator status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "receiptsNotifier",
    "url" :  "https://${internal_api_domain_prefix}.receipts.${internal_api_domain_suffix}/pagopa-receipt-pdf-notifier/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts notifier status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "receiptsNotifier",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=receiptpdfnotifier",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts notifier status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "status",
    "appName" : "receipts",
    "url" :  "https://${internal_api_domain_prefix}.receipts.${internal_api_domain_suffix}/pagopa-receipt-pdf-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "status",
    "appName" : "receipts",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=receiptpdfservice",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} receipts status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },






  {
    "apiName" : "status",
    "appName" : "gpdAnalysis",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=gpdreportinganalysis",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd-analysis status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },


  {
    "apiName" : "status",
    "appName" : "gpdBatch",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=gpdreportingbatch",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd-batch status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },


  {
    "apiName" : "status",
    "appName" : "gpdReporting",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=gpdreportingservice",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd-reporting status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },





  {
    "apiName" : "checkPosition",
    "appName" : "nodo",
    "url" : "https://${api_dot_env_name}.platform.pagopa.it/nodo/nodo-per-pm/v1/checkPosition",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "POST",
    "expectedCodes" : ["200"],
    "body": {"positionslist": [{"fiscalCode": "${check_position_body.fiscal_code}", "noticeNumber": "${check_position_body.notice_number}"}]},
    "expectedBody": {"outcome":"OK"},
    "bodyCompareStrategy": "contains",
    "headers": {
      "Content-Type": "application/json"
    },
    "tags" : {
      "description" : "pagopa nodo ${env_name} check position"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "verifyPaymentNoticeExternal",
    "appName" : "nodo",
    "url" : "https://${api_dot_env_name}.platform.pagopa.it/nodo-auth/node-for-psp/v1",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "POST",
    "expectedCodes" : ["200"],
    "expectedBody": {
      "soapenv:Envelope": {
        "soapenv:Body": {
          "nfp:verifyPaymentNoticeRes": {
            "outcome": "KO"
          }
        }
      }
    },
    "bodyCompareStrategy": "xmlContains",
    "body": "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'><soapenv:Header /><soapenv:Body><nod:verifyPaymentNoticeReq xmlns:nod='http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd'><idPSP>ABI18164</idPSP><idBrokerPSP>02654890025</idBrokerPSP><idChannel>02654890025_01</idChannel><password>PLACEHOLDER</password><qrCode><fiscalCode>97532760580</fiscalCode><noticeNumber>302704889233205169</noticeNumber></qrCode></nod:verifyPaymentNoticeReq></soapenv:Body></soapenv:Envelope>",
    "headers": {
      "SOAPAction": "verifyPaymentNotice",
      "Ocp-Apim-Subscription-Key": "${nodo_subscription_key}",
      "Content-Type": "application/xml"
    },
    "tags" : {
      "description" : "pagopa nodo ${env_name} verify payment notice to external service"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "verifyPaymentNoticeInternal",
    "appName" : "nodo",
    "url" : "https://${api_dot_env_name}.platform.pagopa.it/nodo-auth/node-for-psp/v1",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "POST",
    "expectedCodes" : ["200"],
    "expectedBody": {
      "soapenv:Envelope": {
        "soapenv:Body": {
          "nfp:verifyPaymentNoticeRes": {
            "outcome": "KO"
          }
        }
      }
    },
    "bodyCompareStrategy": "xmlContains",
    "body": "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/'> <SOAP-ENV:Body> <ns3:verifyPaymentNoticeReq xmlns:ns3='http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd'> <idPSP>CIPBITMM</idPSP> <idBrokerPSP>13212880150</idBrokerPSP> <idChannel>13212880150_10</idChannel> <password>PLACEHOLDER</password> <qrCode> <fiscalCode>83000970612</fiscalCode> <noticeNumber>302000000014360604</noticeNumber> </qrCode> </ns3:verifyPaymentNoticeReq> </SOAP-ENV:Body> </SOAP-ENV:Envelope>",
    "headers": {
      "SOAPAction": "verifyPaymentNotice",
      "Ocp-Apim-Subscription-Key": "${nodo_subscription_key}",
      "Content-Type": "application/xml"
    },
    "tags" : {
      "description" : "pagopa nodo ${env_name} verify payment notice to internal service"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },

  {
    "apiName" : "verifyPaymentNoticeExternal",
    "appName" : "nodo",
    "url" : "https://${appgw_public_ip}/nodo-auth/node-for-psp/v1",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "POST",
    "expectedCodes" : ["200"],
    "expectedBody": {
      "soapenv:Envelope": {
        "soapenv:Body": {
          "nfp:verifyPaymentNoticeRes": {
            "outcome": "KO"
          }
        }
      }
    },
    "bodyCompareStrategy": "xmlContains",
    "body": "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'><soapenv:Header /><soapenv:Body><nod:verifyPaymentNoticeReq xmlns:nod='http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd'><idPSP>ABI18164</idPSP><idBrokerPSP>02654890025</idBrokerPSP><idChannel>02654890025_01</idChannel><password>PLACEHOLDER</password><qrCode><fiscalCode>97532760580</fiscalCode><noticeNumber>302704889233205169</noticeNumber></qrCode></nod:verifyPaymentNoticeReq></soapenv:Body></soapenv:Envelope>",
    "headers": {
      "SOAPAction": "verifyPaymentNotice",
      "Ocp-Apim-Subscription-Key": "${nodo_subscription_key}",
      "Content-Type": "application/xml",
      "Host": "${api_dot_env_name}.platform.pagopa.it"
    },
    "tags" : {
      "description" : "pagopa nodo ${env_name} verify payment notice to external service"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  },
  {
    "apiName" : "verifyPaymentNoticeInternal",
    "appName" : "nodo",
    "url" : "https://${appgw_public_ip}/nodo-auth/node-for-psp/v1",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "POST",
    "expectedCodes" : ["200"],
    "expectedBody": {
      "soapenv:Envelope": {
        "soapenv:Body": {
          "nfp:verifyPaymentNoticeRes": {
            "outcome": "KO"
          }
        }
      }
    },
    "bodyCompareStrategy": "xmlContains",
    "body": "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/'> <SOAP-ENV:Body> <ns3:verifyPaymentNoticeReq xmlns:ns3='http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd'> <idPSP>CIPBITMM</idPSP> <idBrokerPSP>13212880150</idBrokerPSP> <idChannel>13212880150_10</idChannel> <password>PLACEHOLDER</password> <qrCode> <fiscalCode>83000970612</fiscalCode> <noticeNumber>302000000014360604</noticeNumber> </qrCode> </ns3:verifyPaymentNoticeReq> </SOAP-ENV:Body> </SOAP-ENV:Envelope>",
    "headers": {
      "SOAPAction": "verifyPaymentNotice",
      "Ocp-Apim-Subscription-Key": "${nodo_subscription_key}",
      "Content-Type": "application/xml",
      "Host": "${api_dot_env_name}.platform.pagopa.it"
    },
    "tags" : {
      "description" : "pagopa nodo ${env_name} verify payment notice to internal service"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : ${alert_enabled}
    }
  }

]
