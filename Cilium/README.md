# Cilium
eBPF-based Networking, Observability, Security

## Installation
- CLI
```
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
```

- on K8s
```
cilium install
```

## Verification
- Validate
```
cilium status --wait
   /¯¯\
/¯¯\__/¯¯\    Cilium:         OK
\__/¯¯\__/    Operator:       OK
/¯¯\__/¯¯\    Hubble:         disabled
\__/¯¯\__/    ClusterMesh:    disabled
   \__/

DaemonSet         cilium             Desired: 2, Ready: 2/2, Available: 2/2
Deployment        cilium-operator    Desired: 2, Ready: 2/2, Available: 2/2
Containers:       cilium-operator    Running: 2
                  cilium             Running: 2
Image versions    cilium             quay.io/cilium/cilium:v1.9.5: 2
                  cilium-operator    quay.io/cilium/operator-generic:v1.9.5: 2
```

- Connectivity Test
```
cilium connectivity test
ℹ️  Monitor aggregation detected, will skip some flow validation steps
✨ [k8s-cluster] Creating namespace for connectivity check...

---------------------------------------------------------------------------------------------------------------------
📋 Test Report
---------------------------------------------------------------------------------------------------------------------
✅ 69/69 tests successful (0 warnings)
```

## Hubble (Monitoring Purposes)
```
cilium hubble enable
cilium hubble ui
hubble status
cilium status
```

- Portforwarding
```
export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
HUBBLE_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
sha256sum --check hubble-linux-${HUBBLE_ARCH}.tar.gz.sha256sum
sudo tar xzvfC hubble-linux-${HUBBLE_ARCH}.tar.gz /usr/local/bin
rm hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}

cilium hubble port-forward&
hubble observe
```

## Change Kubeproxy to Cilium on Existing K8s Cluster
```
kubectl -n kube-system delete ds kube-proxy
kubectl -n kube-system delete cm kube-proxy
iptables-save | grep -v KUBE | iptables-restore

helm repo add cilium https://helm.cilium.io/
helm install cilium cilium/cilium --version 1.9.18 \
    --namespace kube-system \
    --set kubeProxyReplacement=strict \
    --set k8sServiceHost=REPLACE_WITH_API_SERVER_IP \
    --set k8sServicePort=REPLACE_WITH_API_SERVER_PORT
kubectl -n kube-system get pods -l k8s-app=cilium

kubectl exec -it -n kube-system cilium-fmh8d -- cilium status | grep KubeProxyReplacement
kubectl exec -it -n kube-system cilium-fmh8d -- cilium status --verbose
```
- Ref : https://docs.cilium.io/en/v1.9/gettingstarted/kubeproxy-free/

## Prometheus Metrics
- https://grafana.com/grafana/dashboards/15513-cilium-metrics/
- https://github.com/cilium/cilium/blob/main/examples/kubernetes/addons/prometheus/README.md
```
kubectl patch -n kube-system configmap cilium-config --type merge --patch '{"data":{"prometheus-serve-addr":":9962"}}'
kubectl rollout restart deploy/cilium-operator -n kube-system

## Scrape it with prometheus
---
  - job_name: 'cilium-cluster-exporter'
    scrape_interval: 10s
    metrics_path: /metrics
    static_configs:
      - targets: ['K8sIP:9962']
        labels:
          cluster_name: yourCluster
---
```

## Error on Ubuntu 22.04LTS with Cilium (COREDNS)
```
sed -i -e '/net.ipv4.conf.*.rp_filter/d' $(grep -ril '\.rp_filter' /etc/sysctl.d/ /usr/lib/sysctl.d/)
sysctl -a | grep '\.rp_filter' | awk '{print $1" = 0"}' > /etc/sysctl.d/1000-cilium.conf
sysctl --system
sysctl -a | grep '\.rp_filter'
```

### Reference
- https://github.com/cilium/cilium
- https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/
- https://cilium.io/
