## Installing (Istio, Grafana) :
```
$ curl -L https://istio.io/downloadIstio | sh -
$ cd istio-1.12.1
$ export PATH=$PWD/bin:$PATH
$ istioctl operator init  
$ kubectl get all -n istio-operator
$ kubectl create ns istio-system
$ kubectl apply -f - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: istio-system
  name: example-istiocontrolplane
spec:
  profile: demo
EOF
$ kubectl get all -n istio-system

Change Service to LoadBalancer :
$ kubectl edit svc istio-ingressgateway -n istio-system
$ kubectl get svc istio-ingressgateway -n istio-system

Install Prometheus :
$ kubectl apply -f https://gitlab.com/gilangvperdana/microservices-app-on-k-8-s-with-istio/-/raw/master/addons/prometheus.yaml

Install Grafana (Optional) :
$ kubectl apply -f https://gitlab.com/gilangvperdana/microservices-app-on-k-8-s-with-istio/-/raw/master/addons/grafana.yaml 

Change Service Grafana to LoadBalancer:
$ kubectl edit svc grafana -n istio-system
$ http://<ip-external-service-grafana>:3000
```

## Monitoring with Kiali?
```
$ cd istio-1.12.1
$ kubectl apply -f samples/addons/kiali.yaml

Change service to LoadBalancer:
$ kubectl edit svc kiali -n istio-system
$ kubectl get svc kiali -n istio-system
http://ip_external_kiali:20001

After Kiali was Deployed, Inject sidecard to all running pod :
$ kubectl label namespace postsapp istio-injection=enabled --overwrite
$ kubectl get namespace -L istio-injection

To remove injection :
$ kubectl label namespace postsapp istio-injection=disabled --overwrite 

Monitoring on Kiali Dashboard :
http://ip_external_kiali:20001
```