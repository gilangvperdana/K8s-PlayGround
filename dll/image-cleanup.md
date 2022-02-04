## Docker Image Clean Up

```
Clean automaticly Image Docker
```

## Use
```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    name: clean-up
  name: clean-up
spec:
  selector:
    matchLabels:
      app: clean-up
  template:
    metadata:
      labels:
        app: clean-up 
    spec:
      volumes:
        - name: docker-sock
          hostPath:
            path: /var/run/docker.sock
        - name: docker-directory
          hostPath:
            path: /var/lib/docker
      containers:
        - image: andyzhangx/docker-cleanup:latest  # based on https://hub.docker.com/r/meltwater/docker-cleanup/
          name: clean-up
          env:
            - name: CLEAN_PERIOD
              value: "60"
            - name: DELAY_TIME
              value: "1800"
          volumeMounts:
            - mountPath: /var/run/docker.sock
              name: docker-sock
              readOnly: false
            - mountPath: /var/lib/docker
              name: docker-directory
              readOnly: false
```