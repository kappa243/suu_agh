kubectl create namespace ocm-system
kubectl apply -f mysql-deployment.yaml
kubectl apply -f ocm-hub-deployment.yaml
kubectl apply -f ocm-loadbalancer-service.yaml
