namespace: ${NAMESPACE}
nameOverride: ""
fullnameOverride: ""

deployment:
  create: true

kvCertificatesName:
  - ${CERTIFICATE_NAME}

keyvault:
  name: "pagopa-${ENV_SHORT}-${DOMAIN}-kv"
  tenantId: ${TENANT_ID}
