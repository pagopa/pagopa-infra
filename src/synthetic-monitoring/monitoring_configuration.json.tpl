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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmcalculator",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmcalculator",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "afmmarketplace",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmmarketplace",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "afmutils",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "afmutils",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "apiconfig",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "apiconfig",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "authorizer",
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "bizevents-neg",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "bizevents-neg",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "bizevents-ds",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "bizevents-ds",
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "gpd-payments",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd-payments",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd-payments-pull",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd-enrollment",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd-enrollment",
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "receipts-datastore",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "receipts-datastore",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "receipts-generator",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "receipts-generator",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "receipts-notifier",
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
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "receipts-notifier",
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
      "enabled" : false
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
      "enabled" : false
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "authorizer",
    "url" :  "https://pagopa-${env_short}-weu-shared-authorizer-fn.azurewebsites.net/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} authorizer status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "canoneunico",
    "url" :  "https://pagopa-${env_short}-fn-canoneunico.azurewebsites.net/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} canoneunico status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "canoneunico",
    "url" :  "https://${api_dot_env_name}.platform.pagopa.it/shared/statuspage/v1/info?product=canoneunico",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} canoneunico status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "gpd-analysis",
    "url" :  "https://pagopa-${env_short}-weu-fn-gpd-analysis.azurewebsites.net/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd-analysis status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd-analysis",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "gpd-batch",
    "url" :  "https://pagopa-${env_short}-weu-fn-gpd-batch.azurewebsites.net/api/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd-batch status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd-batch",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "gpd-reporting",
    "url" :  "https://pagopa-${env_short}-weu-fn-gpd-service.azurewebsites.net/api/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gpd-reporting status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  },
  {
    "apiName" : "status",
    "appName" : "gpd-reporting",
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
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "gps-donations",
    "url" :  "https://${internal_api_domain_prefix}.gps.${internal_api_domain_suffix}/pagopa-gps-donation-service/info",
    "type" : "private",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} gps donations status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  },

  {
    "apiName" : "status",
    "appName" : "fdr-org",
    "url" : "https://${api_dot_env_name}.platform.pagopa.it/fdr-org/service/v1/info",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "GET",
    "expectedCodes" : ["200"],
    "tags" : {
      "description" : "pagopa ${env_name} fdr status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  },
  {
    "apiName" : "request-flow",
    "appName" : "fdr",
    "url" : "https://${api_dot_env_name}.platform.pagopa.it/fdr-psp/service/v1/psps/60000000001/fdrs/2024-02-0860000000001-17074057078",
    "type" : "public",
    "checkCertificate" : true,
    "method" : "POST",
    "expectedCodes" : ["200", "400"],
    "body": {
      "fdr": "2024-02-0860000000001-17074057078",
      "fdrDate": "2024-02-08T15:21:47.834Z",
      "sender": {
        "type": "LEGAL_PERSON",
        "id": "SELBIT2B",
        "pspId": "60000000001",
        "pspName": "Bank",
        "pspBrokerId": "60000000001",
        "channelId": "15376371009_04"
      ,"password": "PLACEHOLDER"
      },
      "receiver": {
        "id": "APPBIT2B",
        "organizationId": "15376371009",
        "organizationName": "Comune di xyz"
      },
      "regulation": "SEPA - Bonifico xzy",
      "regulationDate": "2024-02-08T15:21:47.834Z",
      "bicCodePouringBank": "UNCRITMMXXX",
      "totPayments": 3,
      "sumPayments": 0.03
    },
    "headers": {
      "Ocp-Apim-Subscription-Key": "e879a6b70e2241898d0b8b5b9d647df0"
    },
    "tags" : {
      "description" : "pagopa fdr ${env_name} status endpoint"
    },
    "durationLimit" : 10000,
    "alertConfiguration" : {
      "enabled" : false
    }
  }
]
