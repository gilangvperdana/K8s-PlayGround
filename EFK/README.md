# Elasticsearch + FluentD + Kibana (EFK)
```
Provisioning EFK Stack on Kubernetes Cluster
```

## Environment
```
Kubernetes Cluster
```

## Installation
```
kubectl apply -f ns.yaml
kubectl apply -f . -n logging
```

## Access
- Elastic Search :
    - http://localhost:9200/_cluster/state?pretty
- Kibana :
    - http://localhost:5601/

## Testing loging with BusyBox
```
kubectl apply -f containerlogging -n logging
```