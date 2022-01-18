## Kubectx // Kubens
```
kubectx is a tool to switch between contexts (clusters) on kubectl faster.
kubens is a tool to switch between Kubernetes namespaces (and configure them for kubectl) easily.
```

## Install Krew :
```
$ (
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

$ nano /root/.bashrc
---
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
---

$ su
$ kubectl krew
```

## Installation :
```
$ kubectl krew install ctx
$ kubectl krew install ns
```

## Source :
```
https://github.com/ahmetb/kubectx
```