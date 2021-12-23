# Wordpress/MySQL/PHPmyAdmin on K8s
    Simply deploy Wordpress on Kubernetes Cluster.
```Environment:
Environment:
    Kubernetes Cluster
```

# 1. with Deployment
```
if you want to create a deployment, please go to the with-Deployment directory.
$ kubectl create -f wordpress-mysql-with-PMA.yaml (if you want to use PMA).
$ kubectl create -f wordpress-mysql.yaml (if you dont want to use PMA).
```

# 2. with POD
```
if you dont want to create a deployment, please go to the with-POD directory.
$ kubectl create -f wordpress-mysql-with-PMA.yaml (if you want to use PMA).
$ kubectl create -f wordpress-mysql.yaml (if you dont want to use PMA).
```
# 3. Expose Service
```
the files in the two directories are the same, please adjust your needs.
$ kubectl create -f Service-LB.yaml (if you want to LoadBalance your Wordpress).
$ kubectl create -f Service-NP.yaml (if you just want Expose with NodePort ).
```
# 4. Environment details
```
some about service credential.
all service account credentials can be changed in the env section of the yaml file.

Default Credentials account:
1. DB (MySQL):
user : root
pass : wordpress

user : wordpress
pass : wordpress

2. PHPMyAdmin
all following the credentials from mysql.
```

# 5. Access on
```
After you deploy, you can check your node port or your expose service address at:
$ kubectl get services (look at the generated port and then access http://localhost:nodeport or http://localhost:80 for the load-balancer service.)
```
