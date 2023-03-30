## K1S
A minimalistic Kubernetes dashboard showing the current state of Kubernetes resources of a specific type in real-time. The entire tool consists merely of a Bash script with about 50 lines of code.

## Installation
- Install JQ
```
sudo apt-get install jq
```

- Install K1s
```
wget https://raw.githubusercontent.com/weibeld/k1s/master/k1s
chmod +x k1s
mv k1s /usr/local/bin
```

## Use
- To list an object
```
k1 <namespace> <kubernetes_object>
k1 default pods
```

## Reference
- https://github.com/weibeld/k1s