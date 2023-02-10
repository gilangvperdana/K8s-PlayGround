# OAUTH2PROXY
- Try to implement OAUTH2 to our ingress endpoint with Github ORG.
- All manifest on this directory.

## Prepare Redis
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install redis bitnami/redis --values=values.yml
```

- Dump password
```
export REDIS_PASSWORD=$(kubectl get secret redis -o jsonpath="{.data.redis-password}" | base64 --decode)
```

## Prepare OAUTH2Proxy
In our case, we use Github to validate token, so we must create some OAUTH2Apps on Github on `Settings -> Developer Settings -> OAuth Apps -> New Oauth Apps`
  - Homepage URL : user1.example.com
  - Authorization Callback URL : oauth.example.com/oauth2/callback
  - Then from github OAUTH we have :
    - `Client ID` -> `from-literal=client-id`
    - `Client secrets` -> `from-literal=client-secret`
```
kubectl create secret generic oauth2-proxy-creds-github \
  --from-literal=client-id=XXXXXXXXXXXXXXXXXXXX \
  --from-literal=client-secret=YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY \
  --from-literal=cookie-secret=ababababababababababcabc
```

- Deploy
```
helm repo add oauth2-proxy https://oauth2-proxy.github.io/manifests
helm install oauth2-proxy oauth2-proxy/oauth2-proxy --values=values.yml
```

## Deploy our apps
```
kubectl apply -f ingress.yaml
```
