## Linkerd

```
Linkerd is a service mesh for Kubernetes. It makes running services easier and safer by giving you runtime debugging, observability, reliability, and security—all without requiring any changes to your code.
```

## Installation
```
$ curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh
$ nano /root/.bashrc
---
export PATH=$PATH:/root/.linkerd2/bin
---
$ su
$ linkerd version
$ linkerd check --pre

$ linkerd install | kubectl apply -f -
$ linkerd check
```

## Install a Demo App 
```
$ curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/emojivoto.yml \
  | kubectl apply -f -

Inject Linkerd to Deployment :
$ kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -

Check Linkerd has been installed to emojivoto :
$ linkerd -n emojivoto check --proxy

Access on :
http://clusterip_web-svc
```

## Access with Nginx Ingress
```
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: web-ingress
  namespace: emojivoto
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/configuration-snippet: |
      proxy_set_header l5d-dst-override $service_name.$namespace.svc.cluster.local:$service_port;
      grpc_set_header l5d-dst-override $service_name.$namespace.svc.cluster.local:$service_port;      

spec:
  rules:
  - host: emojivoto.com
    http:
      paths:
      - backend:
          serviceName: web-svc
          servicePort: 80
---
Access on emojivoto.com
```

## Linkerd Dashboard
```
VIZ Dashboard
$ linkerd viz install | kubectl apply -f - 
$ linkerd viz dashboard &

Buoyant Dashboard
$ curl --proto '=https' --tlsv1.2 -sSfL https://buoyant.cloud/install | sh 
$ nano /root/.bashrc
---
export PATH=$PATH:/root/.linkerd2/bin
---
$ su
$ linkerd buoyant install | kubectl apply -f - 
$ linkerd buoyant dashboard &
```

## Source
```
https://linkerd.io/2.11/getting-started/
https://linkerd.io/2.9/tasks/using-ingress/
```