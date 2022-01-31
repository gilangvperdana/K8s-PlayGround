## Pixie (Self Hosted Version)

```
Instant open-source debugging for your applications on Kubernetes
```

## Reuqirement
```
1. Brew
2. Mkcert
3. Kustomize
4. Pixie
```

## Install Brew
```
The Missing Package Manager for macOS (or Linux).
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
$ test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
$ test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
$ echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile

https://docs.brew.sh/Homebrew-on-Linux
```

## Install Mkcert
```
mkcert is a simple tool for making locally-trusted development certificates. It requires no configuration.

$ sudo apt install libnss3-tools
$ brew install mkcert

https://github.com/FiloSottile/mkcert#installation
```

## Install Kustomize
```
$ curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

https://kubectl.docs.kubernetes.io/installation/kustomize/
```

## Installation
```
$ git clone https://github.com/pixie-io/pixie.git
$ cd pixie
$ mkcert -install
$ kubectl create namespace plc
$ ./scripts/create_cloud_secrets.sh
$ kustomize build k8s/cloud_deps/public/ | kubectl apply -f - --namespace=plc
$ kustomize build k8s/cloud/public/ | kubectl apply -f - --namespace=plc
$ kubectl get pods -n plc

Set Up DNS :
$ minikube tunnel # if running on minikube
$ kubectl get service cloud-proxy-service -n plc
$ kubectl get service vzconn-service -n plc

$ go build src/utils/dev_dns_updater/dev_dns_updater.go
$ ./dev_dns_updater --domain-name="dev.withpixie.dev"  --kubeconfig=$HOME/.kube/config --n=plc
```

## Access :
```
User : admin@default.com
Pass : 
$ kubectl logs create-admin-job-<pod_string> -n plc

Access on dev.withpixie.dev
```

## Pixie CLI (Optional)
```
# Set the cloud address with an environment variable:
export PL_CLOUD_ADDR=dev.withpixie.dev

# Copy and run command to install the Pixie CLI.
$ bash -c "$(curl -fsSL https://withpixie.ai/install.sh)"

https://docs.px.dev/installing-pixie/install-schemes/cli/
```

## Source
```
https://github.com/pixie-io/pixie
https://docs.px.dev/
```