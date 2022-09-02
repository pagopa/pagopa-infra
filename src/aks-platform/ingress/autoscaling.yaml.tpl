controller:
  keda:
    enabled: true
    minReplicas: ${min_replicas}
    maxReplicas: ${max_replicas}
    pollingInterval: ${polling_interval}
    cooldownPeriod: ${cooldown_period}
    triggers:
      ${indent(6, yamlencode(triggers))}