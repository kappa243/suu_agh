## Running main cluster: 

 Inside the main cluster the OCM hub, MySQL database server and a load balancer have to be installed. In order to achieve it, a cluster has been configured within the AWS Elastic Kubernetes Service. Then the following yaml files have been prepared to deploy the aforementioned services:

- For OCM hub:
```
apiVersion: v1
kind: Namespace
metadata:
  name: open-cluster-management
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ocm-controller
  namespace: open-cluster-management
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ocm-controller
  template:
    metadata:
      labels:
        app: ocm-controller
    spec:
      containers:
      - name: ocm-controller
        image: quay.io/open-cluster-management/ocm-controller:release-2.4
        ports:
        - containerPort: 443
```

- For MySQL database:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  namespace: ocm-system
spec:
  selector:
    matchLabels:
      app: mysql
  replicas: 1
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "rootpassword"
        - name: MYSQL_DATABASE
          value: "mydatabase"
        - name: MYSQL_USER
          value: "myuser"
        - name: MYSQL_PASSWORD
          value: "mypassword"
        ports:
        - containerPort: 3306
---
apiVersion: v1
kind: Service
metadata:
  name: mysql
  namespace: ocm-system
spec:
  selector:
    app: mysql
  ports:
  - port: 3306
    targetPort: 3306
```

- For the AWS load balancer:
```
apiVersion: v1
kind: Service
metadata:
  name: ocm-loadbalancer
  namespace: open-cluster-management
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
spec:
  type: LoadBalancer
  ports:
    - port: 443
      targetPort: 443
  selector:
    app: ocm-controller
```

In order to deploy the services the following commands have been run:
```
kubectl create namespace ocm-system
kubectl apply -f mysql-deployment.yaml
kubectl apply -f ocm-hub-deployment.yaml
kubectl apply -f ocm-loadbalancer-service.yaml
```