# Jenkins on Kubernetes Cluster
```
Jenkins on Kubernetes Cluster Provisioning
```

## Installation
```
kubectl create ns jenkins-dev
kubectl apply -f jenkins.yaml
```

## Access
```
kubectl get po -n jenkins-dev
kubectl logs <pod-name> -n jenkins-dev
```
```
will be Exposed on 30300 with NodePort Service.
```

## Password Dashboard
```
Go to /var/jenkins_home/secrets/initialAdminPassword
Paste on dashboard to login

if you Goin on Minikube, lets exec your Minikube container, with :
minikube ssh
```

## Source
```
https://medium.com/@vishal.sharma./running-jenkins-in-kubernetes-cluster-with-persistent-volume-da6584edc126
```