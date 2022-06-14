controller:
  service:
    loadBalancerIP: ${load_balancer_ip}
    annotations:
      service.beta.kubernetes.io/azure-load-balancer-internal: "true"
