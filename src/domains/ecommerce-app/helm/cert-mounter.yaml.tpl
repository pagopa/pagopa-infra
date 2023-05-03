namespace: ${NAMESPACE}
nameOverride: ""
fullnameOverride: ""

deployment:
  create: true

kvCertificatesName:
  - ${CERTIFICATE_NAME}

keyvault:
  name: "pagopa-${ENV_SHORT}-${DOMAIN}-kv"
  tenantId: "7788edaf-0346-4068-9d79-c868aed15b3d"
