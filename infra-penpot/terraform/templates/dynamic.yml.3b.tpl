http:
  routers:
    # == PROD == 
    penpot-prod-http:
      rule: "Host(`penpot.devops-middleware.fr`)"
      entryPoints:
        - web
      service: penpot-prod
      middlewares:
        - redirect-to-https

    penpot-mon-http:
      rule: "Host(`penpot-monitoring.devops-middleware.fr`)"
      entryPoints:
        - web
      service: penpot-mon

    penpot-prod-https:
      rule: "Host(`penpot.devops-middleware.fr`)"
      entryPoints:
        - websecure
      service: penpot-prod
      tls:
        certResolver: letsencrypt

    # == Staging ==
    penpot-staging-http:
      rule: "Host(`penpot-staging.devops-middleware.fr`)"
      entryPoints:
        - web
      service: penpot-staging
      middlewares:
        - redirect-to-https

    penpot-staging-https:
      rule: "Host(`penpot-staging.devops-middleware.fr`)"
      entryPoints:
        - websecure
      service: penpot-staging
      middlewares:
        - staging-headers
      tls:
        certResolver: letsencrypt

        
  middlewares:
    redirect-to-https:
      redirectScheme:
        scheme: https
        permanent: true

    staging-headers:
      headers:
        customResponseHeaders:
          X-Robots-Tag: "noindex, nofollow"


  services:
    # == PROD == 
    penpot-prod:
      loadBalancer:
        servers:
          - url: "http://${k3s_master_prd_private_ips[1]}:30080"
          - url: "http://${k3s_master_prd_private_ips[3]}:30080"
          - url: "http://${k3s_master_prd_private_ips[5]}:30080"

    penpot-mon:
      loadBalancer:
        servers:
          - url: "http://${prometheus_private_ips[1]}:3000"

    # == Staging ==
    penpot-staging:
      loadBalancer:
        servers:
          - url: "http://${k3s_master_stg_private_ips[1]}:30080"
          - url: "http://${k3s_worker_stg_private_ips[1]}:30080"


