controller:
  service:
    annotations:
      service.beta.kubernetes.io/azure-load-balancer-internal: "true"
      service.beta.kubernetes.io/azure-load-balancer-ipv4: ${load_balancer_ip}
      service.beta.kubernetes.io/azure-load-balancer-internal-subnet: ${private_subnet_name}
