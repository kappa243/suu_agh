kubectl create namespace ocm-system
kubectl apply -f database/mysql.yaml
kubectl apply -f database/mysql_job.yaml
