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
