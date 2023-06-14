# Vault (Docker Version)
- This is a separate version (outside of kubernetes) but i will bundle it with the ESO operator.
- For K8s version please read official docs -> https://developer.hashicorp.com/vault/downloads

### Docker Deployment
```
mkdir vault
cd vault
touch docker-compose.yml
mkdir -p volumes/{config,file,logs}

cat > volumes/config/vault.json << EOF
{
  "backend": {
    "file": {
      "path": "/vault/file"
    }
  },
  "listener": {
    "tcp":{
      "address": "0.0.0.0:8200",
      "tls_disable": 1
    }
  },
  "ui": true
}
EOF
```

```
nano docker-compose.yml
version: '2'
services:
  vault:
    image: vault
    restart: always
    container_name: vault
    ports:
      - "8200:8200"
    restart: always
    volumes:
      - ./volumes/logs:/vault/logs
      - ./volumes/file:/vault/file
      - ./volumes/config:/vault/config
    cap_add:
      - IPC_LOCK
    entrypoint: vault server -config=/vault/config/vault.json
```

```
docker-compose up -d
```

### Initiate
```
docker exec -it vault ash
export VAULT_ADDR='http://127.0.0.1:8200'
vault operator init -key-shares=6 -key-threshold=3

vault operator unseal Qpyo...   
vault operator unseal sVTE...  
vault operator unseal maqT... 
vault status -format=json
```

### Login from CLI
```
export VAULT_ADDR='http://127.0.0.1:8200'
vault login hvs.Hv...
```

### Login from UI
- Access localhost:8200/

### Basic Command for Add Secret
```
vault secrets enable -version=1 -path=secret kv
vault kv put secret/my-app/db username=username123 password=123
vault kv get secret/my-app/db
```

### Create Policy from CLI
```
nano read-my-app-db.hcl
```
```
ath "secret/my-app/db" {
  capabilities = ["read"]
}
```
```
vault policy write read-my-app-db read-my-app-db.hcl
```

### Create token
```
vault token create -policy=read-my-app-db -policy=secret/my-app/db

or NO TTL 
vault token create -no-default-policy -policy=read-my-app-db-nottl -policy=secret/my-app/db -ttl=0
```

### Integrate with K8s
```
helm repo add external-secrets https://charts.external-secrets.io
helm repo update
helm install external-secrets \
    external-secrets/external-secrets \
    -n external-secrets \
    --create-namespace \
    --set installCRDs=true

kubectl create secret generic vault-token --from-literal=token=hvs...
```

### Create Secret Store
```
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-backend
spec:
  provider:
    vault:
      server: "http://YOUR_VAULT_EXTERNAL_IP:8200"
      path: "secret/my-app/"
      version: "v1"
      auth:
        tokenSecretRef:
          name: "vault-token"
          key: "token"
```
```
kubectl get SecretStore 
kubectl get SecretStore vault-backend -o yaml
```

### Create External Secret

```
apiVersion: external-secrets.io/v1alpha1
kind: ExternalSecret
metadata:
  name: my-cool-secret
spec:
  refreshInterval: "3s"
  secretStoreRef:
    name: vault-backend
    kind: SecretStore
  target:
    name: my-cool-new-secret #name of k8s secret
    creationPolicy: Owner #will be automatically create or delete on k8s
  data:
    - secretKey: username #k8s secret form name
      remoteRef:
        key: db #path on Vault
        property: username #form name on Vault
    - secretKey: password
      remoteRef:
        key: db 
        property: password
```

```
kubectl get ExternalSecret my-cool-secret
kubectl get ExternalSecret my-cool-secret -o yaml
```

## Reference
- https://blog.ruanbekker.com/blog/2019/05/06/setup-hashicorp-vault-server-on-docker-and-cli-guide/
- https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-external-vault
- https://www.digitalocean.com/community/tutorials/how-to-access-vault-secrets-inside-of-kubernetes-using-external-secrets-operator-eso
