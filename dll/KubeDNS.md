# Kube DNS
```
The Domain Name System (DNS) is a system for associating various types of information – such as IP addresses – with easy-to-remember names. By default most Kubernetes clusters automatically configure an internal DNS service to provide a lightweight mechanism for service discovery. Built-in service discovery makes it easier for applications to find and communicate with each other on Kubernetes clusters, even when pods and services are being created, deleted, and shifted between nodes.
```

## Example DNS Endpoint
```
for Service :
service.namespace.svc.cluster.local

for Pod :
ip_pod.namespace.pod.cluster.local
```

```
So, if we have :
mongo-posts-clusterip-srv : name of Service
postsapp : name of Namespace

we can write like :
mongo-posts-clusterip-srv.postsapp.svc.cluster.local
```

## Debugging
```
kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
kubectl exec -i -t dnsutils -- nslookup kubernetes.default
```

### Check are DNS expose to public with :
```
kubectl exec -i -t dnsutils -- nslookup mongo-posts-clusterip-srv.postsapp.svc.cluster.local

If you have a SERVFAIL Response, its gonna be good. Cause KubeDNS its not exposed. But if you have an Authoritive Answer with Public IP you must to change /etc/resolv.conf on your Kubernetes Cluster to DNS Google or Anything.
```

## Source
```
https://www.digitalocean.com/community/tutorials/an-introduction-to-the-kubernetes-dns-service
https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
https://gist.github.com/superseb/f6894ddbf23af8e804ed3fe44dd48457
```