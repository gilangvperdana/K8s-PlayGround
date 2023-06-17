## Helm
```
Helm is the package manager for Kubernetes.
```

## Installation :
```
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

## Source :
```
https://helm.sh/docs/intro/install/
```

## Chartmuseum
a Solution opensource platform to store Helm Charts Package

```
docker run --rm -it \
  -p 8080:8080 \
  -e DEBUG=1 \
  -e STORAGE=local \
  -e STORAGE_LOCAL_ROOTDIR=/charts \
  -v $(pwd)/charts:/charts \
  ghcr.io/helm/chartmuseum:v0.14.

chmod 777 $(pwd)/charts
```
- Ref : https://chartmuseum.com/#Instructions

## Helm Push Chart
You can use `helm cm-push` -> https://github.com/chartmuseum/helm-push

```
helm plugin install https://github.com/chartmuseum/helm-push
helm repo add chartmuseum http://localhost:8080

# to Push charts
helm cm-push myCharts/ chartmuseum

# to See charts on chartmuseum
helom repo update
helm search repo chartmuseum
```

