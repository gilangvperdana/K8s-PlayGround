## Kube Prometheus Stack
Bundled monitoring stack on Kubernetes (Grafana, Prometheus, Alert Manager, NodeExporter)

```
## Add Metric Server
wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability.yaml

--- file content omitted ---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    k8s-app: metrics-server
  name: metrics-server
  namespace: kube-system
spec:
--- file content omitted ---
  template:
    metadata:
      labels:
        k8s-app: metrics-server
--- file content omitted ---
    spec:
      containers:
      - args:
        - --cert-dir=/tmp
        - --secure-port=4443
        - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
        - --kubelet-use-node-status-port
        - --metric-resolution=15s
        - --kubelet-insecure-tls # Add this line
--- file content omitted —

kubectl apply -f high-availability.yaml

## Prepare KubeStack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

cat<<EOF > values.yaml
alertmanager:
  enabled: false
nodeExporter:
  enabled: true
kubeEtcd:
  service:
    targetPort: 2381
    targetPort: 2381
kubeScheduler:
  service:
    targetPort: 10259
    targetPort: 10259
  serviceMonitor:
    https: "true"
    insecureSkipVerify: "true"

networkPolicy:
  enabled: true
EOF

## Apply
kubectl create ns monitoring
helm install --namespace monitoring prometheus prometheus-community/kube-prometheus-stack -f values.yaml

## Get Password
kubectl get secret --namespace monitoring prometheus-grafana -o jsonpath="{.data.admin-user}" | base64 --decode ; echo
kubectl get secret --namespace monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

## Create Ingress Grafana
cat<<EOF > grafana-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana
  namespace: monitoring
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: aa-grafana.btech.id
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus-grafana
            port:
              number: 80
EOF

kubectl apply -f grafana-ingress.yaml
```

## Reference
- https://github.com/prometheus-operator/kube-prometheus