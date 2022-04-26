## Testing HPA 

```
Minikube Version.

Install Metric Server :
$ minikube addons enable metrics-server 
$ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

Deploy Some Project :
$ kubectl apply -f https://k8s.io/examples/application/php-apache.yaml

Create a HPA :
$ kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

Test Load :
$ kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"

CTRL+C if you done to test a load.
```

## Monitor :
```
$ watch kubectl get pod
```

## Metric Server Error
```
"Failed to scrape node" err="Get \"https://192.168.65.4:10250/stats/summary?only_cpu_and_memory=true\": x509: cannot validate certificate for 192.168.65.4 because it doesn't contain any IP SANs" node="docker-desktop"
```
```
kubectl patch deployment metrics-server -n kube-system --type 'json' -p '[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
```

## Source :
```
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/
https://searchitoperations.techtarget.com/tutorial/Kubernetes-performance-testing-tutorial-Load-test-a-cluster
https://github.com/kubernetes-sigs/metrics-server
```