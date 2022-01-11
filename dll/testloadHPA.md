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

## Source :
```
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/
https://searchitoperations.techtarget.com/tutorial/Kubernetes-performance-testing-tutorial-Load-test-a-cluster
https://github.com/kubernetes-sigs/metrics-server
```