namespace: ${NAMESPACE}

resources:
  limits:
    cpu: 10m
    memory: 30Mi
  requests:
    cpu: 10m
    memory: 30Mi

deployment:
  create: true

kvCertificatesName:
  - ${CERTIFICATE_NAME}

keyvault:
  name: "pagopa-${ENV_SHORT}-${DOMAIN}-kv"
  tenantId: 7788edaf-0346-4068-9d79-c868aed15b3d

serviceAccount:
  name: "${SERVICE_ACCOUNT_NAME}"
azure:
  workloadIdentityClientId: "${WORKLOAD_IDENTITY_CLIENT_ID}"
