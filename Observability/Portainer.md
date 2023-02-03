## Portainer

```
Portainer Community Edition (CE) is our foundation. With over half a million regular users, CE is a powerful, open source toolset that allows you to easily build and manage containers in Docker, Docker Swarm, Kubernetes and Azure ACI.
```

## Installation

```
helm repo add portainer https://portainer.github.io/k8s/
helm repo update
```

## Expose with Ingress
```
helm install --create-namespace -n portainer portainer portainer/portainer \
  --set service.type=ClusterIP \
  --set ingress.enabled=true \
  --set ingress.annotations.'kubernetes\.io/ingress\.class'=nginx \
  --set ingress.annotations."nginx\.ingress\.kubernetes\.io/backend-protocol"=HTTPS \
  --set ingress.hosts[0].host=portainer.example.io \
  --set ingress.hosts[0].paths[0].path="/"
```
```
Access on portainer.example.io
```

## Behind Reverse Proxy
```
server {
    listen 443;
    ssl on;
    server_name k8s.adaptivenetworklab.org;
    error_page 497 https://$http_host$request_uri;

    ssl_certificate /etc/letsencrypt/live/k8s.adaptivenetworklab.org-0001/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/k8s.adaptivenetworklab.org-0001/privkey.pem;

    location / {
        proxy_pass https://ingress_endpoint;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_set_header host k8s.adaptivenetworklab.org;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_http_version 1.1;
    }
}
```

## Expose with NodePort
```
helm install --create-namespace -n portainer portainer portainer/portainer
```
```
Access on https://your_cluster_ip_public:30779
```

## Expose with Load Balancer
```
helm install --create-namespace -n portainer portainer portainer/portainer \
    --set service.type=LoadBalancer
```
```
Access on https://your_cluster_ip_public:9443 for HTTPS
Access on https://your_cluster_ip_public:9000 for HTTP
```

## Access
```
http://portainer.example.io/
Point to your Ingress Endpoint.
```

## Source

```
https://docs.portainer.io/v/ce-2.9/start/install/server/kubernetes/baremetal
https://docs.portainer.io/
```
