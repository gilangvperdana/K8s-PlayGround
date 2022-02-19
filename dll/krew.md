## Kubectl Krew

```
Krew is the plugin manager for kubectl command-line tool.
```

## Installation

```
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```

```
$ nano /root/.bashrc
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
```

## Source 
```
https://krew.sigs.k8s.io/
```