## Ngrok on K8s

## Env
```
1. Helm
2. Ngrok Account & Auth Token (https://dashboard.ngrok.com/get-started/your-authtoken)
```

## Installation
```
helm repo add zufardhiyaulhaq https://charts.zufardhiyaulhaq.com/
helm install my-release zufardhiyaulhaq/ngrok-operator
```

## Expose your Service
```
$ nano expose.yaml
```

```
apiVersion: ngrok.com/v1alpha1
kind: Ngrok
metadata:
  name: postsapp-ngrok
  namespace: postsapp
spec:
  # ngrok authtoken
  authtoken: your_auth_ngrok_token

  # type of authtoken
  # plain or secret
  authtoken_type: plain

  # protocol used, currently support http & tcp
  # tcp is less tested, please create issue 
  # if there is an issue with tcp
  protocol: http

  # region where ngrok run
  # refer to the docs
  # https://ngrok.com/docs
  region: ap

  # Rewrite the HTTP Host header to this value
  host_header: "*"

  # bind an HTTPS or HTTP endpoint or both
  bind_tls: both

  # enable inspection
  # only works for http protocol
  inspect: true

  # this supported starting with basic plan
  # using custom hostname require to set authtoken
  # the behaviour when set `hostname` with free account
  # is unknown!
  hostname: 

  # service section represent
  # the service name in the same namespace
  service: client-srv

  # port section represent
  # the service port in the same namespace
  port: 3000

  # define the image for the ngrok
  # default to zufardhiyaulhaq/ngrok:latest
  podSpec:
    image: zufardhiyaulhaq/ngrok:v1.0.0
```

```
$ kubectl apply -f expose.yaml
```

## Check URL :
```
kubectl get ngrok --all-namespaces
```

## Source
```
https://github.com/zufardhiyaulhaq/ngrok-operator
```