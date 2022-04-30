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

## Kibana
Lets start monitor logging :
- Goes to Kibana Dashboard
- Click `Discover`
- Click `Create index pattern`
- Fill Name with `logstash-*`
- fill Timestamp filed with `@timestamp`
- Click `Create index pattern`

## Testing logging with BusyBox
```
kubectl apply -f containerlogging -n logging
```
- After Busybox was deployed, monitor it on Kibana
- Goes to `Discover` page
- fill in the search bar with `kubernetes.pod_name:counter`

## Source
- https://azmifarih.medium.com/how-to-set-up-an-elasticsearch-fluentd-and-kibana-efk-logging-stack-on-kubernetes-1c455a6f17a8