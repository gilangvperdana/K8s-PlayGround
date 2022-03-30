## Installing (Istio, Grafana) :
```
Latest Ver : 
$ curl -L https://istio.io/downloadIstio | sh -
Specify Ver :
$ curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.12.1 sh -

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

Install Jaeger (Optional) :
$ kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.13/samples/addons/jaeger.yaml

Install Grafana (Optional) :
$ kubectl apply -f https://gitlab.com/gilangvperdana/microservices-app-on-k-8-s-with-istio/-/raw/master/addons/grafana.yaml 

Change Service Grafana to LoadBalancer:
$ kubectl edit svc grafana -n istio-system
$ http://<ip-external-service-grafana>:3000
```

## Installation with Helm
```
helm repo add gilangvperdana https://githubio.gbesar.com/charts/
helm repo update

kubectl create ns istio-system
helm install istio-base gilangvperdana/base -n istio-system
helm install istiod gilangvperdana/istiod -n istio-system

kubectl create ns istio-ingress
kubectl label namespace istio-ingress istio-injection=enabled
helm install istio-ingress gilangvperdana/gateway -n istio-system

You can specify label selector ingress with :
---
  selector:
    istio: istioingress
---
```

## Monitoring with Kiali?
```
$ kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.13/samples/addons/kiali.yaml

OR for HardWay :
$ curl -L https://istio.io/downloadIstio | sh -
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

## Strict your Pod Connection

```
To all injected sidecar pod :
$ kubectl apply -n istio-system -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: "default"
spec:
  mtls:
    mode: STRICT
EOF
```

```
Specify namespace :
$ kubectl apply -n your_namespace -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: "default"
spec:
  mtls:
    mode: STRICT
EOF

```

```
Check :
$ kubectl get peerauthentication --all-namespaces
```