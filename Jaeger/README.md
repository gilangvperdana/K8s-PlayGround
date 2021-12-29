## Jaeger Installation

```
Monitor and troubleshoot transactions in complex distributed systems.
```

## Environment 
```
1. Kubernetes Cluster
2. Helm
```

## Installation
```
$ helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
$ helm search repo jaegertracing
$ kubectl create ns jaeger
$ helm install jaegertracing/jaeger --generate-name -n jaeger
$ helm install jaegertracing/jaeger-operator --generate-name -n jaeger
```

## Source
```
https://github.com/jaegertracing/helm-charts
```