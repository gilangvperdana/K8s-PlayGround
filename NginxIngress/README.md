## NGINX Ingress
```
Ingress may provide load balancing, SSL termination and name-based virtual hosting.
```

## Installation :
```
$ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
$ kubectl create ns ingress-nginx
$ helm install myingress ingress-nginx/ingress-nginx -n ingress-nginx
$ helm list -n ingress-nginx
$ kubectl get all -n igress-nginx
```

## Test :
```
To test Nginx Ingress, you can use annotations nginx (metadata) on Ingress yaml :
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
---

After that, use a external ip nginx-ingress to access your services.
```

## Activate Real IP behind Reverse Proxy
- Edit configmap
```
data:
  allow-snippet-annotations: 'true'
  compute-full-forwarded-for: 'true'
  proxy-real-ip-cidr: 172.20.0.0/16, 10.0.0.0/16, 192.168.10.0/24, 192.168.100.0/24
  use-forwarded-headers: 'true'
```

- Edit service (myingress-ingress-nginx-controller)
```
  externalTrafficPolicy: Local
```

# Create TLS
- You can generate selfSigned with my [Script](https://github.com/gilangvperdana/K8s-PlayGround/blob/master/NginxIngress/genSSL.sh)
```
spec:
  tls:
    - hosts:
        - notary.registry.adaptivenetlab.site
      secretName: harbor-ingress
  rules:
```

# Enable Geo-IP
- for collect database etc read [Here](https://gist.github.com/gilangvperdana/e49ab4a5056afd5821a112b3b85035d1)
- values.yaml
```
controller:
  config:
    allow_snippet_annotations: true
    compute_full_forwarded_for: true
    enable-geoip: "true"
    log-format-upstream: $remote_addr - $remote_user [$time_local] "$request" $status
      $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for"
      "$http_geoip_country_code" "$http_geoip_city_name"
```

- enable geoip version 2
```
nano /etc/nginx/nginx.conf

---
load_module /etc/nginx/modules/ngx_http_geoip2_module.so;

http {

  geoip2 /etc/nginx/geoip/GeoLite2-City.mmdb {
    $geoip2_data_city_name city names en;
    $geoip2_data_country_iso_code country iso_code;
    $geoip2_data_country_name country names en;
}

  log_format upstreaminfo '$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for" "$geoip2_data_country_iso_code" "$geoip2_data_country_name" ';
}
---
```

## Error
- `Error from server (InternalError): error when creating "ingress.yaml": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": failed to call webhook: Post "https://ingress-nginx-controller-admission.nginx-ingress-research.svc:443/networking/v1/ingresses?timeout=10s": service "ingress-nginx-controller-admission" not found`
  - Fix with `kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission`
  - Source : https://stackoverflow.com/questions/61365202/nginx-ingress-service-ingress-nginx-controller-admission-not-found

## Source :
- https://kubernetes.github.io/ingress-nginx/
