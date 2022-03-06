## Open Service Mesh

```
Open Service Mesh (OSM) is a lightweight and extensible cloud native service mesh.
```

## Installation

```
From Scratch
```
```
OSM CLI :
wget https://github.com/openservicemesh/osm/releases/download/v1.0.0/osm-v1.0.0-linux-amd64.tar.gz
tar -xvzf osm-v1.0.0-linux-amd64.tar.gz
cd linux-amd64
sudo cp -r ./osm /usr/local/bin
su
osm install
```

## Installation with Helm

```
helm install <mesh name> osm --repo https://openservicemesh.github.io/osm --version <chart version> --namespace <osm namespace> --values override.yaml
```

## Sidecar Injection

```
# Enable sidecard with osm cli :
$ osm namespace add <namespace>

# Enable sidecar injection on a namespace :
$ kubectl annotate namespace <namespace> openservicemesh.io/sidecar-injection=enabled

# Enable sidecar injection on a pod :
$ kubectl annotate pod <pod> openservicemesh.io/sidecar-injection=enabled

# Enable on deployment :
metadata:
  name: test
  annotations:
    'openservicemesh.io/sidecar-injection': 'enabled'

Source :
https://release-v1-0.docs.openservicemesh.io/docs/guides/app_onboarding/sidecar_injection/
```

## Source

```
https://openservicemesh.io/
https://github.com/openservicemesh/osm/
```