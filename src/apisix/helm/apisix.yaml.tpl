dashboard:
  enabled: true

apisix:
  service:
    type: ClusterIP

  credentials:
    admin: ${ADMIN_TOKEN}
    viewer: ${VIEWER_TOKEN}
