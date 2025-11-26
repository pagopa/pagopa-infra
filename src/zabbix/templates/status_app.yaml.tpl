namespace: "zabbix"
nameOverride: ""
fullnameOverride: ""

#
# Deploy
#
deployment:
  create: true
  # forceRedeploy: true

image:
  repository: ghcr.io/pagopa/devops-app-status
  tag: v1.0.0
  pullPolicy: Always

livenessProbe:
  httpGet:
    path: /status
    port: 8000
  initialDelaySeconds: 60
  failureThreshold: 6
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /status
    port: 8000
  initialDelaySeconds: 60
  failureThreshold: 6
  periodSeconds: 10


#
# Network
#
service:
  create: true
  type: ClusterIP
  ports:
  - 8000

ingress:
  create: true
  host: "dev01.zabbix.internal.dev.cstar.pagopa.it"
  path: /zabbix(/|$)(.*)
  rewriteTarget: /$2
  servicePort: 8000
  # proxyBodySize: 2m
  annotations: {
    nginx.ingress.kubernetes.io/satisfy: "any"
  }

serviceAccount:
  create: false
  annotations: {}
  name: ""

podAnnotations: {}

podSecurityContext:
  seccompProfile:
    type: RuntimeDefault

securityContext:
  allowPrivilegeEscalation: false

resources:
  requests:
    memory: "128Mi"
    cpu: "40m"
  limits:
    memory: "128Mi"
    cpu: "40m"

autoscaling:
  enable: true
  minReplica: 1
  maxReplica: 3
  pollingInterval: 30 # seconds
  cooldownPeriod: 300 # seconds
  triggers:
    - type: cpu
      metadata:
        type: Utilization
        value: "60"

# nodeSelector: {}

# tolerations: []

# affinity: {}
